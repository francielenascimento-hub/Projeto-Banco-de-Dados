<div>

  # Dicionário de Dados 
  
</div>

O dicionário de dados detalha a estrutura relacional das **14 tabelas** implementadas no Oracle Database, indicando os tipos de dados, a função de cada coluna e as restrições declarativas aplicadas. 

### 1. Tabela `ENDERECO` 

Armazena a localização geográfica padronizada de pessoas e unidades da ONG. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada |
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Endereco` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único do endereço. | 
| `Rua` | `VARCHAR2(100)` | Não | — | **RN01:** Nome do logradouro obrigatório. | 
| `Numero` | `VARCHAR2(6)` | Não | — | **RN01:** Número do imóvel obrigatório. | 
| `Bairro` | `VARCHAR2(70)` | Não | — | **RN01:** Bairro obrigatório. | 
| `Cidade` | `VARCHAR2(100)` | Não | — | **RN01:** Nome do município obrigatório. | 
| `Estado` | `CHAR(2)` | Não | `CHECK` | **RN04:** Sigla da UF válida dentro das 27 UFs brasileiras. | 
| `CEP` | `CHAR(8)` | Não | `CHECK` | **RN04:** CEP numérico obrigatório com 8 dígitos (`REGEXP_LIKE`). | 
| `Complemento` | `VARCHAR2(60)` | Sim | — | Informação adicional de localização. | 

* **Restrição de Unicidade:** `UNIQUE (CEP, Rua, Numero, Complemento)` para evitar cadastros redundantes. 

--- 

### 2. Tabela `ESPECIE` 

Cadastra as espécies de animais atendidas pela instituição. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada |
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Especie` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único da espécie. | | `Nome` | `VARCHAR2(50)` | Não | `UNIQUE` | **RN04:** Nome da espécie único e obrigatório (ex: 'CACHORRO', 'GATO'). | 

--- 

### 3. Tabela `RACA` 

Cadastra as raças vinculadas a cada espécie. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Raca` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único da raça.| 
| `ID_Especie` | `NUMBER(10)` | Não | **FK** (`ESPECIE`) | **RN16:** Chave estrangeira para a espécie (sem `CASCADE`). | 
| `Nome` | `VARCHAR2(30)` | Não | — | Nome da raça (ex: 'SRD', 'POODLE', 'SIAMES'). | 

* **Restrição de Unicidade:** `UNIQUE (ID_Especie, Nome)`. 

--- 

### 4. Tabela `UNIDADE_ONG` 

Registra as sedes e filiais físicas da ONG de Proteção Animal. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Unidade_ONG` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único da unidade da ONG. | 
| `ID_Endereco` | `NUMBER(10)` | Não | **FK** (`ENDERECO`) | **RN01 / RN16:** Endereço obrigatório da unidade (sem `CASCADE`). | 
| `Nome_Unidade` | `VARCHAR2(50)` | Não | — | Nome de identificação da unidade. | 
| `Capacidade` | `NUMBER(5)` | Não | — | **RN11:** Capacidade máxima de animais abrigados simultaneamente. | 
| `Limite_Voluntarios` | `NUMBER(5)` | Não | — | **RN12:** Limite operacional máximo de voluntários ativos. | 

--- 

### 5. Tabela `PESSOA` 

Cadastra todos os indivíduos vinculados (adotantes, voluntários e diretores). 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Pessoa` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único da pessoa. | 
| `ID_Endereco` | `NUMBER(10)` | Não | **FK** (`ENDERECO`) | **RN01 / RN16:** Endereço residencial obrigatório (sem `CASCADE`). | 
| `Estado_Civil` | `VARCHAR2(15)` | Sim | `CHECK` | **RN04:** Valores restritos a 'SOLTEIRO', 'CASADO', 'UNIAO_ESTAVEL', 'VIUVO', 'DIVORCIADO'. | | `CPF` | `CHAR(11)` | Não | `UNIQUE`, `CHECK` | **RN01 / RN02:** CPF obrigatório, único e composto por 11 dígitos numéricos. | 
| `Nome` | `VARCHAR2(200)` | Não | — | **RN01:** Nome completo obrigatório. | 
| `Data_Nascimento` | `DATE` | Não | — | **RN01 / RN03:** Data de nascimento para validação da maioridade (18+ anos). | 
| `Telefone` | `VARCHAR2(18)` | Não | — | **RN01:** Telefone principal de contato obrigatório. | 
| `Email` | `VARCHAR2(120)` | Sim | — | Endereço de correio eletrônico. | 

--- 

### 6. Tabela `ANIMAL` 

Registra a ficha principal e o estado de cada animal resgatado. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Animal` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único do animal. | 
| `ID_Unidade_ONG` | `NUMBER(10)` | Não | **FK** (`UNIDADE_ONG`) | **RN11 / RN16:** Unidade onde está alojado (validado via capacidade). | 
| `ID_Raca` | `NUMBER(10)` | Não | **FK** (`RACA`) | **RN16:** Raça vinculada ao animal (sem `CASCADE`). | 
| `Nome` | `VARCHAR2(20)` | Sim | — | Nome atribuído ao animal. | 
| `Data_Resgate` | `DATE` | Não | `CHECK` | **RN06 / RN07:** Data de resgate não futura e posterior ao nascimento. | 
| `Data_Nascimento_Estipulada` | `DATE` | Não | — | **RN06:** Data estimada de nascimento (`Data_Resgate >= Data_Nascimento_Estipulada`). | 
| `Sexo` | `CHAR(1)` | Não | `CHECK` | **RN04:** Restrito a 'F' (Fêmea), 'M' (Macho) ou 'I' (Indefinido). | 
| `Status` | `VARCHAR2(20)` | Não | `CHECK` | **RN04 / RN09 / RN10 / RN15:** Restrito a 'EM_TRATAMENTO', 'DISPONIVEL', 'EM_PROCESSO', 'ADOTADO', 'OBITO'. | 

* **Restrição de Integridade:** `CHECK (Data_Resgate >= Data_Nascimento_Estipulada)`. 

--- 

### 7. Tabela `DESPESA` 

Registra os custos operacionais e médicos efetuados pelas unidades da ONG. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Despesa` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único da despesa. | 
| `ID_Unidade_ONG` | `NUMBER(10)` | Não | **FK** (`UNIDADE_ONG`) | **RN16:** Unidade geradora do custo (sem `CASCADE`). | 
| `Tipo` | `VARCHAR2(20)` | Não | — | Categoria da despesa (ex: 'ALIMENTACAO', 'MEDICAMENTOS'). | 
| `Valor` | `NUMBER(10,2)` | Não | `CHECK` | **RN05:** Valor monetário estritamente maior que zero (`Valor > 0`). | 
| `Data_Despesa` | `DATE` | Não | — | **RN07:** Data de realização do pagamento não futura. | 

--- 

### 8. Tabela `VOLUNTARIADO` 

Gerencia os vínculos e escalas dos voluntários nas unidades da ONG. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Voluntariado` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador do vínculo de voluntariado. | 
| `ID_Unidade_ONG` | `NUMBER(10)` | Não | **FK** (`UNIDADE_ONG`) | **RN12 / RN16:** Unidade de atuação (respeitando o limite da unidade). | 
| `ID_Pessoa` | `NUMBER(10)` | Não | **FK** (`PESSOA`) | **RN03 / RN12 / RN16:** Voluntário cadastrado (pode ser menor de 18 anos). | 
| `Funcao` | `VARCHAR2(15)` | Não | `CHECK` | **RN04:** Restrito a 'CUIDADOR', 'PASSEADOR', 'RESGATE', 'TRANSPORTE', 'LIMPEZA', 'ADMINISTRATIVO', 'EVENTOS'. | 
| `Data_Inicio` | `DATE` | Não | — | **RN07:** Data de início das atividades voluntárias não futura. | 
| `Data_Fim` | `DATE` | Sim | `CHECK` | **RN06:** Data de término não anterior à inicial (`Data_Fim >= Data_Inicio`). | 

* **Índice Único Condicional (RN12):** `CREATE UNIQUE INDEX uq_voluntariado_ativo ON Voluntariado (CASE WHEN Data_Fim IS NULL THEN ID_Pessoa END, CASE WHEN Data_Fim IS NULL THEN ID_Unidade_ONG END)` para impedir múltiplos voluntariados ativos para a mesma pessoa na mesma unidade. 

--- 

### 9. Tabela `DOACAO` 

Registra doações financeiras recebidas. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Doacao` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único da doação. |
| `ID_Pessoa` | `NUMBER(10)` | Não | **FK** (`PESSOA`) | **RN03 / RN16:** Doador responsável (exige 18+ anos na data da doação). | 
| `ID_Unidade_ONG` | `NUMBER(10)` | Não | **FK** (`UNIDADE_ONG`) | **RN16:** Unidade beneficiada (sem `CASCADE`). | 
| `Valor` | `NUMBER(10,2)` | Não | `CHECK` | **RN05:** Valor doado estritamente maior que zero (`Valor > 0`). | 
| `Data_Doacao` | `DATE` | Não | — | **RN07:** Data do recebimento da doação não futura. | 
| `Metodo` | `VARCHAR2(20)` | Não | `CHECK` | **RN04:** Restrito a 'PIX', 'DINHEIRO', 'CARTAO_CREDITO', 'CARTAO_DEBITO', 'TRANSFERENCIA', 'BOLETO'. | 

--- 

### 10. Tabela `MANDATO_DIRETORIA` 

Controla os cargos administrativos da diretoria das unidades. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Mandato_Diretoria`| `NUMBER(10)` | Não | **PK** (Identity) | Identificador único do mandato. | 
| `ID_Unidade_ONG` | `NUMBER(10)` | Não | **FK** (`UNIDADE_ONG`) | **RN13 / RN16:** Unidade gerida (sem `CASCADE`). | 
| `ID_Pessoa` | `NUMBER(10)` | Não | **FK** (`PESSOA`) | **RN03 / RN16:** Diretor cadastrado (exige 18+ anos na data de posse). | 
| `Funcao` | `VARCHAR2(20)` | Não | `CHECK` | **RN04 / RN13:** Restrito a 'PRESIDENTE', 'VICE_PRESIDENTE', 'SECRETARIO', 'TESOUREIRO'. | 
| `Remuneracao` | `NUMBER(10,2)` | Não | `CHECK` | **RN05:** Valor de pró-labore/ajuda de custo não negativo (`Remuneracao >= 0`). | 
| `Data_Inicio` | `DATE` | Não | — | **RN07:** Data de posse no cargo não futura. | 
| `Data_Saida` | `DATE` | Sim | `CHECK` | **RN06:** Data de término do mandato (`Data_Saida >= Data_Inicio`). | 

* **Índice Único Condicional (RN13):** `CREATE UNIQUE INDEX uq_mandato_ativo ON Mandato_Diretoria (CASE WHEN Data_Saida IS NULL THEN ID_Unidade_ONG END, CASE WHEN Data_Saida IS NULL THEN Funcao END)` para garantir apenas 1 diretor ativo por função na mesma unidade. 

--- 

### 11. Tabela `ADOCAO` 

Gerencia o fluxo e processos formais de adoção de animais. 
| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Adocao` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único da adoção. |
| `ID_Pessoa` | `NUMBER(10)` | Não | **FK** (`PESSOA`) | **RN03 / RN16:** Adotante responsável (exige 18+ anos na data de abertura). | 
| `ID_Animal` | `NUMBER(10)` | Não | **FK** (`ANIMAL`) | **RN08 / RN09 / RN10 / RN16:** Animal em processo de adoção (sem `CASCADE`). | 
| `Data_Inicio` | `DATE` | Não | — | **RN07:** Data de abertura não futura e não anterior ao resgate. | 
| `Data_Conclusao` | `DATE` | Sim | `CHECK` | **RN06 / RN07 / RN10:** Data de término (`Data_Conclusao >= Data_Inicio`), atualizada via `PROCEDURE`. | 
| `Status` | `VARCHAR2(15)` | Não | `CHECK` | **RN04 / RN08 / RN10:** Restrito a 'EM_ANALISE', 'APROVADA', 'REPROVADA', 'CANCELADA', 'CONCLUIDA', 'DEVOLVIDA'. | 

* **Índice Único Condicional (RN08):** `CREATE UNIQUE INDEX uq_adocao_ativa ON Adocao (CASE WHEN Status IN ('EM_ANALISE', 'APROVADA', 'CONCLUIDA') THEN ID_Animal END)` para impedir múltiplos processos de adoção ativos para o mesmo animal. 

--- 

### 12. Tabela `VACINACAO` 

Registra as vacinas e doses aplicadas nos animais resgatados. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Vacinacao` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único do registro de vacina. | 
| `ID_Animal` | `NUMBER(10)` | Não | **FK** (`ANIMAL`) | **RN07 / RN14 / RN16:** Animal imunizado (sem `CASCADE`). |
| `Vacina` | `VARCHAR2(30)` | Não | — | **RN14:** Nome da vacina imunizante (ex: 'ANTIRRABICA', 'V4'). | 
| `Dose` | `NUMBER(2)` | Não | `CHECK` | **RN05 / RN14:** Número da dose aplicada estritamente maior que zero (`Dose > 0`). | 
| `Data_Aplicacao` | `DATE` | Não | — | **RN07:** Data da aplicação da dose não futura e não anterior ao resgate. | 

* **Restrição de Unicidade Composta (RN14):** `UNIQUE (ID_Animal, Vacina, Dose)` para evitar a duplicação de doses da mesma vacina para o mesmo animal. 

--- 

### 13. Tabela `HISTORICO_VETERINARIO` 

Armazena o prontuário clínico e histórico de consultas médicas. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Historico_Veterinario`| `NUMBER(10)` | Não | **PK** (Identity) | Identificador único do atendimento clínico. | 
| `ID_Animal` | `NUMBER(10)` | Não | **FK** (`ANIMAL`) | **RN07 / RN16:** Animal atendido na consulta (sem `CASCADE`). | 
| `Queixa` | `VARCHAR2(300)` | Não | — | Descrição dos sintomas e queixas reportadas. | 
| `Estado_Tratamento` | `VARCHAR2(20)` | Não | `CHECK` | **RN04:** Restrito a 'AGUARDANDO', 'SEM_TRATAMENTO', 'EM_ANDAMENTO', 'CONCLUIDO', 'INTERROMPIDO'. | 
| `Diagnostico` | `VARCHAR2(60)` | Sim | — | Diagnóstico clínico veterinário. | 
| `Data_Atendimento` | `DATE` | Não | — | **RN07:** Data do atendimento não futura e não anterior ao resgate. | | `Tratamento` | `VARCHAR2(300)` | Sim | — | Prescrição médica e intervenções efetuadas. | 

--- 

### 14. Tabela `HISTORICO_STATUS` 

Registra a auditoria de transição de status do animal. 

| Coluna | Tipo de Dado (Oracle) | Nulo? | Chave / Restrição | Descrição / Regra de Negócio Associada | 
| :--- | :--- | :--- | :--- | :--- | 
| `ID_Historico_Status` | `NUMBER(10)` | Não | **PK** (Identity) | Identificador único do log de auditoria. | 
| `ID_Animal` | `NUMBER(10)` | Não | **FK** (`ANIMAL`) | **RN15 / RN16:** Animal que teve o status alterado. | 
| `Status_Anterior` | `VARCHAR2(20)` | Sim | `CHECK` | **RN04 / RN15:** Status anterior à transição (validado na lista de enums). | 
| `Status_Novo` | `VARCHAR2(20)` | Não | `CHECK` | **RN04 / RN15:** Novo status registrado (validado na lista de enums). | 
| `Data_Alteracao` | `DATE` | Não | `DEFAULT` (`SYSDATE`) | **RN15:** Carimbo de data/hora automático da alteração (`SYSDATE`). | 

* **Restrição de Consistência (RN15):** `CHECK (Status_Anterior <> Status_Novo)` para impedir a gravação de logs redundantes.

