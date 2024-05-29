create database LosInvestigadoresPablo;
use LosInvestigadoresPablo;
create table facultad(
    codigo_facultad varchar(20),
    nombre varchar(20),
    primary key(codigo_facultad)
)engine=innoDB;
create table investigadores(
    dni varchar(9),
    nombre varchar(20),
    apellidos varchar(20),
    primary key(dni),
    codigo_facultad varchar(20),
    foreign key (codigo_facultad) references facultad(codigo_facultad)
)engine=innoDB;
create table equipo(
    numero_serie int,
    nombre varchar(20),
    codigo_facultad varchar(20),
    primary key (numero_serie),
    foreign key (codigo_facultad) references facultad(codigo_facultad)
)engine=innoDB;
create table reserva(
    dni varchar(9),
    numero_serie int,
    fecha_inicio date,
    fecha_fin date,
    primary key(dni,numero_serie,fecha_inicio),
    foreign key(dni) references investigadores(dni),
    foreign key(numero_serie) references equipo(numero_serie)
)engine=innoDB;

ESTA CREADA