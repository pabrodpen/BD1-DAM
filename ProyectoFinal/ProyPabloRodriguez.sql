create database ProyPabloRodriguez;
use ProyPabloRodriguez;

create table Tabla1Cliente(
    codigoCliente int,
    dni varchar(50),
    nombre varchar(100),
    tfno int,
    direccion varchar(100),
    fechaNac date,
    primary key(codigoCliente)
);

create table Tabla2Sucursal(
    numSucursal int,
    direccion varchar(100),
    primary key(numSucursal)
);

create table Tabla4Cuenta(
    numCuenta int,
    saldo float,
    interes float,
    numSucursal int,
    codigoCliente int,
    primary key(numCuenta),
    foreign key(numSucursal) references Tabla2Sucursal(numSucursal),
    foreign key(codigoCliente) references Tabla1Cliente(codigoCliente)
);
alter table Tabla4Cuenta add foreign key(codigoCliente) references Tabla1Cliente(codigoCliente);

create table Tabla3Operacion(
    codigoOperacion int,
    cantidad float,
    tipo varchar(100),
    estado varchar(100),
    canal varchar(100),
    fechaOperacion date,
    numCuenta int,
    primary key(codigoOperacion),
    foreign key(numCuenta) references Tabla4Cuenta(numCuenta)
);




INSERT INTO Tabla1Cliente (codigoCliente, dni, nombre, tfno,direccion, fechaNac)
VALUES
(1, '12345678A', 'Juan Perez', 111111111,'Avenida 123', '1992-04-01'),
(2, '23456789B', 'Maria Garcia', 222222222,'Barriada San Diego 26', '1997-05-15'),
(3, '34567890C', 'Luis Martinez', 333333333,'Paseo de las Deliciasn 45', '1982-02-28'),
(4, '45678901D', 'Ana Rodriguez', 444444444,'Calle Francos 27', '2004-11-09'),
(5, '56789012E', 'Pedro Sanchez', 555555555,'Calle Arfe 54', '1968-08-22'),
(6, '67890123F', 'Laura Gonzalez', 666666666,'Plaza de La Gavidia 2', '1993-12-05'),
(7, '78901234G', 'Carlos Jimenez', 777777777,'Calle Javier Lasso de la Vega 34 8B', '1979-07-18'),
(8, '89012345H', 'Marta Fernandez', 888888888,'Avenida Ramón y Cajal 56 7C', '1958-01-31'),
(9, '90123456I', 'Sara Perez', 999999999,'Avenida de la Barzola', '2000-06-24'),
(10, '01234567J', 'Javier Martin', 123456789,'Calle Feria 23 5D', '1976-09-10'),
(11, '12345678K', 'Lorena Ruiz', 987654321,'Ronda Francisco, 4, Bajo ', '1988-03-03'),
(12, '23456789L', 'Roberto Soto', 135791357,'Plaza Carrión, 7, 0º 4º', '1971-10-17'),
(13, '34567890M', 'Elena Gomez', 246802468,'Praza Sofía, 025, Ático 5º', '2002-07-28'),
(14, '45678901N', 'Hector Flores', 101010101,'Ronda Alex, 3, Bajos', '1994-11-30'),
(15, '56789012O', 'Paula Vega', 202020202,'Passeig Conde, 64, 00º B', '1985-06-13'),
(16, '67890123P', 'David Torres', 303030303,'Camiño Alicea, 7', '1977-12-28'),
(17, '78901234Q', 'Isabel Ramos', 404040404,'Paseo Treviño, 8, 2ºE', '1990-05-21'),
(18, '89012345R', 'Antonio Moreno', 505050505,'Avenida Méndez, 62', '1969-09-01'),
(19, '90123456S', 'Carmen Navarro', 606060606,'Avinguda Reyna, 580, 13ºB', '1975-02-14'),
(20, '01234567T', 'Julia Lopez', 707070707,'Rúa Valencia, 76, Bajo 2º', '1999-08-07');


INSERT INTO Tabla2Sucursal (numSucursal, direccion)
VALUES 
    (1, 'Av. Libertador 123'),
    (2, 'Calle 10 de Octubre 456'),
    (3, 'Calle San Martín 789'),
    (4, 'Av. 9 de Julio 1010'),
    (5, 'Calle Corrientes 2222');


INSERT INTO Tabla3Operacion(codigoOperacion, cantidad, tipo, estado, canal, fechaOperacion, numCuenta)
VALUES 
    (1, 1000.50, 'deposito', 'completada', 'en persona', '2020-01-02', 1001),
    (2, 500.00, 'retiro', 'completada', 'online', '2019-01-03', 1002),
    (3, 250.00, 'pago de facturas', 'completada', 'en persona', '2018-01-05', 1020),
    (4, 750.00, 'transferencia', 'completada', 'online', '2019-01-07', 1003),
    (5, 100.00, 'deposito', 'completada', 'en persona', '2022-01-10', 1004),
    (6, 350.00, 'retiro', 'completada', 'en persona', '2020-01-15', 1005),
    (7, 2000.00, 'transferencia', 'completada', 'online', '2019-02-01', 1006),
    (8, 1250.00, 'pago de facturas', 'completada', 'online', '2023-02-03', 1007),
    (9, 800.00, 'deposito', 'completada', 'en persona', '2022-02-05', 1008),
    (10, 450.00, 'retiro', 'completada', 'online', '2020-02-08', 1009),
    (11, 1500.00, 'transferencia', 'pendiente', 'en persona', '2021-03-10', 1010),
    (12, 700.00, 'pago de facturas', 'completada', 'en persona', '2021-03-15', 1011),
    (13, 900.00, 'deposito', 'completada', 'online', '2021-03-20', 1012),
    (14, 600.00, 'retiro', 'completada', 'online', '2023-03-22', 1013),
    (15, 1750.00, 'transferencia', 'cancelada', 'en persona', '2021-04-02', 1014),
    (16, 300.00, 'pago de facturas', 'completada', 'en persona', '2023-04-10', 1015),
    (17, 1200.00, 'deposito', 'completada', 'en persona', '2022-01-02', 1016),
    (18, 950.00, 'retiro', 'completada', 'online', '2022-01-03', 1017),
    (19, 500.00, 'transferencia', 'pendiente', 'en persona', '2022-01-05', 1018),
    (20, 400.00, 'pago de facturas', 'completada', 'online', '2023-01-08', 1019);


INSERT INTO Tabla4Cuenta (numCuenta, saldo, interes, numSucursal,codigoCliente)
VALUES 
    (1001, 5000.00, 0.03, 1,1),
    (1002, 15000.00, 0.05, 2,2),
    (1003, 8000.00, 0.03, 3,3),
    (1004, 1000.00, 0.01, 4,4),
    (1005, 20000.00, 0.05, 5,5),
    (1006, 2000.00, 0.02, 1,6),
    (1007, 3000.00, 0.03, 2,7),
    (1008, 4000.00, 0.04, 3,8),
    (1009, 25000.00, 0.05, 4,9),
    (1010, 6000.00, 0.03, 5,10),
    (1011, 10000.00, 0.04, 1,11),
    (1012, 500.00, 0.01, 2,12),
    (1013, 12000.00, 0.05, 3,13),
    (1014, 1500.00, 0.02, 4,14),
    (1015, 17000.00, 0.05, 5,15),
    (1016, 8000.00, 0.04, 1,16),
    (1017, 9000.00, 0.03, 2,17),
    (1018, 6000.00, 0.02, 3,18),
    (1019, 15000.00, 0.05, 4,19),
    (1020, 1000.00, 0.01, 5,20);




--los tipos que hay son:depósito,retiro,transferencia o pago de facturas
--los estados que hay son:completada,cancelada o pendiente
--los canales(como se ha podido realizar la operacion) que hay son:online, en persona o por teléfono


set foreign_key_checks=0;
--en lugar de var=selet campo...-->select campo into var
--para quitar el deterministic
SET GLOBAL log_bin_trust_function_creators = 1;

--HITO 2

1)
delimiter //
create function obtCadenaTabla1(cod int)
returns varchar(1000)
begin
declare var varchar(1000);
set var=(select nombre
from Tabla1Cliente 
where codigoCliente=cod);
return var;
end//

delimiter ;
select obtCadenaTabla1 (5);



2)
delimiter //
create procedure sp_InsertarTabla1(in nif varchar(50),in nom varchar(50),in telefono int,in direcc varchar(50),in fecha date)
begin
declare max_cod int;
select max(codigoCliente)+1 into max_cod from Tabla1Cliente;
insert into Tabla1Cliente (codigoCliente,dni,nombre,tfno,direccion,fechaNac)
values (max_cod,nif,nom,telefono,direcc,fecha);
end//
--hacemos que automaticamente el codigo vaya avanzando de 1 en 1

delimiter ;
call sp_InsertarTabla1('08235086K','Irene',123456789,'Plaza ABC','2001-10-29');




delimiter //
create procedure sp_InsertarTabla2(in direcc varchar(50))
begin
declare max_cod int;
select max(numSucursal)+1 into max_cod from Tabla2Sucursal;
insert into Tabla2Sucursal (numSucursal,direccion)
values (max_cod,direcc);
end//

delimiter ;
call sp_InsertarTabla2('Calle 123');



delimiter //
create procedure sp_InsertarTabla3(in cant int, in t varchar(50),in est varchar(50),in can varchar(50),in fecha date,in numC int)
begin
declare max_cod int;
select max(codigoOperacion)+1 into max_cod from Tabla3Operacion;
insert into Tabla3Operacion (codigoOperacion, cantidad, tipo, estado, canal, fechaOperacion, numCuenta)
values (max_cod,cant,t,est,can,fecha,numC);
end//

delimiter ;
call sp_InsertarTabla3(300.00,'transferencia','cancelada','por telefono','2023/01/30',1004);


3)
delimiter //
create function actTabla1(cod int,nif varchar(50),nom varchar(50),telefono int,direcc varchar(50),fecha date)
returns varchar(50)
begin
update Tabla1Cliente
set dni=nif,nombre=nom,tfno=telefono,direccion=direcc,fechaNac=fecha
where cod=codigoCliente;
IF cod>(select max(codigoCliente) from Tabla1Cliente) THEN
return 'El cliente no se ha encontrado';
ELSE
return 'Tabla actualizada';
END IF;
end//

delimiter ;
select actTabla1(24,'456650393F','Guillermo',235987356,'Avenida 456','1995/06/29');





delimiter //
create function actTabla2(numS int,direcc varchar(50))
returns varchar(50)
begin
update Tabla2Sucursal
set direccion=direcc
where numS=numSucursal;
IF numS>(select max(numSucursal) from Tabla2Sucursal) THEN
return 'La sucursal no se ha encontrado';
ELSE
return 'Tabla actualizada';
END IF;
end//

delimiter ;
select actTabla2(6,'Avenida de la Palmera 7');


delimiter //
create function actTabla3(cod int,cant float,t varchar(50),e varchar(50),c varchar(50),fecha date,numC int)
returns varchar(50)
begin
update Tabla3Operacion
set cantidad=cant,tipo=t,estado=e,canal=c,fechaOperacion=fecha,numCuenta=numC
where cod=codigoOperacion;
IF cod>(select max(codigoOperacion) from Tabla3Operacion) THEN
return 'La operación no se ha encontrado';
ELSE
return 'Tabla actualizada';
END IF;
end//

delimiter ;
select actTabla3(17,300.0,'depósito','pendiente','por teléfono','2022-10-23',1001);



3)
create table errores(
    tipo varchar(50) default 'sqlexception',
    descripcion varchar(50) default 'Ha habido un error',
    fecha datetime default now(),
    primary key(tipo)
)engine=innoDB;

delimiter //
create procedure sp_InsertarError()
begin
insert into errores values();
end//

--implementamos el caso de error en cada procedimiento que hemos creado anteriormente
delimiter ;
drop procedure sp_InsertarTabla1;
delimiter //
create procedure sp_InsertarTabla1(in nif varchar(50),in nom varchar(50),in telefono int,in direcc varchar(50),in fecha date)
begin
declare max_cod int;
declare exit handler for sqlexception call sp_InsertarError;
select max(codigoCliente)+1 into max_cod from Tabla1Cliente;
insert into Tabla1Cliente (codigoCliente,dni,nombre,tfno,direccion,fechaNac)
values (max_cod,nif,nom,telefono,direcc,fecha);
end//


delimiter ;
drop procedure sp_InsertarTabla2;
delimiter //
create procedure sp_InsertarTabla2(in direcc varchar(50))
begin
declare max_cod int;
declare exit handler for sqlexception call sp_InsertarError;
select max(numSucursal)+1 into max_cod from Tabla2Sucursal;
insert into Tabla2Sucursal (numSucursal,direccion)
values (max_cod,direcc);
end//

delimiter ;
drop procedure sp_InsertarTabla3;
delimiter //
create procedure sp_InsertarTabla3(in cant int, in t varchar(50),in est varchar(50),in can varchar(50),in fecha date,in numC int)
begin
declare max_cod int;
declare exit handler for sqlexception call sp_InsertarError;
select max(codigoOperacion)+1 into max_cod from Tabla3Operacion;
insert into Tabla3Operacion (codigoOperacion, cantidad, tipo, estado, canal, fechaOperacion, numCuenta)
values (max_cod,cant,t,est,can,fecha,numC);
end//





--3/5
--HITO 4,5,6
4)

drop procedure sp_getCamposTabla1;
delimiter //
create procedure sp_getCamposTabla1(cod int)
begin
declare maxCod int;
set maxCod=(select max(codigoCliente) from Tabla1Cliente);
if cod>maxCod then
select * from Tabla1Cliente;
else
select * from Tabla1Cliente where codigoCliente=cod;
end if;
end//

delimiter ;
call sp_getCamposTabla1(2);
call sp_getCamposTabla1(100);



drop procedure sp_getCamposTabla2;
delimiter //
create procedure sp_getCamposTabla2(cod int)
begin
declare maxCod int;
set maxCod=(select max(numSucursal) from Tabla2Sucursal);
if cod>maxCod then
select * from Tabla2Sucursal;
else
select * from Tabla2Sucursal where numSucursal=cod;
end if;
end//

delimiter ;
call sp_getCamposTabla2(2);
call sp_getCamposTabla2(100);



drop procedure sp_getCamposTabla3;
delimiter //
create procedure sp_getCamposTabla3(cod int)
begin
declare maxCod int;
set maxCod=(select max(codigoOperacion) from Tabla3Operacion);
if cod>maxCod then
select * from Tabla3Operacion;
else
select * from Tabla3Operacion where codigoOperacion=cod;
end if;
end//

delimiter ;
call sp_getCamposTabla3(2);
call sp_getCamposTabla3(100);


drop function borrarRegistroTabla1;
delimiter //
create function borrarRegistroTabla1(cod int)
returns varchar(100)
begin
declare maxCod int;
declare codClienteEnCuenta int;
set codClienteEnCuenta=(select codigoCliente from Tabla4Cuenta where codigoCliente=cod);
set maxCod=(select max(codigoCliente) from Tabla1Cliente);
if cod>maxCod then
return 'No se ha encontrado el registro';
else
    if codClienteEnCuenta is not null then
        update Tabla4Cuenta set codigoCliente=null where codigoCliente=codClienteEnCuenta;
    end if;
delete from Tabla1Cliente where codigoCliente=cod;
return 'Registro borrado';
end if;
end//

delimiter ;
set foreign_key_checks=1;
select borrarRegistroTabla1(10);
select borrarRegistroTabla1(100);



drop function borrarRegistroTabla2;
delimiter //
create function borrarRegistroTabla2(cod int)
returns varchar(100)
begin
declare maxCod int;
declare numSucursalEnCuenta int;
set numSucursalEnCuenta=(select numSucursal from Tabla4Cuenta where numSucursal=cod);
set maxCod=(select max(codigoCliente) from Tabla1Cliente);
if cod>maxCod then
return 'No se ha encontrado el registro';
else
    if numSucursalEnCuenta is not null then
        update Tabla4Cuenta set numSucursal=null where numSucursal=numSucursalEnCuenta;
    end if;
delete from Tabla2Sucursal where numSucursal=cod;
return 'Registro borrado';
end if;
end//

delimiter ;
select borrarRegistroTabla2(2);
select borrarRegistroTabla2(100);



drop function borrarRegistroTabla3;
delimiter //
create function borrarRegistroTabla3(cod int)
returns varchar(100)
begin
declare maxCod int;
set maxCod=(select max(codigoOperacion) from Tabla3Operacion);
if cod>maxCod then
return 'No se ha encontrado el registro';
else
delete from Tabla3Operacion where codigoOperacion=cod;
return 'Registro borrado';
end if;
end//


select borrarRegistroTabla3(2);
select borrarRegistroTabla3(100);


5 y 6)

duqmV-g@Hg4c8Er-->contraseña usuario
eLUSnhQ$B&TzSEr7UfS^-->contraseña proy
1xH#WbI=TSnGUQ/W-->contraseña bd