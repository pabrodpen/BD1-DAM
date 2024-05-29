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

insert into libros (codigo_libro,nombre_libro,autor) value(1,'Historia de dos ciudades''Charles Dickens');
insert into libros value(2,'El Señor de los Anillos','J. R. R. Tolkien');
insert into libros value(3,'El Principito','Antoine de Saint Exupery');
insert into libros value(4,'El Hobbit','J. R. R. Tolkien');
insert into libros value(5,'Sueño en el pabellón rojo','Cao Xueqi');
insert into libros value(6,'Triple representatividad','Jiang Zeming');
insert into libros value(7,'Diez negritos','Agatha Christie');
insert into libros value(8,'El león, la bruja y el armario','C. S. Lewis');
insert into libros value(9,'Ella','Henry Rider Haggard');
insert into libros value(10,'El código Da Vinci','Dan Brown');

create table libros_cliente(
    codigo_cliente int,
    codigo_libro int,
    foreign key(codigo_cliente) references clientes(codigo_cliente),
    foreign key(codigo_libro) references libros(codigo_libro)
)engine=innoDB;

insert into libros_cliente value(1111111,1);
insert into libros_cliente value(444444,3);
insert into libros_cliente value(777777,7);
insert into libros_cliente value(777777,9);
insert into libros_cliente value(999999,10);

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


