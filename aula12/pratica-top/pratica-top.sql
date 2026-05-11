CREATE DATABASE academia;
USE academia;

CREATE TABLE aluno (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100),
	data_nascimento DATE,
	data_matricula DATE
);

CREATE TABLE plano (
	id INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(50),
	preco DECIMAL(10,2),
	duracao_dias INT
);

CREATE TABLE forma_pagamento (
	id INT PRIMARY KEY AUTO_INCREMENT,
	tipo VARCHAR(50)
);

CREATE TABLE matricula (
	id INT PRIMARY KEY AUTO_INCREMENT,
	aluno_id INT,
	plano_id INT,
	data_matricula DATE,
	FOREIGN KEY (aluno_id) REFERENCES aluno(id),
	FOREIGN KEY (plano_id) REFERENCES plano(id)
);

CREATE TABLE pagamento (
	id INT PRIMARY KEY AUTO_INCREMENT,
	matricula_id INT,
	forma_pagamento_id INT,
	valor DECIMAL(10,2),
	data_pagamento DATE,
	status_pagamento VARCHAR(30),
	FOREIGN KEY (matricula_id) REFERENCES matricula(id),
	FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(id)
);

INSERT INTO plano (titulo, preco, duracao_dias) VALUES
('Mensal',120.00,30),
('Trimestral',300.00,90),
('Anual',1000.00,365);

INSERT INTO forma_pagamento (tipo) VALUES
('Cartão'),
('Pix'),
('Dinheiro');

INSERT INTO aluno (nome, data_nascimento, data_matricula) VALUES
('João Silva','2000-05-10','2026-01-10'),
('Maria Souza','1998-03-20','2026-01-15'),
('Carlos Lima','1985-08-01','2026-02-01'),
('Fernanda Alves','1992-12-11','2026-02-10'),
('Lucas Santos','2004-07-22','2026-03-05');

INSERT INTO matricula (aluno_id, plano_id, data_matricula) VALUES
(1,1,'2026-01-10'),
(2,3,'2026-01-15'),
(3,2,'2026-02-01'),
(4,1,'2026-02-10'),
(5,3,'2026-03-05'),
(1,2,'2026-04-01');

INSERT INTO pagamento (matricula_id, forma_pagamento_id, valor, data_pagamento, status_pagamento) VALUES
(1,1,120.00,'2026-01-10','Pago'),
(2,2,500.00,'2026-01-15','Pago'),
(2,1,500.00,'2026-02-15','Pago'),
(3,3,150.00,'2026-02-01','Pago'),
(3,2,150.00,'2026-03-01','Atrasado'),
(4,1,120.00,'2026-02-10','Pago'),
(5,2,500.00,'2026-03-05','Pago'),
(5,2,500.00,'2026-04-05','Pago'),
(6,1,300.00,'2026-04-01','Pago'),
(1,3,120.00,'2026-02-10','Atrasado');

SELECT 
	a.nome,
	p.titulo
FROM aluno a
JOIN matricula m ON a.id = m.aluno_id
JOIN plano p ON m.plano_id = p.id;

SELECT 
	a.nome
FROM aluno a
JOIN matricula m ON a.id = m.aluno_id
JOIN plano p ON m.plano_id = p.id
WHERE p.titulo = 'Anual'
AND DATE_ADD(m.data_matricula, INTERVAL 365 DAY) >= CURDATE();

SELECT 
	a.nome,
	SUM(pg.valor) AS total_pago
FROM aluno a
JOIN matricula m ON a.id = m.aluno_id
JOIN pagamento pg ON m.id = pg.matricula_id
GROUP BY a.id;

SELECT DISTINCT
	a.nome
FROM aluno a
JOIN matricula m ON a.id = m.aluno_id
JOIN pagamento pg ON m.id = pg.matricula_id
JOIN forma_pagamento fp ON pg.forma_pagamento_id = fp.id
WHERE fp.tipo = 'Cartão';

SELECT 
	a.nome
FROM aluno a
LEFT JOIN matricula m ON a.id = m.aluno_id
LEFT JOIN pagamento pg ON m.id = pg.matricula_id
WHERE pg.id IS NULL;

SELECT ROUND(AVG(preco),2)
FROM plano;

SELECT 
	fp.tipo,
	SUM(pg.valor) AS total_arrecadado
FROM forma_pagamento fp
JOIN pagamento pg ON fp.id = pg.forma_pagamento_id
GROUP BY fp.id;

SELECT 
	p.titulo,
	COUNT(m.id) AS quantidade_alunos
FROM plano p
JOIN matricula m ON p.id = m.plano_id
GROUP BY p.id;

SELECT 
	DATE_FORMAT(data_pagamento,'%Y-%m') AS mes_ano,
	SUM(valor) AS arrecadacao
FROM pagamento
GROUP BY mes_ano
ORDER BY arrecadacao DESC
LIMIT 1;

SELECT 
	AVG(TIMESTAMPDIFF(YEAR,data_nascimento,CURDATE())) AS idade_media
FROM aluno;

SELECT 
	p.titulo,
	SUM(pg.valor) AS arrecadacao
FROM plano p
JOIN matricula m ON p.id = m.plano_id
JOIN pagamento pg ON m.id = pg.matricula_id
GROUP BY p.id
HAVING arrecadacao > 5000;

SELECT 
	a.nome,
	COUNT(m.id) AS quantidade
FROM aluno a
JOIN matricula m ON a.id = m.aluno_id
GROUP BY a.id
HAVING COUNT(m.id) > 1;

SELECT 
	fp.tipo,
	COUNT(pg.id) AS quantidade
FROM forma_pagamento fp
JOIN pagamento pg ON fp.id = pg.forma_pagamento_id
GROUP BY fp.id
HAVING COUNT(pg.id) < 3;

UPDATE plano
SET preco = preco * 1.10
WHERE titulo = 'Mensal';

UPDATE pagamento
SET forma_pagamento_id = (
	SELECT id
	FROM forma_pagamento
	WHERE tipo = 'Pix'
)
WHERE MONTH(data_pagamento) = MONTH(CURDATE() - INTERVAL 1 MONTH);

DELETE FROM pagamento
WHERE forma_pagamento_id = (
	SELECT id
	FROM forma_pagamento
	WHERE tipo = 'Dinheiro'
);

DELETE FROM aluno
WHERE id = (
	SELECT id_aluno
	FROM (
		SELECT 
			a.id AS id_aluno,
			SUM(pg.valor) AS total_pago
		FROM aluno a
		JOIN matricula m ON a.id = m.aluno_id
		JOIN pagamento pg ON m.id = pg.matricula_id
		GROUP BY a.id
		ORDER BY total_pago
		LIMIT 1
	) AS menor
);

SELECT 
	a.nome
FROM aluno a
JOIN matricula m ON a.id = m.aluno_id
JOIN pagamento pg ON m.id = pg.matricula_id
GROUP BY a.id
HAVING SUM(pg.valor) > (
	SELECT AVG(total_pago)
	FROM (
		SELECT SUM(pg.valor) AS total_pago
		FROM matricula m
		JOIN pagamento pg ON m.id = pg.matricula_id
		GROUP BY m.aluno_id
	) AS media
);

SELECT 
	a.nome,
	p.preco - media.media_planos AS diferenca
FROM aluno a
JOIN matricula m ON a.id = m.aluno_id
JOIN plano p ON m.plano_id = p.id,
(
	SELECT AVG(preco) AS media_planos
	FROM plano
) AS media;

CREATE VIEW V_RELATORIO_FINANCEIRO AS
SELECT 
	a.nome AS aluno,
	p.titulo AS plano,
	p.preco,
	IFNULL(SUM(pg.valor),0) AS total_pago
FROM aluno a
JOIN matricula m ON a.id = m.aluno_id
JOIN plano p ON m.plano_id = p.id
LEFT JOIN pagamento pg ON m.id = pg.matricula_id
GROUP BY a.id,p.id;
