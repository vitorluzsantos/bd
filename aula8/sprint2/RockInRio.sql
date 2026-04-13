CREATE DATABASE RockInRio;
USE RockInRio;

CREATE TABLE palco (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	artista VARCHAR(50),
	capacidade INT,
	preco DECIMAL(10,2)
);

CREATE TABLE participante (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	cpf CHAR(11),
	dtNasc DATE,
	telefone VARCHAR(20),
	fkPalco INT NOT NULL,
	fkResponsavel INT,
	FOREIGN KEY (fkPalco) REFERENCES palco(id),
	FOREIGN KEY (fkResponsavel) REFERENCES participante(id)
);

INSERT INTO palco (nome, artista, capacidade, preco) VALUES
('Sun','Artista A',1000,100),
('Moon','Artista B',2000,250),
('Star','Artista C',1500,180),
('Sky','Artista D',3000,300),
('Sea','Artista E',1200,90);

INSERT INTO participante (nome, cpf, dtNasc, telefone, fkPalco) VALUES
('Vitor','11111111111','2000-01-01','999',1),
('Victor','22222222222','2001-01-01','999',2),
('Isaac','33333333333','2002-01-01','999',3),
('Karina','44444444444','2003-01-01','999',4),
('Caio','55555555555','2004-01-01','999',5);

SELECT p.nome, pa.nome FROM participante p
JOIN palco pa ON p.fkPalco = pa.id;

UPDATE palco SET preco = 500 WHERE id = 1;

SELECT p.nome, pa.nome FROM participante p
JOIN palco pa ON p.fkPalco = pa.id
WHERE pa.preco > 200;

ALTER TABLE participante ADD email VARCHAR(255);

ALTER TABLE participante CHANGE telefone contato VARCHAR(20);

DESCRIBE participante;

SELECT p.nome, d.nome FROM participante p
LEFT JOIN participante d ON d.fkResponsavel = p.id;

SELECT * FROM participante WHERE id NOT IN (
	SELECT fkResponsavel FROM participante WHERE fkResponsavel IS NOT NULL
);

SELECT p.nome AS nomeParticipante, pa.nome AS nomePalco
FROM participante p JOIN palco pa ON p.fkPalco = pa.id;

SELECT pa.nome, pa.capacidade FROM palco pa WHERE preco <= 150;

SELECT p.nome, pa.nome FROM participante p
JOIN palco pa ON p.fkPalco = pa.id
WHERE pa.nome LIKE 'S%';

SELECT pa.nome, p.nome FROM palco pa
LEFT JOIN participante p ON p.fkPalco = pa.id;

SELECT p.nome, pa.nome FROM participante p
JOIN palco pa ON p.fkPalco = pa.id
ORDER BY p.nome ASC, pa.nome DESC;
