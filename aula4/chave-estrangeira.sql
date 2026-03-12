-- foreign key

CREATE DATABASE ccoa;
USE ccoa;

CREATE TABLE turma(
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(20),
	periodo YEAR
);

CREATE TABLE aluno(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	ra char(8),
	dtNasc DATE,
	fkTurma INT,
	CONSTRAINT ctFkTurma FOREIGN KEY(fkTurma) REFERENCES turma(id) -- fk é uma CONSTRAINT
);

-- lembra de colocar na pasta aula4

INSERT INTO turma(descricao, periodo) 
VALUES
('1ccoa 20261', 2026),
('1ccob 20261', 2026),
('1ccok 20252', 2026);

INSERT INTO aluno(nome, ra, dtNasc, fkTurma)
VALUES
('Marcos Paulo', '04261999','2006-10-10', 1),
('Raphael Canudo', '04261998','2007-01-13', 2),
('George Smith', '04251999','1998-02-13', 3);

INSERT INTO aluno(nome, ra, dtNasc, fkTurma)
VALUES
('João Pedro', '04261997', '2004-03-22',1);

CREATE TABLE disciplina(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	fkTurma INT,
	CONSTRAINT ctFkTurma FOREIGN KEY(fkTurma) REFERENCES turma(id)
)
