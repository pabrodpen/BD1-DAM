create database UniversidadPablo;
use UniversidadPablo;
create table persona (dni varchar(9),
 nombre varchar(25),
 apellido varchar(50),
 ciudad varchar(25),
 calle varchar (50),
 numero varchar(3),
 telefono varchar(9),
 fecha_nacimiento date,
 varon char,
 primary key (dni));



create table alumno (id_alumno varchar(7),
 dni varchar(9),
 primary key (id_alumno));



create table profesor (id_profesor varchar(4),
 dni varchar(9),
 primary key (id_profesor));



create table titulacion (id_titulacion varchar(6),
 nombre varchar (20),
 primary key (id_titulacion));



create table asignatura (id_asignatura varchar(6),
 nombre varchar(50),
 creditos integer,
 cuatrimestre varchar(1),
 coste_basico integer,
 id_profesor varchar(4),
 id_titulacion varchar(6),
 curso integer,
 primary key (id_asignatura),
 foreign key (id_profesor) references profesor (id_profesor),
 foreign key (id_titulacion) references titulacion (id_titulacion));



create table alumno_asignatura (id_alumno varchar(7),
 id_asignatura varchar(6),
 numero_matricula integer,
 foreign key (id_alumno) references alumno (id_alumno),
 foreign key (id_asignatura) references asignatura (id_asignatura));

 insert into profesor value('P101','19191919A');
 insert into profesor value('P117','25252525A');
 insert into profesor value('P203','23232323A');
 insert into profesor value('P204','26262626A');
 insert into profesor value('P304','24242424A');

 insert into alumno value('A010101','21212121A');
 insert into alumno value('A020202','18181818A');
 insert into alumno value('A030303','20202020A');
 insert into alumno value('A040404','26262626A');
 insert into alumno value('A121212','16161616A');
 insert into alumno value('A131313','17171717A');

 insert into persona value('16161616A','Luis','Ramirez','Haro','Pez','34','941111111','1969/01/01','1');
 insert into persona value('17171717A','Laura','Beltran','Madrid','Gran via','23','912121212','1974/08/08','0');
 insert into persona value('18181818A','Pepe','Perez','Madrid','Percebe','13','913131313','1980/02/02','1');
 insert into persona value('19191919A','Juan','Sanchez','Bilbao','Melancolia','7','944141414','1966/03/03','1');
 insert into persona value('20202020A','Luis','Jimenez','Najera','Cigueña','15','941151515','1979/03/03','1');
 insert into persona value('21212121A','Rosa','Garcia','Haro','Alegria','16','941161616','1978/04/04','0');
 insert into persona value('23232323A','Jorge','Saenz','Logroño','Luis Ulloa','17','941171717','1978/09/09','1');
 insert into persona value('24242424A','Maria','Gutierrez','Logroño','Avda. de la paz','18','941181818','1964/10/10','0');

insert into titulacion value('130110','Matematicas');
insert into titulacion value('150210','Quimicas');
insert into titulacion value('160000','Empesariales');

insert into asignatura value('000115','Seguridad vial',4.5,'1',30,'P204',NULL,NULL);
insert into asignatura value('130113','Programacion I',9,'1',60,'P101','130110',1);
insert into asignatura value('130122','Analisis II',9,'2',60,'P203','130110',2);
insert into asignatura value('150212','Quimica fisica',4.5,'2',70,'P304','150210',1);
insert into asignatura value('160002','Contabilidad',6,'1',70,'P117','160000',1);


 insert into alumno_asignatura value('A010101','150212',1);
 insert into alumno_asignatura value('A020202','130113',1);
 insert into alumno_asignatura value('A020202','150212',2);
 insert into alumno_asignatura value('A030303','130113',3);
 insert into alumno_asignatura value('A030303','150212',1);
 insert into alumno_asignatura value('A030303','130122',2);
 insert into alumno_asignatura value('A040404','130122',1);
 insert into alumno_asignatura value('A121212','000115',1);
 insert into alumno_asignatura value('A131313','160002',4);

 --ACTIVIDADES--
--30->Nombre de las asignaturas impartidas por profesores de Logroño
select Asignatura.Nombre 
from Asignatura,Profesor,Persona 
where Asignatura.IdProfesor = Profesor.IdProfesor
and Profesor.DNI = Persona.DNI 
and Ciudad='Logroño';
--31->nombre completo alumnos
select Persona.Nombre,Persona.Apellido
from Persona,Alumno
where Persona.DNI=Alumno.DNI;
--32->DNI, nombre y apellidos de los alumnos que viven en La Rioja.Como criterio usar el prefijo 941
select Persona.DNI,Persona.Nombre,Persona.Apellido,Persona.Telefono
from Persona,Alumno
where Persona.DNI=Alumno.DNI
and Persona.Telefono like "941%";
--33->DNI, nombre y apellido de los alumnos matriculados en la asignatura Seguridad Vial
select Persona.DNI,Persona.Nombre,Persona.Apellido,Asignatura.Nombre 
from Persona,Asignatura
where Asignatura.Nombre="Seguridad Vial";
--34->ID de las titulaciones en la que está matriculado el alumno con DNI 20202020A.Un alumno está matriculado en una titulación si está matriculado en una asignatura de la titulación
select Asignatura.IdTitulacion
from Asignatura,Alumno,Alumno_Asignatura
where Alumno.DNI="20202020A"
and Alumno.IdAlumno=Alumno_Asignatura.IdAlumno
and Alumno_Asignatura.IdAsignatura=Asignatura.IdAsignatura;
--35-> Nombre de las asignaturas en la que está matriculada Rosa Garcia,mostrando tmb por  cada asignatura el número de matrícula
select Asignatura.Nombre,Alumno_Asignatura.NumeroMatricula
from Asignatura,Alumno_Asignatura,Persona,Alumno
where Persona.Nombre="Rosa"
and Persona.Apellido="Garcia"
and Persona.DNI=Alumno.DNI
and Alumno.IdAlumno=Alumno_Asignatura.IdAlumno
and Alumno_Asignatura.IdAsignatura=Asignatura.IdAsignatura;
--36->Dni de los alumnos a los que imparte clase el profesor Jorge Saenz
select Alumno.DNI
from Alumno,Persona,Profesor,Asignatura,Alumno_Asignatura
where Persona.Nombre="Jorge"
and Persona.Apellido="Saenz"
and Persona.DNI=Profesor.DNI
and Profesor.IdProfesor=Asignatura.IdProfesor
and Asignatura.IdAsignatura=Alumno_Asignatura.IdAsignatura
and Alumno_Asignatura.IdAlumno=Alumno.IdAlumno;
--37->Cuál sería el coste global de cursar la titulación de Matemáticas si el coste de cada asignatura fuera incrementado un 7%?
select sum(Asignatura.CorteBasico*1.07) as CosteBasicoIncrementado
from Asignatura,Titulacion
where Titulacion.Nombre="Matematicas" 
and Titulacion.IdTitulacion=Asignatura.IdTitulacion;
--38->Nombre de las asignaturas que tienen mas creditos que seguridad vial
select Nombre
from Asignatura
where Creditos > 
(select Creditos
from Asignatura
where Nombre="Seguridad vial");
--39->DNI,nombre y apellidos de los alumnos a los que imparte clase el profesor Jorge Saenz
select Persona.DNI,Persona.Nombre,Persona.Apellido
from Alumno,Persona,Alumno_Asignatura,Asignatura,Profesor
where Persona.DNI=Alumno.DNI
and Alumno.IdAlumno=Alumno_Asignatura.IdAlumno
and Alumno_Asignatura.IdAsignatura=Asignatura.IdAsignatura
and Asignatura.IdProfesor=Profesor.IdProfesor;
--40->DNI d los profesores q tmb son alumnos
select Profesor.DNI
from Profesor,Alumno,Persona
where Profesor.DNI=Persona.DNI
and Persona.DNI=Alumno.DNI;
--41->Cuantos alumnos hay matriculados en cada asignatura
select count(alumno.id_alumno)
from asignatura,alumno,alumno_asignatura
where alumno.id_alumno=alumno_asignatura.id_alumno
and alumno_asignatura.id_asignatura=asignatura.id_asignatura
group by alumno.id_alumno;--si quito el group by me suma todos los alumnos matriculados en total
--41b->Como el 41 pero mostrando el nombre de la asignatura
select asignatura.nombre,count(alumno.id_alumno)
from asignatura,alumno,alumno_asignatura
where alumno.id_alumno=alumno_asignatura.id_alumno
and alumno_asignatura.id_asignatura=asignatura.id_asignatura
group by asignatura.nombre;
--42->Cual es el coste basico en cada titulacion?->suma del coste de las asingaturas
select titulacion.nombre,sum(asignatura.coste_basico)
from titulacion,asignatura
where titulacion.id_titulacion=asignatura.id_titulacion
group by titulacion.nombre;
--43->Supongamos que cada matricula adicional supone un 10% del aumento del coste basico, es decir, un 10% en segunda matricula,un 20% en tercera matricula...Mostrar cuanto ha pagado cada alumno en total por su matricula
select persona.nombre,sum(asignatura.coste_basico+alumno_asignatura.numero_matricula*0.1)
from persona,asignatura,alumno_asignatura,alumno
where persona.dni=alumno.dni
and alumno.id_alumno=alumno_asignatura.id_alumno
and alumno_asignatura.id_asignatura=asignatura.id_asignatura
group by persona.nombre;
--44->Coste medio de las asignaturas de cada titulacion para aquellas titulaciones en la que el coste total de la primera matricula sea mayor que 60 euros
select titulacion.nombre,avg(asignatura.coste_basico) as coste_medio
from titulacion,asignatura
where titulacion.id_titulacion=asignatura.id_titulacion
group by titulacion.nombre
having sum(asignatura.coste_basico)>60;
--45->ID de los alumnos matriculados en la asignatura 150212 y 130113 a la vez-->usar el or
--order by nombre having count 2
--AQUÍ ES FÁCIL XQ EL ID_ASIGN Y EL ID_ALUMN SE PUEDEN MIRAR EN ALUMNO_ASIGN->no hace falta poner
--entidad.atributo ya que todos forman parte de alumno_asignatura
select id_alumno
from alumno_asignatura
where id_asignatura="150212" or id_asignatura="130113"
group by id_alumno
having count(id_alumno)=2;
--46->ID de los alumnos matriculados en las de antes en una o en otra, pero no en ambas
select id_alumno
from alumno_asignatura
where id_asignatura="150212" or id_asignatura="130113"
group by id_alumno
having count(id_alumno)=1;
--47->Nombre de las asignaturas de la titulacion 130110 cuyos costes basicos sobrepasen el coste basico promedio por asignatura de esa titulacion
select nombre,coste_basico
from asignatura
where id_titulacion="130110"
and coste_basico>=(select avg(coste_basico)
from asignatura
where id_titulacion="130110");


