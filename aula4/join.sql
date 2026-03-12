-- aprendendo o JOIN

-- SELECT * FROM aluno JOIN turma ON aluno.fkTurma = turma.id;

SELECT * FROM 
aluno	
JOIN turma ON aluno.fkTurma = turma.id;

SELECT 
	aluno.id AS idAluno
	turma.id AS idTurma
	aluno.nome AS nomeAluno
	turma.descricao AS turma
FROM 
	aluno
JOIN turma ON aluno.fkTurma = turma.id;

INSERT INTO disciplina(nome, fkTurma)
VALUES
('Banco de Dados', 1),
('Algoritmos', 2);

SELECT * FROM turma
JOIN aluno ON turma.id = aluno.fkTurma; -- inner JOIN e o JOIN padrão são a mesma coisa
