1)
insert into Dept(Dept_No,DNombre,Loc) values (60,'Informática','Madrid');

insert into Emp(Emp_No, Apellido, Oficio, Dir, Fecha_Alt, Salario, Comision, Dept_No)
values(7895,'Escriche','programador',0,now(),70000,0,60);
2)
insert into Dept(Dept_No,DNombre,Loc) values (70,'Informática','Fuenlabrada');
3)
update Dept
set Loc='Lérida'
where DNombre='VENTAS';
4)
insert into Emp(Emp_No, Apellido, Fecha_Alt, Salario, Comision, Emp.Dept_No) 
select 7500,'Romeral',now(),80000,15,Emp.Dept_No
from Emp join Dept
on Emp.Dept_No=Dept.Dept_No
where DNombre='VENTAS';

5)
update Emp
set Comision=Comision+0.1*Salario;
6)
update Plantilla
set Salario=Salario+0.05*Salario
where T='N';
7)
update Emp
set Emp.Salario=Emp.Salario+5000
where Emp.Dept_No=(select Dept.Dept_No
from Dept
where Dept.DNombre like 'VENTAS');
8)
update Hospital
set Num_Cama=Num_Cama-100
where Nombre like 'San Carlos';
9)
create table Mujeres(
   Inscripcion int,
   Apellido varchar(50),
   Direccion varchar(50),
   Fecha_Nac varchar(50),
   NSS int,
   primary key(Inscripcion)
)engine=innoDB;
insert into Mujeres(Inscripcion,Apellido,Direccion,Fecha_Nac,NSS)
select Inscripcion,Apellido,Direccion,Fecha_Nac,NSS
from Enfermo
where S like 'F';
10)
create table Empleados(
   Emp_No INT PRIMARY KEY,
   Apellido VARCHAR(50) ,
   Oficio VARCHAR(50) ,
   Dir INT,
   Fecha_Alt    DATETIME,
   Salario NUMERIC(9,2) ,
   Comision NUMERIC(9,2) ,
   Dept_No INT,               
   FOREIGN KEY (Dept_No) REFERENCES Dept(Dept_No)
) engine = innodb;


insert into Empleados
select *
from Emp;
11)
update Empleados
set Salario=Salario+1225000,Comision=Comision+1225000
from Empleados
where Fecha_Alt  > '2022-12-31';
12)
delete from Enfermo
where Inscripcion=64823;
13)
delete from Empleados
where Fecha_Alt between '1980-01-01' and '1982-12-31';


Ejercicios1Empleados

1)
set autocommit=0;
2)
start transaction;
/*insert into Emp(Emp_No,Apellido,Oficio,Dir,Fecha_Alt,Salario,Comision,Dept_No)*/
insert into Emp(Emp_No,Apellido,Fecha_Alt,Salario,)
values(null,'González','2002-03-29',23000);