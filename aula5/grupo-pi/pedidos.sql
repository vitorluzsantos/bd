-- GRUPO - 03
-- caio picciarelli
-- emanuelly 
-- isaac pinheiro
-- karina cupola
-- victor souza
-- vitor da luz

CREATE DATABASE sprint2;
USE sprint2;
show tables;

CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	email VARCHAR(45),
	cidade VARCHAR(45),
	estado VARCHAR(45)
);

CREATE TABLE empresa(
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
	nome_empresa VARCHAR(45),
	nome_vendedor VARCHAR(45)
);

CREATE TABLE produto(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
	preco_unitario DECIMAL(7,2),
	categoria VARCHAR(45),
	quantidade INT, 
	nome_produto VARCHAR(45)
);

CREATE TABLE entrega(
	id_entrega INT PRIMARY KEY AUTO_INCREMENT,
	entrega_prevista DATE,
	data_realizada DATE
);

CREATE TABLE pedidos_consolidados(
	id_pedido INT PRIMARY KEY AUTO_INCREMENT,
	status_pedido VARCHAR(45),
	data_pedido DATETIME,
	fk_cliente INT,
	fk_empresa INT,
	fk_entrega INT,
	fk_produto INT,
	CONSTRAINT ctFkCliente FOREIGN KEY (fk_cliente) REFERENCES cliente(id_cliente),
	CONSTRAINT ctFkEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa),
	CONSTRAINT ctFkEntrega FOREIGN KEY (fk_entrega) REFERENCES entrega(id_entrega),
	CONSTRAINT ctFkProduto FOREIGN KEY (fk_produto) REFERENCES produto(id_produto)
);

-- INSERTS

INSERT INTO cliente (nome,email,cidade,estado) VALUES
	('Ana Souza', 'ana@gmail.com','São Paulo','SP'),
	('João Silva','joao@email.com','Campinas','SP'),
	('Ana Souza','ana@email.com','São Paulo','SP'),
	('Maria Oliveira','maria@email.com','Uberaba','MG'),
	('Lucas Pereira','lucas@email.com','Uberlândia','MG'),
	('Carla Mendes','carla@email.com','Curitiba','PR'),
	('Bruno Rocha','bruno@email.com','Porto Alegre','RS'),
	('Juliana Castro','juliana@email.com','São Paulo','SP'),
	('Ricardo Alves','ricardo@email.com','Belo Horizonte','MG');

INSERT INTO empresa(nome_vendedor, nome_empresa) VALUES
	('Carlos Lima','Techstore'),
	('Fernanda Alves','TechStore'),
	('Carlos Lima','HomeStore'),
	('Bruno Costa','HomeStore'),
	('Fernanda Alves','TechStore'),
	('Rafael Souza','MegaStore'),
	('Rafael Souza','MegaStore'),
	('Carlos Lima','TechStore'),
	('Bruno Costa','HomeStore');

INSERT INTO produto(preco_unitario, categoria, quantidade, nome_produto) VALUES
	(3500, 'Eletrônicos', 1, 'Notebook Dell'),
	(120, 'Eletrônicos', 2, 'Mouse Logitech'),
	(900, 'Móveis', 1, 'Cadeira Gamer'),
	(700, 'Móveis', 1, 'Mesa Escritório'),
	(3500, 'Eletrônicos', 1, 'Notebook Dell'),
	(2800, 'Eletrodomésticos', 1, 'Geladeira Brastemp'),
	(900, 'Eletrodomésticos', 1, 'Fogão 4 bocas'),
	(2200, 'Eletrônicos', 1, 'Smartphone Samsung'),
	(1800, 'Móveis', 1, 'Sofá 3 lugares');

INSERT INTO entrega(entrega_prevista, data_realizada) VALUES
	('2024-01-15', '2024-01-15'),
	('2024-01-13', '2024-01-13'),
	('2026-04-20', NULL),
	('2024-01-20', '2024-01-20'),
	('2026-03-20', NULL),
	('2024-02-20', '2024-02-19'),
	('2024-02-22', '2024-02-25'),
	('2024-03-25', NULL),
	('2024-03-28', NULL);

INSERT INTO pedidos_consolidados(status_pedido, data_pedido, fk_cliente, fk_empresa, fk_entrega, fk_produto) VALUES
	('Entregue', '2024-10-01 13:31:00', 1, 1, 1, 1),
	('Entregue', '2024-11-01 14:20:00', 2, 1, 2, 2),
	('Cancelado', '2024-12-03 07:36:00', 1, 2, 3, 3),
	('Entregue', '2024-12-01 08:30:00', 3, 2, 4, 4),
	('Em transporte', '2024-03-13 09:00:00', 4, 1, 5, 1),
	('Entregue', '2024-02-15 11:10:00', 5, 3, 6, 5),
	('Entregue', '2024-02-16 16:45:00', 6, 3, 7, 6),
	('Em transporte', '2024-02-18 10:15:00', 7, 1, 8, 7),
	('Cancelado', '2024-02-19 18:20:00', 8, 2, 9, 8);

-- SELECT FINAL

SELECT 
	DATE(p.data_pedido) AS 'Data do pedido',
	TIME(p.data_pedido) AS 'Hora do pedido',
	c.nome AS 'Nome do cliente',
	e.nome_empresa AS 'Empresa',
	pr.nome_produto AS 'Produto',
	pr.categoria AS 'Categoria',
	e.nome_vendedor AS 'Nome do vendedor',
	CONCAT(c.nome,' - ', c.email) AS 'Contato do cliente',
	CONCAT(c.cidade,' - ', c.estado) AS 'Localização',
	p.status_pedido AS 'Status do pedido',
	CASE 
		WHEN p.status_pedido = 'Entregue' AND en.data_realizada <= en.entrega_prevista THEN 'Entrega no prazo'
		WHEN p.status_pedido = 'Entregue' AND en.data_realizada > en.entrega_prevista THEN 'Entrega atrasada'
		WHEN p.status_pedido = 'Cancelado' THEN 'Pedido cancelado'
		WHEN p.status_pedido = 'Em transporte' THEN 'Pedido em andamento'
	END AS situacao_pedido
FROM pedidos_consolidados p
JOIN cliente c ON c.id_cliente = p.fk_cliente 
JOIN produto pr ON pr.id_produto = p.fk_produto
JOIN empresa e ON e.id_empresa = p.fk_empresa
JOIN entrega en ON en.id_entrega = p.fk_entrega
WHERE
pr.categoria = 'Eletrônicos' 
AND c.estado = 'SP'
ORDER BY p.data_pedido;

