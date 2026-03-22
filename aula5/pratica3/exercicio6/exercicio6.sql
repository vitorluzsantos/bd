CREATE TABLE Farmacia(
	idFarmacia INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	fkEndereco INT,
	CONSTRAINT ctFkEndereco FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco)
);

CREATE TABLE Endereco(
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
	cep CHAR(7)
);

CREATE TABLE Farmaceutico(
	idFarmaceutico INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cpf CHAR(11),
	fkFarmacia INT,
	CONSTRAINT ctFkFarmacia FOREIGN KEY(fkFarmacia) REFERENCES Farmacia(idFarmacia)
);

INSERT INTO Endereco (cep)
VALUES
('1234567'),
('2345678'),
('3456789'),
('4567890'),
('5678901');

INSERT INTO Farmacia (nome, fkEndereco)
VALUES
('Farmacia Central', 1),
('Drogaria São Paulo', 2),
('Farmacia Popular', 3),
('Drogaria Nova Vida', 4),
('Farmacia Saúde', 5);

INSERT INTO Farmaceutico (nome, cpf)
VALUES
('Ana Martins', '11111111111'),
('Bruno Silva', '22222222222'),
('Carla Souza', '33333333333'),
('Diego Rocha', '44444444444'),
('Elisa Ferreira', '55555555555');

INSERT INTO Farmaceutico (nome, cpf, fkFarmacia)
VALUES
('Ana Martins', '11111111111', 1),
('Bruno Silva', '22222222222', 2),
('Carla Souza', '33333333333', 3),
('Diego Rocha', '44444444444', 4),
('Elisa Ferreira', '55555555555', 5);

SELECT 
    f.idFarmacia AS identificador,
    f.nome AS nome_farmacia, 
    e.cep AS endereco,
    c.nome AS nome_farmaceutico,
    c.cpf 
FROM Farmacia f
LEFT JOIN Endereco e ON f.fkEndereco = e.idEndereco
LEFT JOIN Farmaceutico c ON c.fkFarmacia = f.idFarmacia;
