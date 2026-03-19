create database teste;
use teste;

-- criar primeiro responsavel, depois empresa e por ultimo aluno 
create table aluno(
	id_aluno int primary key auto_increment,
    nome varchar(45),
    ra char(8) unique not null,
    fk_empresa int,
    constraint ctFkEmpresa foreign key (fk_empresa) references empresa(id_empresa)
);
    
create table empresa(
	id_empresa int primary key auto_increment,
    razao_social varchar(45),
    cnpj char(14),
    fk_responsavel int unique ,
    constraint ctFkResponsavel foreign key (fk_responsavel) references responsavel(id_responsavel)
);

create table responsavel(
	id_responsavel int primary key auto_increment,
    nome varchar(45),
    cpf char(11),
    salario decimal(7,2)
);

insert into responsavel(nome, cpf, salario)
values
('zeca','12345678911',5000.00),
('matheus jacob','12345678910',10000.00);

insert into empresa(razao_social, cnpj, fk_responsavel)
values
('empresa da clara','11111111111111',2),
('empresa de canudos','1212121212121',1);

insert into aluno(nome, ra, fk_empresa)
values
('zeca','04261987',1),
('zuca','01242000',2);

-- juntar as tres tabelas

select * from empresa
join  ;

-- um join so junta duas tabelas 
select 
	a.nome as nome_aluno,
    e.razao_social,
    r.nome as nome_responsavel
from empresa e join aluno a on e.id_empresa = a.fk_empresa 
			   join responsavel r on r.id_responsavel = e.fk_responsavel ;

select 
	a.nome,
    e.razao_social
from aluno as a
join empresa e on e.id_empresa = a.fk_empresa;
