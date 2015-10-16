/* 1. Obtener el nombre de los autores de nacionalidad ‘Argentina’ */

select a.nombre
from autor a
where a.nacionalidad='Argentina';

/*2. Obtener los títulos de las obras que contengan la palabra ‘mundo’.*/

select o.titulo
from obra o
where o.titulo LIKE '%mundo%';

/*3. Obtener el identificador de los libros anteriores a 1990 y que contengan más de una obra
indicando el número de obras que contiene*/

select l.id_lib, l.num_obras
from libro l
where l.año<1990 and l.num_obras>1;

/*4. ¿Cuántos libros hay de los que se conozca el año de adquisición?*/

select COUNT(l.id_lib)
from libro l
where l.año is not null;

/*5. ¿Cuántos libros tienen más de una obra? Resolver este ejercicio utilizando el atributo
num_obras*/

select COUNT(l.id_lib)
from libro l
where l.num_obras>1

/* 7. Mostrar todos los títulos de los libros que tienen título en orden alfabético descendente. */