# Projeto-Banco-de-Dados
Sistema de Gestão para ONG de Proteção Animal <br>
| Projeto prático de Banco de Dados Relacional desenvolvido em Oracle SQL e PL/SQL para a disciplina de Banco de Dados I (ADS - FATEC Ribeirão Preto).<br>
Inclui modelagem DER/Lógica, scripts DDL/DML, Procedures, Functions e Triggers.
---
# Sistema de Gestão para ONG de Proteção Animal

**Projeto Prático de Banco de Dados I**

\*\*Curso:\*\* Tecnologia em Análise e Desenvolvimento de Sistemas (ADS) — FATEC Ribeirão Preto &gt; \*\*Orientadora:\*\* Profa. Me. Eliza Bomfim &gt; \*\*SGBD:\*\* Oracle Database --- ## 

📌 Sobre o Projeto 

Este repositório contém a solução completa de banco de dados relacional desenvolvida para a gestão operacional, médica e financeira de uma \*\*ONG de Proteção Animal\*\*. O projeto abrange desde o levantamento das necessidades de informação e modelagem conceitual até a implementação física e programação procedimental em ambiente \*\*Oracle\*\*. O sistema foi projetado para responder a perguntas reais do negócio, garantindo a integridade dos dados, a rastreabilidade dos animais resgatados e a transparência no controle de recursos. --- ## 

🏗️ Módulos e Estrutura do Banco de Dados A modelagem engloba 10 entidades principais organizadas nos seguintes fluxos operacionais: 

\* \*\*Cadastros Base e Atores:\*\* Gestão de Pessoas (Adotantes, Voluntários e Membros da Diretoria) e Animais resgatados. \* \*\*Estrutura Operacional:\*\* Controle de Unidades da ONG e capacidade máxima de alojamento. \* \*\*Processos e Transações:\*\* Gerenciamento dos fluxos de Adoção e escalas de Voluntariado. \* \*\*Registros Médicos e Financeiros:\*\* Acompanhamento do Histórico Veterinário, Carteira de Vacinação, recebimento de Doações e controle de Despesas da instituição. --- ## 🛠️ Tecnologias e Recursos Utilizados \* \*\*SGBD:\*\* Oracle Database \* \*\*Linguagem SQL (DDL e DML):\*\* Criação de tabelas, chaves (PK/FK), restrições de integridade (\`CHECK\`, \`NOT NULL\`, \`UNIQUE\`) e manipulação de dados. \* \*\*Lógica Procedimental (PL/SQL):\*\* \* \*\*Triggers:\*\* Automação de status de adoção e controle de capacidade das unidades. \* \*\*Procedures:\*\* Validação de regras de negócio complexas e cadastro seguro. \* \*\*Functions:\*\* Cálculos dinâmicos de doações acumuladas e despesas veterinárias. \* \*\*Modelagem:\*\* Diagrama Entidade-Relacionamento (DER) e Modelo Lógico Relacional normalizado (3FN). --- ## 

📁 Estrutura do Repositório 

\`\`\`text ├── 01\_ddl\_estrutura.sql # Criação das tabelas, chaves primárias/estrangeiras e restrições CHECK ├── 02\_dml\_carga.sql # Script de carga inicial de dados de teste ├── 03\_dml\_operacoes.sql # Exemplos práticos de atualização (UPDATE) e exclusão (DELETE) ├── 04\_consultas.sql # Consultas SQL (JOIN, Agregação, GROUP BY, Subconsultas, UNION) ├── 05\_plsql.sql # Implementação de Procedures, Functions e Triggers ├── 06\_testes.sql # Execução de testes de validação das regras de negócio └── docs/ # DER, Modelo Lógico, Dicionário de Dados e Documentação do Projeto
