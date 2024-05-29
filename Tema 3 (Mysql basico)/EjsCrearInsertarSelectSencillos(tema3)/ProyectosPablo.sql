create database ProyectosPablo;
use ProyectosPablo;
create table clientes(
    codigo_cliente varchar(20),
    nombre varchar(20),
    NIF varchar(9),
    direccion varchar(20),
    ciudad varchar(20),
    telefono varchar(20),
    primary key(codigo_cliente)
)engine=innoDB;
insert into clientes value("","","","",);

create table departamentos(
    nombre_departamento varchar(20),
    ciudad_departamento varchar(20),
    telefono varchar(20),
    primary key(nombre_departamento,ciudad_departamento)
)engine=innoDB;

create table proyectos(
    codigo_proyecto varchar(20),
    nombre varchar(20),
    precio int,
    fecha_inicio varchar(20),
    fecha_final varchar(20),
    codigo_cliente varchar(20),
    primary key(codigo_proyecto),
    foreign key(codigo_cliente) references clientes(codigo_cliente)
)engine=innoDB;
create table empleados(
    codigo_empleado varchar(20),
    nombre varchar(20),
    apellido varchar(20),
    sueldo int,
    nombre_departamento varchar(20),
    ciudad_departamento varchar(20),
    codigo_cliente varchar(20),
    primary key(codigo_empleado),
    foreign key(nombre_departamento,ciudad_departamento) references departamentos(nombre_departamento,ciudad_departamento),
    foreign key(codigo_cliente) references clientes(codigo_cliente)
)engine=innoDB;