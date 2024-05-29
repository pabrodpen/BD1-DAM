create database LosgrandesalmacenesPablo;
use LosgrandesalmacenesPablo;
create table producto(
    codigoProducto varchar(20),
    nombre varchar(20),
    precio int,
    primary key(codigoProducto)
)engine=innoDB;
create table cajero(
    codigoCajero varchar(20),
    nombre varchar(20),
    apellidos varchar(20),
    primary key(codigoCajero)
)engine=innoDB;
create table maquina(
    codigoMaquina varchar(20),
    piso varchar(10),
    primary key(codigoMaquina)
)engine=innoDB;
create table venta(
    codigoCajero varchar(20),
    codigoMaquina varchar(20),
    codigoProducto varchar(20),
    primary key(codigoCajero,codigoMaquina,codigoProducto),
    foreign key(codigoCajero) references cajero(codigoCajero),
    foreign key(codigoMaquina) references maquina(codigoMaquina),
    foreign key(codigoProducto) references producto(codigoProducto)
)engine=innoDB;

ESTA CREADA