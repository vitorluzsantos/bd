CREATE DATABASE escola_gastronomia;
USE escola_gastronomia;

CREATE TABLE chef(
	id_chef INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	especialidade VARCHAR(45),
	salario DECIMAL(7,2),
	id_supervisor INT,
	CONSTRAINT ctFkSupervisor FOREIGN KEY(id_supervisor) REFERENCES chef(id_chef)
);

CREATE TABLE turma(
	id_turma INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	turno VARCHAR(45),
	sala VARCHAR(45),
	fk_responsavel INT,
	CONSTRAINT ctFkResponsavel FOREIGN KEY(fk_responsavel) REFERENCES chef(id_chef)
);

CREATE TABLE aluno(
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	telefone VARCHAR(45),
	situacao_academica VARCHAR(45),
	fk_turma INT,
	CONSTRAINT ctFkTurma FOREIGN KEY(fk_turma) REFERENCES turma(id_turma)
);

CREATE TABLE aula_pratica(
	id_aula_pratica INT,
	tema VARCHAR(45),
	data DATE,
	observacao VARCHAR(45),
	id_turma
)
