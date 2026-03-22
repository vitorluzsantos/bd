CREATE TABLE Pessoa1(
	idPessoa1 INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	dtNascimento DATE
);

CREATE TABLE Pessoa2(
	idPessoa2 INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	dtNascimento DATE,
	fkPessoa1 INT,
	CONSTRAINT ctFkPessoa1 FOREIGN KEY (fkPessoa1) REFERENCES Pessoa1(idPessoa1)
);

INSERT INTO Pessoa1 (nome, dtNascimento)
VALUES
('Ana', '1990-05-10'),
('Bruno', '1985-08-22'),
('Carlos', '2000-01-15'),
('Daniela', '1995-12-03'),
('Eduardo', '1988-07-19');

INSERT INTO Pessoa2 (nome, dtNascimento, fkPessoa1)
VALUES
('Fernanda', '2010-03-12', 1),
('Gabriel', '2012-06-25', 2),
('Helena', '2015-09-30', 3),
('Igor', '2018-11-05', 4),
('Julia', '2020-02-17', 5);

SELECT * FROM Pessoa1 JOIN Pessoa2 ON fkPessoa1 = idPessoa1;

SELECT 
	p1.nome as 'nome da pessoa1',
	p1.dtNascimento as 'data nascimento pessoa1',
	p2.nome as 'nome da pessoa2',
	p2.dtNascimento as 'data nascimento pessoa2'
FROM Pessoa1 p1 JOIN Pessoa2 p2 ON fkPessoa1 = idPessoa1;

SELECT
    p2.nome,
    p2.dtNascimento,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, p2.dtNascimento, CURDATE()) < 12 THEN 'Criança'
        WHEN TIMESTAMPDIFF(YEAR, p2.dtNascimento, CURDATE()) BETWEEN 12 AND 17 THEN 'Adolescente'
        WHEN TIMESTAMPDIFF(YEAR, p2.dtNascimento, CURDATE()) BETWEEN 18 AND 59 THEN 'Adulto'
        ELSE 'Idoso'
    END AS faixa_etaria
FROM Pessoa2 p2;

SELECT
    IFNULL(nome, 'Nome não informado') AS nome,
    IFNULL(dtNascimento, 'Data de nascimento não informada') AS data_nascimento
FROM Pessoa1;
