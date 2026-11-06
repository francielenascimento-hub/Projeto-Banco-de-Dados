# Regras de Negócio do Sistema 

<div align="justify">

Abaixo estão listadas as 16 regras de negócio oficiais que regem o funcionamento da ONG de Proteção Animal, acompanhadas dos respectivos mecanismos técnicos de garantia implementados no Oracle Database e do local onde cada uma está no código: 

</div>

| Regra | Descrição da Regra de Negócio | Como Garantir no Oracle (Mecanismo) | Onde está no código |
| :--- | :--- | :--- | :--- |
| **RN01** | Toda pessoa deve ter nome, CPF, data de nascimento, telefone e endereço | `NOT NULL` e `FK` | `01_ddl_estrutura.sql`: tabela `PESSOA` |
| **RN02** | CPF é único e tem 11 dígitos | `UNIQUE` + `CHECK` | `01_ddl_estrutura.sql`: coluna `PESSOA.CPF` |
| **RN03** | Adotantes, doadores e diretores têm 18 anos ou mais na data do evento; voluntários podem ser menores | Function + 3 Triggers | `05_plsql.sql`: `fn_maior_idade`, `trg_adocao_maior_idade`, `trg_doacao_maior_idade`, `trg_mandato_maior_idade` |
| **RN04** | Campos de lista só aceitam valores definidos; CEP tem 8 dígitos | `CHECK` | `01_ddl_estrutura.sql`: colunas `Estado`, `CEP`, `Estado_Civil`, `Sexo`, `Status`, `Funcao`, `Metodo`, `Estado_Tratamento`, `Status_Anterior` e `Status_Novo` |
| **RN05** | Doação, despesa e dose são maiores que 0; remuneração é maior ou igual a 0 | `CHECK` | `01_ddl_estrutura.sql`: `DOACAO.Valor`, `DESPESA.Valor`, `VACINACAO.Dose`, `MANDATO_DIRETORIA.Remuneracao` |
| **RN06** | Data final não antecede a inicial; nascimento não é posterior ao resgate | `CHECK` | `01_ddl_estrutura.sql`: tabelas `ANIMAL`, `VOLUNTARIADO`, `MANDATO_DIRETORIA` e `ADOCAO` |
| **RN07** | Datas não são futuras; adoção, atendimento e vacinação não antecedem o resgate | Procedure + 6 Triggers | `05_plsql.sql`: `prc_validar_data_evento`, `trg_animal_data`, `trg_adocao_data`, `trg_hist_vet_data`, `trg_vacinacao_data`, `trg_doacao_data`, `trg_despesa_data` |
| **RN08** | Cada animal tem no máximo um processo de adoção ativo | Índice único com `CASE` | `01_ddl_estrutura.sql`: índice `uq_adocao_ativa` |
| **RN09** | Só animal `DISPONIVEL` inicia adoção | Trigger | `05_plsql.sql`: `trg_adocao_animal_disponivel` e `trg_adocao_status_animal` |
| **RN10** | Concluir a adoção atualiza adoção e animal juntos | Procedure + Trigger | `05_plsql.sql`: `prc_concluir_adocao` e `trg_adocao_status_animal` |
| **RN11** | Unidade não recebe animais acima da capacidade | Procedure + Function | `05_plsql.sql`: `prc_registrar_resgate` e `fn_vagas_disponiveis` |
| **RN12** | Unidade respeita o limite de voluntários, e cada pessoa tem um voluntariado ativo nela | Procedure + Índice único | `05_plsql.sql`: `prc_registrar_voluntario`; `01_ddl_estrutura.sql`: índice `uq_voluntariado_ativo` |
| **RN13** | Só há um mandato ativo por função em cada unidade | Índice único com `CASE` | `01_ddl_estrutura.sql`: índice `uq_mandato_ativo` |
| **RN14** | A mesma dose da mesma vacina não se repete no animal | `UNIQUE` composto | `01_ddl_estrutura.sql`: `UNIQUE (ID_Animal, Vacina, Dose)` em `VACINACAO` |
| **RN15** | Toda mudança de status do animal fica registrada | Trigger | `05_plsql.sql`: `trg_animal_historico_status` |
| **RN16** | Animal com histórico não pode ser excluído | `FK` sem `ON DELETE CASCADE` + Procedure | `01_ddl_estrutura.sql`: FKs de `ADOCAO`, `VACINACAO`, `HISTORICO_VETERINARIO` e `HISTORICO_STATUS`; `05_plsql.sql`: `prc_excluir_animal` |

