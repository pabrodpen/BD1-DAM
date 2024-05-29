create database AutomovilesPablo;
use AutomovilesPablo;
create table clientes(
    NIF varchar(9),
    nombre varchar(20),
    ciudad varchar(20),
    telefono varchar(20),
    primary key(NIF)
)engine=innoDB;
insert into clientes value('111','Ignacio','Murcia','555-11-22-33');
insert into clientes value('222','Julia','Burgos','555-00-33-44');
insert into clientes value('333','Pedro','Cádiz','555-99-88-00');
insert into clientes value('444','David','Vizcaya','555-00-88-77');


create table coches(
    matricula varchar(20),
    marca varchar(20),
    modelo varchar(20),
    color varchar(20),
    precio int,
    NIF varchar(9),
    primary key(matricula),
    foreign key(NIF) references clientes(NIF)
)engine=innoDB;
insert into coches value('2222-BBB','seat','ibiza','blanco',12000,'111');
insert into coches value('3333-CCC','seat','toledo','gris',18000,'222');
insert into coches value('4444-DDDD','renault','clio','rojo',15000,'222');
insert into coches value('6666-FFFF','renault','megane','blanco',19000,'444');

create table revisiones(
    codigo varchar(20),
    filtro varchar(20),
    aceite varchar(20),
    frenos varchar(20),
    matricula varchar(20),
    primary key(codigo),
    foreign key(matricula) references coches(matricula)
)engine=innoDB;
insert into revisiones value('1','1','0','1','2222-BBB');
insert into revisiones value('2','1','1','1','3333-CCC');
insert into revisiones value('3','0','0','1','4444-DDD');
insert into revisiones value('4','1','0','1','2222-BBB');