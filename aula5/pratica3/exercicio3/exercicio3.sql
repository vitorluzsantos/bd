CREATE TABLE Pessoa(
	idPessoa INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cpf CHAR(11)
);

CREATE TABLE Reserva(
	idReserva INT PRIMARY KEY AUTO_INCREMENT,
	dtReserva DATETIME,
	dtRetirada DATETIME,
	fkPessoa INT,
	CONSTRAINT ctFkPessoa FOREIGN KEY (fkPessoa) REFERENCES Pessoa(idPessoa)
);

INSERT INTO Pessoa(nome, cpf)
VALUES
('vitor','11111111111'),
('jacob','22222222222'),
('pedro','33333333333'),
('marina','44444444444'),
('caio','55555555555');

INSERT INTO Reserva(dtReserva, dtRetirada, fkPessoa)
VALUES
('2026-03-22 12:18','2026-03-22 12:23',1),
('2026-03-22 12:18','2026-03-22 12:23',2),
('2026-03-22 12:18','2026-03-22 12:25',3),
('2026-03-22 12:18','2026-03-22 12:25',4),
('2026-03-22 12:18','2026-03-22 12:18',5);

SELECT * FROM Pessoa JOIN Reserva ON fkPessoa = idPessoa;

SELECT 
	p.idPessoa as id,
	p.nome as nome_pessoa,
	p.cpf as cpf_pessoa,
	r.dtReserva as data_reserva,
	r.dtRetirada as data_retirada 
FROM Pessoa p JOIN Reserva r ON fkPessoa = idPessoa;

SELECT
    p.idPessoa,
    p.nome,
    r.dtReserva,
    r.dtRetirada,
    CASE 
        WHEN r.dtRetirada > r.dtReserva THEN 'Atrasado'
        WHEN r.dtRetirada = r.dtReserva THEN 'Retirada imediata'
        ELSE 'No prazo'
    END AS status_reserva
FROM Pessoa p

JOIN Reserva r ON r.fkPessoa = p.idPessoa;	
SELECT
    p.nome,
    r.dtReserva,
    IFNULL(r.dtRetirada, 'Ainda não retirado') AS data_retirada
FROM Pessoa p
JOIN Reserva r ON r.fkPessoa = p.idPessoa;
