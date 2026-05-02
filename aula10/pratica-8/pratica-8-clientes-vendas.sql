CREATE DATABASE Venda;
USE Venda;

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100),
    endereco VARCHAR(150),
    fk_indicador INT,
    FOREIGN KEY (fk_indicador) REFERENCES cliente(id_cliente)
);

CREATE TABLE venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    total DECIMAL(10,2),
    data_venda DATE,
    fk_cliente INT,
    FOREIGN KEY (fk_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10,2)
);

CREATE TABLE venda_produto (
    fk_venda INT,
    fk_produto INT,
    quantidade INT,
    desconto DECIMAL(10,2),
    PRIMARY KEY (fk_venda, fk_produto),
    FOREIGN KEY (fk_venda) REFERENCES venda(id_venda),
    FOREIGN KEY (fk_produto) REFERENCES produto(id_produto)
);

INSERT INTO cliente (nome, email, endereco, fk_indicador) VALUES
('João', 'joao@gmail.com', 'Rua A', NULL),
('Maria', 'maria@gmail.com', 'Rua B', 1),
('Carlos', 'carlos@gmail.com', 'Rua C', 1),
('Ana', 'ana@gmail.com', 'Rua D', 2);

INSERT INTO produto (nome, descricao, preco) VALUES
('Produto 1', 'Desc 1', 10.00),
('Produto 2', 'Desc 2', 20.00),
('Produto 3', 'Desc 3', 30.00);

INSERT INTO venda (total, data_venda, fk_cliente) VALUES
(100.00, '2026-05-01', 1),
(150.00, '2026-05-02', 1),
(200.00, '2026-05-03', 2);

INSERT INTO venda_produto VALUES
(1,1,2,0),
(1,2,3,5),
(2,3,1,0),
(3,1,5,10);

SELECT * FROM cliente;
SELECT * FROM venda;
SELECT * FROM produto;
SELECT * FROM venda_produto;

SELECT c.*, v.*
FROM cliente c
JOIN venda v ON c.id_cliente = v.fk_cliente;

SELECT c.*, v.*
FROM cliente c
JOIN venda v ON c.id_cliente = v.fk_cliente
WHERE c.nome = 'João';

SELECT c.nome, i.nome AS indicador
FROM cliente c
LEFT JOIN cliente i ON c.fk_indicador = i.id_cliente;

SELECT c.nome AS indicado, i.nome AS indicador
FROM cliente c
JOIN cliente i ON c.fk_indicador = i.id_cliente
WHERE i.nome = 'João';

SELECT c.nome, i.nome AS indicador, v.id_venda, p.nome AS produto
FROM cliente c
LEFT JOIN cliente i ON c.fk_indicador = i.id_cliente
LEFT JOIN venda v ON c.id_cliente = v.fk_cliente
LEFT JOIN venda_produto vp ON v.id_venda = vp.fk_venda
LEFT JOIN produto p ON vp.fk_produto = p.id_produto;

SELECT v.data_venda, p.nome, vp.quantidade
FROM venda v
JOIN venda_produto vp ON v.id_venda = vp.fk_venda
JOIN produto p ON vp.fk_produto = p.id_produto;

SELECT p.nome, p.preco, SUM(vp.quantidade) AS total_vendido
FROM produto p
JOIN venda_produto vp ON p.id_produto = vp.fk_produto
GROUP BY p.nome, p.preco;

INSERT INTO cliente (nome, email, endereco) VALUES
('Novo Cliente', 'novo@gmail.com', 'Rua X');

SELECT c.*, v.*
FROM cliente c
LEFT JOIN venda v ON c.id_cliente = v.fk_cliente;

SELECT MIN(preco), MAX(preco) FROM produto;

SELECT SUM(preco), AVG(preco) FROM produto;

SELECT COUNT(*) 
FROM produto
WHERE preco > (SELECT AVG(preco) FROM produto);

SELECT SUM(DISTINCT preco) FROM produto;

SELECT fk_venda, SUM(preco)
FROM venda_produto vp
JOIN produto p ON vp.fk_produto = p.id_produto
GROUP BY fk_venda;
