CREATE DATABASE pratica8;
use pratica8;

CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	email_principal VARCHAR(45),
	data_cadastro VARCHAR(45)
);

CREATE TABLE sessao(
	id_sessao INT PRIMARY KEY AUTO_INCREMENT,
	inicio_sessao DATETIME,
	expira_em DATETIME,
	ip_acesso	VARCHAR(45),
	fk_usuario INT,
	CONSTRAINT ctFkSessaoUsuario FOREIGN KEY(fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE credencial(
	id_credencial INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(45),
	senha_hash VARCHAR(45),
	ultimo_login DATETIME,
	fk_usuario INT,
	CONSTRAINT ctFkCredencialUsuario FOREIGN KEY(fk_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE papel(
	id_papel INT PRIMARY KEY AUTO_INCREMENT,
	nome_papel VARCHAR(45),
	descricao TEXT
);

CREATE TABLE usuario_papel(
	usuario_id_usuario INT,
	papel_id_papel INT,
	atribuido_em DATETIME,
	CONSTRAINT chave_composta PRIMARY KEY(usuario_id_usuario, papel_id_papel)
);	

INSERT INTO usuario (nome, email_principal, data_cadastro) VALUES
('João Silva', 'joao@gmail.com', NOW()),
('Maria Souza', 'maria@gmail.com', NOW()),
('Carlos Lima', 'carlos@gmail.com', NOW()),
('Ana Costa', 'ana@gmail.com', NOW()),
('Pedro Santos', 'pedro@gmail.com', NOW());

INSERT INTO sessao (inicio_sessao, expira_em, ip_acesso, fk_usuario) VALUES
(NOW(), DATE_ADD(NOW(), INTERVAL 2 HOUR), '192.168.0.1', 1),
(NOW(), DATE_ADD(NOW(), INTERVAL 2 HOUR), '192.168.0.2', 2),
(NOW(), DATE_ADD(NOW(), INTERVAL 2 HOUR), '192.168.0.3', 3),
(NOW(), DATE_ADD(NOW(), INTERVAL 2 HOUR), '192.168.0.4', 4),
(NOW(), DATE_ADD(NOW(), INTERVAL 2 HOUR), '192.168.0.5', 5);

INSERT INTO credencial (username, senha_hash, ultimo_login, fk_usuario) VALUES
('joao123', 'hash123', NOW(), 1),
('maria123', 'hash456', NOW(), 2),
('carlos123', 'hash789', NOW(), 3),
('ana123', 'hash101', NOW(), 4),
('pedro123', 'hash202', NOW(), 5);

INSERT INTO papel (nome_papel, descricao) VALUES
('ADMIN', 'Acesso total ao sistema'),
('USER', 'Usuário comum'),
('MODERATOR', 'Moderação de conteúdo');

INSERT INTO usuario_papel (usuario_id_usuario, papel_id_papel, atribuido_em) VALUES
(1, 1, NOW()),
(2, 2, NOW()),
(3, 2, NOW()),
(4, 3, NOW()),
(5, 2, NOW());

use pratica8;
SELECT 
    u.nome,
    COUNT(s.id_sessao) AS total_sessoes,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, s.inicio_sessao, s.expira_em)), 2) AS media_minutos
FROM usuario u
LEFT JOIN sessao s ON u.id_usuario = s.fk_usuario
GROUP BY u.id_usuario, u.nome;		
