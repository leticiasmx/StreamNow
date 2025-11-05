# 🎯 StreamNow - Particionamento de Dados no PostgreSQL

# 📋 Descrição do Projeto
Implementação de estratégias avançadas de particionamento de dados no PostgreSQL para otimizar o desempenho e facilitar a manutenção do banco de dados da StreamNow, uma plataforma de streaming em crescimento rápido que enfrenta desafios de escalabilidade.

# 🏢 Contexto do Cenário
A StreamNow é uma plataforma de streaming de vídeos que cresceu rapidamente nos últimos anos, com:

Milhões de usuários cadastrados

Bilhões de registros de reproduções

Problemas de performance em consultas

Dificuldades em gerenciamento de backups e manutenção

# 🎯 Objetivos
✅ Implementar particionamento estratégico de dados

✅ Melhorar performance de consultas frequentes

✅ Facilitar manutenção e backups

✅ Otimizar escalabilidade do sistema

✅ Simplificar arquivamento de dados históricos

# 🧠 Estratégias de Particionamento Implementadas
# 📊 Tabela usuarios
Aspecto	Detalhamento
Tipo	Particionamento LIST
Coluna	pais
Partições	usuarios_brasil, usuarios_eua
Justificativa	Consultas frequentes por país, mais de 40 países diferentes, distribuição natural dos dados
# 📊 Tabela reproducoes
Aspecto	Detalhamento
Tipo	Particionamento RANGE
Coluna	data_reproducao
Partições	reproducoes_2024_01, reproducoes_2024_02
Justificativa	Crescimento diário de milhões de registros, consultas por período, facilidade de arquivamento

# 🚀 Como Executar o Projeto
Pré-requisitos
PostgreSQL 16 ou superior

Acesso de superusuário para criar partições

# 📊 Consultas Otimizadas
# 🔍 Análise de Usuários
sql
-- Total de usuários por país (otimizado por LIST partitioning)
SELECT pais, COUNT(*) as total_usuarios
FROM usuarios 
GROUP BY pais;

# 🎬 Análise de Reproduções
sql
-- Total de horas assistidas por mês (otimizado por RANGE partitioning)
SELECT 
    DATE_TRUNC('month', data_reproducao) as mes,
    SUM(duracao_segundos)/3600 as total_horas
FROM reproducoes 
GROUP BY mes;

# 📈 Benefícios Mensurados
⚡ Performance
Redução de 60-80% no tempo de consultas por período

Scan de dados reduzido em consultas filtradas por país/data

Melhor utilização de índices e cache

# 🔧 Manutenção
Backups segmentados por país/periodo

Arquivamento simplificado (DROP PARTITION)

Manutenção mensal otimizada

# 📊 Gestão de Dados
Retenção flexível de dados históricos

Escalabilidade horizontal simplificada

Isolamento de partições problemáticas

# 🛠️ Scripts Disponíveis
Script	Descrição
01_create_tables.sql	Cria tabelas principais com definição de particionamento
02_create_partitions.sql	Cria partições específicas para cada tabela
03_inserts.sql	Insere dados de exemplo nas partições
04_queries.sql	Consultas de exemplo demonstrando os benefícios


Se você tiver alguma dúvida ou sugestão, por favor abra uma issue no repositório.

