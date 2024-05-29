create database HospitalesPablo;
use HospitalesPablo;
create table empleado(
    cod_hospital int,
    dni int,
    nombre varchar(50),
    funcion varchar(20),
    salario float,
    localidad varchar(20),
    primary key(dni)
)engine=innoDB;

insert into empleado value(1,12345678,"García Hernández, Eladio","CONSERJE",1200,"LORCA");
insert into empleado value(4,22233311,"Martínez Molina, Gloria","MÉDICO",1600,"MURCIA");
insert into empleado value(2,22233322,"Tristán García, Ana","MÉDICO",1900,"MURCIA");
insert into empleado value(2,22233322,"Tristán García, Ana","MÉDICO",1900,"MURCIA");
insert into empleado value(4,33222111,"Mesa del Castillo, Juan","MÉDICO",2200,"LORCA");
insert into empleado value(3,55544411,"Ruiz Hernández, Caridad","MÉDICO",1900,"LORCA");
insert into empleado value(4,55544412,"Jiménez Jiménez, Dolores","CONSERJE",1200,"MURCIA");
insert into empleado value(2,55544433,"González Marín, Alicia","CONSERJE",1200,"MURCIA");
insert into empleado value(1,66655544,"Castillo Montes, Pedro","MÉDICO",1700,"MURCIA");
insert into empleado value(1,87654321,"Fuentes Bermejo, Carlos","DIRECTOR",2000,"MURCIA");
insert into empleado value(3,99988333,"Serrano Díaz, Alejandro","DIRECTOR",2400,"CARTAGENA");
insert into empleado value(2,22233333,"Martínez Molina,Andrés","MÉDICO",1600,"CARTAGENA");