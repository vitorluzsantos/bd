CREATE TABLE professor( 
	id INT,
	nome VARCHAR(45),
	cpf CHAR(11),
	salario DECIMAL(6,2),
	tipo VARCHAR(20),
	dtCadastro DATETIME,
	CONSTRAINT PKid PRIMARY KEY (id), /* criando uma restrição e referenciando o id */ 
	CONSTRAINT cTipo CHECK (tipo IN('Assistente','Titular','Monitor'))
);

/* constraint é uma restrição e a primary key é um tipo de constraint check é outro */
ALTER TABLE professor MODIFY COLUMN id INT AUTO_INCREMENT;

ALTER TABLE professor MODIFY COLUMN
id INT AUTO_INCREMENT;

INSERT INTO professor (nome, cpf, salario, tipo, dtCadastro)
VALUES
('Clara','11111111111',1.99,'Assistente',CURRENT_TIMESTAMP()),
('Pedro','22222222222',1000.10,'Monitor',NOW()),
('Raphael','33333333333',5000.10,'Titular',NOW()),
('Nicole','44444444444',6000.50,'Titular',CURRENT_TIMESTAMP());

ALTER TABLE professor DROP CONSTRAINT cTipo; /* apagando a constraint */
ALTER TABLE professor ADD CONSTRAINT cTipo CHECK(tipo IN('Assistente','Titular','Monitor')); /* adicionando uma restrição a uma tabela existente */

CREATE TABLE aluno(
	id INT PRIMARY KEY AUTO_INCREMENT,
	ra CHAR(8) UNIQUE,
	nome VARCHAR(45) DEFAULT 'sem nome', /* o default declara um valor inicial automatica */
	dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO aluno(ra)
VALUES
('04261000'),
('04261015'),
('04261090');

UPDATE aluno SET nome = 'Nicole' WHERE id = 1;
UPDATE aluno SET nome = 'Thiago' WHERE id = 2;
UPDATE aluno SET nome = 'Clara' WHERE id = 3;

SELECT 
	nome AS 'Primeiro nome',
	ra AS 'Registro academico'
FROM aluno;

SELECT 
	CASE 
		WHEN tipo = 'Monitor' THEN 3000.00
		WHEN tipo = 'Assistente' THEN 5000.00
		WHEN tipo = 'Titular' THEN 9000.00
		ELSE 0.00
	END AS salario_teste
FROM professor;

CREATE TABLE atleta(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	modalidade VARCHAR(30),
	cpf CHAR(11) UNIQUE NOT NULL,
	dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
	qtdMedalhas INT,
	CONSTRAINT cModalidade CHECK(modalidade, IN('Atletismo','Natação','Futebol de botão'))
);

INSERT INTO atleta(nome, modalidade, cpf, qtdMedalhas)
VALUES
('Phelps','Natação','11111111111',28),
('Guilherme','Natação','22222222222',20),
('Raphael','Futebol de Botão','33333333333',10),
('Rafael','Futebol de Botão','44444444444',10);


INSERT INTO atleta (cpf) 
VALUES 
('55555555555')

SELECT IFNULL(nome,'sem nome') FROM atleta; verifica se tem algum nulo na tabela

