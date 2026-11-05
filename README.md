<p align="center">
  
  # Projeto Banco de Dados
  
</p>

**| Sistema de Gestão para ONG de Proteção Animal** <br>
**| Projeto prático de Banco de Dados Relacional desenvolvido em Oracle SQL e PL/SQL para a disciplina de Banco de Dados I (ADS - FATEC Ribeirão Preto).** <br>
**| Inclui modelagem DER/Lógica, scripts DDL/DML, Procedures, Functions e Triggers.**

---

<p align="center">

  # Sistema de Gestão para ONG de Proteção Animal

</p>

<p align="center">
  
  ## Projeto Prático de Banco de Dados I
  
</p>

**Curso:** Tecnologia em Análise e Desenvolvimento de Sistemas (ADS) — FATEC Ribeirão Preto<br>
**Orientadora:** Profa. Me. Eliza Bomfim<br>
**SGBD:** Oracle Database<br>
**Integrantes:**
- [Ana Clara Almeida Barbosa](https://github.com/AnaBarbosa18)
- [Franciele Patrícia Nascimento da Silva](https://github.com/francielenascimento-hub)
- [Jordana dos Santos Pelis](https://github.com/m0biius2)
- [Samuel Pires Rodrigues](https://github.com/SamuelRod99)
- [Thiago Santana de Freitas](https://github.com/Thiaguin7)

---

### Sobre o Projeto 

<div align="justify">
  
Este repositório contém a solução completa de banco de dados relacional desenvolvida para a gestão operacional, médica e financeira de uma **ONG de Proteção Animal**. O projeto abrange desde o levantamento das necessidades de informação e modelagem conceitual até a implementação física e programação procedimental em ambiente **Oracle**. O sistema foi projetado para responder a perguntas reais do negócio, garantindo a integridade dos dados, a rastreabilidade dos animais resgatados e a transparência no controle de recursos.

</div>

---

### Módulos e Estrutura do Banco de Dados A modelagem engloba 10 entidades principais organizadas nos seguintes fluxos operacionais: 

<div align="justify">

**Cadastros Base e Atores:** Gestão de Pessoas (Adotantes, Voluntários e Membros da Diretoria) e Animais resgatados.<br>
**Estrutura Operacional:** Controle de Unidades da ONG e capacidade máxima de alojamento.<br>
**Processos e Transações:** Gerenciamento dos fluxos de Adoção e escalas de Voluntariado.<br>
**Registros Médicos e Financeiros:** Acompanhamento do Histórico Veterinário, Carteira de Vacinação, recebimento de Doações e controle de Despesas da instituição.<br>

</div>

---

### Tecnologias e Recursos Utilizados 

<div align="justify">

**SGBD:** Oracle Database <br>
**Linguagem SQL (DDL e DML):** Criação de tabelas, chaves (PK/FK), restrições de integridade (`CHECK`, `NOT NULL`, `UNIQUE`) e manipulação de dados.<br>
**Lógica Procedimental (PL/SQL):** <br>
- **Triggers:** Automação de status de adoção e controle de capacidade das unidades.
- **Procedures:** Validação de regras de negócio complexas e cadastro seguro.
- **Functions:** Cálculos dinâmicos de doações acumuladas e despesas veterinárias.<br>

**Modelagem:** Diagrama Entidade-Relacionamento (DER) e Modelo Lógico Relacional normalizado (3FN).

</div>

---

### Estrutura do Repositório 

<div align="justify">

├── [`Modelo Conceitual`](Modelo_Conceitual-ONG_de_Protecao_Animal.pdf)<br>
├── [`Modelo Lógico`](Modelo_Logico-ONG_de_Protecao_Animal.pdf)<br>
├── [`01_ddl_estrutura.sql`](01_ddl_estrutura.sql)········# Criação das tabelas, chaves primárias/estrangeiras e restrições CHECK<br> 
├── [`02_dml_carga.sql`](02_dml_carga.sql)············# Script de carga inicial de dados de teste<br>
├── [`03_dml_operacoes.sql`](03_dml_operacoes.sql)········# Exemplos práticos de atualização (UPDATE) e exclusão (DELETE)<br>
├── [`04_consultas.sql`]()············# Consultas SQL (JOIN, Agregação, GROUP BY, Subconsultas, UNION)<br>
├── [`05_plsql.sql`]()················# Implementação de Procedures, Functions e Triggers<br>
├── [`06_testes.sql`]()···············# Execução de testes de validação das regras de negócio<br>
└── [`docs`]()························# DER, Modelo Lógico, Dicionário de Dados e Documentação do Projeto<br>

</div>

<hr size="15">

### 1. Modelo Conceitual

#### Conceito: O que são MER e DER?

<div align="justify">

**MER (Modelo Entidade-Relacionamento):** É a especificação conceitual e abstrata do domínio de negócio1. Ele identifica quais entidades do mundo real precisam ser registradas no sistema, quais atributos descrevem essas entidades e como elas se relacionam sintaticamente, sem se preocupar com restrições técnicas ou implementação física em um SGBD específico.

**DER (Diagrama Entidade-Relacionamento):** É a representação visual e gráfica do MER13. Utiliza notação conceitual (como a notação de Peter Chen), onde as entidades são desenhadas em retângulos, os atributos em elipses/bolinhas, os relacionamentos em losangos e as linhas de associação indicam as cardinalidades mínimas e máximas do sistema1.

</div>

#### 1.1 Modelo Conceitual do Projeto (ONG de Proteção Animal)

O Modelo Conceitual do projeto foi desenvolvido para cobrir todo o ciclo operacional, médico e administrativo da instituição, estando organizado visualmente em 5 blocos funcionais/temáticos:<br>

<div align="justify">

🟨 *Atores Principais / Cadastros Base (Amarelo):* Formado pelas entidades Pessoa, Animal, Especie, Raca e Endereco4. Modela os indivíduos cadastrados no sistema (adotantes, voluntários e diretores), os animais resgatados e a taxonomia básica.<br>
🟧 *Processos e Transações do Sistema (Laranja):* Engloba os relacionamentos transacionais Adocao, Voluntariado e Doacao. Gerencia o ciclo de adoções, as escalas de trabalho dos voluntários e as contribuições financeiras recebidas.<br>
🟪 *Estrutura Física e Operacional (Roxo):* Representado pela entidade Unidade_ONG, encarregada de registrar os abrigos e sedes físicas da ONG, controlando a capacidade de alojamento de animais e limites operacionais.<br>
🟦 *Gestão e Governança (Azul):* Composto por Mandato_Diretoria e Historico_Status. Controla os cargos administrativos da ONG e rastreia o histórico temporal das mudanças de estado do animal (ex: transição de EM_TRATAMENTO para DISPONIVEL ou ADOTADO).<br>
🟩 *Registros Médicos e Financeiros (Verde):* Formado por Historico_Veterinario, Vacinacao e Despesa4. Armazena os atendimentos clínicos, prontuários veterinários, vacinas aplicadas e as despesas operacionais das unidades.<br>

</div>

---

### 2. Modelo Lógico Relacional

#### Conceito: O que é o Modelo Lógico?

<div align="justify">

O Modelo Lógico (ou Relacional) representa a tradução do modelo conceitual para o modelo relacional de banco de dados. Ele converte entidades em tabelas, atributos em colunas com tipos de dados definidos (como VARCHAR2, NUMBER, DATE, CHAR) e estabelece a integridade referencial por meio de Chaves Primárias (PK) e Chaves Estrangeiras (FK)1more_horiz. Nessa etapa, aplicam-se as Formas Normais (1FN, 2FN e 3FN) para eliminar redundâncias e evitar anomalias de inserção, alteração e exclusão18.

</div>

#### 2.1 Modelo Lógico do Projeto (ONG de Proteção Animal)

<div align="justify">

Na conversão do DER para a estrutura relacional do projeto, as entidades e associações foram mapeadas conforme as seguintes diretrizes técnicas:

* **Mapeamento de Tabelas e Chaves:** Cada entidade do DER gerou uma tabela relacional dotada de chave primária (PK) auto-incremental (NUMBER / IDENTITY). As relações de cardinalidade ´1:N´ e ´N:N´ foram estruturadas pela inclusão de chaves estrangeiras (FK) nas tabelas dependentes (como ID_Animal em Vacinacao e Historico_Veterinario).

* **Normalização Aplicada:**
  * ´Especie e Raca:´ Foram separadas em tabelas próprias para eliminar a repetição de nomes de espécies/raças na tabela Animal (atendendo à 2FN e 3FN).
  * ´Endereco:´ Isolado em uma tabela dedicada, permitindo o compartilhamento e a padronização de localização entre Pessoa e Unidade_ONG.
  * ´Historico_Status:´ Tabela criada especificamente para auditoria e registro de histórico de transição de status dos animais.

* **Tipagem dos Atributos no Oracle:** Os tipos de dados foram especificados utilizando a sintaxe do Oracle Database: VARCHAR2 para textos descritivos, DATE para datas de eventos/resgates, CHAR para códigos de tamanho fixo (CPF, Sexo, Estado) e NUMBER(10,2) para valores monetários de doações e despesas5more_horiz. 

</div>

--- 

## Justificativa da Normalização 

<div align="justify">

O processo de normalização do banco de dados relacional foi conduzido rigorosamente para garantir a integridade dos dados, eliminar redundâncias desnecessárias e evitar anomalias de inserção, alteração e exclusão . As regras aplicadas contemplam as três primeiras formas normais (1FN, 2FN e 3FN), além de justificativas técnicas para redundâncias deliberadamente mantidas. 

</div>

### 1. Primeira Forma Normal (1FN) — Atributos Atômicos e Monovalorados 

<div align="justify">

* **Atomicidade dos Dados:** Todos os campos das 14 tabelas armazenam valores atômicos e indivisíveis.

* **Decomposição do Endereço:** O endereço não é armazenado como uma string concatenada. Ele foi isolado na tabela `ENDERECO`, decomposto nos atributos `Rua`, `Numero`, `Bairro`, `Cidade`, `Estado`, `CEP` e `Complemento`. 

* **Ausência de Grupos Repetitivos:** Informações multivaloradas (como múltiplas vacinas ou atendimentos veterinários de um mesmo animal) foram alocadas em tabelas próprias (`VACINACAO` e `HISTORICO_VETERINARIO`), relacionadas via chave estrangeira (`ID_Animal`). 

</div>

### 2. Segunda Forma Normal (2FN) — Dependência Funcional Total

<div align="justify">

* **Eliminação de Dependências Parciais:** Todas as tabelas possuem Chaves Primárias (`PK`) simples e bem definidas (utilizando chaves substitutas do tipo `IDENTITY`/`NUMBER`). 

* **Decomposição de Espécie e Raça:** Em vez de armazenar o nome da espécie e da raça diretamente na tabela `ANIMAL`, a taxonomia foi normalizada nas tabelas `ESPECIE` e `RACA`. Os atributos de `RACA` dependem funcionalmente apenas de `ID_Raca`, e `ANIMAL` faz referência somente a `ID_Raca`. 

</div>

### 3. Terceira Forma Normal (3FN) — Eliminação de Dependências Transitivas 

<div align="justify">

* **Eliminação de Atributos Transitivos:** Atributos não-chave dependem exclusivamente da Chave Primária da própria tabela. 

* **Normalização de Membros da Diretoria:** A tabela `MANDATO_DIRETORIA` armazena apenas a referência `ID_Pessoa` . O nome e os dados pessoais do diretor permanecem exclusivamente na tabela `PESSOA`, evitando a duplicação do nome em `MANDATO_DIRETORIA`. 

* **Compartilhamento de Endereço:** As tabelas `PESSOA` e `UNIDADE_ONG` não replicam colunas de localização; elas apenas contêm a chave estrangeira `ID_Endereco`, apontando para a tabela `ENDERECO` . 

</div>

### 4. Justificativa de Redundâncias Deliberadas 

<div align="justify">

* **Tabela `HISTORICO_STATUS`:** O status atual do animal fica registrado na coluna `Status` da tabela `ANIMAL`. No entanto, foi criada a tabela `HISTORICO_STATUS` para registrar `Status_Anterior`, `Status_Novo` e `Data_Alteracao` . Essa duplicação temporal é **deliberada e necessária para auditoria**, rastreabilidade do histórico de vida do animal resgatado e acionamento de gatilhos procedimentais (`TRIGGERS`) . 

</div>

--- 

## Dicionário de Dados 

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
 


---

### Carga Inicial de Dados de Teste (`02_dml_carga.sql`) 

A povoação inicial do banco de dados foi projetada para garantir volume e relevância técnica suficientes para a execução de relatórios, consultas complexas com `JOIN` e testes de restrições de integridade. 

Para respeitar as dependências de chaves estrangeiras (`FOREIGN KEY`), o script de inserção `02_dml_carga.sql` foi estruturado em **4 níveis hierárquicos sequenciais**:

1. **Nível 1 (Tabelas Base Independentes):** Inserção de dados nas tabelas `ENDERECO` e `ESPECIE`, que não possuem dependências externas.
2. **Nível 2 (Tabelas Dependentes do Nível 1):** Inserção nas tabelas `RACA`, `UNIDADE_ONG` e `PESSOA`.
3. **Nível 3 (Tabelas Operacionais e Transacionais):** Cadastro dos registros de `ANIMAL`, `MANDATO_DIRETORIA`, `DESPESA`, `VOLUNTARIADO` e `DOACAO`.
4. **Nível 4 (Tabelas Dependentes do Animal e Processos):** Lançamento de dados em `ADOCAO`, `VACINACAO`, `HISTORICO_VETERINARIO` e `HISTORICO_STATUS`. 

--- 

### Operações Práticas de Atualização e Exclusão (`03_dml_operacoes.sql`) 

O script `03_dml_operacoes.sql` reúne exemplos de manipulação de dados (`UPDATE` e `DELETE`) associados a situações reais do fluxo de trabalho da ONG de Proteção Animal. 

<br> 

#### 1. Operações de Atualização (`UPDATE`)

* **Atualização de Status Clínico do Animal (RN):**
  * *Pergunta de negócio:* Como atualizar o status de um animal que concluiu o tratamento médico para que ele fique disponível para adoção?
  * *Comando:* `UPDATE Animal SET Status = 'DISPONIVEL' WHERE ID_Animal = 2 AND Status = 'EM_TRATAMENTO';` 

* **Finalização Formal de Adoção:**
  * *Pergunta de negócio:* Como aprovar e concluir formalmente um processo de adoção em análise, registrando a data de conclusão?
  * *Comando:* `UPDATE Adocao SET Status = 'CONCLUIDA', Data_Conclusao = TO_DATE('2026-11-01', 'YYYY-MM-DD') WHERE ID_Adocao = 2 AND Status = 'EM_ANALISE';`

* **Encerramento de Vínculo de Voluntariado:**
  * *Pergunta de negócio:* Como registrar a data de encerramento do trabalho de um voluntário que se desligou da instituição?
  * *Comando:* `UPDATE Voluntariado SET Data_Fim = TO_DATE('2026-11-01', 'YYYY-MM-DD') WHERE ID_Voluntariado = 1 AND Data_Fim IS NULL;`

* **Manutenção Cadastral de Pessoas:**
  * *Pergunta de negócio:* Como atualizar os canais de contato (telefone e e-mail) de um doador ou voluntário cadastrado?
  * *Comando:* `UPDATE Pessoa SET Telefone = '16999998888', Email = 'ana.souza_atualizado@email.com' WHERE ID_Pessoa = 1;` 

<br> 

#### 2. Operações de Exclusão (`DELETE`) 
* **Remoção de Adoção Cancelada:**
  * *Pergunta de negócio:* Como remover do banco de dados um registro de processo de adoção cancelado antes de sua efetivação?
  * *Comando:* `DELETE FROM Adocao WHERE ID_Adocao = 2 AND Status = 'CANCELADA';`

* **Exclusão de Despesa Indevida:**
  * *Pergunta de negócio:* Como apagar um lançamento financeiro de despesa cadastrado erroneamente?
  * *Comando:* `DELETE FROM Despesa WHERE ID_Despesa = 2;`

* **Estorno de Aplicação de Vacina Errônea:**
  * *Pergunta de negócio:* Como apagar o registro de uma dose de vacina lançada por engano no prontuário do animal?
  * *Comando:* `DELETE FROM Vacinacao WHERE ID_Vacinacao = 2;`

* **Limpeza de Prontuário Veterinário Duplicado:**
  * *Pergunta de negócio:* Como remover um histórico médico registrado em duplicidade?
  * *Comando:* `DELETE FROM Historico_Veterinario WHERE ID_Historico_Veterinario = 2;`

---

