CREATE DATABASE 1ccoa_bd_20260507;
use 1ccoa_bd_20260507;

CREATE TABLE departamento (
	idDepartamento INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50)
);

CREATE TABLE funcionario(
	idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(80),
	salario DECIMAL(10,2),
	fkDepartamento INT,
	FOREIGN KEY(fkDepartamento) REFERENCES departamento(idDepartamento)
);

INSERT INTO departamento (nome) VALUES 
('TI'),
('RH'),
('OP'),
('vendas');

INSERT INTO funcionario (nome, salario, fkDepartamento) 
VALUES
('Clara',5000,1),
('Vivian',5500,1),
('Pedro',6200,2),
('Walter',9999,4);

-- subquery - consulta dentro de consulta
-- separado por ()
-- trazer nome e salario de todo mundo que é do departamento de TI

-- ex de subquery como CONDICAO no where 
SELECT 
	nome,
	salario
FROM funcionario
WHERE fkDepartamento IN (
	SELECT idDepartamento
	FROM departamento
	WHERE nome = 'TI'
);

-- trazendo o nome dos funcionarios onde o salario é maior do que a media
-- ex de subquery como CONDICAO no where 
SELECT 
	nome 
FROM funcionario
WHERE salario > (
	SELECT 
		AVG(salario)
	FROM funcionario
);

-- ex de subquery utilizada no FROM, trazendo uma tabela virtual como resultado da subquery
use 1ccoa_bd_20260507;
SELECT * FROM 
	(
		SELECT 
			fkDepartamento AS id_departamento,
			AVG(salario) AS media_salario
		FROM funcionario
		GROUP BY fkDepartamento
	) AS medias m 
JOIN departamento d ON d.idDepartamento = m.id_departamento
WHERE media_salario > 4000;

-- SELECT * FROM 
-- 	(
-- 		SELECT 
-- 			fkDepartamento AS id_departamento,
-- 			AVG(salario) AS media_salario
-- 		FROM funcionario
-- 		GROUP BY fkDepartamento
-- 	) AS medias  
-- WHERE media_salario > 4000;

SELECT 
	AVG(media_salarial) as media_total
FROM dp_salario;

use 1ccoa_bd_20260507;
CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
	nomeEmpresa VARCHAR(45),
	cnpj CHAR(14)
);

ALTER TABLE departamento ADD COLUMN fkEmpresa INT;
ALTER TABLE departamento ADD CONSTRAINT ctFkEmpresa FOREIGN KEY(fkEmpresa) REFERENCES empresa(idEmpresa);

INSERT INTO empresa(nomeEmpresa, cnpj)
VALUES
('empresa da clara','12345678912345');

UPDATE departamento
	SET fkEmpresa = 1
WHERE idDepartamento IN(1, 2, 3, 4);

INSERT INTO empresa(nomeEmpresa, cnpj)
VALUES
('empresa do matheus','12345678912345');

-- não é uma boa praticar usar o RIGHT JOIN e o LEFT JOIN juntos
use 1ccoa_bd_20260507;
SELECT 
	* 
FROM empresa 
LEFT JOIN departamento ON fkEmpresa = idEmpresa 
LEFT JOIN funcionario ON fkDepartamento = idDepartamento;
