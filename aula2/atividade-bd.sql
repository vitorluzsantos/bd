-- exercicio 1 CREATE TABLE Atleta(
	idAtleta INT PRIMARY KEY,
	nome VARCHAR(40),
	modalidade VARCHAR(40),
	qtdMedalha INT
);

INSERT INTO Atleta(nome, modalidade, qtdMedalha)
VALUES
	(1,'matheus','natação', 67),
	(2,'vitor','natação',4),
	(3,'pedro','dança',10),
	(4,'marina','dança',5),
	(5,'raphael','e-esports',100);

-- exibir todos os dados da tabela 
SELECT * FROM Atleta;

-- atualizando a quantidade de medalhas do jacob
UPDATE Atleta SET qtdMedalha = 10 WHERE idAtleta = 1;

-- atualizando a quantidade de medalhas dos ids 2, 3
UPDATE Atleta SET qtdMedalha = 3 WHERE idAtleta in(2,3);

-- atualizando o nome do atleta de id 4
UPDATE Atleta SET nome = 'gabriel' WHERE idAtleta = 4;

-- adicionando uma nova coluna com a data de nascimento dos atletas 
ALTER TABLE Atleta ADD COLUMN dtNasc DATE;

-- adicionando os registros a nova coluna 
UPDATE Atleta SET dtNasc = '17-02-2008' WHERE idAtleta = 1;
UPDATE Atleta SET dtNasc = '07-11-2007' WHERE idAtleta = 2;
UPDATE Atleta SET dtNasc = '21-10-2007' WHERE idAtleta = 3;
UPDATE Atleta SET dtNasc = '01-04-2007' WHERE idAtleta = 4;
UPDATE Atleta SET dtNasc = '21-05-2007' WHERE idAtleta = 5;

-- deletando o atleta de id =5 
DELETE FROM Atleta WHERE idAtleta = 5;

-- selecionando atletas que não praticam natação
SELECT * FROM Atleta WHERE modalidade <> 'natação';

-- selecionando atletas mais de 3 medalhas
SELECT * FROM Atleta WHERE qtdMedalha >=3;

-- mudando a quantidade do varchar de 40 pra 60
ALTER TABLE Atleta MODIFY COLUMN modalidade VARCHAR(60);

DESCRIBE Atleta;

TRUNCATE Atleta;

-- exercicio2

CREATE TABLE Musica(
	idMusica INT PRIMARY KEY,
	titulo VARCHAR(40), 
	artista VARCHAR(40),
	genero VARCHAR(40)
);

INSERT INTO * Musica(titulo, artista, genero)
VALUES
	(1,'black','pearl jam','grunge'),
	(2,'better man','pearl jam','grunge'),
	(3,'black hole sun','sound garden','grunge'),
	(4,'like a stone','audioslave','grunge'),
	(5,'umbrella','rihanna','pop'),
	(6,'diamonds','rihanna','pop'),
	(7,'2 mundos','basara','geek');

-- exibindo todos os dados da tabela
SELECT * FROM Musica;

-- adicionando o campo curtidas do tipo int
ALTER TABLE Musica ADD COLUMN curtidas INT;

-- adicionando registros a coluna curtidas
UPDATE Musica SET curtidas = 10;
UPDATE Musica SET curtidas = 11;
UPDATE Musica SET curtidas = 20;
UPDATE Musica SET curtidas = 30;
UPDATE Musica SET curtidas = 99;
UPDATE Musica SET curtidas = 4;
UPDATE Musica SET curtidas = 90;

-- atualizar o campo artista do tamanho 40 pra 60 
ALTER TABLE Musica MODIFY COLUMN artista VARCHAR(60);

-- atualizar as curtidas de musica do id = 1
UPDATE Musica SET curtidas = 12 WHERE idMusica = 1;

-- atualizar a quantidade de curtidas do id = 2 
UPDATE Musica SET curtidas = 20 WHERE idMusica in(2,3);

-- atualizando o nome da musica de id = 5
UPDATE Musica SET nome = 'nothing else matters' WHERE idMusica = 5;

-- apagar a musica de id = 4
DELETE FROM Musica where id = 4;

-- exibir as musicas com genero diferente de grunge 
SELECT * FROM Musica WHERE genero <> 'grunge';

-- exibir os dados de musicas com mais de 20 curtidas
SELECT * FROM Musica WHERE curtidas >=20;

DESCRIBE Musica;

TRUNCATE Musica;

-- exercicio 3 

CREATE TABLE Filme(
	idFilme INT PRIMARY KEY,
	titulo VARCHAR(50),
	genero VARCHAR(40),
	diretor VARCHAR(40)
);

INSERT INTO Filme(titulo, genero, diretor)
VALUES
	(1,'minions', 'comedia', 'gru'),
	(2,'o iluminado', 'terror' 'stanley'),
	(3,'vingadores', 'ação', 'stanley'),
	(4,'ainda estou aqui','drama', 'fernanda monte negro'),
	(5,'larva', 'comedia', 'larva amarela'),
	(6,'vila sesamo', 'terror', 'kermit'),
	(7,'rio 2', 'ação', 'walter branco');

-- mostrar tudo da tabela
SELECT * FROM Filme;

-- adicionar o campo protagonista
ALTER TABLE Filme ADD COLUMN protagonista;

-- adicionando registro protagonista 
UPDATE Filme SET protagonista = 'kevin';
UPDATE Filme SET protagonista = 'jacky';
UPDATE Filme SET protagonista = 'homem';
UPDATE Filme SET protagonista = 'fernanda monte negro';
UPDATE Filme SET protagonista = 'larva vermelha';
UPDATE Filme SET protagonista = 'garibaldo';
UPDATE Filme SET protagonista = 'ararinha azul';

-- alterar o tamanho do campo diretor
ALTER TABLE Filme MODIFY COLUMN diretor VARCHAR(150);

-- mudando o nome do diretor de id = 5 
UPDATE Filme SET diretor = 'rola bosta' WHERE idFilme = 5;

-- mudando o nome do diretor de id = 2 e 7 
UPDATE Filme SET diretor = 'mogador' WHERE idFilme in(2,7);

-- mudando o titulo por que o kermit é o goat
UPDATE Filme SET titulo = 'kermit' WHERE idFilme = 6;

-- deletando a linha 3 por que sim
DELETE FROM Filme WHERE idFilme = 3;

-- selecionando não drama
SELECT * FROM Filme WHERE genero <> 'drama';

-- selecio suspense
SELECT * FROM Filme WHERE genero = 'suspense';

DESCRIBE Filme;

TRUNCATE Filme;

-- exercicio 4 

CREATE TABLE Professor(
	idProfessor INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	especialidade VARCHAR(40),
	dtNasc(date)
);

INSERT INTO Professor(nome, especialidade, dtNasc)
VALUES
	('gislayno','engenharia de produção','1900-01-01'),
	('freeza','matar o kuririn','0001-01-01'),
	('vivian','banco de dados','1980-10-03'),
	('clara','banco de dados', '1999-10-02'),
	('rafiq','socioemocional','2007-09-13'),
	('erasmo','engenharia da pesca','2007-12-23');

-- exibindo tudo
SELECT * FROM Professor;

-- criando a coluna função !
ALTER TABLE Professor ADD COLUMN funcao VARCHAR(50);

-- atualizando aqui
UPDATE Professor SET funcao = 'monitor' WHERE idProfessor = 1;
UPDATE Professor SET funcao = 'titular' WHERE idProfessor = 2;
UPDATE Professor SET funcao = 'titular' WHERE idProfessor = 3;
UPDATE Professor SET funcao = 'assistente' WHERE idProfessor = 4;
UPDATE Professor SET funcao = 'monitor' WHERE idProfessor = 5;
UPDATE Professor SET funcao = 'titular' WHERE idProfessor = 6;

INSERT INTO Professor(nome, especialidade, dtNasc, funcao)
VALUES 
	('vitor', 'arq comp', '2007-11-07','titular');

DELETE FROM Professor WHERE idProfessor = 5;

SELECT * FROM Professor WHERE funcao = 'titular';

SELECT especialidade,dtNasc FROM Professor WHERE funcao = 'monitor';

UPDATE Professor SET dtNasc = '1985-10-09' idProfessor;

TRUNCATE Professor;

-- exercicio 5 
CREATE TABLE Curso(
	idCurso INT PRIMARY KEY,
	nome VARCHAR(50),
	sigla VARCHAR(3),
	coordenador VARCHAR(50)
);

INSERT INTO Curso(nome, sigla, coordenador)
VALUES
(1,'arquitetura de computadores','adc','matheus'),
(2,'banco de dados','bd','vivian'),
(3,'algoritmos','a','giulia');

-- exibindo os dados da tabela
SELECT * FROM Curso;

-- exibindo os dados co coordenador
SELECT coordenador FROM Curso;

-- exibindo os dados da sigla a 
SELECT * FROM Curso WHERE sigla = 'a';

-- exibindo os dados ordenando pelo nome
SELECT * FROM Curso ORDER BY nome;

-- exibindo pelo coordenador descendente
SELECT * FROM Curso ORDER BY coordenador DESC;

-- exibindo dados da tabela curso que começam com M
SELECT * FROM Curso WHERE nome LIKE 'm%';

-- exibindo dados da tabela que acaba com a letra s
SELECT * FROM Curso WHERE nome LIKE '%s';

-- selecionando dado que tem como segunda letra i 
SELECT * FROM Curso WHERE nome LIKE '_i%';

-- selecionando dado com penultima letra o
SELECT * FROM Curso WHERE nome LIKE	'%o_';

TRUNCATE Curso;

-- exercicio 6

CREATE TABLE Revista(
	idRevista INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(40),
	categoria VARCHAR(30)
);

INSERT INTO Revista(nome)
VALUES
('Veja'),
('Avon'),
('Caras'),
('playboy');

SELECT * FROM Revista;

-- atualizando os dados da coluna categoria
UPDATE Revista SET categoria = 'noticias' WHERE id = 1;
UPDATE Revista SET categoria = 'maquiagem' WHERE id = 2;
UPDATE Revista SET categoria = 'noticias' WHERE id = 3;
UPDATE Revista SET categoria = 'picante' WHERE id = 4;

INSERT INTO Revista(nome, categoria)
VALUES
('turma da monica','gibi'),
('folha de são paulo','jornal'),
('bleach','manga');

-- alterando a coluna categoria para tamanho de 40
ALTER TABLE Revista MODIFY COLUMN categoria VARCHAR(40);

DESCRIBE Revista;

-- adicionando a coluna periodicidade
ALTER TABLE Revista ADD COLUMN periodicidade VARCHAR(15);

SELECT * FROM Revista;

ALTER TABLE Revista DROP COLUMN periodicidade;

-- exercicio 7 

CREATE TABLE Carro(
	idCarro INT PRIMARY KEY AUTO_INCREMENT, adicionar /* o auto increment apartir de 1000 */
	nome VARCHAR(40),
	placa CHAR(7)
);

INSERT INTO Carro(nome,placa)
VALUES
('gol','EWT4586'),
('hb20','ONI2930'),
('onix','jdz3020'),
('corolla','nix1032');

SELECT * FROM Carro;

INSERT INTO Carro(nome)
VALUES
('saveiro'),
('spacefox'),
('strada');

SELECT * FROM Carro;

DESCRIBE Carro;

-- alterando o armazenamento do nome para 28 
ALTER TABLE Carro MODIFY COLUMN nome VARCHAR(28);

DESCRIBE Carro;

-- adicionando a coluna ano 
ALTER TABLE Carro ADD COLUMN ano CHAR(4);

-- atualizando os dados nulos da tabela
UPDATE Carro SET placa = 'XYZ9292' WHERE id = 1005;
UPDATE Carro SET placa = 'ABE0193' WHERE id = 1006;
UPDATE Carro SET placa = 'TEX6660' WHERE id = 1007;
UPDATE Carro SET ano = '2004' WHERE id = 1001;
UPDATE Carro SET ano = '2005' WHERE id = 1002;
UPDATE Carro SET ano = '2012' WHERE id = 1003;
UPDATE Carro SET ano = '2018' WHERE id = 1004;
UPDATE Carro SET ano = '2010' WHERE id = 1005;
UPDATE Carro SET ano = '2014' WHERE id = 1006;
UPDATE Carro SET ano = '2007' WHERE id = 1007;





