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

├── [`Modelo Conceitual`](MODELO CONCEITUAL – ONG de Proteção Animal.pdf)
├── [`Modelo Lógico`]()
├── [`01_ddl_estrutura.sql`](01_ddl_estrutura.sql)········# Criação das tabelas, chaves primárias/estrangeiras e restrições CHECK<br> 
├── [`02_dml_carga.sql`](02_dml_carga.sql)············# Script de carga inicial de dados de teste<br>
├── [`03_dml_operacoes.sql`](03_dml_operacoes.sql)········# Exemplos práticos de atualização (UPDATE) e exclusão (DELETE)<br>
├── [`04_consultas.sql`]()············# Consultas SQL (JOIN, Agregação, GROUP BY, Subconsultas, UNION)<br>
├── [`05_plsql.sql`]()················# Implementação de Procedures, Functions e Triggers<br>
├── [`06_testes.sql`]()···············# Execução de testes de validação das regras de negócio<br>
└── [`docs`]()························# DER, Modelo Lógico, Dicionário de Dados e Documentação do Projeto<br>

</div>

---

1. Modelo Conceitual💡

Conceito: O que são MER e DER?

MER (Modelo Entidade-Relacionamento): É a especificação conceitual e abstrata do domínio de negócio1. Ele identifica quais entidades do mundo real precisam ser registradas no sistema, quais atributos descrevem essas entidades e como elas se relacionam sintaticamente, sem se preocupar com restrições técnicas ou implementação física em um SGBD específico.

DER (Diagrama Entidade-Relacionamento): É a representação visual e gráfica do MER13. Utiliza notação conceitual (como a notação de Peter Chen), onde as entidades são desenhadas em retângulos, os atributos em elipses/bolinhas, os relacionamentos em losangos e as linhas de associação indicam as cardinalidades mínimas e máximas do sistema1.

Modelo Conceitual do Projeto (ONG de Proteção Animal)

O Modelo Conceitual do projeto foi desenvolvido para cobrir todo o ciclo operacional, médico e administrativo da instituição, estando organizado visualmente em 5 blocos funcionais/temáticos:
🟨 Atores Principais / Cadastros Base (Amarelo): Formado pelas entidades Pessoa, Animal, Especie, Raca e Endereco4. Modela os indivíduos cadastrados no sistema (adotantes, voluntários e diretores), os animais resgatados e a taxonomia básica.
🟧 Processos e Transações do Sistema (Laranja): Engloba os relacionamentos transacionais Adocao, Voluntariado e Doacao. Gerencia o ciclo de adoções, as escalas de trabalho dos voluntários e as contribuições financeiras recebidas.
🟪 Estrutura Física e Operacional (Roxo): Representado pela entidade Unidade_ONG, encarregada de registrar os abrigos e sedes físicas da ONG, controlando a capacidade de alojamento de animais e limites operacionais.
🟦 Gestão e Governança (Azul): Composto por Mandato_Diretoria e Historico_Status4. Controla os cargos administrativos da ONG e rastreia o histórico temporal das mudanças de estado do animal (ex: transição de EM_TRATAMENTO para DISPONIVEL ou ADOTADO).
🟩 Registros Médicos e Financeiros (Verde): Formado por Historico_Veterinario, Vacinacao e Despesa4. Armazena os atendimentos clínicos, prontuários veterinários, vacinas aplicadas e as despesas operacionais das unidades.

2. Modelo Lógico Relacional💡

Conceito: O que é o Modelo Lógico?O Modelo Lógico (ou Relacional) representa a tradução do modelo conceitual para o modelo relacional de banco de dados18. Ele converte entidades em tabelas, atributos em colunas com tipos de dados definidos (como VARCHAR2, NUMBER, DATE, CHAR) e estabelece a integridade referencial por meio de Chaves Primárias (PK) e Chaves Estrangeiras (FK)1more_horiz. Nessa etapa, aplicam-se as Formas Normais (1FN, 2FN e 3FN) para eliminar redundâncias e evitar anomalias de inserção, alteração e exclusão18.

🐾 Modelo Lógico do Projeto (ONG de Proteção Animal)

Na conversão do DER para a estrutura relacional do projeto, as entidades e associações foram mapeadas conforme as seguintes diretrizes técnicas119:Mapeamento de Tabelas e Chaves: Cada entidade do DER gerou uma tabela relacional dotada de chave primária (PK) auto-incremental (NUMBER / IDENTITY)5more_horiz. As relações de cardinalidade $1:N$ e $N:N$ foram estruturadas pela inclusão de chaves estrangeiras (FK) nas tabelas dependentes (como ID_Animal em Vacinacao e Historico_Veterinario)16more_horiz.Normalização Aplicada:Especie e Raca: Foram separadas em tabelas próprias para eliminar a repetição de nomes de espécies/raças na tabela Animal (atendendo à 2FN e 3FN)1more_horiz.Endereco: Isolado em uma tabela dedicada, permitindo o compartilhamento e a padronização de localização entre Pessoa e Unidade_ONG1more_horiz.Historico_Status: Tabela criada especificamente para auditoria e registro de histórico de transição de status dos animais1more_horiz.Tipagem dos Atributos no Oracle: Os tipos de dados foram especificados utilizando a sintaxe do Oracle Database: VARCHAR2 para textos descritivos, DATE para datas de eventos/resgates, CHAR para códigos de tamanho fixo (CPF, Sexo, Estado) e NUMBER(10,2) para valores monetários de doações e despesas5more_horiz. 

