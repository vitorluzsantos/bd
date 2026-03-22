CREATE TABLE Musica(
	idMusica INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(40),
	artista VARCHAR(40),
	genero VARCHAR(40),
	fkAlbum INT,
	CONSTRAINT ctFkAlbum FOREIGN KEY (fkAlbum) REFERENCES Album(idAlbum)
);


CREATE TABLE Album(
	idAlbum INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	tipo VARCHAR(45),
	dtLancamento DATE
);

ALTER TABLE Album ADD CONSTRAINT ctTipo CHECK (tipo IN ('digital','fisico'));

INSERT INTO Album(nome, tipo, dtLancamento)
VALUES
('ten','fisico','1993-10-10'),
('starboy','digital','2010-10-10');

INSERT INTO Musica(titulo, artista, genero, fkAlbum)
VALUES
('black','pearl jam','grunge',1),
('alive','pearl jam','grunge',1),
('starboy','the weeknd','pop',2);

SELECT * FROM Album;

SELECT * from Musica;

SELECT
	a.nome as nome_album,
	m.titulo as titulo_musica,
	m.genero,
	m.artista
FROM Musica m JOIN Album a ON fkAlbum = idAlbum;

SELECT
	a.nome as nome_album,
	m.titulo as titulo_musica
FROM Musica m JOIN Album a ON fkAlbum = idAlbum;

SELECT
	*
FROM Musica JOIN Album ON fkAlbum = idAlbum;
