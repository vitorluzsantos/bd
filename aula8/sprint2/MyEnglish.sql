CREATE DATABASE escola;
USE escola;

CREATE TABLE aluno (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100),
	dtNasc DATE,
	matricula CHAR(8) UNIQUE
);

CREATE TABLE endereco (
	idEndereco INT AUTO_INCREMENT PRIMARY KEY,
	logradouro VARCHAR(100),
	numero VARCHAR(10),
	bairro VARCHAR(50),
	cidade VARCHAR(50),
	estado VARCHAR(50),
	cep CHAR(8),
	fkAluno INT,
	FOREIGN KEY (fkAluno) REFERENCES aluno(id)
) AUTO_INCREMENT = 100;

INSERT INTO aluno (nome, dtNasc, matricula) VALUES
('Vitor', '2005-01-01', '12345678'),
('Victor', '2004-02-02', '12345679'),
('Isaac', '2003-03-03', '12345670'),
('Karina', '2002-04-04', '12345671'),
('Caio', '2001-05-05', '12345672'),
('Emanuelly', '2000-06-06', '12345673'),
('Joao', '1999-07-07', '12345674'),
('Maria', '1998-08-08', '12345675'),
('Pedro', '1997-09-09', '12345676'),
('Ana', '1996-10-10', '12345677');

INSERT INTO endereco (logradouro, numero, bairro, cidade, estado, cep, fkAluno) VALUES
('Rua A','10','Centro','São Paulo','SP','01000000',1),
('Rua B','20','Bela Vista','São Paulo','SP','02000000',2),
('Rua C','30','Centro','Rio de Janeiro','RJ','03000000',3),
('Rua D','40','Mooca','São Paulo','SP','04000000',4),
('Rua E','50','Centro','Curitiba','PR','05000000',5),
('Rua F','60','Centro','São Paulo','SP','06000000',6),
('Rua G','70','Centro','Rio de Janeiro','RJ','07000000',7),
('Rua H','80','Centro','São Paulo','SP','08000000',8),
('Rua I','90','Centro','São Paulo','SP','09000000',9),
('Rua J','100','Centro','São Paulo','SP','10000000',10);

SELECT a.nome, e.* FROM aluno a
LEFT JOIN endereco e ON a.id = e.fkAluno;

UPDATE endereco SET logradouro='Rua Nova', numero='999' WHERE fkAluno = 1;

SELECT * FROM endereco WHERE cidade = 'São Paulo';

DELETE FROM endereco WHERE estado = 'Rio de Janeiro';

ALTER TABLE endereco ADD pais VARCHAR(50);

DELETE FROM endereco WHERE bairro LIKE '_a%';

ALTER TABLE endereco CHANGE cep codigoPostal CHAR(8);

DESCRIBE endereco;

SELECT a.nome, e.* FROM aluno a
LEFT JOIN endereco e ON a.id = e.fkAluno
ORDER BY a.nome;

SELECT * FROM aluno WHERE id NOT IN (SELECT fkAluno FROM endereco);

SELECT a.nome AS nomeAluno, e.logradouro AS logradouroEndereco
FROM aluno a JOIN endereco e ON a.id = e.fkAluno;

SELECT * FROM aluno ORDER BY nome LIMIT 5;

SELECT * FROM aluno WHERE nome NOT LIKE '%a%';

DELETE FROM endereco;
DELETE FROM aluno;
