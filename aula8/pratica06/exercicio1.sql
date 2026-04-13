CREATE DATABASE AlunoProjeto;
USE AlunoProjeto;

CREATE TABLE projeto (
	id_projeto INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	descricao VARCHAR(100)
);

CREATE TABLE aluno (
	ra INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	telefone VARCHAR(20),
	fk_projeto INT,
	ra_representante INT,
	FOREIGN KEY (fk_projeto) REFERENCES projeto(id_projeto),
	FOREIGN KEY (ra_representante) REFERENCES aluno(ra)
);

CREATE TABLE acompanhante (
	id_acomp INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	tipo_relacao VARCHAR(30),
	fk_aluno INT,
	FOREIGN KEY (fk_aluno) REFERENCES aluno(ra)
);

INSERT INTO projeto (nome, descricao) VALUES
('Sistema Web', 'Sistema para vendas'),
('App Mobile', 'Aplicativo escolar');

INSERT INTO aluno (nome, telefone, fk_projeto, ra_representante) VALUES
('Vitor', '1111-1111', 1, NULL),
('Victor', '2222-2222', 1, 1),
('Isaac', '3333-3333', 2, 1),
('Karina', '4444-4444', 2, 3);

INSERT INTO acompanhante (nome, tipo_relacao, fk_aluno) VALUES
('Maria', 'Mãe', 1),
('João', 'Amigo', 2),
('Carlos', 'Irmão', 3);

SELECT * FROM projeto;
SELECT * FROM aluno;
SELECT * FROM acompanhante;

SELECT a.nome, p.nome
FROM aluno a
JOIN projeto p ON a.fk_projeto = p.id_projeto;

SELECT a.nome, ac.nome
FROM aluno a
JOIN acompanhante ac ON ac.fk_aluno = a.ra;

SELECT a.nome, r.nome AS representante
FROM aluno a
LEFT JOIN aluno r ON a.ra_representante = r.ra;

SELECT a.nome, p.nome
FROM aluno a
JOIN projeto p ON a.fk_projeto = p.id_projeto
WHERE p.nome = 'Sistema Web';

SELECT a.nome, p.nome, ac.nome
FROM aluno a
JOIN projeto p ON a.fk_projeto = p.id_projeto
LEFT JOIN acompanhante ac ON ac.fk_aluno = a.ra;
