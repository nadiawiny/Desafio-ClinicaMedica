create database Clinica;
use Clinica;

create table Ambulatorios (
	nroa int ,
    andar numeric(3) not null,
    capacidade smallint,
    primary key (nroa)
);

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

 create table Pacientes (
	codp int,
    nome varchar(40) not null,
    idade smallint not null,
    cidade varchar (30),
    CPF numeric (11) unique,
    doenca varchar (40) not null,
    primary key (codp)
);
    
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

create table Consultas (
    codm int,
    codp int,
    data date,
    hora time,
    FOREIGN KEY (codm) REFERENCES Medicos(codm),
    FOREIGN KEY (codp) REFERENCES Pacientes(codp) on delete cascade
);