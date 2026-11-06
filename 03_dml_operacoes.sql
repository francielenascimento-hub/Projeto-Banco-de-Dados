-- ============================================================================
-- 03_DML_OPERACOES.SQL - EXEMPLOS DE ATUALIZAÇÃO E EXCLUSÃO
-- Rode depois do 05_plsql.sql: os triggers registram o histórico de status
-- e mantêm o status do animal coerente com a adoção.
-- ============================================================================

-- ============================================================================
-- PARTE 1: COMANDOS DE ATUALIZAÇÃO (UPDATE)
-- ============================================================================

-- 1. ALTA DE TRATAMENTO
-- Pergunta de negócio: Como registrar que um animal concluiu o tratamento médico e ficou disponível para adoção?

UPDATE Historico_Veterinario
SET Estado_Tratamento = 'CONCLUIDO'
WHERE ID_Historico_Veterinario = 1
  AND Estado_Tratamento = 'EM_ANDAMENTO';

UPDATE Animal
SET Status = 'DISPONIVEL'
WHERE ID_Animal = 2
  AND Status = 'EM_TRATAMENTO';

-- 2. APROVAÇÃO DE PROCESSO DE ADOÇÃO
-- Pergunta de negócio: Como registrar que um processo de adoção em análise foi aprovado?
-- O animal continua EM_PROCESSO até a conclusão, feita pela procedure prc_concluir_adocao.

UPDATE Adocao
SET Status = 'APROVADA'
WHERE ID_Adocao = 2
  AND Status = 'EM_ANALISE';

-- 3. DESLIGAMENTO DE VOLUNTÁRIO
-- Pergunta de negócio: Como registrar a data de encerramento do vínculo ativo de um voluntário que se desligou da ONG?

UPDATE Voluntariado
SET Data_Fim = TO_DATE('2026-11-01', 'YYYY-MM-DD')
WHERE ID_Voluntariado = 1
  AND Data_Fim IS NULL;

-- 4. MANUTENÇÃO CADASTRAL DE PESSOA
-- Pergunta de negócio: Como atualizar o telefone e o e-mail de contato de uma pessoa cadastrada no sistema?

UPDATE Pessoa
SET Telefone = '16999998888',
    Email = 'ana.souza_atualizado@email.com'
WHERE ID_Pessoa = 1;

-- 5. REPROVAÇÃO DE PROCESSO DE ADOÇÃO
-- Pergunta de negócio: Como registrar que um processo de adoção foi reprovado e liberar o animal para outra adoção?
-- O trigger trg_adocao_status_animal devolve o animal 15 para DISPONIVEL.

UPDATE Adocao
SET Status = 'REPROVADA',
    Data_Conclusao = TO_DATE('2026-11-03', 'YYYY-MM-DD')
WHERE ID_Adocao = 6
  AND Status = 'EM_ANALISE';

-- ============================================================================
-- PARTE 2: COMANDOS DE EXCLUSÃO (DELETE)
-- ============================================================================

-- 1. DOAÇÃO LANÇADA EM DUPLICIDADE
-- Pergunta de negócio: Como excluir uma doação que foi registrada duas vezes por engano?

DELETE FROM Doacao
WHERE ID_Doacao = 11;

-- 2. DESPESA LANÇADA INDEVIDAMENTE
-- Pergunta de negócio: Como excluir o registro de uma despesa cadastrada com valor errado?

DELETE FROM Despesa
WHERE ID_Despesa = 10;

-- 3. REGISTRO INCORRETO DE VACINAÇÃO
-- Pergunta de negócio: Como apagar uma dose de vacina lançada por engano no cartão de vacinação de um animal?

DELETE FROM Vacinacao
WHERE ID_Vacinacao = 10;

-- 4. HISTÓRICO VETERINÁRIO DUPLICADO
-- Pergunta de negócio: Como remover um lançamento duplicado no histórico veterinário de um animal?

DELETE FROM Historico_Veterinario
WHERE ID_Historico_Veterinario = 8;

COMMIT;
