-- ============================================================================
-- 04_CONSULTAS.SQL - CONSULTAS E PERGUNTAS DE NEGÓCIO
-- Rode depois da carga, dos objetos PL/SQL e do 03_dml_operacoes.sql.
-- ============================================================================

-- 1. ANIMAIS DISPONÍVEIS POR UNIDADE
-- Requisito: SELECT com filtro, JOIN e ORDER BY
-- Pergunta de negócio: Quais animais estão disponíveis para adoção em cada unidade, com espécie e raça?

SELECT u.Nome_Unidade, a.Nome AS Animal, e.Nome AS Especie, r.Nome AS Raca, a.Data_Resgate
FROM   Animal a
JOIN   Unidade_ONG u ON u.ID_Unidade_ONG = a.ID_Unidade_ONG
JOIN   Raca r        ON r.ID_Raca = a.ID_Raca
JOIN   Especie e     ON e.ID_Especie = r.ID_Especie
WHERE  a.Status = 'DISPONIVEL'
ORDER  BY u.Nome_Unidade, a.Nome;

-- 2. SITUAÇÃO ATUAL E MUDANÇAS DE STATUS DO ANIMAL
-- Requisito: JOIN com Historico_Status
-- Pergunta de negócio: Qual é o status atual de cada animal e por quais mudanças de status ele já passou?

SELECT a.Nome AS Animal, a.Status AS Status_Atual,
       h.Status_Anterior, h.Status_Novo, h.Data_Alteracao
FROM   Animal a
JOIN   Historico_Status h ON h.ID_Animal = a.ID_Animal
ORDER  BY a.Nome, h.Data_Alteracao, h.ID_Historico_Status;

-- 3. ADOÇÕES POR SITUAÇÃO
-- Requisito: GROUP BY com COUNT
-- Pergunta de negócio: Quantos processos de adoção existem em cada situação?

SELECT Status, COUNT(*) AS Quantidade
FROM   Adocao
GROUP  BY Status
ORDER  BY Quantidade DESC;

-- 4. ANIMAIS SEM NENHUMA VACINA
-- Requisito: subconsulta (NOT EXISTS)
-- Pergunta de negócio: Quais animais sob cuidado da ONG ainda não receberam nenhuma vacina?

SELECT a.ID_Animal, a.Nome, a.Status, u.Nome_Unidade
FROM   Animal a
JOIN   Unidade_ONG u ON u.ID_Unidade_ONG = a.ID_Unidade_ONG
WHERE  a.Status IN ('EM_TRATAMENTO', 'DISPONIVEL', 'EM_PROCESSO')
  AND  NOT EXISTS (SELECT 1
                   FROM   Vacinacao v
                   WHERE  v.ID_Animal = a.ID_Animal)
ORDER  BY u.Nome_Unidade, a.Nome;

-- 5. ANIMAIS COM TRATAMENTO EM ANDAMENTO
-- Requisito: JOIN com filtro
-- Pergunta de negócio: Quais animais estão com tratamento em andamento, com diagnóstico e tratamento prescrito?

SELECT a.Nome AS Animal, u.Nome_Unidade, h.Data_Atendimento,
       h.Diagnostico, h.Tratamento
FROM   Historico_Veterinario h
JOIN   Animal a      ON a.ID_Animal = h.ID_Animal
JOIN   Unidade_ONG u ON u.ID_Unidade_ONG = a.ID_Unidade_ONG
WHERE  h.Estado_Tratamento = 'EM_ANDAMENTO'
ORDER  BY h.Data_Atendimento;

-- 6. OCUPAÇÃO DA UNIDADE VERSUS CAPACIDADE
-- Requisito: agregação, JOIN e HAVING
-- Pergunta de negócio: Quais unidades têm pelo menos 3 animais sob cuidado e qual o percentual de ocupação de cada uma?

SELECT u.Nome_Unidade,
       u.Capacidade,
       COUNT(a.ID_Animal)                                 AS Animais_Sob_Cuidado,
       ROUND(COUNT(a.ID_Animal) * 100 / u.Capacidade, 1) AS Ocupacao_Percentual
FROM   Unidade_ONG u
JOIN   Animal a ON a.ID_Unidade_ONG = u.ID_Unidade_ONG
WHERE  a.Status IN ('EM_TRATAMENTO', 'DISPONIVEL', 'EM_PROCESSO')
GROUP  BY u.Nome_Unidade, u.Capacidade
HAVING COUNT(a.ID_Animal) >= 3
ORDER  BY Ocupacao_Percentual DESC;

-- 7. VOLUNTÁRIOS ATIVOS POR UNIDADE E FUNÇÃO
-- Requisito: GROUP BY com COUNT
-- Pergunta de negócio: Quantos voluntários ativos cada unidade tem em cada função?

SELECT u.Nome_Unidade, v.Funcao, COUNT(*) AS Voluntarios_Ativos
FROM   Voluntariado v
JOIN   Unidade_ONG u ON u.ID_Unidade_ONG = v.ID_Unidade_ONG
WHERE  v.Data_Fim IS NULL
GROUP  BY u.Nome_Unidade, v.Funcao
ORDER  BY u.Nome_Unidade, v.Funcao;

-- 8. DOAÇÕES POR MÊS E POR FORMA DE PAGAMENTO
-- Requisito: SUM e GROUP BY
-- Pergunta de negócio: Quanto a ONG recebeu em doações em cada mês e por qual forma de pagamento?

SELECT TO_CHAR(Data_Doacao, 'YYYY-MM') AS Mes,
       Metodo,
       COUNT(*)   AS Quantidade,
       SUM(Valor) AS Total
FROM   Doacao
GROUP  BY TO_CHAR(Data_Doacao, 'YYYY-MM'), Metodo
ORDER  BY Mes, Total DESC;

-- 9. DESPESAS POR UNIDADE E TIPO
-- Requisito: SUM e GROUP BY
-- Pergunta de negócio: Quanto cada unidade gastou em cada tipo de despesa?

SELECT u.Nome_Unidade, d.Tipo, SUM(d.Valor) AS Total
FROM   Despesa d
JOIN   Unidade_ONG u ON u.ID_Unidade_ONG = d.ID_Unidade_ONG
GROUP  BY u.Nome_Unidade, d.Tipo
ORDER  BY u.Nome_Unidade, Total DESC;

-- 10. DIRETORES ATUAIS POR UNIDADE
-- Requisito: JOIN com filtro Data_Saida IS NULL
-- Pergunta de negócio: Quem compõe a diretoria atual de cada unidade e com qual remuneração?

SELECT u.Nome_Unidade, m.Funcao, p.Nome AS Diretor,
       m.Remuneracao, m.Data_Inicio
FROM   Mandato_Diretoria m
JOIN   Pessoa p      ON p.ID_Pessoa = m.ID_Pessoa
JOIN   Unidade_ONG u ON u.ID_Unidade_ONG = m.ID_Unidade_ONG
WHERE  m.Data_Saida IS NULL
ORDER  BY u.Nome_Unidade, m.Funcao;

-- 11. EQUIPE ATIVA DA ONG
-- Requisito: UNION
-- Pergunta de negócio: Quem são as pessoas que atuam hoje na ONG, como voluntárias ou na diretoria, com telefone e unidade?

SELECT p.Nome, p.Telefone, 'VOLUNTARIADO' AS Papel, u.Nome_Unidade
FROM   Voluntariado v
JOIN   Pessoa p      ON p.ID_Pessoa = v.ID_Pessoa
JOIN   Unidade_ONG u ON u.ID_Unidade_ONG = v.ID_Unidade_ONG
WHERE  v.Data_Fim IS NULL
UNION
SELECT p.Nome, p.Telefone, 'DIRETORIA', u.Nome_Unidade
FROM   Mandato_Diretoria m
JOIN   Pessoa p      ON p.ID_Pessoa = m.ID_Pessoa
JOIN   Unidade_ONG u ON u.ID_Unidade_ONG = m.ID_Unidade_ONG
WHERE  m.Data_Saida IS NULL
ORDER  BY Nome_Unidade, Nome;

-- 12. PESSOAS SEM E-MAIL
-- Requisito: SELECT simples com filtro e ordenação
-- Pergunta de negócio: Quais pessoas não têm e-mail cadastrado e só podem ser contatadas por telefone?

SELECT Nome, Telefone
FROM   Pessoa
WHERE  Email IS NULL
ORDER  BY Nome;
