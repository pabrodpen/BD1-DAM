/*BUSCAR EN INTERNET CUANDO SE HARIA UNA TABLA(CLIENTE-LIBRO) , ES DECIR, UNA TABLA DE UNA RELACION*/
create database BibliotecaPablo;
use BibliotecaPablo;
create table clientes(
    codigo_cliente int,
    nombre_cliente varchar(30),
    primary key(codigo_cliente)
)engine=innoDB;

insert into clientes value(1111111,'Alejandro Mendez Mendez');
insert into clientes value(222222,'Arnulfo Carrera García');
insert into clientes value(333333,'Bernardo López Fernandez');
insert into clientes value(444444,'Carlos Cetino Ruiz');
insert into clientes value(555555,'Carlos Crispín Aliñado Asturias ');
insert into clientes value(666666,'César Augusto Noriega Morales');
insert into clientes value(777777,'Edgar Raúl Culajay');
insert into clientes value(888888,'Eliza Pirír Sabán');
insert into clientes value(999999,'Fermina Chajón Soto');


create table libros(
    codigo_libro int,
    nombre_libro varchar(30),
    autor varchar(30),
    primary key(codigo_libro)
)engine=innoDB;

insert into libros (codigo_libro,nombre_libro,autor) value(1,'Historia de dos ciudades');
insert into libros value(2,'El Señor de los Anillos','J. R. R. Tolkien');
insert into libros value(3,'El Principito','Antoine de Saint Exupery');
insert into libros value(4,'El Hobbit','J. R. R. Tolkien');
insert into libros value(5,'Sueño en el pabellón rojo','Cao Xueqi');
insert into libros value(6,'Triple representatividad','Jiang Zeming');
insert into libros value(7,'Diez negritos','Agatha Christie');
insert into libros value(8,'El león, la bruja y el armario','C. S. Lewis');
insert into libros value(9,'Ella','Henry Rider Haggard');
insert into libros value(10,'El código Da Vinci','Dan Brown');

create table prestamos(
    codigo_cliente int,
    codigo_libro int,
    primary key(codigo_cliente,codigo_libro),
    foreign key(codigo_cliente) references clientes(codigo_cliente),
    foreign key(codigo_libro) references libros(codigo_libro)
)engine=innoDB;


insert into prestamos value(1111111,1);
insert into prestamos value(444444,3);
insert into prestamos value(777777,7);
insert into prestamos value(777777,9);
insert into prestamos value(999999,10);

/*Consultas*/
/*Obtener los clientes con más de un libro prestado*/-->PROBADO
select clientes.nombre_cliente,count(libros.codigo_libro) as numero_libros_prestados
from clientes,libros,libros_cliente
where libros.codigo_libro=libros_cliente.codigo_libro
and libros_cliente.codigo_cliente=clientes.codigo_cliente
group by clientes.nombre_cliente
having count(libros.codigo_libro)>=2;


/*Obtener los libros que tiene prestados el cliente anterior sin usar ninguna referencia de este*/-->PROBADO
select libros.nombre_libro
from libros,libros_cliente,clientes
where libros.codigo_libro=libros_cliente.codigo_libro
and libros_cliente.codigo_cliente=clientes.codigo_cliente
and clientes.codigo_cliente=(select clientes.codigo_cliente
from clientes,libros,libros_cliente
where libros.codigo_libro=libros_cliente.codigo_libro
and libros_cliente.codigo_cliente=clientes.codigo_cliente
group by clientes.codigo_cliente
having count(libros.codigo_libro)>=2);
/*Lo mismo pero mostrando en cada nombre del libro el que lo tiene prestado*/-->PROBADO
select libros.nombre_libro,clientes.nombre_cliente
from libros,libros_cliente,clientes
where libros.codigo_libro=libros_cliente.codigo_libro
and libros_cliente.codigo_cliente=clientes.codigo_cliente
and clientes.codigo_cliente=(select clientes.codigo_cliente
from clientes,libros,libros_cliente
where libros.codigo_libro=libros_cliente.codigo_libro
and libros_cliente.codigo_cliente=clientes.codigo_cliente
group by clientes.codigo_cliente
having count(libros.codigo_libro)>=2);


/*Lo mismo pero con el maximo de libros*/
select libros.nombre_libro,clientes.nombre_cliente
from libros,libros_cliente,clientes
where libros.codigo_libro=libros_cliente.codigo_libro
and libros_cliente.codigo_cliente=clientes.codigo_cliente
and clientes.codigo_cliente=(select clientes.codigo_cliente
from clientes,libros,libros_cliente
where libros.codigo_libro=libros_cliente.codigo_libro
and libros_cliente.codigo_cliente=clientes.codigo_cliente
group by clientes.codigo_cliente
having count(libros.codigo_libro) as numero_libros
and max(numero_libros));

/*Cambios estructurales en la base de datos(Biblioteca2)*/
1
a)
alter table prestamos add fecha datetime;

alter table clientes add penalizacion int(3);

b)
No
c)

2

e)
insert into libros (codigo_libro,nombre_libro,autor)
select 11, nombre_libro, autor
from libros
where nombre_libro like "%Señor%"
and autor like "%Tolkien%";

insert into libros (codigo_libro,nombre_libro,autor)
select 12, nombre_libro, autor
from libros
where nombre_libro like "%negritos%"
and autor like "%Agatha%";

f)
insert into clientes(codigo_cliente,nombre_cliente,penalizacion)
value(1111112,'Pedro López Mendez',5);
insert into prestamos(codigo_cliente,codigo_libro,fecha)
value(1111112,2,'2023-01-01');

3)
3.1
delete from libros
where codigo_libro>10;
3.2
create table autores(
    codigo_autor varchar(30),
    fullname_autor varchar(30),
    primary key(codigo_autor)
)engine=innoDB;


update libros 
set autor=concat('AUT',codigo_libro);


insert into autores(codigo_autor,fullname_autor)
select concat('AUT',codigo_libro),autor from libros;


update libros
set autor='AUT2'
where autor='AUT4';


delete from autores
where codigo_autor='AUT4';



3.3
alter table libros add fecha_registro date;

update libros
set fecha_registro=concat('2022','-',codigo_libro,'-',codigo_libro);
4
update prestamos
set fecha=concat('2023','-',codigo_libro,'-',codigo_libro)
where fecha is null;
7
/*libros prestados y no prestados(con S/C en lugar de NULL*/

select libros.codigo_libro,libros.nombre_libro ,if(prestamos.codigo_cliente is null,'S/C',prestamos.codigo_cliente) as codigo_cliente
from libros left join prestamos
on libros.codigo_libro=prestamos.codigo_libro;

/*el if indica que si el codigo_cliente es nulo te sale S/C, y si no te sale el cogido_cliente*/
5
insert into autores(codigo_autor,fullname_autor)
values ('AUT11','Ray Kroc');

insert into libros(codigo_libro,nombre_libro,autor,fecha_registro)
values (11,'Que sería de mi vida sin el McDonald''s','AUT11',current_date());
/*cambiar campos de una tabla*/
alter table libros change nombre_libro nombre_libro varchar(80);
/*alter table nombre change vieja_tabla nueva_tabla campo tipo(30);*/
/*borrar filas de una tabla*/
delete from libros where...

6
select *
from libros 
where nombre_libro='Que sería de mi vida sin el McDonald''s';

/*EJERCICIO 4*/
1)/*nombre del autor que mas libros ha escrito*/
select autores.fullname_autor,libros.autor,count(libros.codigo_libro)
from libros join autores
on autores.codigo_autor=libros.autor
group by libros.autor
having count(libros.codigo_libro)=(select max(total)
from(select libros.autor,count(libros.codigo_libro) as total
from libros join autores
on autores.codigo_autor=libros.autor
group by libros.autor) as libros_total);

2)
select concat('Código ',libros.codigo_libro,'-Título ',libros.nombre_libro,'del autor ',autores.fullname_autor)
from libros,autores
where codigo_libro between 5 and 10
and libros.autor=autores.codigo_autor;

3)
select prestamos.codigo_cliente,clientes.nombre_cliente,libros.nombre_libro,datediff(current_date,prestamos.fecha)div(10) as penalizacion
from prestamos join clientes
on clientes.codigo_cliente=prestamos.codigo_cliente
join libros 
on prestamos.codigo_libro=libros.codigo_libro;
4)
select prestamos.codigo_cliente,clientes.nombre_cliente,libros.nombre_libro,datediff(current_date,prestamos.fecha)div(10) as penalizacion,if(datediff(prestamos.fecha,current_date)div(10)>20,'Mayor que 20','Menor o igual que 20')as Tipo
from prestamos join clientes
on clientes.codigo_cliente=prestamos.codigo_cliente
join libros 
on prestamos.codigo_libro=libros.codigo_libro;
5)
/*saber el codigo de Arnulfo*/
 select * from clientes where clientes.nombre_cliente like 'Arnulfo%';
/*saber el codigo del libro*/
select * from libros where libros.nombre_libro like 'El león%';
/*insercion con los codigos*/
insert into prestamos(codigo_cliente,codigo_libro,fecha)
values(222222,8,current_date());

select libros.codigo_libro,prestamos.fecha
from libros join prestamos
on prestamos.codigo_libro=libros.codigo_libro
where prestamos.fecha>'2023-06-01'
order by prestamos.fecha desc;

/*intervalos de tiempo-->ej*/
select libros.codigo_libro,prestamos.fecha
from libros join prestamos
on prestamos.codigo_libro=libros.codigo_libro
where prestamos.fecha between '2023-06-01' and '2023-09-30'
order by prestamos.fecha desc;
/*EJERCICIO5*/
1)
/*usamos (prestamos right join clientes) ya que queremos que nos salga nulo la casilla del cliente en caso de que
el libro no tenga propietario(queremos todos los libros aunque no esten prestados)
Asi que tambien hacemos lo mismo con los libros(right join libros)*/
select libros.codigo_libro,libros.nombre_libro,if(clientes.nombre_cliente is null,'Sin prestar',clientes.nombre_cliente) as clientes
from prestamos right join clientes
on clientes.codigo_cliente=prestamos.codigo_cliente
right join libros
on prestamos.codigo_libro=libros.codigo_libro;
2)
select clientes.nombre_cliente,libros.codigo_libro,if(libros.nombre_libro is null,'Sin libro',libros.nombre_libro) as nombre
from prestamos left join clientes
on clientes.codigo_cliente=prestamos.codigo_cliente
left join libros
on prestamos.codigo_libro=libros.codigo_libro;
3)

/*3 BIEN PUESTO*/
/*En referencia a los if, no hace falta ponerlos los 2 en los 2 casos, ya que el primer join mostrará los libros sin
clientes(por lo que saldran nombres de clientes en nulo), asi que se pone el if para el nombre del cliente
En el segundo if pasa el caso contrario, al ser un left join se mostraran los clientes sin libros(se mostraran 
nombres de los libros en nulo), por lo que se pone el if en el nombre del libro*/
(select prestamos.codigo_libro as codigo,libros.nombre_libro as nombre,if(clientes.codigo_cliente is null,'Sin prestar',clientes.codigo_cliente) as clientes
from prestamos right join libros
on libros.codigo_libro=prestamos.codigo_libro
left join clientes
on prestamos.codigo_cliente=clientes.codigo_cliente)
union
(select prestamos.codigo_libro as codigo,if(libros.nombre_libro is null,'Sin libro',libros.nombre_libro)as nombre,clientes.codigo_cliente as clientes
from prestamos left join libros
on libros.codigo_libro=prestamos.codigo_libro
right join clientes
on prestamos.codigo_cliente=clientes.codigo_cliente);

/*quiero que me salgan tanto los libros como en los prestamos, asi que si tengo en el primero prestamos
y libros por ejemplo pongo los libros y en el segundo quiero los prestamos*/
