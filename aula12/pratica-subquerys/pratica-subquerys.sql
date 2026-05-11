CREATE DATABASE subquery;
USE subquery;

CREATE TABLE cliente (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cidade VARCHAR(45)
);

CREATE TABLE pedido (
	id INT PRIMARY KEY AUTO_INCREMENT,
	cliente_id INT,
	data DATE,
	valor_total DECIMAL(10,2),
	FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE produto (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	categoria VARCHAR(45),
	preco DECIMAL(10,2)
);

CREATE TABLE itens_pedido (
	id INT PRIMARY KEY AUTO_INCREMENT,
	pedido_id INT,
	produto_id INT,
	quantidade INT,
	preco_unitario DECIMAL(10,2),
	FOREIGN KEY (pedido_id) REFERENCES pedido(id),
	FOREIGN KEY (produto_id) REFERENCES produto(id)
);

INSERT INTO cliente (nome, cidade) VALUES
('João', 'São Paulo'),
('Maria', 'São Paulo'),
('Carlos', 'Rio de Janeiro'),
('Ana', 'Campinas'),
('Fernanda', 'São Paulo'),
('Lucas', 'Campinas');

INSERT INTO produto (nome, categoria, preco) VALUES
('Notebook', 'Eletrônicos', 4500.00),
('Mouse', 'Eletrônicos', 120.00),
('Teclado', 'Eletrônicos', 250.00),
('Cadeira Gamer', 'Móveis', 1500.00),
('Mesa', 'Móveis', 900.00),
('Monitor', 'Eletrônicos', 1300.00),
('Celular', 'Eletrônicos', 3500.00),
('Impressora', 'Eletrônicos', 800.00);

INSERT INTO pedido (cliente_id, data, valor_total) VALUES
(1, '2026-01-10', 4620.00),
(1, '2026-02-15', 1500.00),
(2, '2026-03-05', 3700.00),
(3, '2026-03-20', 900.00),
(3, '2026-04-01', 250.00),
(4, '2026-04-15', 5800.00),
(5, '2026-05-10', 120.00);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1,1,1,4500.00),
(1,2,1,120.00),
(2,4,1,1500.00),
(3,7,1,3500.00),
(3,2,1,120.00),
(4,5,1,900.00),
(5,3,1,250.00),
(6,1,1,4500.00),
(6,6,1,1300.00),
(7,2,1,120.00);

SELECT *
FROM cliente
WHERE id IN (
	SELECT cliente_id
	FROM pedido
	WHERE valor_total > (
		SELECT AVG(valor_total)
		FROM pedido
	)
);

SELECT *
FROM produto
WHERE preco = (
	SELECT MAX(preco)
	FROM produto
);

SELECT *
FROM pedido
WHERE valor_total > (
	SELECT MIN(valor_total)
	FROM pedido
);

SELECT *
FROM cliente
WHERE id NOT IN (
	SELECT cliente_id
	FROM pedido
);

SELECT *
FROM produto
WHERE preco > (
	SELECT AVG(preco)
	FROM produto
);

SELECT 
	c.nome,
	SUM(p.valor_total) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id
HAVING SUM(p.valor_total) > (
	SELECT AVG(total_cliente)
	FROM (
		SELECT SUM(valor_total) AS total_cliente
		FROM pedido
		GROUP BY cliente_id
	) AS media
);

SELECT *
FROM pedido
WHERE valor_total = (
	SELECT MAX(valor_total)
	FROM pedido
);

SELECT *
FROM produto
WHERE id NOT IN (
	SELECT produto_id
	FROM itens_pedido
);

SELECT 
	c.nome,
	COUNT(p.id) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id;

SELECT 
	categoria,
	COUNT(id) AS quantidade
FROM produto
GROUP BY categoria
HAVING COUNT(id) > 5;

SELECT 
	c.nome,
	c.cidade,
	SUM(p.valor_total) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id, c.cidade
HAVING SUM(p.valor_total) > (
	SELECT AVG(totalCidade)
	FROM (
		SELECT SUM(p2.valor_total) AS totalCidade
		FROM cliente c2
		JOIN pedido p2 ON c2.id = p2.cliente_id
		WHERE c2.cidade = c.cidade
		GROUP BY c2.id
	) AS mediaCidade
);

SELECT *
FROM pedido p
WHERE valor_total > (
	SELECT AVG(valor_total)
	FROM pedido
	WHERE cliente_id = p.cliente_id
);

SELECT 
	pr.nome,
	SUM(ip.quantidade) AS total_vendido
FROM produto pr
JOIN itens_pedido ip ON pr.id = ip.produto_id
GROUP BY pr.id
ORDER BY total_vendido DESC;

SELECT 
	c.nome,
	COUNT(p.id) AS quantidade
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id
HAVING COUNT(p.id) > (
	SELECT AVG(qtd)
	FROM (
		SELECT COUNT(id) AS qtd
		FROM pedido
		GROUP BY cliente_id
	) AS mediaPedidos
);

SELECT *
FROM pedido
WHERE valor_total > (
	SELECT AVG(valor_total)
	FROM pedido
) * 2;

SELECT 
	c.nome,
	SUM(p.valor_total) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id
ORDER BY total_gasto DESC
LIMIT 1;

SELECT 
	pr.nome,
	SUM(ip.quantidade) AS total_vendido
FROM produto pr
JOIN itens_pedido ip ON pr.id = ip.produto_id
GROUP BY pr.id
ORDER BY total_vendido DESC
LIMIT 3;

SELECT 
	c.nome,
	AVG(p.valor_total) AS ticket_medio
FROM cliente c
JOIN pedido p ON c.id = p.cliente_id
GROUP BY c.id
HAVING AVG(p.valor_total) > (
	SELECT AVG(valor_total)
	FROM pedido
);

SELECT 
	categoria,
	AVG(preco) AS preco_medio
FROM produto
GROUP BY categoria
HAVING AVG(preco) > (
	SELECT AVG(preco)
	FROM produto
);

SELECT 
	p.id,
	COUNT(ip.id) AS quantidade_itens
FROM pedido p
JOIN itens_pedido ip ON p.id = ip.pedido_id
GROUP BY p.id
HAVING COUNT(ip.id) > (
	SELECT AVG(qtd)
	FROM (
		SELECT COUNT(id) AS qtd
		FROM itens_pedido
		GROUP BY pedido_id
	) AS mediaItens
);
