-- ============================================================================
-- 05_PLSQL.SQL - FUNCTIONS, TRIGGERS E PROCEDURES | ONG de Protecao Animal
-- Ordem dos scripts: 01 -> 02 -> 05 -> 03 -> 04 -> 06
-- Este arquivo roda DEPOIS da carga: o trigger da RN09 bloquearia as adocoes
-- ja concluidas que a carga insere.
-- ============================================================================

-- ============================================================================
-- FUNCTIONS E ROTINA DE APOIO
-- ============================================================================

-- RN03 | Function: a pessoa tinha 18 anos ou mais na data do evento?
CREATE OR REPLACE FUNCTION fn_maior_idade (
    p_id_pessoa   IN Pessoa.ID_Pessoa%TYPE,
    p_data_evento IN DATE
) RETURN NUMBER IS
    v_nascimento Pessoa.Data_Nascimento%TYPE;
BEGIN
    SELECT Data_Nascimento
      INTO v_nascimento
      FROM Pessoa
     WHERE ID_Pessoa = p_id_pessoa;

    IF ADD_MONTHS(v_nascimento, 216) <= p_data_evento THEN
        RETURN 1;
    END IF;
    RETURN 0;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20010, 'Pessoa nao encontrada.');
END fn_maior_idade;
/

-- RN11 | Function: quantas vagas para animais a unidade ainda tem?
CREATE OR REPLACE FUNCTION fn_vagas_disponiveis (
    p_id_unidade IN Unidade_ONG.ID_Unidade_ONG%TYPE
) RETURN NUMBER IS
    v_capacidade Unidade_ONG.Capacidade%TYPE;
    v_ocupacao   NUMBER;
BEGIN
    SELECT Capacidade
      INTO v_capacidade
      FROM Unidade_ONG
     WHERE ID_Unidade_ONG = p_id_unidade;

    SELECT COUNT(*)
      INTO v_ocupacao
      FROM Animal
     WHERE ID_Unidade_ONG = p_id_unidade
       AND Status IN ('EM_TRATAMENTO', 'DISPONIVEL', 'EM_PROCESSO');

    RETURN GREATEST(v_capacidade - v_ocupacao, 0);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001, 'Unidade nao encontrada.');
END fn_vagas_disponiveis;
/

-- RN07 | Procedure de apoio usada pelos triggers de data
-- Recusa data futura e, quando recebe um animal, data anterior ao resgate.
CREATE OR REPLACE PROCEDURE prc_validar_data_evento (
    p_data      IN DATE,
    p_evento    IN VARCHAR2,
    p_id_animal IN Animal.ID_Animal%TYPE DEFAULT NULL
) IS
    v_resgate Animal.Data_Resgate%TYPE;
BEGIN
    IF TRUNC(p_data) > TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20060,
            'RN07: a data de ' || p_evento || ' nao pode ser futura.');
    END IF;

    IF p_id_animal IS NOT NULL THEN
        BEGIN
            SELECT Data_Resgate
              INTO v_resgate
              FROM Animal
             WHERE ID_Animal = p_id_animal;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN; -- animal inexistente: a FK recusa o comando com ORA-02291
        END;

        IF p_data < v_resgate THEN
            RAISE_APPLICATION_ERROR(-20061,
                'RN07: a data de ' || p_evento || ' nao pode ser anterior ao resgate do animal.');
        END IF;
    END IF;
END prc_validar_data_evento;
/

-- ============================================================================
-- TRIGGERS
-- ============================================================================

-- RN03 | Adotante, doador e diretor precisam ter 18 anos ou mais
CREATE OR REPLACE TRIGGER trg_adocao_maior_idade
BEFORE INSERT OR UPDATE OF ID_Pessoa, Data_Inicio ON Adocao
FOR EACH ROW
BEGIN
    IF fn_maior_idade(:NEW.ID_Pessoa, :NEW.Data_Inicio) = 0 THEN
        RAISE_APPLICATION_ERROR(-20011,
            'RN03: o adotante precisa ter 18 anos ou mais na data de inicio da adocao.');
    END IF;
END trg_adocao_maior_idade;
/

CREATE OR REPLACE TRIGGER trg_doacao_maior_idade
BEFORE INSERT OR UPDATE OF ID_Pessoa, Data_Doacao ON Doacao
FOR EACH ROW
BEGIN
    IF fn_maior_idade(:NEW.ID_Pessoa, :NEW.Data_Doacao) = 0 THEN
        RAISE_APPLICATION_ERROR(-20012,
            'RN03: o doador precisa ter 18 anos ou mais na data da doacao.');
    END IF;
END trg_doacao_maior_idade;
/

CREATE OR REPLACE TRIGGER trg_mandato_maior_idade
BEFORE INSERT OR UPDATE OF ID_Pessoa, Data_Inicio ON Mandato_Diretoria
FOR EACH ROW
BEGIN
    IF fn_maior_idade(:NEW.ID_Pessoa, :NEW.Data_Inicio) = 0 THEN
        RAISE_APPLICATION_ERROR(-20013,
            'RN03: o diretor precisa ter 18 anos ou mais na data de inicio do mandato.');
    END IF;
END trg_mandato_maior_idade;
/

-- RN07 | Datas nao podem ser futuras nem anteriores ao resgate
-- O trigger de Animal so confere a data futura: consultar a propria tabela
-- Animal dentro dele causaria o erro ORA-04091 (tabela mutante).
CREATE OR REPLACE TRIGGER trg_animal_data
BEFORE INSERT OR UPDATE OF Data_Resgate ON Animal
FOR EACH ROW
BEGIN
    prc_validar_data_evento(:NEW.Data_Resgate, 'resgate');
END trg_animal_data;
/

CREATE OR REPLACE TRIGGER trg_adocao_data
BEFORE INSERT OR UPDATE OF Data_Inicio, ID_Animal ON Adocao
FOR EACH ROW
BEGIN
    prc_validar_data_evento(:NEW.Data_Inicio, 'inicio da adocao', :NEW.ID_Animal);
END trg_adocao_data;
/

CREATE OR REPLACE TRIGGER trg_hist_vet_data
BEFORE INSERT OR UPDATE OF Data_Atendimento, ID_Animal ON Historico_Veterinario
FOR EACH ROW
BEGIN
    prc_validar_data_evento(:NEW.Data_Atendimento, 'atendimento', :NEW.ID_Animal);
END trg_hist_vet_data;
/

CREATE OR REPLACE TRIGGER trg_vacinacao_data
BEFORE INSERT OR UPDATE OF Data_Aplicacao, ID_Animal ON Vacinacao
FOR EACH ROW
BEGIN
    prc_validar_data_evento(:NEW.Data_Aplicacao, 'aplicacao da vacina', :NEW.ID_Animal);
END trg_vacinacao_data;
/

CREATE OR REPLACE TRIGGER trg_doacao_data
BEFORE INSERT OR UPDATE OF Data_Doacao ON Doacao
FOR EACH ROW
BEGIN
    prc_validar_data_evento(:NEW.Data_Doacao, 'doacao');
END trg_doacao_data;
/

CREATE OR REPLACE TRIGGER trg_despesa_data
BEFORE INSERT OR UPDATE OF Data_Despesa ON Despesa
FOR EACH ROW
BEGIN
    prc_validar_data_evento(:NEW.Data_Despesa, 'despesa');
END trg_despesa_data;
/

-- RN09 | So animal DISPONIVEL inicia adocao
CREATE OR REPLACE TRIGGER trg_adocao_animal_disponivel
BEFORE INSERT OR UPDATE OF ID_Animal ON Adocao
FOR EACH ROW
DECLARE
    v_status Animal.Status%TYPE;
BEGIN
    SELECT Status
      INTO v_status
      FROM Animal
     WHERE ID_Animal = :NEW.ID_Animal;

    IF v_status <> 'DISPONIVEL' THEN
        RAISE_APPLICATION_ERROR(-20040,
            'RN09: so animal DISPONIVEL pode iniciar adocao (status atual: ' || v_status || ').');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- animal inexistente: a FK recusa o comando com ORA-02291
END trg_adocao_animal_disponivel;
/

-- RN09 e RN10 | O status do animal acompanha o processo de adocao
--   EM_ANALISE ou APROVADA          -> animal EM_PROCESSO
--   CONCLUIDA                       -> animal ADOTADO
--   REPROVADA, CANCELADA, DEVOLVIDA -> animal volta a DISPONIVEL
CREATE OR REPLACE TRIGGER trg_adocao_status_animal
AFTER INSERT OR UPDATE OF Status ON Adocao
FOR EACH ROW
DECLARE
    v_novo_status Animal.Status%TYPE;
BEGIN
    IF UPDATING AND :OLD.Status = :NEW.Status THEN
        RETURN;
    END IF;

    IF :NEW.Status IN ('EM_ANALISE', 'APROVADA') THEN
        v_novo_status := 'EM_PROCESSO';
    ELSIF :NEW.Status = 'CONCLUIDA' THEN
        v_novo_status := 'ADOTADO';
    ELSE
        v_novo_status := 'DISPONIVEL';
    END IF;

    UPDATE Animal
       SET Status = v_novo_status
     WHERE ID_Animal = :NEW.ID_Animal
       AND Status NOT IN (v_novo_status, 'OBITO');
END trg_adocao_status_animal;
/

-- RN15 | Toda mudanca de status do animal fica registrada
CREATE OR REPLACE TRIGGER trg_animal_historico_status
AFTER INSERT OR UPDATE OF Status ON Animal
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO Historico_Status (ID_Animal, Status_Anterior, Status_Novo)
        VALUES (:NEW.ID_Animal, NULL, :NEW.Status);
    ELSIF :OLD.Status <> :NEW.Status THEN
        INSERT INTO Historico_Status (ID_Animal, Status_Anterior, Status_Novo)
        VALUES (:NEW.ID_Animal, :OLD.Status, :NEW.Status);
    END IF;
END trg_animal_historico_status;
/

-- ============================================================================
-- PROCEDURES
-- ============================================================================

-- RN11 | Procedure: cadastra o animal resgatado so se a unidade tiver vaga
CREATE OR REPLACE PROCEDURE prc_registrar_resgate (
    p_id_unidade           IN  Animal.ID_Unidade_ONG%TYPE,
    p_id_raca              IN  Animal.ID_Raca%TYPE,
    p_nome                 IN  Animal.Nome%TYPE,
    p_data_resgate         IN  Animal.Data_Resgate%TYPE,
    p_data_nasc_estipulada IN  Animal.Data_Nascimento_Estipulada%TYPE,
    p_sexo                 IN  Animal.Sexo%TYPE,
    p_id_animal            OUT Animal.ID_Animal%TYPE
) IS
    v_trava Unidade_ONG.ID_Unidade_ONG%TYPE;
BEGIN
    BEGIN
        SELECT ID_Unidade_ONG
          INTO v_trava
          FROM Unidade_ONG
         WHERE ID_Unidade_ONG = p_id_unidade
           FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Unidade nao encontrada.');
    END;

    IF fn_vagas_disponiveis(p_id_unidade) < 1 THEN
        RAISE_APPLICATION_ERROR(-20020,
            'RN11: a unidade ' || p_id_unidade || ' atingiu a capacidade maxima.');
    END IF;

    INSERT INTO Animal (ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate,
                        Data_Nascimento_Estipulada, Sexo, Status)
    VALUES (p_id_unidade, p_id_raca, p_nome, p_data_resgate,
            p_data_nasc_estipulada, p_sexo, 'EM_TRATAMENTO')
    RETURNING ID_Animal INTO p_id_animal;
END prc_registrar_resgate;
/

-- RN10 | Procedure: conclui uma adocao APROVADA
-- O trigger trg_adocao_status_animal muda o animal para ADOTADO no mesmo comando.
CREATE OR REPLACE PROCEDURE prc_concluir_adocao (
    p_id_adocao IN Adocao.ID_Adocao%TYPE
) IS
    v_status Adocao.Status%TYPE;
BEGIN
    BEGIN
        SELECT Status
          INTO v_status
          FROM Adocao
         WHERE ID_Adocao = p_id_adocao
           FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20030, 'Adocao nao encontrada.');
    END;

    IF v_status <> 'APROVADA' THEN
        RAISE_APPLICATION_ERROR(-20031,
            'RN10: so e possivel concluir adocao APROVADA (status atual: ' || v_status || ').');
    END IF;

    UPDATE Adocao
       SET Status = 'CONCLUIDA',
           Data_Conclusao = TRUNC(SYSDATE)
     WHERE ID_Adocao = p_id_adocao;
END prc_concluir_adocao;
/

-- RN12 | Procedure: cadastra o voluntario so se a unidade estiver abaixo do limite
-- O indice uq_voluntariado_ativo impede a mesma pessoa ativa duas vezes na unidade.
CREATE OR REPLACE PROCEDURE prc_registrar_voluntario (
    p_id_unidade      IN  Voluntariado.ID_Unidade_ONG%TYPE,
    p_id_pessoa       IN  Voluntariado.ID_Pessoa%TYPE,
    p_funcao          IN  Voluntariado.Funcao%TYPE,
    p_data_inicio     IN  Voluntariado.Data_Inicio%TYPE,
    p_id_voluntariado OUT Voluntariado.ID_Voluntariado%TYPE
) IS
    v_limite Unidade_ONG.Limite_Voluntarios%TYPE;
    v_ativos NUMBER;
BEGIN
    BEGIN
        SELECT Limite_Voluntarios
          INTO v_limite
          FROM Unidade_ONG
         WHERE ID_Unidade_ONG = p_id_unidade
           FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'Unidade nao encontrada.');
    END;

    SELECT COUNT(*)
      INTO v_ativos
      FROM Voluntariado
     WHERE ID_Unidade_ONG = p_id_unidade
       AND Data_Fim IS NULL;

    IF v_ativos >= v_limite THEN
        RAISE_APPLICATION_ERROR(-20070,
            'RN12: a unidade ' || p_id_unidade || ' atingiu o limite de voluntarios.');
    END IF;

    INSERT INTO Voluntariado (ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim)
    VALUES (p_id_unidade, p_id_pessoa, p_funcao, p_data_inicio, NULL)
    RETURNING ID_Voluntariado INTO p_id_voluntariado;
END prc_registrar_voluntario;
/

-- RN16 | Procedure: exclusao protegida (trata o erro ORA-02292)
CREATE OR REPLACE PROCEDURE prc_excluir_animal (
    p_id_animal IN Animal.ID_Animal%TYPE
) IS
    e_possui_filhos EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_possui_filhos, -2292);
BEGIN
    DELETE FROM Animal
     WHERE ID_Animal = p_id_animal;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20050, 'Animal nao encontrado.');
    END IF;
EXCEPTION
    WHEN e_possui_filhos THEN
        RAISE_APPLICATION_ERROR(-20051,
            'RN16: o animal possui historico ou registros vinculados e nao pode ser excluido.');
END prc_excluir_animal;
/

-- Cursor e record | Procedure: relatorio de ocupacao por unidade
CREATE OR REPLACE PROCEDURE prc_relatorio_ocupacao IS
    CURSOR c_unidades IS
        SELECT ID_Unidade_ONG, Nome_Unidade, Capacidade
          FROM Unidade_ONG
         ORDER BY Nome_Unidade;
    r_unidade c_unidades%ROWTYPE;
    v_vagas   NUMBER;
BEGIN
    OPEN c_unidades;
    LOOP
        FETCH c_unidades INTO r_unidade;
        EXIT WHEN c_unidades%NOTFOUND;

        v_vagas := fn_vagas_disponiveis(r_unidade.ID_Unidade_ONG);
        DBMS_OUTPUT.PUT_LINE(r_unidade.Nome_Unidade
            || ' | capacidade: ' || r_unidade.Capacidade
            || ' | vagas: '      || v_vagas);
    END LOOP;
    CLOSE c_unidades;
END prc_relatorio_ocupacao;
/
