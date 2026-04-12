CREATE DATABASE ccoa;
USE ccoa;

--desafio 1 parte 1
-- exercicio1

CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE pessoa (
    id_pessoa INT PRIMARY KEY AUTO_INCREMENT,
    fk_endereco INT,
    id_sombra INT,
    CONSTRAINT fkPessoaEndereco 
        FOREIGN KEY (fk_endereco) REFERENCES endereco(id_endereco),
    CONSTRAINT fkPessoaSombra 
        FOREIGN KEY (id_sombra) REFERENCES pessoa(id_pessoa)
);

INSERT INTO endereco VALUES (NULL), (NULL);

INSERT INTO pessoa (fk_endereco, id_sombra) VALUES
(1, NULL),
(2, 1),
(1, 1);

SELECT 
    p.id_pessoa,
    e.id_endereco,
    s.id_pessoa AS sombra
FROM pessoa p
JOIN endereco e 
    ON p.fk_endereco = e.id_endereco
LEFT JOIN pessoa s 
    ON p.id_sombra = s.id_pessoa;

CREATE TABLE dono (
    id_dono INT PRIMARY KEY AUTO_INCREMENT
);

--exercicio2 

CREATE TABLE pet (
    id_pet INT PRIMARY KEY AUTO_INCREMENT,
    id_mae INT,
    id_pai INT,
    dono_id_dono INT,
    CONSTRAINT fkPetMae 
        FOREIGN KEY (id_mae) REFERENCES pet(id_pet),
    CONSTRAINT fkPetPai 
        FOREIGN KEY (id_pai) REFERENCES pet(id_pet),
    CONSTRAINT fkPetDono 
        FOREIGN KEY (dono_id_dono) REFERENCES dono(id_dono)
);

INSERT INTO dono VALUES (NULL), (NULL);

INSERT INTO pet (id_mae, id_pai, dono_id_dono) VALUES
(NULL, NULL, 1),
(NULL, NULL, 1),
(1, 2, 2);

SELECT 
    p.id_pet,
    d.id_dono,
    mae.id_pet AS mae,
    pai.id_pet AS pai
FROM pet p
JOIN dono d 
    ON p.dono_id_dono = d.id_dono
LEFT JOIN pet mae 
    ON p.id_mae = mae.id_pet
LEFT JOIN pet pai 
    ON p.id_pai = pai.id_pet;

--exercicio3

CREATE TABLE empresa (
    id_empresa INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    id_supervisor INT,
    fk_empresa INT,
    CONSTRAINT fkFuncionarioSupervisor 
        FOREIGN KEY (id_supervisor) REFERENCES funcionario(id_funcionario),
    CONSTRAINT fkFuncionarioEmpresa 
        FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);

INSERT INTO empresa VALUES (NULL), (NULL);

INSERT INTO funcionario (id_supervisor, fk_empresa) VALUES
(NULL, 1),
(1, 1),
(1, 2);

SELECT 
    f.id_funcionario,
    e.id_empresa,
    s.id_funcionario AS supervisor
FROM funcionario f
JOIN empresa e 
    ON f.fk_empresa = e.id_empresa
LEFT JOIN funcionario s 
    ON f.id_supervisor = s.id_funcionario;

-- parte 2 
CREATE TABLE cliente (
    codCli INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    cnh VARCHAR(11),
    endereco VARCHAR(100)
);

CREATE TABLE telefone (
    id_telefone INT PRIMARY KEY AUTO_INCREMENT,
    telefone VARCHAR(15),
    codCli INT,
    FOREIGN KEY (codCli) REFERENCES cliente(codCli)
);

CREATE TABLE carro (
    codCar INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(8),
    cor VARCHAR(15),
    modelo VARCHAR(20),
    ano INT,
    diaria DOUBLE
);

CREATE TABLE esportivo (
    codCar INT PRIMARY KEY,
    velocidade DOUBLE,
    FOREIGN KEY (codCar) REFERENCES carro(codCar)
);

CREATE TABLE seda (
    codCar INT PRIMARY KEY,
    passageiros INT,
    FOREIGN KEY (codCar) REFERENCES carro(codCar)
);

CREATE TABLE aluga (
    codAlu INT PRIMARY KEY AUTO_INCREMENT,
    dataInicial DATE,
    dataFinal DATE,
    codCar INT,
    codCli INT,
    FOREIGN KEY (codCar) REFERENCES carro(codCar),
    FOREIGN KEY (codCli) REFERENCES cliente(codCli)
);

INSERT INTO cliente (nome, cnh, endereco) VALUES
('Jacob', '12345678901', 'Rua A'),
('Vitor', '98765432100', 'Rua B');

INSERT INTO telefone (telefone, codCli) VALUES
('11999999999', 1),
('11888888888', 1),
('11777777777', 2);

INSERT INTO carro (placa, cor, modelo, ano, diaria) VALUES
('ABC1234', 'Preto', 'Sedan X', 2020, 150),
('DEF5678', 'Vermelho', 'Sport Z', 2022, 300);

INSERT INTO esportivo (codCar, velocidade) VALUES
(2, 320);

INSERT INTO seda (codCar, passageiros) VALUES
(1, 5);

INSERT INTO aluga (dataInicial, dataFinal, codCar, codCli) VALUES
('2026-05-01', '2026-05-05', 1, 1),
('2026-06-10', '2026-06-15', 2, 1),
('2026-07-01', '2026-07-03', 1, 2);

SELECT 
    c.nome,
    t.telefone
FROM cliente c
JOIN telefone t ON t.codCli = c.codCli;

SELECT 
    c.nome,
    ca.modelo,
    a.dataInicial,
    a.dataFinal
FROM aluga a
JOIN cliente c ON a.codCli = c.codCli
JOIN carro ca ON a.codCar = ca.codCar;

SELECT 
    ca.modelo,
    e.velocidade,
    s.passageiros
FROM carro ca
LEFT JOIN esportivo e ON ca.codCar = e.codCar
LEFT JOIN seda s ON ca.codCar = s.codCar;

-- parte 3 

CREATE TABLE cliente (
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    endereco VARCHAR(45),
    bairro VARCHAR(30),
    cidade VARCHAR(45),
    uf VARCHAR(2),
    telefone VARCHAR(45)
);

CREATE TABLE titulo (
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    tipo VARCHAR(45),
    locado BIT
);

CREATE TABLE locacoes (
    codigo INT PRIMARY KEY AUTO_INCREMENT,
    codigoCliente INT,
    codigoTitulo INT,
    dataSaida DATETIME,
    dataRetorno DATETIME,
    FOREIGN KEY (codigoCliente) REFERENCES cliente(codigo),
    FOREIGN KEY (codigoTitulo) REFERENCES titulo(codigo)
);

INSERT INTO cliente (nome, endereco, bairro, cidade, uf, telefone) VALUES
('Jacob', 'Rua A', 'Centro', 'SP', 'SP', '11999999999'),
('Vitor', 'Rua B', 'Zona Sul', 'SP', 'SP', '11888888888');

INSERT INTO titulo (nome, tipo, locado) VALUES
('Filme A', 'DVD', 1),
('Jogo B', 'Blu-ray', 0);

INSERT INTO locacoes (codigoCliente, codigoTitulo, dataSaida, dataRetorno) VALUES
(1, 1, '2026-05-01 10:00:00', '2026-05-05 10:00:00'),
(2, 2, '2026-06-01 14:00:00', '2026-06-03 14:00:00');

SELECT 
    c.nome,
    t.nome AS titulo,
    l.dataSaida,
    l.dataRetorno
FROM locacoes l
JOIN cliente c ON l.codigoCliente = c.codigo
JOIN titulo t ON l.codigoTitulo = t.codigo;

-- desafio 2
CREATE TABLE motorista (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    fone VARCHAR(45)
);

CREATE TABLE cliente (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    fone VARCHAR(45),
    endereco VARCHAR(45)
);

CREATE TABLE veiculo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(45),
    modelo VARCHAR(45),
    cor VARCHAR(45),
    ano INT,
    motorista_id INT,
    FOREIGN KEY (motorista_id) REFERENCES motorista(id)
);

CREATE TABLE viagem (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data DATE,
    time TIME,
    valor FLOAT,
    origem VARCHAR(45),
    destino VARCHAR(45),
    cliente_id INT,
    motorista_id INT,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    FOREIGN KEY (motorista_id) REFERENCES motorista(id)
);

INSERT INTO motorista (nome, fone) VALUES
('Jacob', '11999999999'),
('Vitor', '11888888888');

INSERT INTO cliente (nome, fone, endereco) VALUES
('Marina', '11777777777', 'Rua A'),
('Caio', '11666666666', 'Rua B');

INSERT INTO veiculo (placa, modelo, cor, ano, motorista_id) VALUES
('ABC1234', 'Sedan', 'Preto', 2020, 1),
('DEF5678', 'SUV', 'Branco', 2022, 2);

INSERT INTO viagem (data, time, valor, origem, destino, cliente_id, motorista_id) VALUES
('2026-05-01', '10:00:00', 25.50, 'Centro', 'Zona Sul', 1, 1),
('2026-05-02', '14:30:00', 40.00, 'Zona Norte', 'Centro', 2, 2),
('2026-05-03', '09:15:00', 18.75, 'Centro', 'Zona Leste', 1, 1);

SELECT 
    v.id,
    m.nome AS motorista,
    c.nome AS cliente,
    v.origem,
    v.destino,
    v.valor
FROM viagem v
JOIN motorista m ON v.motorista_id = m.id
JOIN cliente c ON v.cliente_id = c.id;

SELECT 
    m.nome,
    ve.placa,
    ve.modelo
FROM motorista m
JOIN veiculo ve ON ve.motorista_id = m.id;
