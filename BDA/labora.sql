/* 1. Obtener el nombre de los autores de nacionalidad �Argentina� */

select a.nombre
from autor a
where a.nacionalidad='Argentina';

/*2. Obtener los t�tulos de las obras que contengan la palabra �mundo�.*/

select o.titulo
from obra o
where o.titulo LIKE '%mundo%';

/*3. Obtener el identificador de los libros anteriores a 1990 y que contengan m�s de una obra
indicando el n�mero de obras que contiene*/

select l.id_lib, l.num_obras
from libro l
where l.a�o<1990 and l.num_obras>1;

/*4. �Cu�ntos libros hay de los que se conozca el a�o de adquisici�n?*/

select COUNT(l.id_lib)
from libro l
where l.a�o is not null;

/*5. �Cu�ntos libros tienen m�s de una obra? Resolver este ejercicio utilizando el atributo
num_obras*/

select COUNT(l.id_lib)
from libro l
where l.num_obras>1

/* 7. Mostrar todos los t�tulos de los libros que tienen t�tulo en orden alfab�tico descendente. */