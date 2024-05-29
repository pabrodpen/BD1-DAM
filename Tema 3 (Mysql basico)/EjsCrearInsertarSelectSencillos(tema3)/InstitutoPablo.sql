create database InstitutoPablo;
use InstitutoPablo;
create  table profesores(
    identificador varchar(20),
    nombre varchar(20),
    direccion varchar(20),
    telefono int,
    primary key(identificador)
)engine=innoDB;
insert into profesores value('1','Josep','C/Principal',null);
insert into profesores value('2','Maria','Plaza Mayor',935556778); 

create table modulos(
    codigo_modulo varchar(20),
    nombre varchar(20),
    identificador varchar(20),
    primary key(codigo_modulo),
    foreign key (identificador) references profesores(identificador)
)engine=innoDB;
insert into modulos value('100','mates','1');
insert into modulos value('200','lengua','2');
insert into modulos value('300','fisica','1');
insert into modulos value('400','filosofia','2');

create table alumnos(
    num_exp int,
    nombre varchar(20),
    apellidos varchar(20),
    fecha_nacim varchar(20),
    num_delegado int,
    primary key(num_exp)
)engine=innoDB;
alter table alumnos add foreign key(num_delegado) references alumnos(num_exp);

insert into alumnos value(10,'Isabel','Ribes',null,10);
insert into alumnos value(20,'Raúl','Ríos','1978-02-01',10);
insert into alumnos value(30,'Carmen','Giménez',null,10);
insert into alumnos value(40,'Laura','Lahoz','1981-11-20',10);
insert into alumnos value(50,'Ana','Medina',null,40);
insert into alumnos value(60,'Juan','Sánchez',null,40);
insert into alumnos value(70,'Jesús','Pena',null,40);

create table matriculas(
    num_exp int,
    codigo_modulo varchar(20),
    primary key(num_exp,codigo_modulo)
)engine=innoDB;
insert into matriculas value(10,'100');
insert into matriculas value(10,'300');
insert into matriculas value(20,'400');
insert into matriculas value(30,'200');
insert into matriculas value(30,'400');
insert into matriculas value(40,'100');
insert into matriculas value(40,'200');
insert into matriculas value(40,'300');
insert into matriculas value(50,'200');
insert into matriculas value(60,'100');
insert into matriculas value(60,'300');
insert into matriculas value(70,'100');
insert into matriculas value(70,'200');
insert into matriculas value(70,'300');
insert into matriculas value(70,'400');
