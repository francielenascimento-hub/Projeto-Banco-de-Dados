# Regras de Negócio do Sistema 

<div align="justify">

Abaixo estão listadas as 16 regras de negócio oficiais que regem o funcionamento da ONG de Proteção Animal, acompanhadas dos respectivos mecanismos técnicos de garantia implementados no Oracle Database: 

</div>

| Regra | Descrição da Regra de Negócio | Como Garantir no Oracle (Mecanismo) | 
| :--- | :--- | :--- | 
| **RN01** | Toda pessoa deve ter nome, CPF, data de nascimento, telefone e endereço | `NOT NULL` e `FK` | 
| **RN02** | CPF é único e tem 11 dígitos | `UNIQUE` + `CHECK` | 
| **RN03** | Adotantes, doadores e diretores têm 18 anos ou mais na data do evento; voluntários podem ser menores | Function + 3 Triggers | 
| **RN04** | Campos de lista só aceitam valores definidos; CEP tem 8 dígitos | `CHECK` | 
| **RN05** | Doação, despesa e dose são maiores que 0; remuneração é maior ou igual a 0 | `CHECK` | 
| **RN06** | Data final não antecede a inicial; nascimento não é posterior ao resgate | `CHECK` | 
| **RN07** | Datas não são futuras; adoção, atendimento e vacinação não antecedem o resgate | Trigger | 
| **RN08** | Cada animal tem no máximo um processo de adoção ativo | Índice único com `CASE` | 
| **RN09** | Só animal DISPONÍVEL inicia adoção | Trigger | 
| **RN10** | Concluir a adoção atualiza adoção e animal juntos | Procedure | 
| **RN11** | Unidade não recebe animais acima da capacidade | Procedure + Function | 
| **RN12** | Unidade respeita o limite de voluntários, e cada pessoa tem um voluntariado ativo nela | Procedure + Índice único | 
| **RN13** | Só há um mandato ativo por função em cada unidade | Índice único com `CASE` | 
| **RN14** | A mesma dose da mesma vacina não se repete no animal | `UNIQUE` composto | 
| **RN15** | Toda mudança de status do animal fica registrada | Trigger | 
| **RN16** | Animal com histórico não pode ser excluído | `FK` sem `ON DELETE CASCADE` |

