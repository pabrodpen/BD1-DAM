create database LOSdirectoresPablo;
use LOSdirectoresPablo;
create table despacho(
    numero int,
    capacidad int,
    primary key (numero)
)engine=innoDB;
create table directores(
    dni varchar(20),
    dni_jefe varchar(20),
    numero int,
    nombre varchar(10),
    apellido varchar(10),
    primary key (dni),
    foreign key (numero) references despacho(numero)
)engine=innoDB;

ALTER TABLE directores ADD FOREIGN KEY (dni_jefe) REFERENCES directores(dni);

