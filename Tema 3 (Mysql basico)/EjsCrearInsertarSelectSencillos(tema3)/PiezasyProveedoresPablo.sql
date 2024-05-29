create database PiezasyProveedoresPablo;
use PiezasyProveedoresPablo;
create table piezas(
    codigoPieza varchar(20),
    nombre varchar(10),
    primary key (codigoPieza)
)engine=innoDB;

create table proveedor(
    idProveedor int,
    nombre varchar(10),
    primary key(idProveedor)
)engine=innoDB;

create table suministra(
    codigoPieza varchar(20),
    idProveedor int,
    precio int,
    primary key(codigoPieza,idProveedor),
    foreign key (codigoPieza) references piezas(codigoPieza),
    foreign key (idProveedor) references proveedor(idProveedor)
)engine=innoDB;

