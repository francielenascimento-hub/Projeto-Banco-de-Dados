<p align="center">
  
  # Projeto Banco de Dados
  
</p>

**Sistema de Gestão para ONG de Proteção Animal** <br>
**| Projeto prático de Banco de Dados Relacional desenvolvido em Oracle SQL e PL/SQL para a disciplina de Banco de Dados I (ADS - FATEC Ribeirão Preto).** <br>
**Inclui modelagem DER/Lógica, scripts DDL/DML, Procedures, Functions e Triggers.**


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

---

### 1. Modelo Conceitual

#### Conceito: O que são MER e DER?

<div align="justify">

**MER (Modelo Entidade-Relacionamento):** É a especificação conceitual e abstrata do domínio de negócio1. Ele identifica quais entidades do mundo real precisam ser registradas no sistema, quais atributos descrevem essas entidades e como elas se relacionam sintaticamente, sem se preocupar com restrições técnicas ou implementação física em um SGBD específico.

**DER (Diagrama Entidade-Relacionamento):** É a representação visual e gráfica do MER13. Utiliza notação conceitual (como a notação de Peter Chen), onde as entidades são desenhadas em retângulos, os atributos em elipses/bolinhas, os relacionamentos em losangos e as linhas de associação indicam as cardinalidades mínimas e máximas do sistema1.

</div>

#### 1.1 Modelo Conceitual do Projeto (ONG de Proteção Animal)

O Modelo Conceitual do projeto foi desenvolvido para cobrir todo o ciclo operacional, médico e administrativo da instituição, estando organizado visualmente em 5 blocos funcionais/temáticos:
🟨 *Atores Principais / Cadastros Base (Amarelo):* Formado pelas entidades Pessoa, Animal, Especie, Raca e Endereco4. Modela os indivíduos cadastrados no sistema (adotantes, voluntários e diretores), os animais resgatados e a taxonomia básica.<br>
🟧 *Processos e Transações do Sistema (Laranja):* Engloba os relacionamentos transacionais Adocao, Voluntariado e Doacao. Gerencia o ciclo de adoções, as escalas de trabalho dos voluntários e as contribuições financeiras recebidas.<br>
🟪 *Estrutura Física e Operacional (Roxo):* Representado pela entidade Unidade_ONG, encarregada de registrar os abrigos e sedes físicas da ONG, controlando a capacidade de alojamento de animais e limites operacionais.<br>
🟦 *Gestão e Governança (Azul):* Composto por Mandato_Diretoria e Historico_Status. Controla os cargos administrativos da ONG e rastreia o histórico temporal das mudanças de estado do animal (ex: transição de EM_TRATAMENTO para DISPONIVEL ou ADOTADO).<br>
🟩 *Registros Médicos e Financeiros (Verde):* Formado por Historico_Veterinario, Vacinacao e Despesa4. Armazena os atendimentos clínicos, prontuários veterinários, vacinas aplicadas e as despesas operacionais das unidades.<br>

### 2. Modelo Lógico Relacional

#### Conceito: O que é o Modelo Lógico?

<div align="justify">

O Modelo Lógico (ou Relacional) representa a tradução do modelo conceitual para o modelo relacional de banco de dados. Ele converte entidades em tabelas, atributos em colunas com tipos de dados definidos (como VARCHAR2, NUMBER, DATE, CHAR) e estabelece a integridade referencial por meio de Chaves Primárias (PK) e Chaves Estrangeiras (FK)1more_horiz. Nessa etapa, aplicam-se as Formas Normais (1FN, 2FN e 3FN) para eliminar redundâncias e evitar anomalias de inserção, alteração e exclusão18.

</div>

#### Modelo Lógico do Projeto (ONG de Proteção Animal)

Na conversão do DER para a estrutura relacional do projeto, as entidades e associações foram mapeadas conforme as seguintes diretrizes técnicas119:

* **Mapeamento de Tabelas e Chaves:** Cada entidade do DER gerou uma tabela relacional dotada de chave primária (PK) auto-incremental (NUMBER / IDENTITY). As relações de cardinalidade ´1:N´ e ´N:N´ foram estruturadas pela inclusão de chaves estrangeiras (FK) nas tabelas dependentes (como ID_Animal em Vacinacao e Historico_Veterinario).

* **Normalização Aplicada:**
  * ´Especie e Raca:´ Foram separadas em tabelas próprias para eliminar a repetição de nomes de espécies/raças na tabela Animal (atendendo à 2FN e 3FN).
  * ´Endereco:´ Isolado em uma tabela dedicada, permitindo o compartilhamento e a padronização de localização entre Pessoa e Unidade_ONG.
  * ´Historico_Status:´ Tabela criada especificamente para auditoria e registro de histórico de transição de status dos animais.

* **Tipagem dos Atributos no Oracle:** Os tipos de dados foram especificados utilizando a sintaxe do Oracle Database: VARCHAR2 para textos descritivos, DATE para datas de eventos/resgates, CHAR para códigos de tamanho fixo (CPF, Sexo, Estado) e NUMBER(10,2) para valores monetários de doações e despesas5more_horiz. 

---



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

--- 

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

