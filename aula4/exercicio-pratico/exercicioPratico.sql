CREATE TABLE pessoa (
	idPessoa INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	pessoa VARCHAR(45),
	cpf CHAR(11)
);

CREATE TABLE reserva(
	idReserva INT PRIMARY KEY AUTO_INCREMENT,
	dtReserva DATETIME,
	dtRetirada DATETIME,
	dtDevolucao DATETIME,
	fkPessoa INT,
	CONSTRAINT ctFkPessoa FOREIGN KEY (fkPessoa) REFERENCES (idPessoa)
);

SELECT  FROM tableName;
