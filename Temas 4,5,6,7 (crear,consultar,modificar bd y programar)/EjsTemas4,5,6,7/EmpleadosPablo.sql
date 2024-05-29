1)
select concat(nombre,' ',apellido1,' ',if(apellido2 is null,'-',apellido2)) as 'Nombre y apellidos'
from empleado
order by nombre desc,apellido1;
2)
select nombre,apellido1,apellido2
from empleado
where apellido1 like '_AntA%'
or apellido2 like '_AntA%';

3)
select nombre,apellido1,apellido2,nif,cod_depart
from empleado
where cod_depart is not null
and substring(nif,9)='B';

and right(nif,1)='B';
/*o substring(nif,9)='B'*/
/*usar el substring*/


4)
select nombre,apellido1,apellido2,salario_base+(timestampdiff(year,fecha_alta,current_date())div(3))*2000 as salario_total
from empleado;


5)
select empleado.nombre,empleado.apellido1,empleado.apellido2,if(departamento.presupuesto-departamento.gastos<0 or departamento.presupuesto-departamento.gastos is null,0,0.01*(departamento.presupuesto-departamento.gastos)) as plus
from empleado left join departamento
on empleado.cod_depart=departamento.codigo
order by plus;
6)
select nombre,apellido1,apellido2
from empleado
where salario_base>=(select max(salario_base) from empleado);

--o
select nombre,apellido1,apellido2
from empleado
where salario_base in(select max(salario_base) from empleado);

7)

select departamento.nombre,count(empleado.codigo) as 'empleados totales'
from departamento join empleado
on empleado.cod_depart=departamento.codigo
group by departamento.nombre
having count(empleado.codigo)=(select max(total)
from (select departamento.nombre,count(empleado.codigo) as total
from departamento join empleado
on empleado.cod_depart=departamento.codigo
group by departamento.nombre)as empleados_total);


/*correcto*/
select max(numEmpleados) as 'Numero maximo de empleados'from(select count(nombre) as numEmpleados
from empleado
group by cod_depart) as NumTotal;

--con esto tenemos el numero de empleados por codigo de departamento(foreign key)
select count(nombre) as numEmpleados
from empleado
group by cod_depart
--usamos el max 
select max(numEmpleados)
from --el maximo de esa select--->
(select count(nombre) as numEmpleados 
from empleado
group by cod_depart) as NumTotal;



/*EJERCICIOS DE CLASE CON ESTA BASE DE DATOS*/

/*Ejercicios2_Empleados*/
1)
use empleados;
set autocommit=0;
2)
create table empleado(
    codigo int,
    nif varchar(9),
    nombre varchar(30),
    apellido1 varchar(30),
    apellido2 varchar(30),
    cod_depart int,
    fecha_alta date,
    salario_base int,
    primary key(codigo),
    unique key(nif),
    foreign key(cod_depart) references departamento(cod_depart)
)engine=innoDB;

create table empleadobackup(
    codigo int,
    nif varchar(9),
    nombre varchar(30),
    apellido1 varchar(30),
    apellido2 varchar(30),
    cod_depart int,
    fecha_alta date,
    salario_base int,
    primary key(codigo),
    unique key(nif),
    constraint empleado_ibfk_2 foreign key(cod_depart) references departamento(cod_depart)
)engine=innoDB;
/*si intentamos meter la clave foranea normal da este error-->Failed to add the foreign key constraint. Missing column 'cod_depart' for constraint 'empleado_ibfk_2' in the referenced table 'departamento'
asi que hacemos lo del constraint-->PREGUNTAR XQ*/

insert into empleado_backup select * from empleado;

3)
A-
delete from empleado_backup 
where right(left(nif, length(nif)-1), 1) 
in ('0','2','4','6','8');/*REPASAR*/

D-
alter table empleado modify nif varchar(15);/*IMP REPASAR*/

update empleado
set nif=concat(nif,'x');

F-
commit;

Al confirma en la primera terminal se actualiza en la base de datos definitivamente



/*Ejercicios1_Empleados*/

1)
use empleado;
set autocommit=0;
2a)
insert into empleado (codigo,nif,nombre,apellido1,apellido2,fecha_alta,salario_base)
values (14,'99635162B','Pedro Antonio','González','Ruiz','2002-03-29',23000);
commit;

2b)
update empleado
set salario_base=salario_base*1.15
where fecha_alta<'2008-06-01';


/*FUNCIONES*/
create procedure listar_empleados()
    -> begin
    -> select *
    -> from empleado;
    -> end
    -> $$
Query OK, 0 rows affected (0,02 sec)

mysql> delimiter ;
mysql> call listar_empleados;


create procedure listar1empleado(Ncodigo int)
    begin
    select *
    from empleado
    where codigo=Ncodigo;
    end
    $$
    
delimiter ;
call listar1empleado(15)-->sale el empleado con codigo 15
delimiter $$
create procedure salario_empleados(Ncodigo int,out p_nombre varchar(100),out p_salario_base int)
    begin
    select nombre,salario_base into p_nombre,p_salario_base
    from empleado
    where codigo=Ncodigo;
    end
    $$
    
delimiter ;
call salario_empleados(14,@nombre,@salario_base);

select @nombre,@salario_base;

delimiter $$
create procedure mediaMaxMin_empleados(out media float,out max int,out min int)
    begin
    select avg(salario_base),max(salario_base),min(salario_base) into media,max,min
    from empleado;
    end
    $$
    
delimiter ;
call mediaMaxMin_empleados(@media,@max,@min);

select @media as media,@max as maximo,@min as minimo;



/*ejercicio clase*-->6/3*/
delimiter //
create function hello (s char(20))
returns char(50) deterministic
return concat('Hello, ',s,'!');
//
delimiter ;
select hello('world');

/*determinisitc-->siempre va a devolver el mismo dato
//para crear una funcion se tieen que usa al menos 1 de:determinsitic, no sql, reads sql data
*/
SET GLOBAL log_bin_trust_function_creators = 1;-->se pone para que no tenga que poner eso
SHOW CREATE {PROCEDURE|FUNTION} proc_name-->para ver un procedimiento con solo poner su nombre

/*estructura de procedimientos y funciones*/
create --(codigo_empleado)
(return tipo_dto)-->si es funcion
begin
---;
end
//
declare 
--nombre varchar
--despues asigno su valor


--si una variable nos viene como parametro de entrada no hace falta declararla

--set puede caer en el examen
--cuando una variable esta fuera del procedimiento se pone @variable


delimiter //
create function hello (s char(20))
returns char(50)
begin
declare 
auxS varchar(50);
set auxS=concat('Hello, ',s,'!');
return auxS;
end;
//
delimiter ;
select hello('world');

/*Ejercicios3_Empleados*/

1)
set autocommit=0;
2)
--REPASAR
insert into empleado(codigo,nif,nombre,apellido1,apellido2,fecha_alta)
select (select max(codigo) from empleado)+1,'77345687J','Julia','Salas',apellido2,now()
from empleado
where apellido1 = 'Salas';

2)--REPASAR
--apellido que se repita
select apellido1
from empleado
where e2.apellido1!=empleado.apellido1;

--select completa
select *
from empleado--sacamos los empleados con esa condicion
where apellido1 in(select apellido1--el apellido 1 coincida--in es lo mismo que igual pero pudiendo tener varios resultados
from empleado e2--usamos e2 para volver a referenciar a otro empleado de la tabla empleado
where e2.codigo!=empleado.codigo);--que no coincidan los codigos para que no salga el mismo empleado

3)--REPASAR
select * from empleado
where apellido1 in(select apellido1
from empleado e2
where e2.codigo!=empleado.codigo)
and apellido2 in(select apellido2
from empleado e2
where e2.codigo!=empleado.codigo);

4)--REPASAR
--usamos variables auxiliares ue actuaran como variables de empleado(se referencia a si misma)
--tenga el mismo codigo(left join normal para que salga null)
select e1.*, e2.*
from empleado e1 left join empleado e2
on e1.codigo!=e2.codigo and e1.apellido1=e2.apellido1 and e1.apellido2=e2.apellido2;

5)
select e1.*, e2.*,departamento.nombre
from empleado e1 left join empleado e2
on e1.codigo!=e2.codigo and e1.apellido1=e2.apellido1 and e1.apellido2=e2.apellido2
left join departamento
on e2.cod_depart=departamento.codigo; 
/*Ejercicios4_Empleados*/
1)
select empleado.*,departamento.*
from empleado join departamento
on empleado.cod_depart=departamento.codigo;
2)
select empleado.*,departamento.*
from empleado join departamento
on departamento.codigo=empleado.cod_depart
order by departamento.nombre,empleado.apellido1,empleado.apellido2 ,empleado.nombre;
3)--REPASAR

select departamento.codigo,departamento.nombre
from departamento join empleado
on departamento.codigo=empleado.cod_depart
where empleado.cod_depart is not null
group by departamento.codigo;

--OTRA FORMA

--solo quiero una parte de los empleados--left join
select departamento.codigo,departamento.nombre
from empleado left join departamento
on departamento.codigo=empleado.cod_depart
--con esto solo me saldria el codigo y nombre del departammento que tiene cada empleado, asi que agrupamos
--segun el codigo de departamento
group by departamento.codigo;

4)
select departamento.codigo,departamento.nombre,departamento.presupuesto-departamento.gastos as 'valor actual'
from empleado left join departamento
on departamento.codigo=empleado.cod_depart
group by departamento.codigo;

5)
select departamento.nombre
from departamento
where departamento.codigo=(select empleado.cod_depart
from empleado
where empleado.nif like '38382980Mx');--pongo x al final xq en un ejercicio se lo pusimos al nif

--QUITAR LA X DEL NIF USANDO SUBSTRING


6)
select departamento.nombre
from empleado join departamento
on departamento.codigo=empleado.cod_depart
where empleado.nombre like 'Pepe'
and empleado.apellido1 like 'Ruiz'
and empleado.apellido2 like 'Santana';

7)
select *
from empleado
where empleado.cod_depart=(select departamento.codigo
from departamento
where departamento.nombre like 'I+D')
order by apellido1.nombre;

8)
select *
from empleado
where empleado.cod_depart in(select departamento.codigo
from departamento
where departamento.nombre like 'I+D'
or departamento.nombre like 'Sistemas' 
or departamento.nombre like 'Contabilidad'); 
--usamos in en lugar de = xq nos va a dar varios resultados


9)
select empleado.nombre
from empleado
where empleado.cod_depart in(select departamento.codigo
from departamento
where presupuesto not between 100000 and 200000);

10)
select departamento.nombre
from departamento
where departamento.codigo in(select empleado.cod_depart
from empleado
where empleado.apellido2 is null);
--o
select departamento.nombre 
from departamento,empleado
where empleado.apellido2 is null and empleado.cod_depart=departamento.codigo;
11)
select empleado.nombre,departamento.*
from empleado left join departamento
on departamento.codigo=empleado.cod_depart;

12)
select empleado.*
from empleado 
where empleado.cod_depart is null;

13)
select departamento.nombre
from departamento left join empleado
on empleado.cod_depart=departamento.codigo
where empleado.cod_depart is null;
14)
(select empleado.nombre,empleado.apellido1,empleado.apellido2,departamento.nombre
from departamento left join empleado
on empleado.cod_depart=departamento.codigo
order by departamento.nombre)
union
(select empleado.nombre,empleado.apellido1,empleado.apellido2,departamento.nombre
from departamento right join empleado
on empleado.cod_depart=departamento.codigo
order by departamento.nombre);

15)--REPASAR ESTE
--empleados que no tienen ningun departamento
select empleado.nombre
from empleado
where empleado.cod_depart is null;
--departamentos que no tienen ningun empleado asociado
select departamento.nombre
from departamento left join empleado
on empleado.cod_depart=departamento.codigo
where empleado.cod_depart is null;
--todo a la vez
(select empleado.nombre
from empleado
where empleado.cod_depart is null)
union
(select departamento.nombre
from departamento left join empleado
on empleado.cod_depart=departamento.codigo
where empleado.cod_depart is null);





--empleados que no tienen nigun departamento
select empleado.nombre
from empleado left join departamento
on departamento.codigo=empleado.cod_depart
where departamento.codigo is null;

--departamentos que no tienen nigun empleado
select departamento.nombre
from departamento left join empleado
on empleado.cod_depart=departamento.codigo
group by departamento.nombre
having count(empleado.cod_depart)=0;

/*Ejercicios5_Empleados*/
1)
select sum(departamento.presupuesto)
from departamento;
2)
select avg(departamento.presupuesto)
from departamento;
3)
select min(departamento.presupuesto)
from departamento;
4)
select departamento.nombre,departamento.presupuesto
from departamento
where departamento.presupuesto=(select min(departamento.presupuesto)
from departamento);
5)
select max(departamento.presupuesto)
from departamento;
6)
select departamento.nombre,departamento.presupuesto
from departamento
where departamento.presupuesto=
(select max(departamento.presupuesto)
from departamento);

7)
select count(empleado.codigo) as 'numero de empleados'
from empleado;

8)
select count(empleado.codigo) as 'numero de empleados'
from empleado
where apellido2 is not null;

9)
select departamento.nombre,count(empleado.codigo)
from departamento join empleado
on empleado.cod_depart=departamento.codigo
group by departamento.nombre;

10)
select departamento.nombre,count(empleado.codigo)
from departamento join empleado
on empleado.cod_depart=departamento.codigo
group by departamento.nombre
having count(empleado.codigo)>2;

11)
select departamento.nombre,count(*)
from departamento left join empleado
on empleado.cod_depart=departamento.codigo
group by departamento.nombre


12)
select departamento.nombre,count(*)
from departamento join empleado
on empleado.cod_depart=departamento.codigo
where departamento.presupuesto>200000
group by departamento.nombre;--IMP--HAY QUE PONER EL WHERE ANTES DEL GROUP BY


/*Ejercicios7_Empleados*/

delimiter //
create function hello (s char(20))
returns char(50)
begin
declare 
auxS varchar(50);
set auxS=concat('Hello, ',s,'!');
return auxS;
end;
//
delimiter ;
select hello('world');

1)
delimiter //
create procedure sp_GetAllEmpleados()
begin
select *
from empleado;
end
//
delimiter ;
call sp_GetAllEmpleados;


2)
delimiter //
create procedure sp_GetNombreEmpleados(Ncodigo int )
begin
select nombre
from empleado
where codigo=Ncodigo;
end
//
delimiter ;
call sp_GetNombreEmpleados(3);
--se podria haber puesto on out pnombre y hacer set pnombre=select ...\o select nombre into pnombre...

3)
drop procedure sp_MaxMinMedia;
--VER DISTINCT
delimiter //
create procedure sp_MaxMinMedia()
begin
select max(salario_base),min(salario_base),avg(salario_base)
from empleado;
end
//
delimiter ;

call sp_MaxMinMedia;

4)

delimiter //
drop procedure sp_getDptoByCodEmp//
create procedure sp_getDptoByCodEmp(Ncodigo int)
begin
select departamento.codigo
from departamento join empleado
on empleado.cod_depart=departamento.codigo
where empleado.codigo=Ncodigo;
end
//
delimiter ;
call sp_getDptoByCodEmp(3);


5)
delimiter //
create procedure sp_getDptoNameByCodEmp(in Ncodigo int, out nombre_dept varchar(20))
begin
set nombre_dept=(select departamento.nombre
from empleado join departamento
on departamento.codigo=empleado.cod_depart
where empleado.codigo=Ncodigo);
end
//
drop procedure sp_getDptoNameByCodEmp;
delimiter ;
call sp_getDptoNameByCodEmp(10,@nombre);
select @nombre;

6)--REPASAR
drop procedure sp_GetNombreEmpleados//
delimiter //
create procedure sp_GetNombreEmpleados(in Ncodigo int, out variable varchar(50))
begin
select nombre into variable
from empleado
where empleado.codigo=Ncodigo;
set variable=if(variable is null,'Usuario sin identificar',variable);
end
//
delimiter ;
call sp_GetNombreEmpleados(20,@nombre);
select @nombre;

delimiter ;
call sp_GetNombreEmpleados(20,@variable);

7)
drop procedure sp_UpdateSalarioEmp;
delimiter //
create procedure sp_UpdateSalarioEmp(in Ncodigo int,in SalarioAct int)
begin
update empleado
set salario_base=salario_base+SalarioAct
where empleado.codigo=Ncodigo;
end
//

delimiter ;
call sp_UpdateSalarioEmp(3,10000);



/*examen 2 */

1)
--no hace falta join-->solo usamos la tabla empleado aunque sea para poblar empleadoBackup
insert into empleadoBackup(codigo,nif,nombre,apellido1,apellido2,cod_depart,fecha_alta,salario_base)
select codigo,nif,nombre,apellido1,apellido2,cod_depart,fecha_alta,(select avg(salario_base) from empleado where empleado.cod_depart=4 or empleado.cod_depart=5)
from empleado
where substring(apellido1,2,1)='u';


INSERT INTO empleadoBackup (codigo,nif ,nombre, apellido1, apellido2, salario_base, cod_depart, fecha_alta) VALUES(3, '16970642B', 'Adolfo', 'Rubio', 'Flores', 33767, 3, '2007-11-30');
INSERT INTO empleadoBackup (codigo,nif ,nombre, apellido1, apellido2, salario_base, cod_depart, fecha_alta) VALUES(4, '77705545E', 'Adrián', 'Suárez', NULL, 33767, 4, '2007-06-07');
INSERT INTO empleadoBackup (codigo,nif ,nombre, apellido1, apellido2, salario_base, cod_depart, fecha_alta) VALUES(7, '80576669X', 'Pilar', 'Ruiz', NULL, 33767, 2, '2006-05-01');
INSERT INTO empleadoBackup (codigo,nif ,nombre, apellido1, apellido2, salario_base, cod_depart, fecha_alta) VALUES(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 33767, 3, '2000-06-12');
2)
--REPASAR
(select empleado.codigo,empleado.nif,empleado.nombre,empleado.cod_depart,empleado.salario_base
from empleado right join empleadoBackup
on empleadoBackup.codigo=empleado.codigo)
union
(select empleadoBackup.codigo,empleadoBackup.nif,empleadoBackup.nombre,empleadoBackup.cod_depart,empleadoBackup.salario_base
from empleado left join empleadoBackup
on empleadoBackup.codigo=empleado.codigo);

3)
update empleadoBackup,empleado
set empleadoBackup.salario_base=empleadoBackup.salario_base+ 0.1*(select empleado.salario_base from empleado where empleadoBackup.codigo=empleado.codigo);


4)
select empleado.codigo,empleado.nombre,empleado.cod_depart
from empleado
where empleado.cod_depart in (select departamento.codigo
from departamento join empleado
on empleado.cod_depart=departamento.codigo
where departamento.codigo!=3
and departamento.codigo!=5
and departamento.codigo is not null
group by departamento.codigo
having count(empleado.codigo)>1);


5)

select empleado.codigo as 'Cod.Empleado',empleado.nombre as 'Nombre Empleado',departamento.codigo as 'Cod.Depart',departamento.nombre as 'Nombre Depart.',provincia.codigo as 'Cod.Provincia',provincia.nombre as 'Nombre Provincia'
from provincia right join departamento
on departamento.codProvincia=provincia.codigo
right join empleado
on departamento.codigo=empleado.cod_depart
where empleado.cod_depart in(select departamento.codigo
from departamento
where departamento.codigo in(select departamento.codigo from departamento join provincia on provincia.codigo=departamento.codProvincia where provincia.nombre like 'Granada'
)or departamento.nombre like 'Recursos Humanos')
order by departamento.nombre desc,empleado.nombre;


6)
update empleado
set salario_base=salario_base+100,nif=replace(nif,'8','X')
where (empleado.cod_depart=1
or empleado.cod_depart is null)
and salario_base between 23000 and 30000;


7)
a)Una persona realice un cambio en la base de datos y otra persona a la vez este haciendo una transaccion en ella 
y no vea los cambios que se estan haciendo
b)
el commit para poder confirmar las transaccion o rollback para volver atras



--PROCEDIMIENTOS 16/3
delimiter //
create procedure sp_Suma(in n1 int,in n2 int,out var int)
begin
select sum(n1+n2) into var;
end
//

delimiter ;
call sp_Suma(3,10000,@var);
select @var;


delimiter //
create procedure sp_Suma2(in n3 int,out var2 int)
begin
call sp_Suma(2,3,@var);
select sum(n3+@var);
end
//

delimiter ;
call sp_Suma2(3,@var2);


--bucle

delimiter //
create procedure sp_SumaBucle(out var int)
begin
label:LOOP
select sum(1,@var);
if var=100 then
leave label;
END IF;
END LOOP
end
//

delimiter;
call sp_SumaBucle(@var);
select @var;




--FUNCIONES 27/3
DROP DATABASE IF EXISTS test;
Query OK, 1 row affected (0,04 sec)

mysql> CREATE DATABASE test;
Query OK, 1 row affected (0,00 sec)

mysql> USE test;
Database changed
mysql> CREATE TABLE test.t (s1 INT, PRIMARY KEY (s1));
Query OK, 0 rows affected (0,04 sec)

mysql> DELIMITER //
mysql> CREATE PROCEDURE handlerdemo ()
    -> BEGIN
    ->   DECLARE EXIT HANDLER FOR SQLEXCEPTION SET @x = 1;
    ->   SET @x = 1;
    ->   INSERT INTO test.t VALUES (1);
    ->   SET @x = 2;
    ->   INSERT INTO test.t VALUES (1);
    ->   SET @x = 3;
    -> END
    -> //
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> CALL handlerdemo();
Query OK, 0 rows affected (0,01 sec)

mysql> SELECT @x;
--SALE 1


--CAMBIAMOS LOS VALORES INSERTADOS
DROP DATABASE IF EXISTS test;
Query OK, 1 row affected (0,04 sec)

mysql> CREATE DATABASE test;
Query OK, 1 row affected (0,01 sec)

mysql> USE test;
Database changed
mysql> CREATE TABLE test.t (s1 INT, PRIMARY KEY (s1));
Query OK, 0 rows affected (0,05 sec)

mysql> DELIMITER //
mysql> CREATE PROCEDURE handlerdemo ()
    -> BEGIN
    ->   DECLARE EXIT HANDLER FOR SQLEXCEPTION SET @x = 1;
    ->   SET @x = 1;
    ->   INSERT INTO test.t VALUES (4);
    ->   SET @x = 2;
    ->   INSERT INTO test.t VALUES (6);
    ->   SET @x = 3;
    -> END
    -> //
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> CALL handlerdemo();
Query OK, 0 rows affected (0,02 sec)

mysql> SELECT @x;
--SALE 3

--CAMBIAMOS EL EXIT POR EL CONTINUE
DELIMITER //
mysql> CREATE PROCEDURE handlerdemo ()
    -> BEGIN
    ->   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET @x = 1;
    ->   SET @x = 1;
    ->   INSERT INTO test.t VALUES (4);
    ->   SET @x = 2;
    ->   INSERT INTO test.t VALUES (6);
    ->   SET @x = 3;
    -> END
    -> //
Query OK, 0 rows affected (0,01 sec)

mysql> DELIMITER ;
mysql> CALL handlerdemo();
Query OK, 0 rows affected (0,01 sec)

--SALE 3

--29/3

--EJERCICIOS 1 GENERAL
4)
delimiter //
create procedure suma(out a)
begin
LBL:LOOP
    if a<100 then a=a+1
    else leave LBL
    end loop;
    select a;
    end 
    //
    set @num=10
    call sumar(@num)
    select @num;

5)
create function ...(n int)
returns int
begin
declare contador int;
set contador=n-1;
while contador>1 Do
set n=n*contador;
set contador=contador-1;
end while;
return n;
end 
//
select ... (n);




--30/3-->cursores
--DECLARE VARIABLES
--DECLARE cursores
--DECLARE HANDLER


--open miCursor;
--LOOP
--FETCH miCursor into v1,v2;
--end loop;

--10/4
--rellenar empleadoBackup con cursores
drop procedure rellenaEmpleados;
delimiter //
create procedure rellenaEmpleados()
begin
declare flag boolean default FALSE;
declare nif,nombre,apellido1,apellido2 varchar(100);
declare codigo,cod_depart,salario_base int;
declare fecha_alta date;
declare cur1 cursor for select * from empleado;
declare continue handler for not found set flag = true;

open cur1;
cur_loop:LOOP
    fetch cur1 into nif,nombre,apellido1,apellido2.codigo,cod_depart,salario_base,fecha_alta;
    IF flag THEN
    LEAVE cursor_loop;
    END IF;
    insert into empleadoBackup
    values(codigo,nif,nombre,apellido1,apellido2,cod_depart,fecha_alta,salario_base);
END LOOP;

close cur1;
END//
delimiter ;
call rellenaEmpleados();



cur_loop:LOOP--while flag=false




--13/4

--EJERCICIO1GENERAL

--para quitar el determimnstic-->SET GLOBAL log_bin_trust_function_creators = 1;


1)


drop function mayorQueCero;
delimiter //
create function mayorQueCero (n int)
returns varchar(50)
BEGIN
IF n>0 THEN
return concat(n,' es mayor que 0');
else
return concat(n,' es menor o igual que 0');
END IF;
END//
delimiter ;

select mayorQueCero(-1);

--SET-->ASIGNAR UN VALOR A UNA VARIABLE DELCARADA ANTERIORMENTE
2)
drop function tipoSueldo;
delimiter //
create function tipoSueldo(sueldo float)
returns varchar(50)
BEGIN
DECLARE respuesta varchar(50);
IF sueldo>2000 THEN
SET respuesta='Tu sueldo es alto';
ELSEIF sueldo>1000 AND sueldo<=2000 THEN
SET respuesta='Tu sueldo es medio';
ELSE
SET respuesta='Tu sueldo es bajo';
END IF;
return respuesta;
END//

delimiter ;
select tipoSueldo(1250.25);
select tipoSueldo(999.99);
select tipoSueldo(2000.01);


3)

delimiter //
create procedure sp_Suma2Enteros(in n1 int, in n2 int, out resultado int)
begin
set resultado=n1+n2;
end//

delimiter ;

call sp_Suma2Enteros(2,3,@variable);
select @variable;


4)

delimiter //
create procedure sp_sumaHasta100(in n int)
begin
ins_loop:loop
IF n=100 THEN
leave ins_loop;
end if;
set n=n+1;
end loop;
select n;--para que me muestre el 100
end//


5)
--IMP!!
--el substring es (cadena,inicio,longitud) o (cadena,inicio)-->devuelve la subcadena
--longitud 4:desde el principio-->-4 si es dede el final
--el instr es (cadena,subcadena) y devuelve su pos
drop function subcadena;
delimiter //
create function subcadena(cadena varchar(50), letra char)
returns varchar(50)
begin
declare var varchar(50);
IF instr(cadena,letra)>0 THEN 
set var= substring(cadena,instr(cadena,letra));
else
set var= 'No encontrada';
end if;
return var;
end//

delimiter ;
select subcadena('Hola mundo','u');



--PRACTICA EVALUABLE 1

create database PracticaEvaluable1;
use PracticaEvaluable1;

create table jugador(
    turno int,
    nombre varchar(20),
    fallos int default 0,
    primary key(turno)
);

create table partida(
    num_partida int,
    palabra varchar(40),
    letrasFalladas varchar(20),
    letrasAcertadas varchar(20),
    palabraOculta varchar(40) default '',
    turno int,
    primary key(num_partida),
    foreign key(turno) references jugador(turno)
);




drop procedure sp_consultarPartida;
delimiter //
create procedure sp_consultarPartida()
begin
select palabraOculta as 'Palabra' from partida where num_partida=1;
select letrasFalladas as 'Letras falladas' from partida where num_partida=1;
select turno as 'Turno' from partida where num_partida=1;
select concat(turno,'-',nombre,'-',fallos) as 'Jugadores(turnos y número de fallos)' from jugador;
end//

delimiter ;
call sp_consultarPartida();

/*para poner la palabra inicial con guiiones
hay que hacer 3 funciones
1 que coja la primera letra
otra que coja la longitud de la palabra
y otra que ponga tantos guiones como longitud de la palabra -1
lo junto todo con un concat y hago la variable palabraOculta*/



--AL LLAMAR A LAS FUNCIONES DENTRO DE OTRAS NO HACE FALTA PONER EL TIPO DE DATO
--SIEMPRE TODOS LOS DECLARE VAN DESPUES DEL BEGIN(NO PUEDE HABER DECLARE,DESPUES CUERPO DE LA FUNCION Y OTRO DECLARE)

drop function ponerGuiones;
delimiter //
create function ponerGuiones()
returns varchar(40)
begin
declare palabraConGuiones varchar(40);
declare p varchar(40);
select palabra into p from partida;
set palabraConGuiones=replace(p,substring(p,2,length(p)),repeat('-',length(p)-1));
update partida set palabraOculta=palabraConGuiones;
return palabraConGuiones;
end//

delimiter ;
select ponerGuiones();

--IMP -->PONER DOS COMILLAS EN LETRASFALLADAS, YA QUE SI LO DEJO VACIO SE PONE NULL
--Y AL INSERTAR LETRAS EN LETRASFALLADAS DA ERROR
drop procedure sp_altaPartida;
delimiter //
create procedure sp_altaPartida(pal varchar(40))
begin
    declare max_cod int;
    declare num int;
    declare turMin int;
    set turMin=(select min(turno) from jugador); 
    set num=(select num_partida from partida);
    IF num is null THEN
        set max_cod=1;
    ELSE
        set max_cod=(select max(num_partida)+1 from jugador);
    END IF;
    insert into partida(num_partida, palabra, palabraOculta,turno, letrasFalladas)
    values(max_cod, pal, ponerGuiones(), turMin, '');
end//


delimiter ;
call sp_altaPartida('estuche');



delimiter //
create procedure sp_altaJugador(nom varchar(40))
begin
declare maxturno int;
declare t int;
select turno from jugador into t;
IF t is null THEN
set maxturno=1;
ELSE
select max(turno)+1 into maxturno from jugador;
END IF;
insert into jugador (nombre,turno) values (nom,maxturno);
end
//
delimiter ;
call sp_altaJugador('Pablo');
call sp_altaJugador('Manuel');


delimiter //
create procedure sp_resetearPartida()
begin
delete from Partida;
delete from Jugador;
end//

delimiter;
call sp_resetearPartida();
--HAY QUE ESPECIFICAR EN TODOS LOS SELECT Y SET(LOS QUE INCLUYA INFO DE LA TABLA PARTIDA)  FROM PARTIDA WHERE NUM_PARTIDA=1
--(SOLO EL WHERE EN LOS UPDATE)
--AL ACTUALIZAR AUXFALLADAS HAY QUE DECIR DE DONDE VIENE EL CAMPO LETRASFALLADAS(PARTIDA.LETRASFALLADAS)

















drop procedure sp_darLetra;
DELIMITER //
CREATE PROCEDURE sp_darLetra(letra VARCHAR(1))
BEGIN
DECLARE pos INT;
DECLARE auxFalladas VARCHAR(40);
DECLARE pal VARCHAR(40);
DECLARE oculta VARCHAR(40);
set pal=(SELECT palabra FROM partida WHERE num_partida = 1);
set oculta=(SELECT palabraOculta FROM partida WHERE num_partida = 1);
SET pos = INSTR(pal, letra);
IF pos > 0 THEN
UPDATE partida SET letrasAcertadas = letra WHERE num_partida = 1;
UPDATE partida SET palabraOculta = concat(substring(oculta,1,pos-1),letra,substring(oculta,pos+1));
ELSE
SET pos = (SELECT INSTR(palabraOculta, letra) FROM partida WHERE num_partida = 1);
SET auxFalladas = CONCAT((SELECT letrasFalladas FROM partida WHERE num_partida = 1),' ', letra);
UPDATE partida SET letrasFalladas = auxFalladas WHERE num_partida = 1;
END IF;
END//

delimiter ;
call sp_darLetra('r');
call sp_darLetra('a');
call sp_darLetra('t');








--EVALUACION
--2 EXAMENES(50 Y 50)
--EL SEGUNDO DE PROCED ALMACE, TEORIA BBDD O-R, PHP
--10% DE LA P.E 70% AHORCADO Y 30 INTERFZ PHP
--20% PROYECTO




--3/5
--EJERCICIOS 2 GENERAL

1)
create database Test;
use Test;

create table Numeros(
    num int,
    espar boolean,
    primary key(num)
);

delimiter //
create procedure mostrarNumeros(n1 int,n2 int)
begin
declare valor int;
set valor=n1;
while(valor<=n2) DO
insert into Numeros values(valor,tipoNumero(valor));
set valor=valor+1;
end while;
end//

delimiter ;
call mostrarNumeros(3,8);



delimiter //
create function tipoNumero(n int)
returns int
if n%2=0 then
return 1;
else
return 0;
end if;
end//


2)
create table NumerosCopy(
    num int,
    espar boolean,
    primary key(num)
);

drop procedure sp_cursorCopia;
delimiter //
create procedure sp_cursorCopia()
begin
declare flag boolean default false;
declare n int;
declare e boolean;
declare cur1 cursor for select num from Numeros;
declare cur2 cursor for select espar from Numeros;
open cur1;
open cur2;
read_loop:LOOP
fetch cur1 into n;
fetch cur2 into e;
if flag then
leave read_loop;
end if;
insert into NumerosCopy (num, espar) values (n, e);
end loop;
close cur1;
close cur2;
end//

--declaramos una flag para cuando los cusores hayan recorrido todas las columnas
--declaramos los 2 variables aux de num y espar para recoger los registros de las columnas medianmte los cursores
--y para despues insertar los valores
--IMP-->NO SE PUEDE DECLARAR VARIABLES DESPUES DE DECLARAR CURSORES
delimiter ;
call sp_cursorCopia;

3)

--como el cursor recoge todos los valores y los inserta, al modificar para que añada valores superiores
--sigue recogiendo los valores anteriores, por lo que va a saltar errores ya que ya hay valores repetidos
--hay que modificar el cursor para que no salte este error(que el cursor solo coja los valores superiores) 

--hacemos que inserte 3 numeros siguientes que el limite superior
drop procedure mostrarNumeros;
delimiter //
create procedure mostrarNumeros(n1 int,n2 int)
begin
declare valor int;
set valor=n2+1;
while(valor<=n2+3) DO
insert into Numeros values(valor,tipoNumero(valor));
set valor=valor+1;
end while;
end//

delimiter ;
call mostrarNumeros(3,8);




--4/5
--PRIMER EXAMEN TERCER TIMESTRE

1)
-->falta que cambie el flag a true con un declare handler set flag=true para que salga del bucle

drop function GetPedidos;
delimiter //
create function GetPedidos(fecha date)
returns varchar(100)
begin
declare cod int;
declare cadena varchar(100);
declare flag boolean default false;
declare cur1 cursor for select codigoPedido from pedido where fechaPedido<fecha;
declare continue handler for sqlexception set flag=true;-->si hay error (ya no hay mas lineas que recorrer,cambia la flag a true y sale del loop)
set cadena='';
open cur1;
read_loop:LOOP
if flag then
leave read_loop;
set cadena=(select concat(cadena,'No hay más'));
end if;
fetch cur1 into codigoPedido;
set cadena=(select concat(cadena,codigoPedido,','));
end LOOP;
close cur1;
return cadena;
end//

delimiter ;
select GetPedidos('2008-01-01');


 



4)

-->era 1 solo update-->update producto set precioventa=if(stock<=50,precioventa*1.1,precioventa*0.9);
drop procedure UpdatePrecioProduct;
delimiter //
create procedure UpdatePrecioProduct(c varchar(15))
begin
declare stock int;
declare hora int;
set autocommit=1;
set stock=(select cantidad_en_stock from producto where codigo_producto=c);
set hora=(select substring(now(),19,1));
if stock<=50 then
update producto set precio_venta=precio_venta+precio_venta*0.1;
else
update producto set precio_venta=precio_venta-precio_venta*0.1;
end if;
if hora%2=0 then
commit;
select concat('Tiempo:',hora,'.Acción realizada');
else
rollback;
select concat('Tiempo:',hora,'.Acción no realizada');
end if;
end//


delimiter ;
call UpdatePrecioProduct(21636);

--el substring es (cadena,inicio,longitud) o (cadena,inicio)-->devuelve la subcadena
--longitud 4:desde el principio-->-4 si es dede el final
--el instr es (cadena,subcadena) y devuelve su pos

3)

create function GetDifCredito(c int)
returns varchar(100)
begin
declare cadena varchar(1000);
declare cod int;
declare codMax int;
set codMax=(select max(codigo_cliente) from cliente);
set cod=c;
set cadena='';
while cod<=codMax DO
set cadena=(select concat(cadena,(select nombre_cliente from cliente where codigo_cliente=cod),'respecto a '
,select nombre_cliente from cliente where codigo_cliente=cod),'tiene una diferencia de',
((select cliente.limite_credito from cliente where codigo_cliente=cod)-(select cliente.limite_credito from cliente where codigo_cliente=cod))'\\');
end while;
return cadena;
end//

delimiter ;
select GetDifCredito(1);
select GetDifCredito(5);

2)
-->falta lo del asterisco
drop procedure SetGama;

delimiter //
create procedure SetGama(g varchar(50),d text)
begin
declare gam varchar(50);
declare descripcion text;
declare exit handler for sqlexception select 'Error en clave única';
insert into gama_producto(gama,descripcion_texto) values(g,d);
select 'Insertado con éxito';
end//


delimiter ;
call SetGama('Hola','djqcjiq2ejijc');

call SetGama('Frutales','ncowenccne');


--EJERCICIO 1 POSTGRESS
--row=constructor?
insert into Alumnos_t (n_Alumno,nombre,curso)
values ('1','Pepe',
        ROW(101,'1SMR',null))



--EXAMEN 2 CONTROL3

1)
delimiter ;
drop procedure sp_corregir_fecha;

delimiter //
create procedure sp_corregir_fecha()
begin
declare f date;
declare flag1 boolean default false;
declare flag2 boolean default false;
declare cur1 cursor for select fecha_alta from empleado;
declare continue handler for sqlexception set flag1=true;
declare continue handler for 22007 set flag2=true;
open cur1;
read_loop:LOOP
if flag1 THEN
leave read_loop;
end if;
fetch cur1 into f;
if flag2 then
update empleado set error_fecha=f;
end if;
update empleado set fecha_alta2=f;
end loop;
close cur1;
end//

delimiter ;
call sp_corregir_fecha();




2)

create ciudadano as(
    dni varchar(30) PRIMARY KEY,
    nombre varchar(30),
    apellido varchar(30),
    telefonos text[]
);
create table vivienda (
codCatastro varchar(30) PRIMARY KEY,
direccion varchar(100),
conjHabitantes ciudadano[]
);






INSERT INTO vivienda values ('vivienda1', 'AX000001', 'Calle Amapola 5'
 ,array[ROW('78929823S', 'Ramón Higueras', '{"635908678", "666000333"}'),
    ROW('89723897G', 'José Rubio', null)] );

 

INSERT INTO vivienda values ('vivienda2', 'BZ000001', 'Calle Tulipán 7'
 , ROW(null, null, null));




3)








delimiter ;
drop procedure sp_corregir_fecha;

delimiter //
create procedure sp_corregir_fecha()
begin
declare f date;
declare flag boolean default false;
declare fecha_alta date;
declare cur1 cursor for select fecha_alta from empleado;
declare continue handler for sqlexception set flag=true;
declare continue handler for 22007 update empleado set error_fecha=f where fecha_alta=f;
open cur1;
read_loop:LOOP
if flag THEN
leave read_loop;
end if;
fetch cur1 into f;
update empleado set fecha_alta2=f where fecha_alta=f;
close cur1;
end//

delimiter ;
call sp_corregir_fecha();





drop function GetPedidos;
delimiter //
create function GetPedidos(fecha date)
returns varchar(100)
begin
declare cod int;
declare cadena varchar(100);
declare flag boolean default false;
declare cur1 cursor for select codigoPedido from pedido where fechaPedido<fecha;
declare continue handler for sqlexception set flag=true;-->si hay error (ya no hay mas lineas que recorrer,cambia la flag a true y sale del loop)
set cadena='';
open cur1;
read_loop:LOOP
if flag then
leave read_loop;
set cadena=(select concat(cadena,'No hay más'));
end if;
fetch cur1 into codigoPedido;
set cadena=(select concat(cadena,codigoPedido,','));
end LOOP;
close cur1;
return cadena;
end//