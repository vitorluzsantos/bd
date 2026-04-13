CREATE DATABASE hogwarts;
USE hogwarts;

CREATE TABLE casa (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	fundador VARCHAR(50),
	professor VARCHAR(50)
);

CREATE TABLE aluno (
	ra CHAR(5) PRIMARY KEY,
	nome VARCHAR(50),
	quadribol VARCHAR(3),
	dtInicio DATE,
	dtFim DATE,
	pet VARCHAR(50),
	patrono VARCHAR(50),
	fkCasa INT,
	fkMonitor CHAR(5),
	FOREIGN KEY (fkCasa) REFERENCES casa(id),
	FOREIGN KEY (fkMonitor) REFERENCES aluno(ra)
);

INSERT INTO casa (nome, fundador, professor) VALUES
('Grifinoria','Godric Gryffindor','Snape'),
('Sonserina','Salazar Slytherin','Slughorn'),
('Corvinal','Rowena Ravenclaw','Flitwick'),
('Lufa-Lufa','Helga Hufflepuff','Sprout');

INSERT INTO aluno (ra, nome, quadribol) VALUES
('A1','Harry','sim'),
('A2','Ron','nao'),
('A3','Hermione','nao');

SELECT * FROM aluno WHERE quadribol='sim';

SELECT a.nome AS nomeAluno, a.dtInicio, a.patrono
FROM aluno a
JOIN casa c ON a.fkCasa = c.id
WHERE c.nome = 'Lufa-Lufa';

SELECT a.nome, a.pet, c.nome
FROM aluno a
LEFT JOIN casa c ON a.fkCasa = c.id;

SELECT a.nome, c.nome,
CASE
WHEN a.fkCasa IS NULL THEN 'aluno não alocado'
END
FROM aluno a
LEFT JOIN casa c ON a.fkCasa = c.id;

DROP DATABASE hogwarts;
