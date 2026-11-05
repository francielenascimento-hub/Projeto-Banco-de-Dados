

-- 1. ATUALIZAÇÃO DE STATUS DO ANIMAL
-- Pergunta de negócio: Como atualizar o status de um animal que concluiu o tratamento médico para que ele fique disponível para adoção?

UPDATE Animal
SET Status = 'DISPONIVEL'
WHERE ID_Animal = 2
  AND Status = 'EM_TRATAMENTO';

-- 2. FINALIZAÇÃO DE PROCESSO DE ADOÇÃO
-- Pergunta de negócio: Como aprovar e concluir formalmente um processo de adoção em análise, registrando a data de conclusão?

UPDATE Adocao
SET Status = 'CONCLUIDA',
    Data_Conclusao = TO_DATE('2026-11-01', 'YYYY-MM-DD')
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


-- ============================================================================
-- PARTE 2: COMANDOS DE EXCLUSÃO (DELETE)
-- ============================================================================

-- 1. ADOÇÃO CANCELADA
-- Pergunta de negócio: Como remover do banco de dados um registro de processo de adoção que foi cancelado antes de sua efetivação?

DELETE FROM Adocao
WHERE ID_Adocao = 2
  AND Status = 'CANCELADA';

-- 2. DESPESA LANÇADA INDEVIDAMENTE
-- Pergunta de negócio: Como excluir o registro de uma despesa cadastrada erroneamente no sistema?

DELETE FROM Despesa
WHERE ID_Despesa = 2;

-- 3. REGISTRO INCORRETO DE VACINAÇÃO
-- Pergunta de negócio: Como apagar uma dose de vacina lançada por engano no cartão de vacinação de um animal?

DELETE FROM Vacinacao
WHERE ID_Vacinacao = 2;

-- 4. HISTÓRICO VETERINÁRIO DUPLICADO OU ERRO DE CADASTRO
-- Pergunta de negócio: Como remover um lançamento duplicado no histórico veterinário de um animal?

DELETE FROM Historico_Veterinario
WHERE ID_Historico_Veterinario = 2;

COMMIT;
