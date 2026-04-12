CREATE DATABASE AlunoProjeto;
USE AlunoProjeto;

CREATE TABLE aluno(
	ra INT PRIMARY KEY AUTO_INCREMENT,
	fk_projeto INT,
	ra_representante INT,
	nome VARCHAR(45) NOT NULL,
	telefone VARCHAR(45),
	CONSTRAINT fkRepresentante FOREIGN KEY(ra_representante) REFERENCES aluno(ra),
	CONSTRAINT fkProjeto FOREIGN KEY(fk_projeto) REFERENCES projeto(id_projeto)
);

CREATE TABLE projeto(
	id_projeto INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	descricao VARCHAR(300)
);

INSERT INTO projeto (nome, descricao) VALUES
('Projeto A', 'Sistema de vendas'),
('Projeto B', 'Aplicativo mobile'),
('Projeto C', 'Site institucional');

INSERT INTO aluno (fk_projeto, ra_representante, nome, telefone) VALUES
(1, NULL, 'Jacob', '11911111111'),
(1, NULL, 'Pedrao', '11922222222'),
(2, NULL, 'Marina', '11933333333'),
(2, NULL, 'Caio', '11944444444'),
(3, NULL, 'Vitor', '11955555555'),
(3, NULL, 'Raphael', '11966666666');

INSERT INTO aluno (fk_projeto, ra_representante, nome, telefone) VALUES
(1, 1, 'Karina', '11911111111'),
(1, 2, 'Isaac', '11922222222'),
(2, 3, 'Emanuelly', '11933333333');

SELECT * FROM aluno;
SELECT * FROM projeto;

SELECT 
	*
FROM aluno JOIN projeto ON aluno.fk_projeto = projeto.id_projeto; 

SELECT 
	a.nome as nome_aluno,
	a.telefone as telefone_aluno,
	r.nome as nome_representante,
	r.telefone as telefone_representante
FROM aluno a JOIN aluno r ON a.ra_representante = r.ra;

SELECT 
	p.nome,
	p.descricao,
	a.nome
FROM projeto p JOIN aluno a ON p.id_projeto = a.fk_projeto WHERE p.nome = 'Projeto A';

