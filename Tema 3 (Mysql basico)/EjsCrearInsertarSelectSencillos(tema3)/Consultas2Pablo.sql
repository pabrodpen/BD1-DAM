create table empleados(
    num_empleado int,
    apellido varchar(20),
    oficio varchar(20),
    direccion int,
    fecha_alta date,
    salario int,
    comision int,
    num_departamento int,
    primary key(num_empleado)
)engine=innoDB;
alter table empleados add foreign key(num_departamento) references departamentos(num_departamento);

insert into empleados value(7369,"SANCHEZ","EMPLEADO",7902,"1990/12/17",1040,null,20);
insert into empleados value(7499,"ARROYO","VENDEDOR",7698,"1990/02/20",1500,390,30);
insert into empleados value(7521,"SALA","VENDEDOR",7698,"1990/02/22",1625,650,30);
insert into empleados value(7566,"JIMENEZ","DIRECTOR",7839,"1991/04/02",2900,null,20);
insert into empleados value(7788,"GIL","ANALISTA",7566,"1991/11/09",3000,null,20);
insert into empleados value(7839,"REY","PRESIDENTE",null,"1991/11/17",4100,null,10);

create table departamentos(
    num_departamento int,
    nombre_dpto varchar(20),
    localidad varchar(20),
    primary key(num_departamento)
)engine=innoDB;
insert into departamentos value(10,"CONTABILIDAD","SEVILLA");
insert into departamentos value(20,"INVESTIGACION","MADRID");
insert into departamentos value(30,"VENTAS","BARCELONA");
insert into departamentos value(40,"PRODUCCION","BILBAO");