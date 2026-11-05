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

### Estrutura do Repositório 

<div align="justify">

├── 01_ddl_estrutura.sql        # Criação das tabelas, chaves primárias/estrangeiras e restrições CHECK<br> 
├── 02_dml_carga.sql            # Script de carga inicial de dados de teste<br>
├── 03_dml_operacoes.sql        # Exemplos práticos de atualização (UPDATE) e exclusão (DELETE)<br>
├── 04_consultas.sql            # Consultas SQL (JOIN, Agregação, GROUP BY, Subconsultas, UNION)<br>
├── 05_plsql.sql                # Implementação de Procedures, Functions e Triggers<br>
├── 06_testes.sql               # Execução de testes de validação das regras de negócio<br>
└── docs                        # DER, Modelo Lógico, Dicionário de Dados e Documentação do Projeto<br>

</div>


