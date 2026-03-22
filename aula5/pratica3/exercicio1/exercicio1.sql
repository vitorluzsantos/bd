CREATE DATABASE sprint2;
USE sprint2;

CREATE TABLE Atleta(
	idAtleta INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(40),
	modalidade VARCHAR(40),
	qtdMedalha INT,
	fkPais INT,
	CONSTRAINT ctFkPais FOREIGN KEY(fkPais) REFERENCES Pais(idPais)
);

CREATE TABLE Pais(
	idPais INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(30),
	capital VARCHAR(40)
);

INSERT INTO Pais(nome, capital)
VALUES
('brasil','brasilia'),
('argentina','buenos aires'),
('portugal','lisboa'),
('estados unidos','washington')

INSERT INTO Atleta(nome, modalidade, qtdMedalha, fkPais)
VALUES
('vitor','futebol',11,1),
('messi','argentina',47,2),
('neymar','bale',10,1),
('marina','bale',0,1),
('jacob','computacao',999,4);

SELECT 
	a.idAtleta,
	a.nome,
	a.modalidade,
	a.qtdMedalha,
	p.nome as nome_pais
FROM Atleta a JOIN Pais p ON fkPais = idPais;

SELECT 
	Atleta.nome as 'nome do atleta',
	Pais.nome as 'nome do pais'
FROM Atleta JOIN Pais ON fkPais = idPais;

SELECT 
	*
FROM Atleta JOIN Pais ON fkPais = idPais;
