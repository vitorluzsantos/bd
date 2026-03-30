CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
	idGerente INT, -- fk
	nome VARCHAR(45),
	CONSTRAINT ctFkGerente FOREIGN KEY (idGerente) REFERENCES usuario(idUsuario)
);

CREATE TABLE email(
	idEmail INT,
	fkUsuario INT,
	conteudo VARCHAR(300),
	CONSTRAINT chave_composta PRIMARY KEY (idEmail, fkUsuario),
	CONSTRAINT ctFkUsuario FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

INSERT INTO usuario(nome, idGerente)
VALUES
('vitor',null),
('jacob',null),
('raphael',null),
('pedro',1),
('marina',2),
('rafiq',3),
('gabriel',2);

INSERT INTO email(idEmail,fkUsuario,conteudo)
VALUES
(1,3,'gosto muito de jogar lol'),
(2,5,'ola eu amo bale'),
(3,1,'eu sou o adm'),
(4,2,'eu sou jacobe');

SELECT 
	u.idUsuario as id,
	u.nome, 
	g.nome as gerente,
	e.conteudo
FROM usuario u 
	JOIN usuario g ON u.idGerente = g.idUsuario
	JOIN email e ON e.fkUsuario = u.idUsuario;

SELECT 
	u.idUsuario as id,
	u.nome, 
	g.nome as gerente,
	e.conteudo
FROM usuario u 
	JOIN usuario g ON u.idGerente = g.idUsuario
	JOIN email e ON e.fkUsuario = u.idUsuario
WHERE u.nome LIKE 'm%';

SELECT 
	u.idUsuario as id,
	u.nome, 
	g.nome as gerente,
	e.conteudo,
	CASE 
		WHEN e.conteudo = 'eu sou o adm' THEN 'cuidado ele é o adm'
		WHEN e.conteudo = 'eu sou jacobe' THEN 'pelo visto ele é o jacob'
		END AS aviso
FROM usuario u 
	JOIN usuario g ON u.idGerente = g.idUsuario
	JOIN email e ON e.fkUsuario = g.idUsuario;


