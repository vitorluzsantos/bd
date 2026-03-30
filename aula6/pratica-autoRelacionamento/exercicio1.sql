CREATE TABLE funcionario(
	idFuncionario INT,
	nome VARCHAR(45),
	qualificacao VARCHAR(45),
	dtNasc DATE,
	idSupervisor INT, -- fk
	fkArea INT,
	CONSTRAINT chave_composta PRIMARY KEY(idFuncionario, fkArea),
	CONSTRAINT ctFkArea FOREIGN KEY (fkArea) REFERENCES area(idArea),
	CONSTRAINT ctFkSupervisor FOREIGN KEY (idSupervisor) REFERENCES funcionario(idFuncionario)
);

CREATE TABLE area(
	idArea INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45)
);

INSERT INTO area(nome)
VALUES
('administracao'),
('logistica'),
('desenvolvimento');

INSERT INTO funcionario
VALUES
(1, 'guilherme','senior','2004-08-14', null, 3),
(2, 'vitor','junior','2007-11-07', 1, 3),
(3, 'laiza','senior','2010-05-26', null, 1),
(4, 'jacob','pleno','2008-02-17', null, 2),
(5, 'pedrao','junior','2007-09-09', 4, 2);

SELECT 
	f.idFuncionario as id, 
	f.nome, 
	f.qualificacao, 
	f.dtNasc as 'data de nascimento',
	s.nome as supervisor, 
	a.nome as area
FROM funcionario f 
	JOIN area a ON f.fkArea = a.idArea
	JOIN funcionario s ON s.idFuncionario = f.idSupervisor;

SELECT 
	f.idFuncionario as id, 
	f.nome, 
	f.qualificacao, 
	f.dtNasc as 'data de nascimento',
	a.nome as area
FROM funcionario f JOIN area a ON f.fkArea = a.idArea
WHERE f.idSupervisor IS null; 

SELECT 
	f.idFuncionario as id, 
	f.nome, 
	f.qualificacao, 
	f.dtNasc as 'data de nascimento',
	a.nome as area,
	CASE 
		WHEN f.qualificacao = 'junior' THEN 'muito chao pela frente'
		WHEN f.qualificacao = 'pleno' THEN 'ta quase la'
		WHEN f.qualificacao = 'senior' THEN 'parabens'
		END AS condecoracao
FROM funcionario f JOIN area a ON f.fkArea = a.idArea
