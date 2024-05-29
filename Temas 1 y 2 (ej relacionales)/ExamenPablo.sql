create database ExamenPablo;
use ExamenPablo;
create table alumnos(
    expediente int,
    nombre varchar(20),
    localidad varchar(20),
    nacimiento date,
    curso int,
    nivel varchar(20),
    faltas int,
    primary key(expediente)
)engine=innoDB;


insert into alumnos value(123,"Juan Soler","Sevilla","2005/10/10",1,"ESO",15);
insert into alumnos value(223,"Raquel Rubio","Carmona","2000/11/23",1,"BACHILLERATO",7);
insert into alumnos value(334,"Pedro Rodríguez","Écija","2004/03/10",2,"ESO",11);
insert into alumnos value(344,"Javier Hérnandez","Sevilla","2003/05/27",3,"ESO",0);
insert into alumnos value(445,"Francisco Cano","Sevilla","2002/07/01",4,"ESO",13);
insert into alumnos value(654,"Laura Gómez","Camas","2004/05/10",2,"ESO",25);
insert into alumnos value(765,"Beatriz Martínez","Sevilla","2003/05/05",3,"ESO",5);
insert into alumnos value(987,"Diego Martín","Écija","2000/06/03",1,"BACHILLERATO",34);
insert into alumnos value(993,"Gema Rubio","Carmona","2002/09/09",1,"BACHILLERATO",19);
insert into alumnos value(998,"Cristina Sánchez","Sevilla","2005/03/19",1,"ESO",null);


CONSULTAS

2)select distinct(localidad) from alumnos;
3)select nombre,faltas*2 as faltas_de_asistencia from alumnos;
4)select * from alumnos where localidad="Sevilla" and curso=1 and nivel="ESO";
5)select * from alumnos where localidad="Carmona" and nombre like "%o";
6)select * from alumnos where faltas is null;
7)select * from alumnos where faltas between 10 and 20 order by nombre;
8)select * from alumnos where faltas between 10 and 20 and localidad="Sevilla" and curso=1 and nivel="ESO";
9)select * from alumnos where faltas not between 10 and 20;
10)select * from alumnos where nivel not in ("BACHILLERATO") and curso=1 or curso=2 order by nombre;
11)select * from alumnos where year(nacimiento)=2003 or year(nacimiento)=2004 order by nombre;
12)select * from alumnos where nivel not in("BACHILLERATO") and nombre like "J%" and faltas>10 order by curso,nombre; 
13)select upper(nombre),lower(localidad) from alumnos order by localidad;
14)select nombre,year(nacimiento),month(nacimiento) from alumnos;
15)select nombre,year(current_date())-year(nacimiento) from alumnos;



