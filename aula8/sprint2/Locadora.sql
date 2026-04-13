CREATE DATABASE locadora;
USE locadora;

CREATE TABLE cliente (
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(50),
	rua VARCHAR(50),
	complemento VARCHAR(50),
	bairro VARCHAR(50),
	cidade VARCHAR(50),
	uf CHAR(2),
	telefone VARCHAR(20),
	email VARCHAR(100)
);

CREATE TABLE produto (
	id INT AUTO_INCREMENT PRIMARY KEY,
	titulo VARCHAR(50),
	ano INT,
	tipo VARCHAR(20),
	genero VARCHAR(50),
	plataforma VARCHAR(50),
	preco DECIMAL(10,2),
	condicaoProduto VARCHAR(50)
);

CREATE TABLE aluguel (
	id INT AUTO_INCREMENT PRIMARY KEY,
	fkCliente INT,
	fkProduto INT,
	dataRetirada DATE,
	dataDevolucao DATE,
	FOREIGN KEY (fkCliente) REFERENCES cliente(id),
	FOREIGN KEY (fkProduto) REFERENCES produto(id)
);

INSERT INTO cliente (nome) VALUES ('Vitor'),('Isaac'),('Caio');

INSERT INTO produto (titulo, tipo, preco) VALUES
('Mario','jogo',20),
('Zelda','jogo',25),
('Matrix','filme',10);

INSERT INTO aluguel (fkCliente, fkProduto, dataRetirada) VALUES
(1,1,'2025-01-01'),
(2,2,'2025-01-02');

SELECT c.nome, p.titulo, a.dataRetirada, a.dataDevolucao
FROM aluguel a
JOIN cliente c ON a.fkCliente = c.id
JOIN produto p ON a.fkProduto = p.id;

UPDATE aluguel SET dataDevolucao = NULL WHERE id = 1;

SELECT c.nome, p.titulo
FROM cliente c
JOIN aluguel a ON c.id = a.fkCliente
JOIN produto p ON p.id = a.fkProduto
WHERE p.preco > 15;

SELECT c.nome FROM cliente c
JOIN aluguel a ON c.id = a.fkCliente
WHERE a.dataDevolucao IS NULL;

SELECT c.nome, p.titulo,
CASE
WHEN a.dataDevolucao IS NULL THEN 'Em Aberto'
ELSE 'Concluído'
END AS situacao
FROM aluguel a
JOIN cliente c ON c.id = a.fkCliente
JOIN produto p ON p.id = a.fkProduto;

ALTER TABLE produto CHANGE condicaoProduto condicao VARCHAR(50);
