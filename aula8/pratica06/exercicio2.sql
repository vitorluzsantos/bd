CREATE DATABASE Campanha;
USE Campanha;

CREATE TABLE organizador (
	id_organizador INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	rua VARCHAR(50),
	bairro VARCHAR(50),
	email VARCHAR(50),
	id_orientador INT,
	FOREIGN KEY (id_orientador) REFERENCES organizador(id_organizador)
) AUTO_INCREMENT = 30;

CREATE TABLE campanha (
	id_campanha INT AUTO_INCREMENT PRIMARY KEY,
	categoria VARCHAR(50),
	instituicao1 VARCHAR(50),
	instituicao2 VARCHAR(50),
	data_final DATE,
	fk_organizador INT,
	FOREIGN KEY (fk_organizador) REFERENCES organizador(id_organizador)
) AUTO_INCREMENT = 500;

INSERT INTO organizador (nome, rua, bairro, email, id_orientador) VALUES
('Joao', 'Rua A', 'Centro', 'joao@email.com', NULL),
('Maria', 'Rua B', 'Zona Sul', 'maria@email.com', 30),
('Carlos', 'Rua C', 'Zona Leste', 'carlos@email.com', 30),
('Ana', 'Rua D', 'Centro', 'ana@email.com', 31);

INSERT INTO campanha (categoria, instituicao1, instituicao2, data_final, fk_organizador) VALUES
('Alimentos', 'ONG A', 'ONG B', '2026-05-01', 30),
('Higiene', 'ONG C', NULL, '2026-06-01', 30),
('Máscaras', 'Hospital X', 'Hospital Y', '2026-07-01', 31);

SELECT * FROM organizador;
SELECT * FROM campanha;

SELECT o.nome, c.categoria
FROM organizador o
JOIN campanha c ON o.id_organizador = c.fk_organizador;

SELECT o.nome, c.categoria
FROM organizador o
JOIN campanha c ON o.id_organizador = c.fk_organizador
WHERE o.nome = 'Joao';

SELECT n.nome AS novato, v.nome AS orientador
FROM organizador n
JOIN organizador v ON n.id_orientador = v.id_organizador;

SELECT n.nome AS novato, v.nome AS orientador
FROM organizador n
JOIN organizador v ON n.id_orientador = v.id_organizador
WHERE v.nome = 'Joao';

SELECT n.nome, c.categoria, v.nome
FROM organizador n
JOIN campanha c ON n.id_organizador = c.fk_organizador
JOIN organizador v ON n.id_orientador = v.id_organizador;

SELECT n.nome, c.categoria, v.nome
FROM organizador n
JOIN campanha c ON n.id_organizador = c.fk_organizador
JOIN organizador v ON n.id_orientador = v.id_organizador
WHERE n.nome = 'Maria';
