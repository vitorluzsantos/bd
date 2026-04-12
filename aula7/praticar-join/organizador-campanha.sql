CREATE DATABASE Campanha;
USE Campanha;

CREATE TABLE organizador(
	id_organizador INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	endereco VARCHAR(45),
	id_veterano INT,
	CONSTRAINT fkVeterano FOREIGN KEY(id_veterano) REFERENCES organizador(id_organizador)
)AUTO_INCREMENT = 30;

CREATE TABLE campanha(
	id_campanha INT PRIMARY KEY AUTO_INCREMENT,
	fk_organizador INT,
	categoria VARCHAR(45),
	instituicao VARCHAR(45),
	dataFinal DATE,
	CONSTRAINT fkOrganizador FOREIGN KEY(fk_organizador) REFERENCES organizador(id_organizador)
)AUTO_INCREMENT = 500;

INSERT INTO organizador (nome, endereco, id_veterano) VALUES
('Jacob', 'Rua A', NULL); -- id 30 (veterano)

INSERT INTO organizador (nome, endereco, id_veterano) VALUES
('Vitor', 'Rua B', 30),
('Marina', 'Rua C', 30),
('Caio', 'Rua D', 30);

INSERT INTO campanha (fk_organizador, categoria, instituicao, dataFinal) VALUES
(30, 'Alimentos', 'ONG Esperança', '2026-05-10'),
(30, 'Roupas', 'Instituto Solidário', '2026-06-15'),

(31, 'Brinquedos', 'Casa Feliz', '2026-07-20'),
(31, 'Higiene', 'Ajuda Já', '2026-08-05'),

(32, 'Alimentos', 'Banco de Alimentos', '2026-09-01');

SELECT * FROM campanha;
SELECT * FROM organizador;

SELECT 
	*
FROM campanha JOIN organizador ON campanha.fk_organizador = organizador.id_organizador;

SELECT 
	*
FROM campanha JOIN organizador ON campanha.fk_organizador = organizador.id_organizador
WHERE organizador.id_veterano IS NULL;

SELECT 
	*
FROM organizador JOIN campanha ON organizador.id_organizador = campanha.fk_organizador
WHERE organizador.nome = 'Jacob';

SELECT 
	* 
FROM organizador n JOIN organizador v ON v.id_organizador = n.id_veterano;

SELECT 
	* 
FROM organizador n JOIN organizador v ON v.id_organizador = n.id_veterano
WHERE v.nome = 'Jacob';

SELECT 
	*
FROM campanha JOIN organizador ON campanha.fk_organizador = organizador.id_organizador;

SELECT 
	n.nome AS nome_novato,
	c.categoria AS nome_campanha,
	v.nome AS nome_veterano
FROM organizador n 
JOIN organizador v 
	ON n.id_veterano = v.id_organizador
JOIN campanha c 
	ON c.fk_organizador = n.id_organizador;

