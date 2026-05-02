CREATE DATABASE 1ccoa20260430;
USE 1ccoa20260430;

CREATE TABLE aluno(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(80),
	cpf CHAR(11),
	dt_nasc DATE
);

CREATE TABLE curso(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45)
);

CREATE TABLE aluno_curso(
	fk_aluno INT,
	fk_curso INT,
	dt_inicio DATE,
	PRIMARY KEY(fk_aluno, fk_curso),
	FOREIGN KEY(fk_aluno) REFERENCES aluno(id),
	FOREIGN KEY(fk_curso) REFERENCES curso(id)
);

INSERT INTO aluno (nome, cpf, dt_nasc) VALUES 
('Clara','11111111111', '1999-06-19'),
('Joao','22222222222', '2004-05-10');

INSERT INTO curso(nome)
VALUES
('java script'),
('css'),
('python');

INSERT INTO aluno_curso(fk_aluno, fk_curso, dt_inicio)
VALUES
(1,1,CURDATE()),
(1,3,CURDATE()),
(2,1,CURDATE()),
(2,2,CURDATE()),
(2,3,CURDATE());

SELECT * FROM aluno
JOIN aluno_curso ON aluno_curso.fk_aluno = aluno.id
JOIN curso ON aluno_curso.fk_curso = curso.id;

USE 1ccoa20260430;
SELECT 
	a.nome,
	c.nome,
	ac.dt_inicio,
	DATEDIFF(CURDATE(), a.dt_nasc) AS idade
FROM aluno a 
JOIN aluno_curso ac ON ac.fk_aluno = a.id
JOIN curso c ON ac.fk_curso;

-- guardar o select numa tabela virtual com o "view"

