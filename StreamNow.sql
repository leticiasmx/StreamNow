CREATE TABLE usuarios (
    id_usuario SERIAL,
    nome VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    data_cadastro DATE NOT NULL,
    plano VARCHAR(20) NOT NULL
) PARTITION BY LIST (pais);

CREATE TABLE reproducoes (
    id_reproducao SERIAL,
    id_usuario INT NOT NULL,
    data_reproducao DATE NOT NULL,
    duracao_segundos INT NOT NULL,
    categoria VARCHAR(50) NOT NULL
) PARTITION BY RANGE (data_reproducao);

CREATE TABLE usuarios_brasil PARTITION OF usuarios
    FOR VALUES IN ('Brasil');

CREATE TABLE usuarios_eua PARTITION OF usuarios
    FOR VALUES IN ('Estados Unidos');

CREATE TABLE reproducoes_2024_01 PARTITION OF reproducoes
    FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE reproducoes_2024_02 PARTITION OF reproducoes
    FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

INSERT INTO usuarios (nome, pais, data_cadastro, plano) VALUES
('João Silva', 'Brasil', '2024-01-15', 'Premium'),
('Maria Santos', 'Brasil', '2024-01-20', 'Family'),
('John Smith', 'Estados Unidos', '2024-02-01', 'Premium'),
('Emily Johnson', 'Estados Unidos', '2024-02-10', 'Free');

INSERT INTO reproducoes (id_usuario, data_reproducao, duracao_segundos, categoria) VALUES
(1, '2024-01-15', 3600, 'Filme'),
(2, '2024-01-20', 1800, 'Série'),
(3, '2024-02-05', 2700, 'Documentário'),
(4, '2024-02-15', 1500, 'Infantil');

SELECT pais, COUNT(*) as total_usuarios
FROM usuarios 
GROUP BY pais;

SELECT 
    DATE_TRUNC('month', data_cadastro) as mes,
    COUNT(*) as total_cadastros
FROM usuarios 
WHERE pais = 'Brasil'
GROUP BY mes 
ORDER BY mes;

-- Total de reproduções por categoria
SELECT categoria, COUNT(*) as total_reproducoes
FROM reproducoes 
GROUP BY categoria;

-- Total de horas assistidas por mês
SELECT 
    DATE_TRUNC('month', data_reproducao) as mes,
    SUM(duracao_segundos)/3600 as total_horas
FROM reproducoes 
GROUP BY mes 
ORDER BY mes;

-- Histórico de reproduções de um período específico
SELECT 
    r.data_reproducao,
    u.nome,
    r.categoria,
    r.duracao_segundos
FROM reproducoes r
JOIN usuarios u ON r.id_usuario = u.id_usuario
WHERE r.data_reproducao BETWEEN '2024-01-01' AND '2024-01-31'
ORDER BY r.data_reproducao;
