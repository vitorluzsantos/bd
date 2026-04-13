CREATE DATABASE escola_gastronomia;
USE escola_gastronomia;

-- CREATE TABLES

CREATE TABLE chef(
	id_chef INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	especialidade VARCHAR(45),
	salario DECIMAL(7,2),
	id_supervisor INT,
	CONSTRAINT ctFkSupervisor FOREIGN KEY(id_supervisor) REFERENCES chef(id_chef)
);

CREATE TABLE turma(
	id_turma INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	turno VARCHAR(45),
	sala VARCHAR(45),
	fk_responsavel INT,
	CONSTRAINT ctFkResponsavel FOREIGN KEY(fk_responsavel) REFERENCES chef(id_chef)
);

CREATE TABLE recepcionista(
	id_recepcionista INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	email VARCHAR(45),
	turno_de_trabalho VARCHAR(45)
);

CREATE TABLE aluno(
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	telefone VARCHAR(45),
	situacao_academica VARCHAR(45),
	fk_turma INT,
	CONSTRAINT ctFkTurma FOREIGN KEY(fk_turma) REFERENCES turma(id_turma)
);

CREATE TABLE matricula(
	id_matricula INT PRIMARY KEY,
	data_matricula DATE,
	situacao VARCHAR(45),
	fk_recepcionista INT,
	CONSTRAINT chFkRecepcionista FOREIGN KEY(fk_recepcionista) REFERENCES recepcionista(id_recepcionista)
);

CREATE TABLE aula_pratica(
	id_aula_pratica INT,
	tema VARCHAR(45),
	data DATE,
	observacao VARCHAR(45),
	id_turma INT,
	CONSTRAINT chave_composta PRIMARY KEY(id_aula_pratica, id_turma),
	CONSTRAINT fkTurmaAula FOREIGN KEY(id_turma) REFERENCES turma(id_turma)
);

-- INSERTS

INSERT INTO chef (nome, especialidade, salario, id_supervisor) VALUES
('Carlos Silva', 'Confeitaria', 4500.00, NULL),
('Mariana Souza', 'Cozinha Italiana', 5200.00, 1),
('João Pereira', 'Panificação', 4000.00, 1),
('Ana Costa', 'Cozinha Japonesa', 6000.00, NULL),
('Pedro Lima', 'Churrasco', 3800.00, 4);

INSERT INTO turma (nome, turno, sala, fk_responsavel) VALUES
('Turma A', 'Manhã', '101', 1),
('Turma B', 'Tarde', '102', 2),
('Turma C', 'Noite', '103', 4),
('Turma D', 'Manhã', '104', 3);

INSERT INTO recepcionista (nome, email, turno_de_trabalho) VALUES
('Clara Dias', 'clara@escola.com', 'Manhã'),
('Roberto Alves', 'roberto@escola.com', 'Tarde'),
('Sofia Lima', 'sofia@escola.com', 'Noite');

INSERT INTO aluno (nome, telefone, situacao_academica, fk_turma) VALUES
('Lucas Alves', '11999999999', 'Ativo', 1),
('Fernanda Rocha', NULL, 'Ativo', 1),
('Bruno Martins', '11888888888', 'Trancado', 2),
('Juliana Mendes', NULL, 'Ativo', 2),
('Rafael Gomes', '11777777777', 'Formado', 3),
('Patricia Nunes', NULL, 'Ativo', 3),
('Diego Castro', '11666666666', 'Ativo', 4),
('Camila Freitas', NULL, 'Ativo', 4);

INSERT INTO matricula (id_matricula, data_matricula, situacao, fk_recepcionista) VALUES
(1, '2024-01-10', 'Ativa', 1),
(2, '2024-01-15', 'Cancelada', 2),
(3, '2024-02-01', 'Ativa', 3),
(4, '2024-02-10', 'Trancada', 1),
(5, '2024-03-05', 'Ativa', 2),
(6, '2024-03-15', 'Cancelada', 3),
(7, '2024-04-01', 'Ativa', 1),
(8, '2024-04-10', 'Trancada', 2);

INSERT INTO aula_pratica (id_aula_pratica, tema, data, observacao, id_turma) VALUES
(1, 'Massas', '2024-05-01', 'Aula básica', 1),
(2, 'Doces', '2024-05-02', 'Sem açúcar', 1),
(3, 'Sushi', '2024-05-03', 'Peixes frescos', 3),
(4, 'Churrasco', '2024-05-04', 'Carnes nobres', 3),
(5, 'Pães', '2024-05-05', 'Fermentação natural', 4),
(6, 'Molhos', '2024-05-06', 'Clássicos italianos', 2);

ALTER TABLE chef RENAME COLUMN nome TO nomeChef;
ALTER TABLE aluno ADD CONSTRAINT ctChSituacao CHECK (situacao_academica IN ('matriculado','reprovado','aprovado'));

DELETE FROM matricula WHERE id_matricula = 4;
DELETE FROM aula_pratica WHERE id_aula_pratica = 6;
DELETE FROM aluno WHERE id_aluno = 8;

SELECT 
	UPPER(nome) as nome_formatado,
	telefone,
	turma
FROM aluno;

SELECT 
	r.nomeChef,
	t.sala
FROM turma t JOIN chef r ON r.id_chef = t.fk_responsavel;

SELECT 
	r.nomeChef,
	a.tema,
	t.sala
FROM turma t 
	LEFT JOIN chef r ON r.id_chef = t.fk_responsavel 
	LEFT JOIN aula_pratica a ON a.id_aula_pratica = t.id_turma;

ALTER TABLE matricula 
ADD COLUMN fk_aluno INT,
ADD COLUMN fk_turma INT;

ALTER TABLE matricula
ADD CONSTRAINT fkMatriculaAluno
FOREIGN KEY (fk_aluno) REFERENCES aluno(id_aluno);

ALTER TABLE matricula
ADD CONSTRAINT fkMatriculaTurma
FOREIGN KEY (fk_turma) REFERENCES turma(id_turma);

ALTER TABLE matricula
ADD CONSTRAINT uq_matricula UNIQUE (fk_aluno, fk_turma);

SELECT 
    a.nome AS aluno,
    t.nome AS turma,
    c.nome AS chef_responsavel,
    r.nome AS recepcionista,
    m.situacao
FROM matricula m
INNER JOIN aluno a 
    ON a.id_aluno = m.fk_aluno
INNER JOIN turma t 
    ON t.id_turma = m.fk_turma
LEFT JOIN chef c 
    ON c.id_chef = t.fk_responsavel
LEFT JOIN recepcionista r 
    ON r.id_recepcionista = m.fk_recepcionista;

SELECT 
    UPPER(a.nome) AS aluno_formatado,
    a.telefone,
    t.nome AS turma,
    m.situacao,
    CASE 
        WHEN m.situacao = 'ativa' THEN 'Aluno regularmente matriculado'
        WHEN m.situacao = 'cancelada' THEN 'Matrícula cancelada'
        WHEN m.situacao = 'concluida' THEN 'Curso concluído'
        ELSE 'Situação não identificada'
    END AS classificacao
FROM matricula m
INNER JOIN aluno a 
    ON a.id_aluno = m.fk_aluno
INNER JOIN turma t 
    ON t.id_turma = m.fk_turma
ORDER BY a.nome ASC;

