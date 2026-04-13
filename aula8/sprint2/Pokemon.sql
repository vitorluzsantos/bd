CREATE DATABASE pokemon;
USE pokemon;

CREATE TABLE treinador (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	dtNasc DATE,
	medalhas INT,
	cidade VARCHAR(50),
	fkMentor INT,
	FOREIGN KEY (fkMentor) REFERENCES treinador(id)
);

CREATE TABLE pokemon (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	altura DECIMAL(5,2),
	peso DECIMAL(5,2),
	lendario BOOLEAN NOT NULL,
	tipo VARCHAR(20),
	fkTreinador INT,
	FOREIGN KEY (fkTreinador) REFERENCES treinador(id)
) AUTO_INCREMENT = 100;

INSERT INTO treinador (nome, dtNasc, medalhas, cidade) VALUES
('Ash','2000-01-01',5,'Pallet'),
('Misty','1999-01-01',3,'Cerulean'),
('Brock','1998-01-01',4,'Pewter');

INSERT INTO pokemon (nome, altura, peso, lendario, tipo, fkTreinador) VALUES
('Pikachu',0.4,6,false,'Eletrico',1),
('Charmander',0.6,8,false,'Fogo',1),
('Squirtle',0.5,9,false,'Agua',2);

SELECT p.nome, t.nome FROM pokemon p
LEFT JOIN treinador t ON p.fkTreinador = t.id;

SELECT nome,
CASE WHEN peso IS NULL THEN 'Muito leve' ELSE peso END
FROM pokemon;

SELECT tipo,
CASE
WHEN tipo='Fogo' THEN 'Fraco contra água'
WHEN tipo='Agua' THEN 'Fraco contra elétrico'
END
FROM pokemon;

INSERT INTO pokemon (nome, altura, peso, lendario, tipo) VALUES
('Mew',0.4,NULL,true,'Psiquico'),
('Onix',8.8,210,false,'Pedra');

SELECT t.nome, m.nome, p.nome FROM treinador t
LEFT JOIN treinador m ON t.fkMentor = m.id
LEFT JOIN pokemon p ON p.fkTreinador = t.id;
