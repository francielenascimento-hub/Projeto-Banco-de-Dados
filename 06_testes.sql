-- ============================================================================
-- 06_TESTES.SQL - DEMONSTRAÇÃO DO PL/SQL E DAS RESTRIÇÕES
-- Ordem dos scripts: 01 -> 02 -> 05 -> 03 -> 04 -> 06
-- Rode um bloco de cada vez, na ordem. Os comandos marcados com
-- "Esperado: ORA-..." DEVEM falhar: o erro mostra a regra funcionando.
-- Se o FreeSQL não reconhecer o SET SERVEROUTPUT ON, apague essa linha.
-- ============================================================================

SET SERVEROUTPUT ON;

-- ============================================================================
-- PARTE 1: FUNCTION fn_maior_idade E TRIGGERS DA RN03
-- ============================================================================

-- 1.1 Cadastro de uma pessoa menor de idade (voluntários podem ser menores)
INSERT INTO Pessoa (ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email)
VALUES (6, 'SOLTEIRO', '22233344455', 'Lucas Souza', DATE '2012-03-10', '16999990000', NULL);

-- 1.2 A function retorna 1 para maior de idade e 0 para menor
SELECT Nome, Data_Nascimento, fn_maior_idade(ID_Pessoa, SYSDATE) AS Maior_De_Idade
FROM   Pessoa
WHERE  CPF IN ('11111111111', '22233344455');

-- 1.3 RN03: menor de idade não pode doar
-- Esperado: ORA-20012
INSERT INTO Doacao (ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo)
VALUES ((SELECT ID_Pessoa FROM Pessoa WHERE CPF = '22233344455'), 1, 20.00, DATE '2026-11-05', 'PIX');

-- 1.4 RN03: menor de idade não pode adotar
-- Esperado: ORA-20011
INSERT INTO Adocao (ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status)
VALUES ((SELECT ID_Pessoa FROM Pessoa WHERE CPF = '22233344455'), 4, DATE '2026-11-05', NULL, 'EM_ANALISE');

-- ============================================================================
-- PARTE 2: PROCEDURE prc_registrar_voluntario (RN12)
-- ============================================================================

-- 2.1 O menor de idade pode ser voluntário
DECLARE
    v_pessoa Pessoa.ID_Pessoa%TYPE;
    v_id     Voluntariado.ID_Voluntariado%TYPE;
BEGIN
    SELECT ID_Pessoa INTO v_pessoa FROM Pessoa WHERE CPF = '22233344455';
    prc_registrar_voluntario(5, v_pessoa, 'PASSEADOR', DATE '2026-11-05', v_id);
    DBMS_OUTPUT.PUT_LINE('Voluntariado criado: ' || v_id);
END;
/

-- 2.2 RN12: unidade no limite não aceita novo voluntário
UPDATE Unidade_ONG SET Limite_Voluntarios = 1 WHERE ID_Unidade_ONG = 2;

-- Esperado: ORA-20070
DECLARE
    v_id Voluntariado.ID_Voluntariado%TYPE;
BEGIN
    prc_registrar_voluntario(2, 5, 'LIMPEZA', DATE '2026-11-05', v_id);
END;
/

UPDATE Unidade_ONG SET Limite_Voluntarios = 10 WHERE ID_Unidade_ONG = 2;

-- ============================================================================
-- PARTE 3: PROCEDURE prc_registrar_resgate E FUNCTION fn_vagas_disponiveis (RN11)
-- ============================================================================

-- 3.1 Vagas antes do resgate
SELECT Nome_Unidade, fn_vagas_disponiveis(ID_Unidade_ONG) AS Vagas
FROM   Unidade_ONG
WHERE  ID_Unidade_ONG = 5;

-- 3.2 Resgate cadastrado pela procedure
DECLARE
    v_id Animal.ID_Animal%TYPE;
BEGIN
    prc_registrar_resgate(5, 3, 'Pipoca', DATE '2026-11-05', DATE '2026-06-01', 'F', v_id);
    DBMS_OUTPUT.PUT_LINE('Animal cadastrado: ' || v_id);
END;
/

-- 3.3 RN15: o trigger registrou o primeiro status do novo animal
SELECT a.Nome, h.Status_Anterior, h.Status_Novo, h.Data_Alteracao
FROM   Historico_Status h
JOIN   Animal a ON a.ID_Animal = h.ID_Animal
WHERE  a.Nome = 'Pipoca';

-- 3.4 RN11: unidade sem vaga não recebe novo animal
-- A unidade 5 fica com 3 animais sob cuidado, então a capacidade 3 a deixa sem vagas.
UPDATE Unidade_ONG SET Capacidade = 3 WHERE ID_Unidade_ONG = 5;

-- Esperado: ORA-20020
DECLARE
    v_id Animal.ID_Animal%TYPE;
BEGIN
    prc_registrar_resgate(5, 3, 'Paçoca', DATE '2026-11-05', DATE '2026-07-01', 'M', v_id);
END;
/

UPDATE Unidade_ONG SET Capacidade = 60 WHERE ID_Unidade_ONG = 5;

-- ============================================================================
-- PARTE 4: FLUXO DE ADOÇÃO (RN08, RN09, RN10)
-- ============================================================================

-- 4.1 Nova adoção de um animal DISPONIVEL
INSERT INTO Adocao (ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status)
VALUES (5, 1, DATE '2026-11-05', NULL, 'EM_ANALISE');

-- 4.2 O trigger trg_adocao_status_animal mudou o animal para EM_PROCESSO
SELECT ID_Animal, Nome, Status FROM Animal WHERE ID_Animal = 1;

-- 4.3 RN09: animal que não está DISPONIVEL não inicia adoção
-- Esperado: ORA-20040
INSERT INTO Adocao (ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status)
VALUES (6, 1, DATE '2026-11-05', NULL, 'EM_ANALISE');

-- 4.4 RN08: reabrir um processo antigo do mesmo animal criaria dois processos ativos
-- Esperado: ORA-00001 (índice uq_adocao_ativa)
UPDATE Adocao SET Status = 'EM_ANALISE' WHERE ID_Adocao = 7;

-- 4.5 RN10: só uma adoção APROVADA pode ser concluída
-- Esperado: ORA-20031
DECLARE
    v_id Adocao.ID_Adocao%TYPE;
BEGIN
    SELECT ID_Adocao INTO v_id
    FROM   Adocao
    WHERE  ID_Animal = 1 AND Status = 'EM_ANALISE';
    prc_concluir_adocao(v_id);
END;
/

-- 4.6 RN10: conclusão da adoção 5, que está APROVADA
BEGIN
    prc_concluir_adocao(5);
END;
/

-- 4.7 A adoção ficou CONCLUIDA, e o animal 9 ficou ADOTADO
SELECT ad.ID_Adocao, ad.Status AS Status_Adocao, ad.Data_Conclusao,
       an.Nome, an.Status AS Status_Animal
FROM   Adocao ad
JOIN   Animal an ON an.ID_Animal = ad.ID_Animal
WHERE  ad.ID_Adocao = 5;

-- ============================================================================
-- PARTE 5: EXCLUSÃO PROTEGIDA E DATAS (RN16, RN07)
-- ============================================================================

-- 5.1 RN16: animal com adoções e vacinas não pode ser excluído
-- Esperado: ORA-20051
BEGIN
    prc_excluir_animal(1);
END;
/

-- 5.2 RN07: despesa com data futura
-- Esperado: ORA-20060
INSERT INTO Despesa (ID_Unidade_ONG, Tipo, Valor, Data_Despesa)
VALUES (1, 'ALIMENTACAO', 100.00, DATE '2027-01-10');

-- 5.3 RN07: vacina aplicada antes do resgate do animal
-- Esperado: ORA-20061
INSERT INTO Vacinacao (ID_Animal, Vacina, Dose, Data_Aplicacao)
VALUES (20, 'V10', 1, DATE '2026-10-01');

-- ============================================================================
-- PARTE 6: RELATÓRIO COM CURSOR E HISTÓRICO DE STATUS
-- ============================================================================

-- 6.1 Relatório de ocupação (a saída aparece no DBMS_OUTPUT)
BEGIN
    prc_relatorio_ocupacao;
END;
/

-- 6.2 RN15: todas as mudanças de status registradas pelos testes e pelo 03
SELECT h.ID_Historico_Status, a.Nome, h.Status_Anterior, h.Status_Novo, h.Data_Alteracao
FROM   Historico_Status h
JOIN   Animal a ON a.ID_Animal = h.ID_Animal
ORDER  BY h.ID_Historico_Status;

-- ============================================================================
-- PARTE 7: RESTRIÇÕES DECLARATIVAS DO DDL
-- ============================================================================

-- 7.1 UNIQUE: CPF já cadastrado
-- Esperado: ORA-00001
INSERT INTO Pessoa (ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email)
VALUES (6, 'SOLTEIRO', '11111111111', 'Pessoa Repetida', DATE '1990-01-01', '16999991111', NULL);

-- 7.2 NOT NULL: pessoa sem nome
-- Esperado: ORA-01400
INSERT INTO Pessoa (ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email)
VALUES (6, 'SOLTEIRO', '99988877766', NULL, DATE '1990-01-01', '16999991111', NULL);

-- 7.3 CHECK: doação com valor zero
-- Esperado: ORA-02290
INSERT INTO Doacao (ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo)
VALUES (1, 1, 0, DATE '2026-11-05', 'PIX');

-- 7.4 CHECK: status escrito fora do padrão
-- Esperado: ORA-02290
UPDATE Animal SET Status = 'disponivel' WHERE ID_Animal = 20;

-- 7.5 FK: animal com raça inexistente
-- Esperado: ORA-02291
INSERT INTO Animal (ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status)
VALUES (1, 99, 'Sem Raca', DATE '2026-11-05', DATE '2026-01-01', 'M', 'EM_TRATAMENTO');

-- 7.6 FK: espécie que tem raças vinculadas
-- Esperado: ORA-02292
DELETE FROM Especie WHERE ID_Especie = 1;

-- 7.7 UNIQUE composto: mesma dose da mesma vacina no animal
-- Esperado: ORA-00001
INSERT INTO Vacinacao (ID_Animal, Vacina, Dose, Data_Aplicacao)
VALUES (1, 'V10', 1, DATE '2026-03-01');

-- 7.8 Tamanho da coluna: CEP com hífen não cabe em CHAR(8)
-- Esperado: ORA-12899
INSERT INTO Endereco (Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento)
VALUES ('Rua Teste', '1', 'Centro', 'Ribeirao Preto', 'SP', '14020-000', NULL);

COMMIT;