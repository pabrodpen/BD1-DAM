create database ejercicio0pablo;
use ejercicio0pablo;
create table empleados2(
    codigo_postal int,
    ciudad varchar(10),
    municipio varchar(10),
    primary key (codigo_postal)
)engine=innoDB;
create table empleados1(
    codigo_postal int,
    dni varchar(20),
    nombre varchar(10),
    apellido varchar(20),
    direccion varchar(40),
    foreign key (codigo_postal) references empleados2(codigo_postal),
    primary key (dni)
)engine=innoDB; 
create table historial_salarial(
    codigo_historial varchar(20),
    dni varchar(20),
    salario int,
    fecha_comienzo date,
    fecha_fin date,
    foreign key (dni) references empleados1(dni),
    primary key (codigo_historial)
)engine=innoDB;
create table departamentos(
    codigo_departamento varchar(20),
    nombre varchar(10),
    presupuesto int,
    presupuesto_actual int,
    primary key (codigo_departamento)
)engine=innoDB;
create table trabajos(
    codigo_trabajo varchar(20),
    codigo_departamento varchar(20),
    nombre varchar(20),
    salario_min int,
    salario_max int,
    foreign key (codigo_departamento) references departamentos(codigo_departamento),
    primary key (codigo_trabajo)
)engine=innoDB;
create table estudios(
    codigo_estudios varchar(20),
    titulo varchar(20),
    ciudad varchar(20),
    primary key (codigo_estudios)
)engine=innoDB;
create table tiene(
    dni varchar(20),
    codigo_estudios varchar(20),
    primary key (dni,codigo_estudios),
    foreign key (dni) references empleados1(dni),
    foreign key (codigo_estudios) references estudios(codigo_estudios)
)engine=innoDB;
create table historial_laboral(
    dni varchar(20),
    codigo_trabajo varchar(20),
    fecha_comienzo date,
    primary key (dni,codigo_trabajo,fecha_comienzo),
    foreign key (dni) references empleados1(dni),
    foreign key (codigo_trabajo) references trabajos(codigo_trabajo),
    fecha_fin date
)engine=innoDB;

