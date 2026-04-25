CREATE DATABASE pratica09;
USE pratica09;

CREATE TABLE aluno(
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
	ra CHAR(8),
	nome VARCHAR(45),
	email VARCHAR(45),
	fk_grupo INT,
	CONSTRAINT ctFkGrupo FOREIGN KEY(fk_grupo) REFERENCES grupo(id_grupo)
);

CREATE TABLE grupo(
	id_grupo INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	desc_projeto VARCHAR(300)
);

CREATE TABLE professor(
	id_professor INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	disciplina VARCHAR(45)
);

CREATE TABLE avaliacao(
	id_avaliacao INT PRIMARY KEY AUTO_INCREMENT,
	fk_professor INT,
	fk_grupo INT 
);

CREATE TABLE professor(
	id_professor INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	disciplina VARCHAR(45)
);

 
