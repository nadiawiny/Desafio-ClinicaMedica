/*Feito em Trio - Nádia Winy, Ranyelle dos Santos e Kaio Vinícus - ADS 4M ED2 - 021*/

create database Clinica;
use Clinica;

create table Ambulatorios (
	nroa int ,
    andar numeric(3) not null,
    capacidade smallint,
    primary key (nroa)
);

insert into Ambulatorios (nroa, andar, capacidade)
		values  (1, 1, 30),
				(2, 1, 50),
				(3, 2, 40),
				(4, 2, 25),
				(5, 2, 55);

create table Medicos (
	codm int,
    nome varchar (40) not null,
    idade smallint not null,
    especialidade char (20),
    CPF numeric (11) unique,
    cidade varchar (30),
    nroa int,
    primary key (codm),
    foreign key (nroa) references Ambulatorios (nroa)
 );

 insert into Medicos (codm, nome, idade, especialidade, CPF, cidade, nroa)
		values  (1, 'João', 40, '0rtopedia', 10000100000, 'Florianopolis', 1),
				(2, 'Maria', 42, 'traumatologia', 10000110000, 'Blumenau', 2),
				(3, 'Pedro', 51, 'pediatria', 11000100000, 'São José', 2),
				(4, 'Carlos', 28, 'ortopedia', 11000110000, 'Joinville', null),
				(5, 'Marcia', 33, 'neurologia', 11000111000, 'Biguacu', 3);
    
create table Pacientes (
	codp int,
    nome varchar(40) not null,
    idade smallint not null,
    cidade varchar (30),
    CPF numeric (11) unique,
    doenca varchar (40) not null,
    primary key (codp)
);

insert into Pacientes (codp, nome, idade, cidade, CPF, doenca)
		values  (1, 'Ana', 20, 'Florianopolisa', 20000200000, 'gripe'),
				(2, 'Paulo', 24, 'Palhaca', 20000220000, 'fratura'),
				(3, 'Lucia', 30, 'Biguacu', 22000200000, 'tendinite'),
				(4, 'Carlos', 28, 'Joinville', 11000110000, 'Sarampo');
    
    
create table Funcionarios (
	codf int,
    nome varchar (40) not null,
    idade smallint,
    CPF numeric(11) unique,
    cidade varchar (30),
    salario numeric (10),
    cargo varchar (20),
    primary key (codf)
);

-- 03 
alter table Funcionarios add nroa int;

insert into Funcionarios (codf, nome, idade, CPF, cidade, salario, cargo, nroa)
		values  (1, 'Rita', 32, 20000100000, 'São Jose', 1200, 'Recepcionista', 1),
				(2, 'Maria', 55, 30000110000, 'Palhoca', 1220, 'Enfermeiro', 2),
				(3, 'Caio', 45, 41000100000, 'Florianopolis', 1100, 'Gerente', 1),
				(4, 'Carlos', 44, 50000110000, 'Florianopolis', 1200, 'Aux. Laboratório', 3),
				(5, 'Paula', 33, 61000111000, 'Florianopolis', 2500, 'Aux. Administrativo', 2);

create table Consultas (
    codm int,
    codp int,
    data date,
    hora time,
    FOREIGN KEY (codm) REFERENCES Medicos(codm),
    FOREIGN KEY (codp) REFERENCES Pacientes(codp) on delete cascade
);

insert into Consultas (codm, codp, data, hora)
		values  (1, 1, '2006-06-12', '14:00'),
				(1, 4, '2006-06-13', '10:00'),
				(2, 1, '2006-06-13', '9:00'),
				(2, 2, '2006-06-13', '11:00'),
				(2, 3, '2006-06-14', '14:00'),
				(2, 4, '2006-06-14', '17:00'),
				(3, 1, '2006-06-19', '18:00'),
				(3, 3, '2006-06-22', '10:00'),
				(3, 4, '2023-09-19', '13:00'),
				(4, 4, '2006-06-20', '13:00'),
				(4, 4, '2006-06-22', '19:30');

-- 04 indices
create unique index idx_medicos_cpf on Medicos (CPF);

create index idx_pacientes_doenca on Pacientes (doenca);

 -- 05
drop index idx_pacientes_doenca on Pacientes;

-- 06
alter table Funcionarios drop column cargo;

alter table Funcionarios drop column nroa;

/*-------------------------------------------------------------------*/
-- 1)O paciente Paulo mudou-se para Ilhota
UPDATE Pacientes SET cidade = 'Ilhota' WHERE nome = 'Paulo' and codp = 2;
 select * from pacientes;
 
-- 2)A consulta do médico 1 com o paciente 4  passou para às 12:00 horas do dia 4 de Julho de 2006
UPDATE consultas SET hora = '12:00', data = '2006-07-04' WHERE codm = 1 and codp = 4;
select * from consultas;

-- 3)A paciente Ana fez aniversário e sua doença agora é cancer
UPDATE Pacientes SET idade = idade+1 , doenca = 'cancer' WHERE nome = 'ana' and codp = 1;
select * from pacientes;

-- 4)A consulta do médico Pedro (codf = 3) com o paciente Carlos (codf = 4) passou para uma hora e meia depois
UPDATE Consultas SET hora = ADDTIME(hora, '01:30:00') WHERE codm = 3 AND codp = 4;
select * from consultas;

-- 5)O funcionário Carlos (codf = 4) deixou a clínica
DELETE FROM Funcionarios WHERE codf = 4;
select * from funcionarios;

-- 6)As consultas marcadas após as 19 horas foram canceladas
DELETE FROM Consultas WHERE hora > '19:00:00';
select * from Consultas;

-- 7)Os pacientes com câncer ou idade inferior a 10 anos deixaram a clínica
DELETE FROM pacientes WHERE doenca = 'cancer' or idade < 10;
select * from pacientes;

-- 8)Os médicos que residem em Biguacu e Palhoca deixaram a clínica
DELETE FROM medicos WHERE cidade ='Biguacu' or cidade = 'Palhoca';
select * from medicos;