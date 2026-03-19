
create database sprint2;
use sprint2;

CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	email VARCHAR(45),
	cidade VARCHAR(45),
	estado VARCHAR(45)
);

CREATE TABLE pedidos(
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
    data_realizada DATE,
    endereco VARCHAR(45)
);

INSERT INTO cliente (nome,email,cidade,estado) VALUES
('Ana Souza', 'ana@gmail.com','São Paulo','SP'),
('João Silva','joao@email.com','Campinas','SP'),
('Ana Souza','ana@email.com','São Paulo','SP'),
('Maria Oliveira','maria@email.com','Uberaba','MG'),
('Lucas Pereira','lucas@email.com','Uberlândia','MG'),
('Carla Mendes','carla@email.com','Curitiba','PR'),
('Bruno Rocha',	'bruno@email.com',	'Porto Alegre','RS'),
('Juliana Castro','juliana@email.com','São Paulo','SP'),
('Ricardo Alves','ricardo@email.com','Belo Horizonte','MG');

INSERT INTO empresa(nome_vendedor, nome_empresa)
VALUES
();
