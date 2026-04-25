-- funções de agregação

CREATE DATABASE ccoasp02;
USe ccoasp02;

CREATE TABLE cliente(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cpf CHAR(11)
);

CREATE TABLE pedido(
	id INT PRIMARY KEY AUTO_INCREMENT,
	dt_pedido DATETIME,
	valor DECIMAL(7,2),
	fk_cliente INT,
	CONSTRAINT ctFkCliente FOREIGN KEY(fk_cliente) REFERENCES cliente(id)
);

INSERT INTO cliente(nome, cpf)
VALUES
('clara','11111111111'),
('matheus','22222222222'),
('marina','33333333333');

INSERT INTO pedido(dt_pedido, valor, fk_cliente)
VALUES
(NOW(),2500.00,1),
('2026-04-22 10:00:00',3100.00,1),
(NOW(),9800.00,1),
(NOW(),1250.00,3);

-- SUM() => vai somar todos os elementos
SELECT SUM(valor) FROM pedido as receita_total;

-- AVG() => calcula a media dos elementos
SELECT AVG(valor) AS ticket_medio FROM pedido;

-- ROUND() => arredondar a saida
SELECT ROUND(AVG(valor),2) AS ticket_medio FROM pedido;

-- TRUNCATE() => elimina as casas decimais, pos o valor especificado
SELECT 
	TRUNCATE(SUM(valor),1) AS receita_total_formatada 
FROM pedido;

-- MAX() => maior valor entre os elementos 
SELECT MAX(valor)  AS maior_valor FROM pedido;

-- COUNT() => conta a quantidade de elementos
SELECT 
	COUNT(*) as quantidade_campos
FROM pedido;

SELECT 
	c.nome,
	SUM(p.valor)
FROM cliente c JOIN pedido p ON p.fk_cliente = c.id
GROUP BY c.nome;

USE ccoasp02;
SELECT 
	c.nome as maiores_compradores,
	SUM(p.valor)
FROM cliente c JOIN pedido p ON p.fk_cliente = c.id
GROUP BY c.nome
HAVING SUM(p.valor) > 3000;


