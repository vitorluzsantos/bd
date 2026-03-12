CREATE DATABASE jogos;
USE jogos;

CREATE TABLE jogo(
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30),
nomeDiretor VARCHAR(30),
genero VARCHAR(30),
dtLanc DATE,
nota INT,
quantidade INT,
CONSTRAINT cNota CHECK(nota BETWEEN 0 AND 10)
);

INSERT INTO jogo(nome, nomeDiretor, genero, dtLanc, nota, quantidade)
VALUES
('lol','riot games','moba','2009-01-01',10,111),
('valorant','riot games','fps','2020-11-07',10,222),
('counter strike','valve','fps','2007-11-07',8,333),
('death stranding','kojima products','aventura','2019-11-08',10,444),
('the last of us','naught dog','ação','2013-06-14',9,555);

ALTER TABLE jogo ADD COLUMN tipoMidia VARCHAR(30);
ALTER TABLE jogo ADD CONSTRAINT cTipoMidia CHECK(tipoMidia IN('fisica','digital'));

UPDATE jogo SET tipoMidia = 'fisica' WHERE id = 1;
UPDATE jogo SET tipoMidia = 'digital' WHERE id = 2;
UPDATE jogo SET tipoMidia = 'digital' WHERE id = 3;
UPDATE jogo SET tipoMidia = 'fisica' WHERE id = 4;
UPDATE jogo SET tipoMidia = 'digital' WHERE id = 5;

SELECT * FROM jogo WHERE dtLanc >= '2015-01-01';

SELECT * FROM jogo WHERE nome LIKE '%a%';

SELECT * FROM jogo WHERE nomeDiretor LIKE '%e';

SELECT * FROM jogo WHERE genero = 'fps' AND quantidade > 0;

DELETE FROM jogo WHERE quantidade = 0;

ALTER TABLE jogo RENAME COLUMN nomeDiretor TO nomeCriador;
