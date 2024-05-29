create database ejercicio1pablo;
use ejercicio1pablo;
create table fabricantes(
    codigo_fabricante varchar(20),
    nombre varchar(10),
    primary key (codigo_fabricante)
)engine=innoDB;
create table articulos(
    codigo_articulo varchar(20),
   nombre varchar(10),
    apellido varchar(10),
    primary key (codigo_articulo),
    foreign key (codigo_fabricante) references fabricantes(codigo_fabricante)
)engine=innoDB;
create table departamentos(
    codigo_departamento varchar(20),
    nombre varchar(10),
    presupuesto int,
    primary key (codigo_departamento)
)engine=innoDB;
create table empleado(
    dni int,
    nombre varchar(10),
    apellido varchar(10),
    primary key (dni),
    foreign key (codigo_departamento) references departamentos(codigo_departamento)
)engine=innoDB;
create table almacenes(
    codigo_almacen varchar(20),
    lugar varchar(10),
    capacidad int,
    primary key (codigo_almacen)
)engine=innoDB;
create table cajas(
    numero_referencia int,
    contenido varchar(10),
    valor int,
    primary key (numero_referencia),
    foreign key (codigo_almacen) references almacenes(codigo_almacen)
)engine=innoDB;
create table pelicula(
    codigo_pelicula varchar(20),
    nombre varchar(10),
    calificacion int,
    edad int,
    primary key (codigo_pelicula),
)engine=innoDB;
create table salas(
    codigo_sala varchar(20),
    nombre varchar(10),
    pelicula varchar(10),
    primary key (codigo_sala),
    foreign key (codigo_pelicula) references pelicula(codigo_pelicula)
)engine=innoDB;
NO ESTA CREADA