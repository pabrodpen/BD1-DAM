create database EquiposPablo;
use EquiposPablo;

create table equipo(id_equipo int, 
nombre_equipo varchar(20),
ciudad varchar(20),
web_oficial varchar(20),
puntos int,
primary key (id_equipo)
)engine=innoDB;
insert into equipo value(1,"Regal Barcelona","Barcelona","http://",10);
insert into equipo value(2,"Real Madrid","Madrid","http://",9);
insert into equipo value(3,"P.E.Valencia","Valencia","http://",11);
insert into equipo value(4,"Caja Laboral","Vitoria","http://",22);
insert into equipo value(5,"Gran Canaria","Las Palmas","http://",14);
insert into equipo value(6,"CAI Zaragoza","Zaragoza","http://",23);

create table jugador(id_jugador int,
nombre varchar(20),
apellido varchar(20),
puesto varchar(20),
id_capitan int,
fecha_alta date,
salario double,
id_equipo int,
altura double,
primary key (id_jugador),
foreign key (id_equipo) references equipo (id_equipo)
)engine=innoDB;
alter table jugador add foreign key(id_capitan) references jugador(id_jugador);


set foreign_key_checks=0;
insert into jugador value(1,"Juan Carlos","Navarro","Escolta",1,"2010-10-01",130000,1,null);
insert into jugador value(2,"Felipe","Reyes","Pivot",2,"2009/02/20",120000,2,2.04);
insert into jugador value(3,"Víctor","Claver","Alero",3,"2009/03/08",90000,3,2.08);
insert into jugador value(4,"Rafa","Martínez","Escolta",4,"2010/11/11",51000,3,1.91);
insert into jugador value(5,"Fernando","San Emeterio","Alero",6,"2008/09/22",60000,4,1.99);
insert into jugador value(6,"Mirza","Teletovic","Pivot",6,"2010/05/13",70000,4,2.06);
insert into jugador value(7,"Sergio","Llul","Escolta",2,"2011/10/29",100000,2,1.90);
insert into jugador value(8,"Víctor","Sada","Base",1,"2012/01/01",80000,1,1.92);
insert into jugador value(9,"Carlos","Suarez","Alero",2,"2011/02/19",60000,2,2.03);
insert into jugador value(10,"Xavi","Rey","Pivot",14,"2008/10/12",95000,5,2.09);
insert into jugador value(11,"Carlos","Cabezas","Base",13,"2012/01/21",105000,6,1.86);
insert into jugador value(12,"Pablo","Aguilar","Alero",13,"2011/06/14",47000,6,2.03);
insert into jugador value(13,"Rafa","Hettsheimeir","Pivot",13,"2008/04/15",53000,6,2.08);
insert into jugador value(14,"Sitapha","Savané","Pivot",14,"2011/07/27",60000,5,2.01);
set foreign_key_checks=1;

create table partido(elocal int,
evisitante int,
resultado varchar(20),
fecha date,
arbitro int,
primary key (elocal,evisitante,fecha)
)engine=innoDB;
insert into partido value(1,2,"100-100","2011/10/10",4);
insert into partido value(2,3,"90-91","2011/11/17",5);
insert into partido value(3,4,"88-77","2011/11/23",6);
insert into partido value(1,6,"66-78","2011/11/30",6);
insert into partido value(2,4,"90-90","2012/01/12",7);
insert into partido value(4,5,"79-83","2012/01/19",3);
insert into partido value(3,6,"91-88","2012/02/22",3);
insert into partido value(5,4,"90-66","2012/04/27",2);
insert into partido value(6,5,"110-70","2012/05/30",1);

//elocal y evisitante forman parte de id_equipo(para el partido es
//necesario el id del local y del visitante), por lo que referencia a
//equipo
alter table partido add foreign key(elocal) references equipo(id_equipo);
alter table partido add foreign key(evisitante) references equipo(id_equipo);

//para ver una tabla en concreto(con datos)-->select * from nombre_tabla
//para ver una tabla en concreto(sin datos)-->describe nombre_tabla
//para ver una base de datos -->show database
//para ver todas las tablas de una base de datos-->show tables (dentro de la database)


