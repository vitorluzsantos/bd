CREATE DATABASE sprint2;
USE sprint2;

-- exercicio 1
CREATE TABLE pessoa (
	idPessoa INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cpf CHAR(11)
);

CREATE TABLE reserva(
	idReserva INT PRIMARY KEY AUTO_INCREMENT,
	dtReserva DATETIME,
	dtRetirada DATETIME,
	dtDevolucao DATETIME,
	fkPessoa INT,
	CONSTRAINT ctFkPessoa FOREIGN KEY (fkPessoa) REFERENCES pessoa(idPessoa)
);

INSERT INTO pessoa(nome, cpf)
VALUES
('vitor','AAABBBCCC11'),
('joao','AAABBBCCC22'),
('freitas','AAABBBCCC33'),
('jacob','AAABBBCCC44'),
('matheus','AAABBBCCC55'),
('incognita');

INSERT INTO reserva(dtReserva, dtRetirada, dtDevolucao, fkPessoa)
VALUES
('2026-03-15 10:00:00', '2026-03-16 08:00:00', '2026-03-18 18:00:00', 1),
('2026-03-16 14:30:00', '2026-03-17 09:00:00', '2026-03-19 17:00:00', 2),
('2026-03-17 09:15:00', '2026-03-18 10:00:00', '2026-03-20 16:30:00', 3),
('2026-03-18 11:45:00', '2026-03-19 08:30:00', '2026-03-21 19:00:00', 4),
('2026-03-19 15:00:00', '2026-03-20 09:00:00', '2026-03-22 18:30:00', 5);

SELECT * FROM pessoa;
SELECT * FROM reserva;

SELECT 
	dtReserva as 'data da reserva',
	dtRetirada as 'data da retirada',
	dtDevolucao as 'data da devolucao',
	nome,
	cpf
FROM reserva 
JOIN pessoa ON reserva.fkPessoa = pessoa.idPessoa;

SELECT 
    idPessoa,
    cpf,
    CASE
        WHEN nome LIKE 'm%' THEN 'Seu nome começa com m'
        WHEN nome LIKE 'v%' THEN 'Seu nome começa com v'
        ELSE 'Não se encaixa nas restrições'
    END AS 'letra inicial'
FROM pessoa;

SELECT 
	idPessoa,
	nome,
	IFNULL(cpf, 'CPF não informado') as cpf
FROM pessoa;

-- exercicio2

CREATE TABLE pessoa1(
	idPessoa1 INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	dtNasc DATE
);

CREATE TABLE pessoa2(
	idPessoa2 INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	dtNasc DATE,
	fkPessoa1 INT,
	CONSTRAINT ctFkPessoa1 FOREIGN KEY (fkPessoa1) REFERENCES pessoa1(idPessoa1)
);

-- inserir registros

SELECT * FROM pessoa1;
SELECT * FROM pessoa2;

SELECT 
	idPessoa2 as 'identificador',
	pessoa1.nome as 'nome da pessoa',
	pessoa2.dtNasc as 'data de nascimento',
	pessoa1.nome as 'nome do responsavel', 
	pessoa1.dtNasc as 'data de nascimento do responsavel'
FROM pessoa2
JOIN pessoa1 ON pessoa2.fkPessoa1 = pessoa1.idPessoa1;

SELECT
	nome, 
	CASE 
		WHEN dtNasc < '2007-01-01' THEN 'Maior de idade'
		ELSE 'Menor de idade'
	END AS 'classificacao'
FROM pessoa2;

-- exercicio 3 

SELECT 
	idPessoa2,
	nome,
	IFNULL(dtNasc, 'Data de nascimento não informada') as 'data de nascimento'
FROM pessoa2;

CREATE TABLE pessoa (
    idPessoa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    dtNascimento DATE
);

CREATE TABLE habilitacao (
    idHabilitacao INT PRIMARY KEY AUTO_INCREMENT,
    categoria CHAR(1),
    validade INT,
    fkPessoa INT UNIQUE,
    CONSTRAINT fkPessoaHabilitacao
        FOREIGN KEY (fkPessoa)
        REFERENCES pessoa(idPessoa)
);

INSERT INTO pessoa (nome, dtNascimento) VALUES
('João Silva','2000-05-10'),
('Maria Souza','1999-03-20'),
('Carlos Lima','2001-08-15'),
('Ana Costa','1998-12-01'),
('Pedro Santos','2002-07-30');

INSERT INTO habilitacao (categoria, validade, fkPessoa) VALUES
('A',1,1),
('B',1,2),
('A',1,3),
('B',1,4),
('A',1,5);

SELECT * FROM pessoa
JOIN habilitacao
ON pessoa.idPessoa = habilitacao.fkPessoa;

SELECT 
    pessoa.nome AS nome_candidato,
    pessoa.dtNascimento AS data_nascimento,
    habilitacao.categoria AS categoria_cnh,
    habilitacao.validade AS validade_anos
FROM pessoa
JOIN habilitacao
ON pessoa.idPessoa = habilitacao.fkPessoa;

SELECT 
    nome,
    CASE
        WHEN categoria = 'A' THEN 'Moto'
        WHEN categoria = 'B' THEN 'Carro'
        ELSE 'Outra'
    END AS tipo_veiculo
FROM pessoa
JOIN habilitacao
ON pessoa.idPessoa = habilitacao.fkPessoa;

SELECT 
    nome,
    IFNULL(categoria,'Categoria não definida') AS categoria
FROM pessoa
LEFT JOIN habilitacao
ON pessoa.idPessoa = habilitacao.fkPessoa;

-- exercicio 4
CREATE TABLE farmacia (
    idFarmacia INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE endereco (
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(100),
    numero INT,
    cidade VARCHAR(100),
    fkFarmacia INT UNIQUE,
    CONSTRAINT fkEnderecoFarmacia
        FOREIGN KEY (fkFarmacia)
        REFERENCES farmacia(idFarmacia)
);

CREATE TABLE farmaceutico (
    idFarmaceutico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    crf VARCHAR(20),
    fkFarmacia INT,
    CONSTRAINT fkFarmaceuticoFarmacia
        FOREIGN KEY (fkFarmacia)
        REFERENCES farmacia(idFarmacia)
);

INSERT INTO farmacia (nome, telefone) VALUES
('Farmacia Vida','1111-1111'),
('Farmacia Popular','2222-2222'),
('Farmacia Central','3333-3333'),
('Farmacia Bem Estar','4444-4444'),
('Farmacia Saúde','5555-5555');

INSERT INTO endereco (rua, numero, cidade, fkFarmacia) VALUES
('Rua A',10,'São Paulo',1),
('Rua B',20,'São Paulo',2),
('Rua C',30,'São Paulo',3),
('Rua D',40,'São Paulo',4),
('Rua E',50,'São Paulo',5);

INSERT INTO farmaceutico (nome, crf, fkFarmacia) VALUES
('Carlos Silva','CRF123',1),
('Ana Souza','CRF456',1),
('Pedro Lima','CRF789',2),
('Mariana Costa','CRF321',3),
('João Santos','CRF654',4);

SELECT *
FROM farmacia
JOIN endereco ON farmacia.idFarmacia = endereco.fkFarmacia
JOIN farmaceutico ON farmacia.idFarmacia = farmaceutico.fkFarmacia;

SELECT 
    farmacia.nome AS farmacia,
    endereco.rua AS rua,
    endereco.cidade AS cidade,
    farmaceutico.nome AS farmaceutico
FROM farmacia
JOIN endereco ON farmacia.idFarmacia = endereco.fkFarmacia
JOIN farmaceutico ON farmacia.idFarmacia = farmaceutico.fkFarmacia;

SELECT 
    farmaceutico.nome,
    CASE
        WHEN endereco.cidade = 'São Paulo' THEN 'Capital'
        ELSE 'Interior'
    END AS localizacao
FROM farmacia
JOIN endereco ON farmacia.idFarmacia = endereco.fkFarmacia
JOIN farmaceutico ON farmacia.idFarmacia = farmaceutico.fkFarmacia;

SELECT 
    farmacia.nome,
    IFNULL(farmaceutico.nome,'Sem farmacêutico') AS farmaceutico
FROM farmacia
LEFT JOIN farmaceutico ON farmacia.idFarmacia = farmaceutico.fkFarmacia;

