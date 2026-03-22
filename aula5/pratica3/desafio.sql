CREATE TABLE Time (
    idTime INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    estado CHAR(2)
);

CREATE TABLE Tecnico (
    idTecnico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    fkTime INT,
    CONSTRAINT ctFkTime FOREIGN KEY (fkTime) REFERENCES Time(idTime)
);

CREATE TABLE Escalacao (
    idEscalacao INT PRIMARY KEY AUTO_INCREMENT,
    numJogador CHAR(3),
    nome VARCHAR(45),
    posicao VARCHAR(45),
    tipo VARCHAR(45),
    dtJogo DATETIME,
    fkTecnico INT,
    CONSTRAINT ctFkTecnico FOREIGN KEY (fkTecnico) REFERENCES Tecnico(idTecnico)
);

INSERT INTO Time (nome, estado)
VALUES
('Flamengo', 'RJ'),
('Palmeiras', 'SP'),
('Grêmio', 'RS'),
('Atlético-MG', 'MG'),
('Corinthians', 'SP');

INSERT INTO Tecnico (nome, fkTime)
VALUES
('Vanderlei Luxemburgo', 1),
('Abel Ferreira', 2),
('Renato Gaúcho', 3),
('Cuca', 4),
('Sylvinho', 5);

INSERT INTO Escalacao (numJogador, nome, posicao, tipo, dtJogo, fkTecnico)
VALUES
('10', 'Diego', 'Meio-campo', 'Titular', '2026-03-25 20:00:00', 1),
('9', 'Rony', 'Atacante', 'Titular', '2026-03-25 20:00:00', 2),
('7', 'Ferreira', 'Atacante', 'Reserv', '2026-03-25 20:00:00', 3),
('1', 'Everson', 'Goleiro', 'Titular', '2026-03-25 20:00:00', 4),
('5', 'Gil', 'Zagueiro', 'Titular', '2026-03-25 20:00:00', 5);

SELECT
	ti.idTime,
	ti.nome AS nome_time,
	ti.estado,
	te.nome AS nome_tecnico,
	es.nome AS nome_jogador,
	es.posicao,
	es.tipo,
	es.dtJogo
FROM Escalacao es
JOIN Tecnico te ON es.fkTecnico = te.idTecnico
JOIN Time ti ON te.fkTime = ti.idTime;
