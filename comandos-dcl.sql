-- comando DCL - Data Control Language

-- GRANT - REVOLK
-- estagiario só vai poder fazer select e o gestor todos os comandos

-- estagiario Senha@123 - SELECT 
CREATE USER	'estagiario'@'%' IDENTIFIED BY 'Senha@123';
GRANT SELECT ON ccoa.* TO 'estagiario'@'%';

-- criando gestor
CREATE USER 'gestor'@'%' IDENTIFIED BY 'Senha@123';
GRANT ALL PRIVILEGES ON ccoa.* TO 'gestor'@'%';
-- garantir todos os privilegios para o banco de dados na tabela

-- para eu garantir que o usuario tenha acesso eu rodo esse comando;
FLUSH PRIVILEGES;

-- remover os privilegios
REVOKE ALL PRIVILEGES ON ccoa.* FROM 'gestor'@'%';

--apagar usuario
DROP USER 'gestor'@'%';


-- o que é uma variavel de ambiente (é uma variavel que pode ser acessado por qualquer lugar via prompt de comando
