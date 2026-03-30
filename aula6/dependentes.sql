CREATE DATABASE tabelas_dependentes;
USE tabelas_dependentes;

-- regra de negocio a tabela funcionario se relaciona com ela mesma 
-- e tem uma tabela 'denpendente' que não existe sem o funcionario

CREATE TABLE funcionario(
	id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cpf CHAR(11) UNIQUE NOT NULL,
	salario DECIMAL(7,2),
	fk_supervisor INT, -- quando to fazendo um auto relacionamento é diferente o references
	CONSTRAINT ctFkSupervisor FOREIGN KEY (fk_supervisor) REFERENCES funcionario (id_funcionario)
);

-- tabela dependente do funcionario
CREATE TABLE dependente(
	id_dependente INT,
	nome VARCHAR(45),
	cpf CHAR(11) UNIQUE NOT NULL,
	fk_funcionario INT,
	CONSTRAINT chave_composta PRIMARY KEY(id_dependente,fk_funcionario),
	CONSTRAINT ctFkFuncionario FOREIGN KEY (fk_funcionario) REFERENCES funcionario(id_funcionario)
);

INSERT INTO funcionario(nome, cpf, salario, fk_supervisor)
VALUES
('clara', '11111111111', 15000, null),
('vivian', '22222222222', 16000, null),
('marcos', '33333333333', 6000, 1),
('canuto', '44444444444', 6000, 2);

SELECT
	f.nome AS 'Nome supervisor',
	s.nome AS 'Nome funcionario'
FROM funcionario AS s JOIN funcionario  AS f ON f.id_funcionario = s.fk_supervisor;

SELECT * FROM 
	funcionario AS f
JOIN funcionario AS s ON f.id_funcionario = s.fk_supervisor;

-- TRUNCATE o truncate so funciona se voce primeiro deletar a fk 

