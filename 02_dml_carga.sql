-- ============================================================================
-- 02_DML_CARGA.SQL - CARGA DE DADOS DE TESTE
-- Ordem dos scripts: 01 -> 02 -> 05 -> 03 -> 04 -> 06
-- Rode ANTES do 05_plsql.sql: o trigger da RN09 bloquearia as adoções
-- já concluídas que esta carga insere.
-- ============================================================================

-- ============================================================================
-- NÍVEL 1: TABELAS SEM CHAVE ESTRANGEIRA (FK)
-- ============================================================================

-- ENDERECO (15 Registros: 1 a 5 das unidades, 6 a 15 das pessoas)

INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (1, 'Rua das Flores', '123', 'Centro', 'Ribeirao Preto', 'SP', '14010000', NULL);
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (2, 'Av Brasil', '456', 'Jardim Paulista', 'Ribeirao Preto', 'SP', '14020000', 'Sala 2');
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (3, 'Rua Sete de Setembro', '789', 'Centro', 'Limeira', 'SP', '13480000', NULL);
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (4, 'Av Paulista', '1000', 'Bela Vista', 'Sao Paulo', 'SP', '01310100', 'Apto 45');
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (5, 'Rua XV de Novembro', '200', 'Centro', 'Campinas', 'SP', '13010000', NULL);
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (6, 'Rua Amador Bueno', '350', 'Centro', 'Ribeirao Preto', 'SP', '14010070', NULL);
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (7, 'Rua Garibaldi', '1200', 'Centro', 'Ribeirao Preto', 'SP', '14010170', 'Apto 32');
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (8, 'Av Presidente Vargas', '2001', 'Jardim America', 'Ribeirao Preto', 'SP', '14020260', NULL);
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (9, 'Rua Cerqueira Cesar', '540', 'Centro', 'Ribeirao Preto', 'SP', '14010130', NULL);
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (10, 'Rua Visconde de Inhauma', '88', 'Centro', 'Ribeirao Preto', 'SP', '14010100', 'Casa 2');
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (11, 'Av Independencia', '3100', 'Alto da Boa Vista', 'Ribeirao Preto', 'SP', '14025000', NULL);
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (12, 'Rua Barao do Amazonas', '415', 'Centro', 'Limeira', 'SP', '13480010', NULL);
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (13, 'Rua Augusta', '900', 'Consolacao', 'Sao Paulo', 'SP', '01305000', 'Apto 101');
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (14, 'Estrada Municipal', 'S/N', 'Zona Rural', 'Campinas', 'SP', '13100000', NULL);
INSERT INTO Endereco (ID_Endereco, Rua, Numero, Bairro, Cidade, Estado, CEP, Complemento) VALUES (15, 'Rua Jose Paulino', '77', 'Centro', 'Campinas', 'SP', '13013000', NULL);

-- ESPECIE (2 Registros)

INSERT INTO Especie (ID_Especie, Nome) VALUES (1, 'CACHORRO');
INSERT INTO Especie (ID_Especie, Nome) VALUES (2, 'GATO');

-- ============================================================================
-- NÍVEL 2: TABELAS QUE DEPENDEM DO NÍVEL 1
-- ============================================================================

-- RACA (4 Registros)

INSERT INTO Raca (ID_Raca, ID_Especie, Nome) VALUES (1, 1, 'SRD');
INSERT INTO Raca (ID_Raca, ID_Especie, Nome) VALUES (2, 1, 'POODLE');
INSERT INTO Raca (ID_Raca, ID_Especie, Nome) VALUES (3, 2, 'SRD');
INSERT INTO Raca (ID_Raca, ID_Especie, Nome) VALUES (4, 2, 'SIAMES');

-- UNIDADE_ONG (5 Registros)

INSERT INTO Unidade_ONG (ID_Unidade_ONG, ID_Endereco, Capacidade, Limite_Voluntarios, Nome_Unidade) VALUES (1, 1, 100, 20, 'SEDE RIBEIRAO PRETO');
INSERT INTO Unidade_ONG (ID_Unidade_ONG, ID_Endereco, Capacidade, Limite_Voluntarios, Nome_Unidade) VALUES (2, 2, 50, 10, 'FILIAL JARDIM PAULISTA');
INSERT INTO Unidade_ONG (ID_Unidade_ONG, ID_Endereco, Capacidade, Limite_Voluntarios, Nome_Unidade) VALUES (3, 3, 80, 15, 'UNIDADE LIMEIRA');
INSERT INTO Unidade_ONG (ID_Unidade_ONG, ID_Endereco, Capacidade, Limite_Voluntarios, Nome_Unidade) VALUES (4, 4, 150, 30, 'SEDE SAO PAULO');
INSERT INTO Unidade_ONG (ID_Unidade_ONG, ID_Endereco, Capacidade, Limite_Voluntarios, Nome_Unidade) VALUES (5, 5, 60, 10, 'UNIDADE CAMPINAS');

-- PESSOA (20 Registros; cada endereço de 6 a 15 tem 2 moradores)

INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (1, 6, 'SOLTEIRO', '11111111111', 'Ana Souza', TO_DATE('1990-05-15', 'YYYY-MM-DD'), '11999991111', 'ana@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (2, 7, 'CASADO', '22222222222', 'Carlos Silva', TO_DATE('1985-10-20', 'YYYY-MM-DD'), '11999992222', 'carlos@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (3, 12, 'DIVORCIADO', '33333333333', 'Mariana Oliveira', TO_DATE('1992-02-10', 'YYYY-MM-DD'), '11999993333', 'mariana@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (4, 8, 'UNIAO_ESTAVEL', '44444444444', 'Roberto Almeida', TO_DATE('1988-08-30', 'YYYY-MM-DD'), '11999994444', NULL);
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (5, 9, 'SOLTEIRO', '55555555555', 'Fernanda Lima', TO_DATE('1995-12-05', 'YYYY-MM-DD'), '11999995555', 'fernanda@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (6, 7, 'CASADO', '66666666666', 'Lucas Martins', TO_DATE('1980-04-12', 'YYYY-MM-DD'), '11999996666', 'lucas@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (7, 10, 'SOLTEIRO', '77777777777', 'Juliana Costa', TO_DATE('1998-07-22', 'YYYY-MM-DD'), '11999997777', NULL);
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (8, 12, 'VIUVO', '88888888888', 'Marcos Pereira', TO_DATE('1975-01-18', 'YYYY-MM-DD'), '11999998888', 'marcos@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (9, 13, 'SOLTEIRO', '99999999999', 'Camila Santos', TO_DATE('2000-09-09', 'YYYY-MM-DD'), '11999999999', 'camila@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (10, 14, 'CASADO', '10101010101', 'Pedro Henrique', TO_DATE('1982-11-11', 'YYYY-MM-DD'), '11999991010', 'pedro@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (11, 11, 'SOLTEIRO', '12121212121', 'Beatriz Rocha', TO_DATE('1994-03-25', 'YYYY-MM-DD'), '11999991212', NULL);
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (12, 15, 'DIVORCIADO', '13131313131', 'Rafael Sousa', TO_DATE('1989-06-14', 'YYYY-MM-DD'), '11999991313', 'rafael@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (13, 8, 'UNIAO_ESTAVEL', '14141414141', 'Amanda Ribeiro', TO_DATE('1991-08-08', 'YYYY-MM-DD'), '11999991414', 'amanda@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (14, 13, 'SOLTEIRO', '15151515151', 'Diego Carvalho', TO_DATE('1996-02-28', 'YYYY-MM-DD'), '11999991515', NULL);
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (15, 14, 'CASADO', '16161616161', 'Patricia Gomes', TO_DATE('1984-12-12', 'YYYY-MM-DD'), '11999991616', 'patricia@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (16, 6, 'SOLTEIRO', '17171717171', 'Thiago Santana', TO_DATE('1993-05-05', 'YYYY-MM-DD'), '11999991717', 'thiago@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (17, 9, 'VIUVO', '18181818181', 'Leticia Mendes', TO_DATE('1970-10-30', 'YYYY-MM-DD'), '11999991818', 'leticia@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (18, 10, 'SOLTEIRO', '19191919191', 'Samuel Dias', TO_DATE('1997-04-17', 'YYYY-MM-DD'), '11999991919', 'samuel@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (19, 11, 'CASADO', '20202020202', 'Jordana Lima', TO_DATE('1986-09-03', 'YYYY-MM-DD'), '11999992020', 'jordana@email.com');
INSERT INTO Pessoa (ID_Pessoa, ID_Endereco, Estado_Civil, CPF, Nome, Data_Nascimento, Telefone, Email) VALUES (20, 15, 'DIVORCIADO', '21212121212', 'Bruno Alves', TO_DATE('1983-01-21', 'YYYY-MM-DD'), '11999992121', NULL);

-- ============================================================================
-- NÍVEL 3: TABELAS QUE DEPENDEM DE UNIDADE E PESSOA
-- ============================================================================

-- ANIMAL (20 Registros)

INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (1, 1, 1, 'Rex', TO_DATE('2026-01-10', 'YYYY-MM-DD'), TO_DATE('2024-01-10', 'YYYY-MM-DD'), 'M', 'DISPONIVEL');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (2, 1, 3, 'Mia', TO_DATE('2026-02-15', 'YYYY-MM-DD'), TO_DATE('2025-05-20', 'YYYY-MM-DD'), 'F', 'EM_TRATAMENTO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (3, 2, 2, 'Bolinha', TO_DATE('2026-03-01', 'YYYY-MM-DD'), TO_DATE('2023-11-15', 'YYYY-MM-DD'), 'M', 'EM_PROCESSO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (4, 3, 4, 'Simba', TO_DATE('2026-04-12', 'YYYY-MM-DD'), TO_DATE('2026-01-01', 'YYYY-MM-DD'), 'M', 'DISPONIVEL');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (5, 4, 1, 'Luna', TO_DATE('2026-05-20', 'YYYY-MM-DD'), TO_DATE('2022-08-10', 'YYYY-MM-DD'), 'F', 'ADOTADO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (6, 5, 3, 'Nina', TO_DATE('2026-06-05', 'YYYY-MM-DD'), TO_DATE('2025-12-10', 'YYYY-MM-DD'), 'F', 'DISPONIVEL');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (7, 1, 1, 'Thor', TO_DATE('2026-07-10', 'YYYY-MM-DD'), TO_DATE('2024-03-15', 'YYYY-MM-DD'), 'M', 'EM_TRATAMENTO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (8, 2, 2, 'Belinha', TO_DATE('2026-08-15', 'YYYY-MM-DD'), TO_DATE('2021-07-20', 'YYYY-MM-DD'), 'F', 'DISPONIVEL');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (9, 3, 4, 'Mingau', TO_DATE('2026-09-01', 'YYYY-MM-DD'), TO_DATE('2026-02-28', 'YYYY-MM-DD'), 'M', 'EM_PROCESSO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (10, 4, 1, 'Mel', TO_DATE('2026-10-12', 'YYYY-MM-DD'), TO_DATE('2023-09-05', 'YYYY-MM-DD'), 'F', 'DISPONIVEL');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (11, 5, 3, 'Frajola', TO_DATE('2026-01-25', 'YYYY-MM-DD'), TO_DATE('2025-06-18', 'YYYY-MM-DD'), 'M', 'ADOTADO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (12, 1, 1, 'Bob', TO_DATE('2026-02-28', 'YYYY-MM-DD'), TO_DATE('2024-11-11', 'YYYY-MM-DD'), 'M', 'DISPONIVEL');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (13, 2, 2, 'Amora', TO_DATE('2026-03-10', 'YYYY-MM-DD'), TO_DATE('2022-04-30', 'YYYY-MM-DD'), 'F', 'EM_TRATAMENTO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (14, 3, 4, 'Garfield', TO_DATE('2026-04-20', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'M', 'DISPONIVEL');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (15, 4, 1, 'Cacau', TO_DATE('2026-05-05', 'YYYY-MM-DD'), TO_DATE('2023-10-25', 'YYYY-MM-DD'), 'F', 'EM_PROCESSO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (16, 5, 3, 'Salem', TO_DATE('2026-06-18', 'YYYY-MM-DD'), TO_DATE('2026-03-10', 'YYYY-MM-DD'), 'M', 'DISPONIVEL');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (17, 1, 1, 'Marley', TO_DATE('2026-07-22', 'YYYY-MM-DD'), TO_DATE('2021-12-05', 'YYYY-MM-DD'), 'M', 'ADOTADO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (18, 2, 2, 'Princesa', TO_DATE('2026-08-08', 'YYYY-MM-DD'), TO_DATE('2024-08-20', 'YYYY-MM-DD'), 'F', 'DISPONIVEL');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (19, 3, 4, 'Tom', TO_DATE('2026-09-14', 'YYYY-MM-DD'), TO_DATE('2025-07-01', 'YYYY-MM-DD'), 'M', 'EM_TRATAMENTO');
INSERT INTO Animal (ID_Animal, ID_Unidade_ONG, ID_Raca, Nome, Data_Resgate, Data_Nascimento_Estipulada, Sexo, Status) VALUES (20, 4, 1, 'Lola', TO_DATE('2026-10-30', 'YYYY-MM-DD'), TO_DATE('2026-05-15', 'YYYY-MM-DD'), 'F', 'DISPONIVEL');

-- MANDATO_DIRETORIA (9 Registros; o 8 é um mandato encerrado)

INSERT INTO Mandato_Diretoria (ID_Mandato_Diretoria, ID_Unidade_ONG, ID_Pessoa, Funcao, Remuneracao, Data_Inicio, Data_Saida) VALUES (1, 1, 4, 'PRESIDENTE', 0.00, TO_DATE('2025-01-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Mandato_Diretoria (ID_Mandato_Diretoria, ID_Unidade_ONG, ID_Pessoa, Funcao, Remuneracao, Data_Inicio, Data_Saida) VALUES (2, 2, 8, 'TESOUREIRO', 1500.00, TO_DATE('2025-03-15', 'YYYY-MM-DD'), NULL);
INSERT INTO Mandato_Diretoria (ID_Mandato_Diretoria, ID_Unidade_ONG, ID_Pessoa, Funcao, Remuneracao, Data_Inicio, Data_Saida) VALUES (3, 1, 6, 'TESOUREIRO', 0.00, TO_DATE('2025-01-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Mandato_Diretoria (ID_Mandato_Diretoria, ID_Unidade_ONG, ID_Pessoa, Funcao, Remuneracao, Data_Inicio, Data_Saida) VALUES (4, 2, 17, 'PRESIDENTE', 0.00, TO_DATE('2025-02-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Mandato_Diretoria (ID_Mandato_Diretoria, ID_Unidade_ONG, ID_Pessoa, Funcao, Remuneracao, Data_Inicio, Data_Saida) VALUES (5, 3, 10, 'PRESIDENTE', 0.00, TO_DATE('2025-04-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Mandato_Diretoria (ID_Mandato_Diretoria, ID_Unidade_ONG, ID_Pessoa, Funcao, Remuneracao, Data_Inicio, Data_Saida) VALUES (6, 4, 19, 'PRESIDENTE', 2000.00, TO_DATE('2025-01-15', 'YYYY-MM-DD'), NULL);
INSERT INTO Mandato_Diretoria (ID_Mandato_Diretoria, ID_Unidade_ONG, ID_Pessoa, Funcao, Remuneracao, Data_Inicio, Data_Saida) VALUES (7, 5, 15, 'PRESIDENTE', 0.00, TO_DATE('2025-05-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Mandato_Diretoria (ID_Mandato_Diretoria, ID_Unidade_ONG, ID_Pessoa, Funcao, Remuneracao, Data_Inicio, Data_Saida) VALUES (8, 1, 2, 'PRESIDENTE', 0.00, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'));
INSERT INTO Mandato_Diretoria (ID_Mandato_Diretoria, ID_Unidade_ONG, ID_Pessoa, Funcao, Remuneracao, Data_Inicio, Data_Saida) VALUES (9, 4, 12, 'SECRETARIO', 800.00, TO_DATE('2025-06-01', 'YYYY-MM-DD'), NULL);

-- DESPESA (10 Registros; o 10 foi lançado com valor errado e é excluído no 03)

INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (1, 1, 'ALIMENTACAO', 450.50, TO_DATE('2026-10-05', 'YYYY-MM-DD'));
INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (2, 2, 'MEDICAMENTOS', 120.00, TO_DATE('2026-10-10', 'YYYY-MM-DD'));
INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (3, 1, 'VETERINARIO', 300.00, TO_DATE('2026-09-12', 'YYYY-MM-DD'));
INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (4, 2, 'ALIMENTACAO', 280.00, TO_DATE('2026-09-20', 'YYYY-MM-DD'));
INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (5, 3, 'ALIMENTACAO', 350.00, TO_DATE('2026-10-02', 'YYYY-MM-DD'));
INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (6, 4, 'ALUGUEL', 2500.00, TO_DATE('2026-10-01', 'YYYY-MM-DD'));
INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (7, 5, 'MANUTENCAO', 180.00, TO_DATE('2026-10-08', 'YYYY-MM-DD'));
INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (8, 3, 'MEDICAMENTOS', 95.90, TO_DATE('2026-10-15', 'YYYY-MM-DD'));
INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (9, 4, 'TRANSPORTE', 60.00, TO_DATE('2026-10-20', 'YYYY-MM-DD'));
INSERT INTO Despesa (ID_Despesa, ID_Unidade_ONG, Tipo, Valor, Data_Despesa) VALUES (10, 1, 'ALIMENTACAO', 4500.00, TO_DATE('2026-10-22', 'YYYY-MM-DD'));

-- VOLUNTARIADO (10 Registros; o 7 é um voluntariado encerrado)

INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (1, 1, 1, 'CUIDADOR', TO_DATE('2026-01-15', 'YYYY-MM-DD'), NULL);
INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (2, 2, 2, 'LIMPEZA', TO_DATE('2026-03-10', 'YYYY-MM-DD'), NULL);
INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (3, 1, 3, 'PASSEADOR', TO_DATE('2026-02-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (4, 3, 5, 'RESGATE', TO_DATE('2026-04-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (5, 4, 6, 'TRANSPORTE', TO_DATE('2026-05-10', 'YYYY-MM-DD'), NULL);
INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (6, 5, 10, 'ADMINISTRATIVO', TO_DATE('2026-03-20', 'YYYY-MM-DD'), NULL);
INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (7, 2, 15, 'EVENTOS', TO_DATE('2026-06-01', 'YYYY-MM-DD'), TO_DATE('2026-09-30', 'YYYY-MM-DD'));
INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (8, 1, 17, 'CUIDADOR', TO_DATE('2026-07-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (9, 3, 1, 'LIMPEZA', TO_DATE('2026-08-01', 'YYYY-MM-DD'), NULL);
INSERT INTO Voluntariado (ID_Voluntariado, ID_Unidade_ONG, ID_Pessoa, Funcao, Data_Inicio, Data_Fim) VALUES (10, 4, 20, 'PASSEADOR', TO_DATE('2026-09-10', 'YYYY-MM-DD'), NULL);

-- DOACAO (11 Registros; o 11 é uma cópia do 10 e é excluído no 03)

INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (1, 4, 1, 100.00, TO_DATE('2026-09-01', 'YYYY-MM-DD'), 'PIX');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (2, 5, 2, 50.00, TO_DATE('2026-09-15', 'YYYY-MM-DD'), 'DINHEIRO');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (3, 1, 1, 200.00, TO_DATE('2026-08-10', 'YYYY-MM-DD'), 'CARTAO_CREDITO');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (4, 3, 3, 75.00, TO_DATE('2026-08-20', 'YYYY-MM-DD'), 'PIX');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (5, 6, 4, 500.00, TO_DATE('2026-09-05', 'YYYY-MM-DD'), 'TRANSFERENCIA');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (6, 9, 5, 30.00, TO_DATE('2026-09-20', 'YYYY-MM-DD'), 'PIX');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (7, 10, 1, 150.00, TO_DATE('2026-10-01', 'YYYY-MM-DD'), 'BOLETO');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (8, 13, 2, 80.00, TO_DATE('2026-10-05', 'YYYY-MM-DD'), 'CARTAO_DEBITO');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (9, 16, 3, 120.00, TO_DATE('2026-10-12', 'YYYY-MM-DD'), 'PIX');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (10, 19, 4, 1000.00, TO_DATE('2026-10-18', 'YYYY-MM-DD'), 'TRANSFERENCIA');
INSERT INTO Doacao (ID_Doacao, ID_Pessoa, ID_Unidade_ONG, Valor, Data_Doacao, Metodo) VALUES (11, 19, 4, 1000.00, TO_DATE('2026-10-18', 'YYYY-MM-DD'), 'TRANSFERENCIA');

-- ============================================================================
-- NÍVEL 4: TABELAS QUE DEPENDEM DO ANIMAL
-- ============================================================================

-- ADOCAO (10 Registros)
-- Cada animal ADOTADO tem um processo CONCLUIDA, e cada animal EM_PROCESSO
-- tem um processo ativo. Os processos 7 a 10 mostram o histórico de um animal
-- com reprovação, cancelamento e devolução.

INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (1, 7, 5, TO_DATE('2026-07-01', 'YYYY-MM-DD'), TO_DATE('2026-07-15', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (2, 9, 3, TO_DATE('2026-10-25', 'YYYY-MM-DD'), NULL, 'EM_ANALISE');
INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (3, 11, 11, TO_DATE('2026-03-01', 'YYYY-MM-DD'), TO_DATE('2026-03-10', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (4, 12, 17, TO_DATE('2026-08-05', 'YYYY-MM-DD'), TO_DATE('2026-08-20', 'YYYY-MM-DD'), 'CONCLUIDA');
INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (5, 13, 9, TO_DATE('2026-10-10', 'YYYY-MM-DD'), NULL, 'APROVADA');
INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (6, 14, 15, TO_DATE('2026-10-20', 'YYYY-MM-DD'), NULL, 'EM_ANALISE');
INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (7, 16, 1, TO_DATE('2026-03-01', 'YYYY-MM-DD'), TO_DATE('2026-03-12', 'YYYY-MM-DD'), 'REPROVADA');
INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (8, 18, 8, TO_DATE('2026-09-01', 'YYYY-MM-DD'), TO_DATE('2026-09-05', 'YYYY-MM-DD'), 'CANCELADA');
INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (9, 19, 12, TO_DATE('2026-04-01', 'YYYY-MM-DD'), TO_DATE('2026-04-15', 'YYYY-MM-DD'), 'DEVOLVIDA');
INSERT INTO Adocao (ID_Adocao, ID_Pessoa, ID_Animal, Data_Inicio, Data_Conclusao, Status) VALUES (10, 20, 15, TO_DATE('2026-06-01', 'YYYY-MM-DD'), TO_DATE('2026-06-10', 'YYYY-MM-DD'), 'REPROVADA');

-- VACINACAO (10 Registros; o 10 foi lançado por engano e é excluído no 03)

INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (1, 1, 'ANTIRRABICA', 1, TO_DATE('2026-02-01', 'YYYY-MM-DD'));
INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (2, 2, 'V4', 1, TO_DATE('2026-03-05', 'YYYY-MM-DD'));
INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (3, 1, 'V10', 1, TO_DATE('2026-02-01', 'YYYY-MM-DD'));
INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (4, 1, 'V10', 2, TO_DATE('2026-02-22', 'YYYY-MM-DD'));
INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (5, 5, 'V10', 1, TO_DATE('2026-06-01', 'YYYY-MM-DD'));
INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (6, 6, 'V4', 1, TO_DATE('2026-06-20', 'YYYY-MM-DD'));
INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (7, 8, 'V10', 1, TO_DATE('2026-08-25', 'YYYY-MM-DD'));
INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (8, 12, 'ANTIRRABICA', 1, TO_DATE('2026-03-15', 'YYYY-MM-DD'));
INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (9, 14, 'V4', 1, TO_DATE('2026-05-01', 'YYYY-MM-DD'));
INSERT INTO Vacinacao (ID_Vacinacao, ID_Animal, Vacina, Dose, Data_Aplicacao) VALUES (10, 2, 'V4', 2, TO_DATE('2026-03-05', 'YYYY-MM-DD'));

-- HISTORICO_VETERINARIO (8 Registros; o 8 é uma cópia do 4 e é excluído no 03)

INSERT INTO Historico_Veterinario (ID_Historico_Veterinario, ID_Animal, Queixa, Estado_Tratamento, Diagnostico, Data_Atendimento, Tratamento) VALUES (1, 2, 'Apatia e falta de apetite', 'EM_ANDAMENTO', 'Virose', TO_DATE('2026-02-20', 'YYYY-MM-DD'), 'Soro e antibiotico');
INSERT INTO Historico_Veterinario (ID_Historico_Veterinario, ID_Animal, Queixa, Estado_Tratamento, Diagnostico, Data_Atendimento, Tratamento) VALUES (2, 7, 'Ferida na pata dianteira', 'CONCLUIDO', 'Corte superficial', TO_DATE('2026-07-15', 'YYYY-MM-DD'), 'Curativo local e anti-inflamatorio');
INSERT INTO Historico_Veterinario (ID_Historico_Veterinario, ID_Animal, Queixa, Estado_Tratamento, Diagnostico, Data_Atendimento, Tratamento) VALUES (3, 7, 'Retorno: pata ainda inchada', 'EM_ANDAMENTO', 'Inflamacao', TO_DATE('2026-07-25', 'YYYY-MM-DD'), 'Antibiotico por 10 dias');
INSERT INTO Historico_Veterinario (ID_Historico_Veterinario, ID_Animal, Queixa, Estado_Tratamento, Diagnostico, Data_Atendimento, Tratamento) VALUES (4, 13, 'Tosse persistente', 'EM_ANDAMENTO', 'Traqueobronquite', TO_DATE('2026-03-15', 'YYYY-MM-DD'), 'Xarope e repouso');
INSERT INTO Historico_Veterinario (ID_Historico_Veterinario, ID_Animal, Queixa, Estado_Tratamento, Diagnostico, Data_Atendimento, Tratamento) VALUES (5, 1, 'Check-up de rotina', 'SEM_TRATAMENTO', 'Saudavel', TO_DATE('2026-01-12', 'YYYY-MM-DD'), NULL);
INSERT INTO Historico_Veterinario (ID_Historico_Veterinario, ID_Animal, Queixa, Estado_Tratamento, Diagnostico, Data_Atendimento, Tratamento) VALUES (6, 4, 'Coceira intensa', 'CONCLUIDO', 'Pulgas', TO_DATE('2026-04-15', 'YYYY-MM-DD'), 'Antipulgas');
INSERT INTO Historico_Veterinario (ID_Historico_Veterinario, ID_Animal, Queixa, Estado_Tratamento, Diagnostico, Data_Atendimento, Tratamento) VALUES (7, 10, 'Avaliacao pos-resgate', 'AGUARDANDO', NULL, TO_DATE('2026-10-14', 'YYYY-MM-DD'), NULL);
INSERT INTO Historico_Veterinario (ID_Historico_Veterinario, ID_Animal, Queixa, Estado_Tratamento, Diagnostico, Data_Atendimento, Tratamento) VALUES (8, 13, 'Tosse persistente', 'EM_ANDAMENTO', 'Traqueobronquite', TO_DATE('2026-03-15', 'YYYY-MM-DD'), 'Xarope e repouso');

-- HISTORICO_STATUS: sem INSERT manual.
-- Os registros desta tabela são gravados pelo trigger trg_animal_historico_status.

COMMIT;

-- ============================================================================
-- AJUSTE DOS CONTADORES DE IDENTITY
-- Como a carga informou os IDs, o contador de cada tabela ainda está em 1.
-- Estes comandos fazem o próximo ID gerado começar depois do maior ID existente.
-- ============================================================================

ALTER TABLE Endereco              MODIFY ID_Endereco              GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Especie               MODIFY ID_Especie               GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Raca                  MODIFY ID_Raca                  GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Unidade_ONG           MODIFY ID_Unidade_ONG           GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Pessoa                MODIFY ID_Pessoa                GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Animal                MODIFY ID_Animal                GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Despesa               MODIFY ID_Despesa               GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Voluntariado          MODIFY ID_Voluntariado          GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Doacao                MODIFY ID_Doacao                GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Mandato_Diretoria     MODIFY ID_Mandato_Diretoria     GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Adocao                MODIFY ID_Adocao                GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Vacinacao             MODIFY ID_Vacinacao             GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Historico_Veterinario MODIFY ID_Historico_Veterinario GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
ALTER TABLE Historico_Status      MODIFY ID_Historico_Status      GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE);
