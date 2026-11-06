<div align="center">
  
  # Projeto Prático de Banco de Dados I
  
</div>

<div align="center">

  ## Sistema de Gestão para ONG de Proteção Animal

</div>

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

<div align="center">

  ## SUMÁRIO

</div>

- [Contexto e Problema](#contexto-e-problema)
- [Público-alvo](#público-alvo)
- [Necessidades de Informação](#necessidades-de-informação)
- [Módulos e Estrutura do Banco de Dados](#módulos-e-estrutura-do-banco-de-dados)
- [Tecnologias e Recursos Utilizados](#tecnologias-e-recursos-utilizados)
- [Estrutura do Repositório](#estrutura-do-repositório)
- [Como Executar no Oracle](#como-executar-no-oracle)
- [Documentação](#documentação)
- [Modelo Conceitual](#modelo-conceitual)
- [Modelo Lógico Relacional](#modelo-lógico-relacional)
- [Justificativa da Normalização](#justificativa-da-normalização)
- [Dicionário de Dados](#dicionário-de-dados)
- [Regras de Negócio](#regras-de-negócio)
- [Carga Inicial de Dados](#carga-inicial-de-dados)
- [Operações de Atualização e Exclusão](#operações-de-atualização-e-exclusão)
- [Consultas SQL](#consultas-sql)
- [Objetos PL/SQL](#objetos-plsql)
- [Testes](#testes)

---

## Contexto e Problema 

<div align="justify">
  
ONGs de proteção animal recebem, ao longo do tempo, animais resgatados que precisam de tratamento veterinário, vacinação, abrigo e, por fim, de um lar. Ao mesmo tempo, dependem de doações, de voluntários e de uma diretoria
para funcionar. Em muitas organizações, essas informações ficam dispersas em planilhas, cadernos e mensagens de aplicativos, o que gera:

- dificuldade em saber a situação atual de cada animal (em tratamento, disponível, em processo de adoção, adotado);
- falta de histórico de vacinas e atendimentos veterinários;
- risco de duas adoções simultâneas para o mesmo animal;
- falta de controle sobre a lotação das unidades e o número de voluntários;
- pouca transparência sobre quanto foi arrecadado e quanto foi gasto.

Este projeto propõe um banco de dados relacional em Oracle que centraliza essas informações, garante sua consistência por meio de restrições de integridade e regras de negócio, e permite responder a perguntas de gestão por meio de consultas SQL.

</div>

---

## Público-alvo

<div align="justify">

O banco foi pensado para quem coordena a ONG no dia a dia:

- **Coordenação e diretoria:** acompanham animais, adoções, lotação das
  unidades, doações e despesas para tomar decisões e prestar contas.
- **Voluntários responsáveis pelo cadastro:** registram resgates, vacinas,
  atendimentos veterinários e escalas de voluntariado.
- **Responsável financeiro (tesoureiro):** consulta doações recebidas e
  despesas por unidade e por tipo.

</div>

---

## Necessidades de Informação

O banco deve responder, entre outras, às seguintes perguntas:

1. Quais animais estão disponíveis para adoção em cada unidade?
2. Qual é a situação atual (status) de cada animal e como ela mudou ao longo do tempo?
3. Quais adoções estão em análise, concluídas ou foram devolvidas?
4. Quais animais não possuem nenhuma vacina registrada?
5. Quais animais estão com tratamento veterinário em andamento?
6. Qual é a ocupação de cada unidade em relação à sua capacidade máxima?
7. Quantos voluntários ativos cada unidade possui, e em quais funções?
8. Qual o total arrecadado em doações por mês e por forma de pagamento?
9. Qual o total de despesas por unidade e por tipo?
10. Quem são os diretores atuais de cada unidade e em que função?
11. Quem são as pessoas que atuam hoje na ONG, como voluntárias ou na diretoria?
12. Quais pessoas não têm e-mail cadastrado e só podem ser contatadas por telefone?

As consultas que respondem a essas perguntas estão em `04_consultas.sql`.

---

## Módulos e Estrutura do Banco de Dados 

A modelagem engloba 14 entidades principais organizadas nos seguintes fluxos operacionais: 

<div align="justify">

**Cadastros Base e Atores:** Gestão de Pessoas (Adotantes, Voluntários e Membros da Diretoria) e Animais resgatados.<br>
**Estrutura Operacional:** Controle de Unidades da ONG e capacidade máxima de alojamento.<br>
**Processos e Transações:** Gerenciamento dos fluxos de Adoção e escalas de Voluntariado.<br>
**Registros Médicos e Financeiros:** Acompanhamento do Histórico Veterinário, Vacinação, recebimento de Doações e controle de Despesas da instituição.<br>

</div>

---

## Tecnologias e Recursos Utilizados 

<div align="justify">

**SGBD:** Oracle Database <br>
**Linguagem SQL (DDL e DML):** Criação de tabelas, chaves (PK/FK), restrições de integridade (`CHECK`, `NOT NULL`, `UNIQUE`), índices únicos condicionais e manipulação de dados.<br>
**Lógica Procedimental (PL/SQL):** <br>
- **Triggers:** Validação de maioridade (adoção, doação e mandato), validação de datas (sem datas futuras e sem eventos anteriores ao resgate), restrição de adoção a animais disponíveis, atualização automática do status do animal conforme o processo de adoção e registro automático do histórico de status.
- **Procedures:** Registro de resgate com controle de capacidade da unidade, registro de voluntário com controle de limite, conclusão de adoção, exclusão protegida de animal, validação de datas e relatório de ocupação (com cursor).
- **Functions:** Verificação de maioridade na data do evento e cálculo de vagas disponíveis por unidade.<br>

**Modelagem:** Diagrama Entidade-Relacionamento (DER) e Modelo Lógico Relacional normalizado (3FN).

</div>

---

## Estrutura do Repositório 

<div align="justify">

```text
.
├── README.md
├── Modelo Conceitual (DER).pdf                    # DER
├── Modelo Lógico.pdf                              # Modelo lógico/relacional
├── Dicionario_de_Dados.md                         # Dicionário de dados
├── Regras_de_Negocio.md                           # Regras de negócio (RN01 a RN16)
├── 01_ddl_estrutura.sql                           # Tabelas, chaves, restrições e índices
├── 02_dml_carga.sql                               # Carga de dados de teste
├── 03_dml_operacoes.sql                           # UPDATE e DELETE
├── 04_consultas.sql                               # Consultas e perguntas de negócio
├── 05_plsql.sql                                   # Functions, triggers e procedures
└── 06_testes.sql                                  # Testes das regras de negócio
```

</div>

---

## Como Executar no Oracle

O projeto foi desenvolvido no **Oracle FreeSQL** (ambiente web usado na disciplina), sem necessidade de instalação.

### Passo a passo

1. Acesse o FreeSQL e entre com sua conta.
2. Abra uma nova planilha (worksheet) em um ambiente limpo.
3. Execute cada arquivo com o botão **Run Script**, e não com **Run Statement**, que executa só o comando em que está o cursor. O resultado aparece na aba **Script Output**.
4. Siga exatamente esta ordem:

| Ordem | Script | O que faz |
|:-----:|:-------|:----------|
| 1 | `01_ddl_estrutura.sql` | Cria tabelas, chaves, restrições e índices |
| 2 | `02_dml_carga.sql` | Insere os dados de teste e ajusta os contadores de `IDENTITY` |
| 3 | `05_plsql.sql` | Cria functions, triggers e procedures |
| 4 | `03_dml_operacoes.sql` | Exemplos de `UPDATE` e `DELETE` |
| 5 | `04_consultas.sql` | Consultas de negócio |
| 6 | `06_testes.sql` | Demonstração das regras de negócio |

> **Por que o `05` vem antes do `03`?** A carga roda antes do PL/SQL porque o trigger da RN09 bloquearia as adoções já concluídas que ela insere. Já o `03` precisa rodar depois do PL/SQL, porque os triggers registram o histórico de status e mantêm o status do animal coerente com a adoção.

O `06_testes.sql` contém comandos que **devem falhar**, marcados com o erro esperado. Execute-o um bloco de cada vez. Para ver as mensagens de `DBMS_OUTPUT`, execute `SET SERVEROUTPUT ON` antes, se o ambiente exigir.

### Verificação

```sql
-- Deve listar as 14 tabelas
SELECT table_name FROM user_tables ORDER BY table_name;

-- Deve mostrar 2 functions, 6 procedures e 12 triggers, todos com STATUS = 'VALID'
SELECT object_type,
       COUNT(*) AS Total,
       SUM(CASE WHEN status = 'VALID' THEN 1 ELSE 0 END) AS Validos
FROM   user_objects
WHERE  object_type IN ('PROCEDURE', 'FUNCTION', 'TRIGGER')
GROUP  BY object_type;

-- Se algum objeto estiver INVALID, mostra o erro de compilação
SELECT name, type, line, text FROM user_errors ORDER BY name, sequence;
```

### Reiniciar do zero

Para repetir a demonstração, apague as tabelas na ordem inversa da criação e rode os scripts novamente, na ordem acima. Os triggers e índices são apagados junto com as tabelas. As functions e procedures usam `CREATE OR REPLACE`, então são recriadas ao rodar o `05` de novo.

```sql
DROP TABLE Historico_Status      CASCADE CONSTRAINTS PURGE;
DROP TABLE Historico_Veterinario CASCADE CONSTRAINTS PURGE;
DROP TABLE Vacinacao             CASCADE CONSTRAINTS PURGE;
DROP TABLE Adocao                CASCADE CONSTRAINTS PURGE;
DROP TABLE Mandato_Diretoria     CASCADE CONSTRAINTS PURGE;
DROP TABLE Doacao                CASCADE CONSTRAINTS PURGE;
DROP TABLE Voluntariado          CASCADE CONSTRAINTS PURGE;
DROP TABLE Despesa               CASCADE CONSTRAINTS PURGE;
DROP TABLE Animal                CASCADE CONSTRAINTS PURGE;
DROP TABLE Pessoa                CASCADE CONSTRAINTS PURGE;
DROP TABLE Unidade_ONG           CASCADE CONSTRAINTS PURGE;
DROP TABLE Raca                  CASCADE CONSTRAINTS PURGE;
DROP TABLE Especie               CASCADE CONSTRAINTS PURGE;
DROP TABLE Endereco              CASCADE CONSTRAINTS PURGE;
```

---

## Documentação

- [DER (Modelo Conceitual)](Modelo%20Conceitual%20%28DER%29.pdf)
- [Modelo Lógico](Modelo%20L%C3%B3gico.pdf)
- [Dicionário de Dados](Dicionario_de_Dados.md)
- [Regras de Negócio](Regras_de_Negocio.md)

---

## Modelo Conceitual

### Modelo Conceitual do Projeto (MER)

O Modelo Conceitual do projeto foi desenvolvido para cobrir todo o ciclo operacional, médico e administrativo da instituição, estando organizado visualmente em 5 blocos funcionais/temáticos:<br>

<div align="justify">

🟨 *Atores Principais / Cadastros Base (Amarelo):* Formado pelas entidades Pessoa, Animal, Especie, Raca e Endereco. Modela os indivíduos cadastrados no sistema (adotantes, voluntários e diretores), os animais resgatados e a taxonomia básica.<br>
🟧 *Processos e Transações do Sistema (Laranja):* Engloba os relacionamentos transacionais Adocao, Voluntariado e Doacao. Gerencia o ciclo de adoções, as escalas de trabalho dos voluntários e as contribuições financeiras recebidas.<br>
🟪 *Estrutura Física e Operacional (Roxo):* Representado pela entidade Unidade_ONG, encarregada de registrar os abrigos e sedes físicas da ONG, controlando a capacidade de alojamento de animais e limites operacionais.<br>
🟦 *Gestão e Governança (Azul):* Composto por Mandato_Diretoria e Historico_Status. Controla os cargos administrativos da ONG e rastreia o histórico temporal das mudanças de estado do animal (ex: transição de EM_TRATAMENTO para DISPONIVEL ou ADOTADO).<br>
🟩 *Registros Médicos e Financeiros (Verde):* Formado por Historico_Veterinario, Vacinacao e Despesa. Armazena os atendimentos clínicos, prontuários veterinários, vacinas aplicadas e as despesas operacionais das unidades.<br>

</div>

### Diagrama de Entidade e Relacionamento (DER)

📄 **[Abrir o DER em PDF](Modelo%20Conceitual%20%28DER%29.pdf)**

### Cardinalidades

O DER tem 17 relacionamentos, todos 1:N. Quatro entidades associativas resolvem as relações N:N.

| Entidade A | Cardinalidade | Entidade B | Observação |
|:-----------|:-------------:|:-----------|:-----------|
| `ESPECIE` | 1:N | `RACA` | Uma espécie possui várias raças |
| `RACA` | 1:N | `ANIMAL` | Um animal tem uma raça |
| `UNIDADE_ONG` | 1:N | `ANIMAL` | Um animal tem uma unidade responsável |
| `ENDERECO` | 1:N | `PESSOA` | Endereço compartilhável entre moradores |
| `ENDERECO` | 1:N | `UNIDADE_ONG` | Endereço compartilhável |
| `PESSOA` | N:N | `ANIMAL` | Resolvida por `ADOCAO` |
| `PESSOA` | N:N | `UNIDADE_ONG` | Resolvida por `VOLUNTARIADO`, `DOACAO` e `MANDATO_DIRETORIA` |
| `UNIDADE_ONG` | 1:N | `DESPESA` | Despesas por unidade |
| `ANIMAL` | 1:N | `VACINACAO` | Carteira de vacinação |
| `ANIMAL` | 1:N | `HISTORICO_VETERINARIO` | Prontuário |
| `ANIMAL` | 1:N | `HISTORICO_STATUS` | Auditoria de status |

---

## Modelo Lógico Relacional

### Conceito: O que é o Modelo Lógico?

<div align="justify">

O Modelo Lógico (ou Relacional) representa a tradução do modelo conceitual para o modelo relacional de banco de dados. Ele converte entidades em tabelas, atributos em colunas com tipos de dados definidos (como VARCHAR2, NUMBER, DATE, CHAR) e estabelece a integridade referencial por meio de Chaves Primárias (PK) e Chaves Estrangeiras (FK). Nessa etapa, aplicam-se as Formas Normais (1FN, 2FN e 3FN) para eliminar redundâncias e evitar anomalias de inserção, alteração e exclusão.

</div>

### Modelo Lógico do Projeto (ONG de Proteção Animal)

<div align="justify">

Na conversão do DER para a estrutura relacional do projeto, as entidades e associações foram mapeadas conforme as seguintes diretrizes técnicas:

* **Mapeamento de Tabelas e Chaves:** Cada entidade do DER gerou uma tabela relacional dotada de chave primária (PK) auto-incremental (NUMBER / IDENTITY). As relações `1:N` foram estruturadas pela inclusão de chaves estrangeiras (FK) nas tabelas dependentes (como ID_Animal em Vacinacao e Historico_Veterinario). As relações `N:N` foram resolvidas por tabelas associativas (Adocao, Voluntariado, Doacao e Mandato_Diretoria), que ligam Pessoa a Animal ou a Unidade_ONG.

* **Normalização Aplicada:**
  * `Especie e Raca:` Foram separadas em tabelas próprias para eliminar a dependência transitiva `ID_Animal → Raca → Especie` na tabela Animal (atendendo à 3FN).
  * `Endereco:` Isolado em uma tabela dedicada, permitindo o compartilhamento e a padronização de localização entre Pessoa e Unidade_ONG.
  * `Historico_Status:` Tabela criada especificamente para auditoria e registro de histórico de transição de status dos animais.

* **Tipagem dos Atributos no Oracle:** O diagrama usa os tipos disponíveis no brModeloWeb (INT, VARCHAR, CHAR, DATE, FLOAT). No script DDL, eles foram convertidos para a sintaxe do Oracle Database: NUMBER(10) para identificadores, VARCHAR2 para textos descritivos, DATE para datas de eventos/resgates, CHAR para códigos de tamanho fixo (CPF, CEP, Sexo, Estado) e NUMBER(10,2) para valores monetários de doações, despesas e remunerações.

</div>

📄 **[Abrir o Modelo Lógico em PDF](Modelo%20L%C3%B3gico.pdf)**

--- 

## Justificativa da Normalização 

<div align="justify">

O processo de normalização do banco de dados relacional foi conduzido para garantir a integridade dos dados, eliminar redundâncias desnecessárias e evitar anomalias de inserção, alteração e exclusão. As regras aplicadas contemplam as três primeiras formas normais (1FN, 2FN e 3FN), além de justificativas técnicas para redundâncias deliberadamente mantidas. 

</div>

### 1. Primeira Forma Normal (1FN) — Atributos Atômicos e Monovalorados 

<div align="justify">

* **Atomicidade dos Dados:** Todos os campos das 14 tabelas armazenam valores atômicos e indivisíveis.

* **Decomposição do Endereço:** O endereço não é armazenado como uma string concatenada. Ele foi isolado na tabela `ENDERECO`, decomposto nos atributos `Rua`, `Numero`, `Bairro`, `Cidade`, `Estado`, `CEP` e `Complemento`. 

* **Ausência de Grupos Repetitivos:** Informações multivaloradas (como múltiplas vacinas ou atendimentos veterinários de um mesmo animal) foram alocadas em tabelas próprias (`VACINACAO` e `HISTORICO_VETERINARIO`), relacionadas via chave estrangeira (`ID_Animal`). 

</div>

### 2. Segunda Forma Normal (2FN) — Dependência Funcional Total

<div align="justify">

* **Eliminação de Dependências Parciais:** A 2FN proíbe que uma coluna dependa de apenas parte de uma chave primária composta. Todas as tabelas do projeto possuem Chaves Primárias (`PK`) simples (chaves substitutas do tipo `IDENTITY`/`NUMBER`), então não existe dependência parcial e a 2FN é atendida em todas elas. 

* **Entidades Associativas:** Mesmo as tabelas que resolvem relações N:N (`ADOCAO`, `VOLUNTARIADO`, `DOACAO` e `MANDATO_DIRETORIA`) usam PK simples, e não a combinação das FKs. Isso também permite que o mesmo par se repita ao longo do tempo, como uma pessoa que adota o mesmo animal em um novo processo.

</div>

### 3. Terceira Forma Normal (3FN) — Eliminação de Dependências Transitivas 

<div align="justify">

* **Eliminação de Atributos Transitivos:** Atributos não-chave dependem exclusivamente da Chave Primária da própria tabela. 

* **Decomposição de Espécie e Raça:** Se a tabela `ANIMAL` guardasse a raça e a espécie, haveria a dependência transitiva `ID_Animal → Raca → Especie`, pois a espécie é determinada pela raça, e não pelo animal. Por isso, a taxonomia foi normalizada nas tabelas `ESPECIE` e `RACA`, e `ANIMAL` faz referência somente a `ID_Raca`. 

* **Normalização de Membros da Diretoria:** A tabela `MANDATO_DIRETORIA` armazena apenas a referência `ID_Pessoa`. O nome e os dados pessoais do diretor permanecem exclusivamente na tabela `PESSOA`, evitando a duplicação do nome em `MANDATO_DIRETORIA`. 

* **Compartilhamento de Endereço:** As tabelas `PESSOA` e `UNIDADE_ONG` não replicam colunas de localização; elas apenas contêm a chave estrangeira `ID_Endereco`, apontando para a tabela `ENDERECO`. 

</div>

### 4. Justificativa de Redundâncias Deliberadas 

<div align="justify">

* **Status atual e `HISTORICO_STATUS`:** O status atual do animal fica registrado na coluna `Status` da tabela `ANIMAL`, e ele também poderia ser obtido pelo último registro de `HISTORICO_STATUS`. Essa redundância é **deliberada**: a consulta do status atual fica direta, sem busca no histórico, e o trigger `trg_animal_historico_status` grava cada mudança automaticamente, mantendo as duas informações coerentes. 

* **Tabela `ENDERECO`:** `ENDERECO` mantém dependências transitivas conhecidas, como `Cidade → Estado`, e o `CEP` geralmente determina `Rua`, `Bairro`, `Cidade` e `Estado`. Eliminá-las exigiria tabelas de cidades e de logradouros/CEPs, mas o projeto não mantém uma base de CEPs e o ganho não compensaria a complexidade para o domínio. A redundância foi **mantida de propósito**, como permite o edital quando tecnicamente justificada. 

</div>

--- 

## Dicionário de Dados 

O dicionário descreve as **14 tabelas** do banco: colunas, tipos Oracle,
chaves, restrições e a regra de negócio ligada a cada coluna.

📄 **[Ver o Dicionário de Dados completo](Dicionario_de_Dados.md)**

| Grupo | Tabelas |
|:------|:--------|
| Cadastros base | `ENDERECO`, `ESPECIE`, `RACA`, `PESSOA`, `ANIMAL` |
| Estrutura e governança | `UNIDADE_ONG`, `MANDATO_DIRETORIA` |
| Processos | `ADOCAO`, `VOLUNTARIADO`, `DOACAO` |
| Registros médicos e financeiros | `VACINACAO`, `HISTORICO_VETERINARIO`, `DESPESA` |
| Auditoria | `HISTORICO_STATUS` |

---

## Regras de Negócio

O banco implementa **16 regras de negócio** (RN01 a RN16). Para cada uma, o
documento indica o que ela garante, **como** foi implementada
(restrição declarativa, modelagem, SQL ou PL/SQL) e onde está no código.

📄 **[Ver as Regras de Negócio completas](Regras_de_Negocio.md)**

| Mecanismo | Regras |
|:----------|:-------|
| Restrição declarativa (`NOT NULL`, `UNIQUE`, `CHECK`, `FK`) | RN01, RN02, RN04, RN05, RN06, RN14, RN16 |
| Índice único condicional | RN08, RN12 (um voluntariado ativo por pessoa na unidade), RN13 |
| PL/SQL (trigger/procedure) | RN03, RN07, RN09, RN10, RN11, RN12 (limite de voluntários), RN15, RN16 (tratamento do erro na exclusão) |

---

## Carga Inicial de Dados 

A povoação inicial do banco de dados foi projetada para garantir volume e relevância técnica suficientes para a execução de relatórios, consultas com `JOIN` e agrupamentos, e testes de restrições de integridade. Os dados também são coerentes entre si: todo animal `ADOTADO` tem uma adoção `CONCLUIDA`, e todo animal `EM_PROCESSO` tem um processo de adoção ativo.

Para respeitar as dependências de chaves estrangeiras (`FOREIGN KEY`), o script de inserção `02_dml_carga.sql` foi estruturado em **4 níveis hierárquicos sequenciais**:

1. **Nível 1 (Tabelas Base Independentes):** Inserção de dados nas tabelas `ENDERECO` e `ESPECIE`, que não possuem dependências externas.
2. **Nível 2 (Tabelas Dependentes do Nível 1):** Inserção nas tabelas `RACA`, `UNIDADE_ONG` e `PESSOA`.
3. **Nível 3 (Tabelas Operacionais e Transacionais):** Cadastro dos registros de `ANIMAL`, `MANDATO_DIRETORIA`, `DESPESA`, `VOLUNTARIADO` e `DOACAO`.
4. **Nível 4 (Tabelas Dependentes do Animal e Processos):** Lançamento de dados em `ADOCAO`, `VACINACAO` e `HISTORICO_VETERINARIO`.

A tabela `HISTORICO_STATUS` não recebe `INSERT` manual: ela é preenchida pelo trigger `trg_animal_historico_status` a cada mudança de status feita depois da criação do PL/SQL.

| Tabela | Registros | Tabela | Registros |
|:-------|:---------:|:-------|:---------:|
| `ENDERECO` | 15 | `MANDATO_DIRETORIA` | 9 |
| `ESPECIE` | 2 | `DESPESA` | 10 |
| `RACA` | 4 | `VOLUNTARIADO` | 10 |
| `UNIDADE_ONG` | 5 | `DOACAO` | 11 |
| `PESSOA` | 20 | `ADOCAO` | 10 |
| `ANIMAL` | 20 | `VACINACAO` | 10 |
| `HISTORICO_VETERINARIO` | 8 | `HISTORICO_STATUS` | 0 (preenchida pelo trigger) |

Como a carga informa os IDs explicitamente, o final do script ajusta o contador de cada coluna `IDENTITY` com `ALTER TABLE ... GENERATED BY DEFAULT AS IDENTITY (START WITH LIMIT VALUE)`. Assim, os próximos registros criados pelas procedures e triggers recebem IDs depois do maior ID da carga.

--- 

## Operações de Atualização e Exclusão 

O script `03_dml_operacoes.sql` reúne exemplos de manipulação de dados (`UPDATE` e `DELETE`) associados a situações reais do fluxo de trabalho da ONG de Proteção Animal. Ele deve rodar depois do `05_plsql.sql`, para que os triggers atuem sobre as alterações.

<br> 

### 1. Operações de Atualização (`UPDATE`)

* **Alta de Tratamento:**
  * *Pergunta de negócio:* Como registrar que um animal concluiu o tratamento médico e ficou disponível para adoção?
  * *Comandos:* `UPDATE Historico_Veterinario SET Estado_Tratamento = 'CONCLUIDO' WHERE ID_Historico_Veterinario = 1 AND Estado_Tratamento = 'EM_ANDAMENTO';` e `UPDATE Animal SET Status = 'DISPONIVEL' WHERE ID_Animal = 2 AND Status = 'EM_TRATAMENTO';`

* **Aprovação de Processo de Adoção:**
  * *Pergunta de negócio:* Como registrar que um processo de adoção em análise foi aprovado?
  * *Comando:* `UPDATE Adocao SET Status = 'APROVADA' WHERE ID_Adocao = 2 AND Status = 'EM_ANALISE';`
  * O animal continua `EM_PROCESSO` até a conclusão, feita pela procedure `prc_concluir_adocao`.

* **Encerramento de Vínculo de Voluntariado:**
  * *Pergunta de negócio:* Como registrar a data de encerramento do trabalho de um voluntário que se desligou da instituição?
  * *Comando:* `UPDATE Voluntariado SET Data_Fim = TO_DATE('2026-11-01', 'YYYY-MM-DD') WHERE ID_Voluntariado = 1 AND Data_Fim IS NULL;`

* **Manutenção Cadastral de Pessoas:**
  * *Pergunta de negócio:* Como atualizar os canais de contato (telefone e e-mail) de um doador ou voluntário cadastrado?
  * *Comando:* `UPDATE Pessoa SET Telefone = '16999998888', Email = 'ana.souza_atualizado@email.com' WHERE ID_Pessoa = 1;` 

* **Reprovação de Processo de Adoção:**
  * *Pergunta de negócio:* Como registrar que um processo de adoção foi reprovado e liberar o animal para outra adoção?
  * *Comando:* `UPDATE Adocao SET Status = 'REPROVADA', Data_Conclusao = TO_DATE('2026-11-03', 'YYYY-MM-DD') WHERE ID_Adocao = 6 AND Status = 'EM_ANALISE';`
  * O trigger `trg_adocao_status_animal` devolve o animal 15 para `DISPONIVEL`.

<br> 

### 2. Operações de Exclusão (`DELETE`) 

Cada exclusão remove um registro lançado por engano na carga. Os processos de adoção não são excluídos, porque o histórico de reprovações, cancelamentos e devoluções faz parte do domínio.

* **Exclusão de Doação em Duplicidade:**
  * *Pergunta de negócio:* Como excluir uma doação que foi registrada duas vezes por engano?
  * *Comando:* `DELETE FROM Doacao WHERE ID_Doacao = 11;`

* **Exclusão de Despesa Indevida:**
  * *Pergunta de negócio:* Como apagar um lançamento de despesa cadastrado com valor errado?
  * *Comando:* `DELETE FROM Despesa WHERE ID_Despesa = 10;`

* **Estorno de Aplicação de Vacina Errônea:**
  * *Pergunta de negócio:* Como apagar o registro de uma dose de vacina lançada por engano no cartão de vacinação do animal?
  * *Comando:* `DELETE FROM Vacinacao WHERE ID_Vacinacao = 10;`

* **Limpeza de Prontuário Veterinário Duplicado:**
  * *Pergunta de negócio:* Como remover um atendimento veterinário registrado em duplicidade?
  * *Comando:* `DELETE FROM Historico_Veterinario WHERE ID_Historico_Veterinario = 8;`

---

## Consultas SQL

O script `04_consultas.sql` contém 12 consultas. Cada uma vem acompanhada, no próprio arquivo, do requisito do edital que atende e da pergunta de negócio que responde. Ele deve rodar depois do `03_dml_operacoes.sql`.

| # | Pergunta de negócio | Recursos SQL |
|:-:|:--------------------|:-------------|
| 1 | Quais animais estão disponíveis para adoção em cada unidade, com espécie e raça? | Filtro, `JOIN` com 4 tabelas e `ORDER BY` |
| 2 | Qual é o status atual de cada animal e por quais mudanças de status ele já passou? | `JOIN` com `HISTORICO_STATUS` |
| 3 | Quantos processos de adoção existem em cada situação? | `COUNT` e `GROUP BY` |
| 4 | Quais animais sob cuidado da ONG ainda não receberam nenhuma vacina? | Subconsulta com `NOT EXISTS` |
| 5 | Quais animais estão com tratamento em andamento, com diagnóstico e tratamento prescrito? | `JOIN` com filtro |
| 6 | Quais unidades têm pelo menos 3 animais sob cuidado e qual o percentual de ocupação de cada uma? | Agregação, `JOIN`, `GROUP BY` e `HAVING` |
| 7 | Quantos voluntários ativos cada unidade tem em cada função? | `COUNT` e `GROUP BY` |
| 8 | Quanto a ONG recebeu em doações em cada mês e por qual forma de pagamento? | `SUM`, `COUNT` e `GROUP BY` por mês |
| 9 | Quanto cada unidade gastou em cada tipo de despesa? | `SUM` e `GROUP BY` |
| 10 | Quem compõe a diretoria atual de cada unidade e com qual remuneração? | `JOIN` com filtro `Data_Saida IS NULL` |
| 11 | Quem são as pessoas que atuam hoje na ONG, como voluntárias ou na diretoria? | `UNION` |
| 12 | Quais pessoas não têm e-mail cadastrado e só podem ser contatadas por telefone? | `SELECT` simples com filtro e ordenação |

A consulta 2 depende do histórico gravado pelo trigger. Se os scripts rodarem fora da ordem indicada, ela não retorna linhas.

---

## Objetos PL/SQL

O script `05_plsql.sql` cria **2 functions, 6 procedures e 12 triggers**. Ele deve ser executado depois da carga e antes do `03_dml_operacoes.sql`. Dentro do arquivo, a ordem é: functions e procedure de apoio, triggers e procedures.

### Functions

| Objeto | Regra | O que faz |
|:-------|:-----:|:----------|
| `fn_maior_idade` | RN03 | Retorna 1 se a pessoa tinha 18 anos ou mais na data informada, e 0 caso contrário. Erro `ORA-20010` se a pessoa não existir |
| `fn_vagas_disponiveis` | RN11 | Capacidade da unidade menos os animais que ocupam vaga (`EM_TRATAMENTO`, `DISPONIVEL`, `EM_PROCESSO`); nunca retorna negativo. Erro `ORA-20001` se a unidade não existir |

### Triggers

| Objeto | Regra | O que faz |
|:-------|:-----:|:----------|
| `trg_adocao_maior_idade` | RN03 | Bloqueia adotante menor de 18 anos (`ORA-20011`) |
| `trg_doacao_maior_idade` | RN03 | Bloqueia doador menor de 18 anos (`ORA-20012`) |
| `trg_mandato_maior_idade` | RN03 | Bloqueia diretor menor de 18 anos (`ORA-20013`) |
| `trg_animal_data` | RN07 | Bloqueia data de resgate futura |
| `trg_adocao_data` | RN07 | Bloqueia início de adoção futuro ou anterior ao resgate |
| `trg_hist_vet_data` | RN07 | Bloqueia atendimento futuro ou anterior ao resgate |
| `trg_vacinacao_data` | RN07 | Bloqueia vacina com data futura ou anterior ao resgate |
| `trg_doacao_data` | RN07 | Bloqueia doação com data futura |
| `trg_despesa_data` | RN07 | Bloqueia despesa com data futura |
| `trg_adocao_animal_disponivel` | RN09 | Só permite adoção de animal com status `DISPONIVEL` (`ORA-20040`) |
| `trg_adocao_status_animal` | RN09, RN10 | Atualiza o status do animal conforme o processo: `EM_PROCESSO` na abertura e aprovação, `ADOTADO` na conclusão e `DISPONIVEL` em reprovação, cancelamento ou devolução |
| `trg_animal_historico_status` | RN15 | Registra em `HISTORICO_STATUS` o cadastro do animal e cada mudança de status |

### Procedures

| Objeto | Regra | O que faz |
|:-------|:-----:|:----------|
| `prc_validar_data_evento` | RN07 | Rotina de apoio dos triggers de data. Recusa data futura (`ORA-20060`) e evento anterior ao resgate do animal (`ORA-20061`) |
| `prc_registrar_resgate` | RN11 | Trava a unidade, confere as vagas e cadastra o animal com status `EM_TRATAMENTO`; devolve o ID criado. Erros: `ORA-20020` (unidade lotada) e `ORA-20001` (unidade inexistente) |
| `prc_concluir_adocao` | RN10 | Conclui somente adoção `APROVADA` e registra a data de conclusão; o trigger `trg_adocao_status_animal` muda o animal para `ADOTADO`. Erros: `ORA-20031` (status inválido) e `ORA-20030` (adoção inexistente) |
| `prc_registrar_voluntario` | RN12 | Trava a unidade, confere o limite de voluntários ativos e cadastra o voluntariado; devolve o ID criado. Erro `ORA-20070` (limite atingido) |
| `prc_excluir_animal` | RN16 | Exclui o animal; se houver registros vinculados, trata o `ORA-02292` e devolve `ORA-20051`. Erro `ORA-20050` se o animal não existir |
| `prc_relatorio_ocupacao` | — | Percorre as unidades com cursor e imprime capacidade e vagas disponíveis |

### Decisões de projeto

- **Maioridade em trigger:** o `CHECK` não consulta outra tabela, e a idade depende da data de nascimento em `PESSOA`. Por isso a regra usa function e trigger, comparando a idade com a data do evento, e não com a data atual.
- **Datas em trigger:** o `CHECK` do Oracle não aceita `SYSDATE`, então a RN07 é aplicada por triggers que chamam `prc_validar_data_evento`. No trigger de `ANIMAL`, só a data futura é conferida, porque consultar a própria tabela causaria o erro `ORA-04091` (tabela mutante).
- **Capacidade e limite de voluntários em procedures:** contar os registros da própria tabela dentro de um trigger também causaria `ORA-04091`. Por isso, `prc_registrar_resgate` e `prc_registrar_voluntario` fazem a contagem antes de inserir.
- **Status do animal sincronizado:** o trigger `trg_adocao_status_animal` mantém o status do animal coerente com qualquer mudança no processo de adoção, mesmo quando ela é feita por `UPDATE` direto.
- **Histórico automático:** a trigger de status grava `Status_Anterior` nulo no cadastro do animal e só registra atualizações em que o status realmente muda.

### Exemplos de uso

```sql
SET SERVEROUTPUT ON

-- Vagas disponíveis em uma unidade
SELECT fn_vagas_disponiveis(1) AS vagas FROM dual;

-- Relatório de ocupação de todas as unidades
BEGIN
    prc_relatorio_ocupacao;
END;
/

-- Concluir uma adoção aprovada (após a carga, as adoções 2 e 5 estão APROVADA)
BEGIN
    prc_concluir_adocao(5);
END;
/
```

As demonstrações completas estão em `06_testes.sql`.

---

## Testes

O script `06_testes.sql` demonstra as functions, procedures e triggers e as restrições declarativas do DDL. Os comandos que **devem falhar** estão marcados no arquivo com o erro esperado: nesses casos, o erro é o resultado correto, porque mostra a regra funcionando. Execute um bloco de cada vez, na ordem, pois alguns testes dependem dos anteriores.

| Parte | O que demonstra | Resultado esperado |
|:-----:|:----------------|:-------------------|
| 1 | `fn_maior_idade` e triggers da RN03: cadastro de uma pessoa menor de idade, retorno 1 ou 0 da function e bloqueio de doação e adoção por menor | Function retorna 1 e 0; `ORA-20012` e `ORA-20011` |
| 2 | `prc_registrar_voluntario` (RN12): menor de idade cadastrado como voluntário e bloqueio quando a unidade atinge o limite | Sucesso; `ORA-20070` |
| 3 | `prc_registrar_resgate` e `fn_vagas_disponiveis` (RN11): cadastro de resgate, registro automático no histórico e bloqueio de unidade lotada | Sucesso; `ORA-20020` |
| 4 | Fluxo de adoção (RN08, RN09, RN10): nova adoção, animal em `EM_PROCESSO`, segunda adoção bloqueada, processo ativo duplicado, conclusão de adoção não aprovada e conclusão pela procedure | Sucesso; `ORA-20040`, `ORA-00001` e `ORA-20031`; animal `ADOTADO` |
| 5 | Exclusão protegida (RN16) e datas (RN07) | `ORA-20051`, `ORA-20060` e `ORA-20061` |
| 6 | Relatório de ocupação com cursor e histórico de status (RN15) | Saída no `DBMS_OUTPUT`; mudanças registradas |
| 7 | Restrições do DDL: CPF repetido, campo obrigatório vazio, valor e status inválidos, FK inexistente, exclusão de registro com dependentes, dose repetida e CEP fora do formato | `ORA-00001`, `ORA-01400`, `ORA-02290`, `ORA-02291`, `ORA-02292` e `ORA-12899` |
