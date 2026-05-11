CREATE DATABASE pratica_complementar;
USE pratica_complementar;

CREATE TABLE curso (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nomeCurso VARCHAR(45),
	coordenador VARCHAR(45)
);

CREATE TABLE aluno (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	email VARCHAR(45),
	fkCurso INT,
	FOREIGN KEY (fkCurso) REFERENCES curso(id)
);

CREATE TABLE projeto (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nomeProjeto VARCHAR(45),
	descricao VARCHAR(100)
);

CREATE TABLE alunoProjeto (
	fkAluno INT,
	fkProjeto INT,
	dataEntrada DATE,
	PRIMARY KEY (fkAluno, fkProjeto),
	FOREIGN KEY (fkAluno) REFERENCES aluno(id),
	FOREIGN KEY (fkProjeto) REFERENCES projeto(id)
);

CREATE TABLE professor (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nomeProfessor VARCHAR(45),
	especialidade VARCHAR(45)
);

CREATE TABLE disciplina (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nomeDisciplina VARCHAR(45),
	cargaHoraria INT,
	fkProfessor INT,
	FOREIGN KEY (fkProfessor) REFERENCES professor(id)
);

CREATE TABLE alunoDisciplina (
	fkAluno INT,
	fkDisciplina INT,
	semestre VARCHAR(20),
	PRIMARY KEY (fkAluno, fkDisciplina),
	FOREIGN KEY (fkAluno) REFERENCES aluno(id),
	FOREIGN KEY (fkDisciplina) REFERENCES disciplina(id)
);

INSERT INTO curso (nomeCurso, coordenador) VALUES
('ADS', 'Carlos Silva'),
('Administração', 'Ana Souza'),
('Mecatrônica', 'Marcos Lima'),
('Informática', 'Fernanda Alves'),
('Design Gráfico', 'Juliana Rocha');

INSERT INTO aluno (nome, email, fkCurso) VALUES
('João Pedro', 'joao@gmail.com', 1),
('Maria Clara', 'maria@gmail.com', 2),
('Lucas Henrique', 'lucas@gmail.com', 1),
('Beatriz Santos', 'beatriz@gmail.com', 4),
('Gabriel Oliveira', 'gabriel@gmail.com', 1),
('Amanda Costa', 'amanda@gmail.com', 3),
('Felipe Santos', 'felipe@gmail.com', 1);

INSERT INTO projeto (nomeProjeto, descricao) VALUES
('Flow', 'Sistema de gerenciamento'),
('Robô Automatizado', 'Projeto de automação'),
('Site Institucional', 'Criação de website'),
('Aplicativo Mobile', 'Aplicativo para celulares'),
('Identidade Visual', 'Projeto de design'),
('Sistema Escolar', 'Sistema acadêmico');

INSERT INTO alunoProjeto (fkAluno, fkProjeto, dataEntrada) VALUES
(1,1,'2026-01-10'),
(1,2,'2026-02-01'),
(2,3,'2026-02-15'),
(3,1,'2026-03-20'),
(5,4,'2026-04-05'),
(5,1,'2026-05-01'),
(7,1,'2026-06-10'),
(7,6,'2026-07-15');

INSERT INTO professor (nomeProfessor, especialidade) VALUES
('Ricardo Alves', 'Banco de Dados'),
('Patricia Lima', 'Programação'),
('Eduardo Costa', 'Eletrônica'),
('Camila Rocha', 'Redes'),
('Roberta Mendes', 'Design');

INSERT INTO disciplina (nomeDisciplina, cargaHoraria, fkProfessor) VALUES
('Banco de Dados',80,1),
('Programação Web',60,2),
('Eletrônica Básica',70,3),
('Redes de Computadores',50,4),
('Design Digital',40,5);

INSERT INTO alunoDisciplina (fkAluno, fkDisciplina, semestre) VALUES
(1,1,'2026-1'),
(1,2,'2026-1'),
(1,4,'2026-2'),
(2,2,'2026-1'),
(3,1,'2026-1'),
(3,3,'2026-2'),
(4,4,'2026-2'),
(5,1,'2026-2'),
(5,2,'2026-2'),
(5,3,'2026-2'),
(7,1,'2026-1'),
(7,2,'2026-1');

SELECT 
	a.nome,
	c.nomeCurso
FROM aluno a
JOIN curso c ON a.fkCurso = c.id;

SELECT 
	a.nome,
	p.nomeProjeto,
	ap.dataEntrada
FROM alunoProjeto ap
JOIN aluno a ON ap.fkAluno = a.id
JOIN projeto p ON ap.fkProjeto = p.id;

SELECT 
	a.nome,
	d.nomeDisciplina,
	ad.semestre
FROM alunoDisciplina ad
JOIN aluno a ON ad.fkAluno = a.id
JOIN disciplina d ON ad.fkDisciplina = d.id;

SELECT 
	a.nome,
	c.nomeCurso
FROM aluno a
JOIN curso c ON a.fkCurso = c.id
WHERE c.nomeCurso = 'ADS';

SELECT DISTINCT
	p.nomeProjeto
FROM alunoProjeto ap
JOIN projeto p ON ap.fkProjeto = p.id;

SELECT 
	a.nome
FROM alunoProjeto ap
JOIN aluno a ON ap.fkAluno = a.id
JOIN projeto p ON ap.fkProjeto = p.id
WHERE p.nomeProjeto = 'Flow';

SELECT 
	p.nomeProfessor,
	d.nomeDisciplina
FROM professor p
JOIN disciplina d ON d.fkProfessor = p.id;

SELECT 
	a.nome
FROM aluno a
LEFT JOIN alunoProjeto ap ON a.id = ap.fkAluno
WHERE ap.fkAluno IS NULL;

SELECT 
	p.nomeProjeto
FROM projeto p
LEFT JOIN alunoProjeto ap ON p.id = ap.fkProjeto
WHERE ap.fkProjeto IS NULL;

CREATE VIEW vwAlunoCurso AS
SELECT 
	a.nome,
	c.nomeCurso
FROM aluno a
JOIN curso c ON a.fkCurso = c.id;

SELECT * FROM vwAlunoCurso;

CREATE VIEW vwAlunoProjeto AS
SELECT 
	a.nome,
	p.nomeProjeto,
	ap.dataEntrada
FROM alunoProjeto ap
JOIN aluno a ON ap.fkAluno = a.id
JOIN projeto p ON ap.fkProjeto = p.id;

SELECT *
FROM vwAlunoProjeto
WHERE dataEntrada > '2026-01-01';

SELECT 
	a.nome,
	COUNT(ad.fkDisciplina) AS quantidade
FROM aluno a
JOIN alunoDisciplina ad ON a.id = ad.fkAluno
GROUP BY a.id
HAVING COUNT(ad.fkDisciplina) > 1;

SELECT 
	d.nomeDisciplina,
	COUNT(ad.fkAluno) AS quantidade
FROM disciplina d
JOIN alunoDisciplina ad ON d.id = ad.fkDisciplina
GROUP BY d.id
HAVING COUNT(ad.fkAluno) > 3;

SELECT 
	p.nomeProfessor,
	d.nomeDisciplina,
	d.cargaHoraria
FROM professor p
JOIN disciplina d ON p.id = d.fkProfessor
WHERE d.cargaHoraria = (
	SELECT MAX(cargaHoraria)
	FROM disciplina
);

SELECT 
	a.nome,
	COUNT(ap.fkProjeto) AS quantidadeProjetos
FROM aluno a
JOIN alunoProjeto ap ON a.id = ap.fkAluno
GROUP BY a.id
HAVING COUNT(ap.fkProjeto) > (
	SELECT AVG(qtd)
	FROM (
		SELECT COUNT(fkProjeto) AS qtd
		FROM alunoProjeto
		GROUP BY fkAluno
	) AS mediaProjetos
);

SELECT 
	p.nomeProjeto,
	COUNT(ap.fkAluno) AS quantidadeAlunos
FROM projeto p
JOIN alunoProjeto ap ON p.id = ap.fkProjeto
GROUP BY p.id
ORDER BY quantidadeAlunos DESC
LIMIT 1;

SELECT DISTINCT
	c.nomeCurso
FROM curso c
JOIN aluno a ON c.id = a.fkCurso;

SELECT DISTINCT
	a.nome
FROM aluno a
JOIN alunoProjeto ap ON a.id = ap.fkAluno
JOIN alunoDisciplina ad ON a.id = ad.fkAluno;

SELECT 
	a.nome
FROM aluno a
LEFT JOIN alunoDisciplina ad ON a.id = ad.fkAluno
WHERE ad.fkAluno IS NULL;

SELECT 
	d.nomeDisciplina
FROM disciplina d
LEFT JOIN alunoDisciplina ad ON d.id = ad.fkDisciplina
WHERE ad.fkDisciplina IS NULL;

SELECT 
	a.nome,
	COUNT(ad.fkDisciplina) AS quantidadeDisciplinas
FROM aluno a
JOIN alunoDisciplina ad ON a.id = ad.fkAluno
GROUP BY a.id
HAVING COUNT(ad.fkDisciplina) = (
	SELECT MAX(qtd)
	FROM (
		SELECT COUNT(fkDisciplina) AS qtd
		FROM alunoDisciplina
		GROUP BY fkAluno
	) AS maior
);

SELECT 
	c.nomeCurso,
	COUNT(a.id) AS quantidadeAlunos
FROM curso c
JOIN aluno a ON c.id = a.fkCurso
GROUP BY c.id
HAVING COUNT(a.id) > (
	SELECT AVG(qtd)
	FROM (
		SELECT COUNT(id) AS qtd
		FROM aluno
		GROUP BY fkCurso
	) AS mediaCursos
);

CREATE VIEW vwResumoAluno AS
SELECT 
	a.nome,
	c.nomeCurso,
	COUNT(DISTINCT ap.fkProjeto) AS quantidadeProjetos,
	COUNT(DISTINCT ad.fkDisciplina) AS quantidadeDisciplinas
FROM aluno a
JOIN curso c ON a.fkCurso = c.id
LEFT JOIN alunoProjeto ap ON a.id = ap.fkAluno
LEFT JOIN alunoDisciplina ad ON a.id = ad.fkAluno
GROUP BY a.id;

SELECT * FROM vwResumoAluno;
