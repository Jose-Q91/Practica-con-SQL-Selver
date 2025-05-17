

USE pubs
go

select * from publishers

select  pub_id, pub_name  from publishers

-- Sintáxis compuesta y completa: NombreTabla.NombreCampo
select Publishers.pub_id , publishers.pub_name from publishers


--Alias de Tabla (es como un sobrenombre)
--Muestro una lista de precios de los libros
select title_id, title, price from titles

--Usando alias de tabla
select t.title_id, t.title, t.price from titles as T

-- Alias de columna
select 
	title_id as IdLibro, 
	title as Titulo, 
	price as Precio 
from titles


-- Otro ejemplo de alias de columna
-- Suponga que el query anterior, lo verá un vendedor en una planilla Excel
-- y quiere el alias Precio Unitario con espacio (puede ser corchete o " " )
select 
	title_id as IdLibro, 
	title as Titulo, 
	price as [Precio Unitario] 
from titles


-- Concatenación de datos (Unir)
-- Lista de autores con formato Apellido, Nombre
select	au_lname, au_fname   from authors

-- es un campo virtual
select	au_lname + ', ' + au_fname as ApellidoYNombre   from authors
	
-- Puedo concatenar con una función predefinida llamada Concat()
select	concat(au_lname, ', ', au_fname) as ApellidoYNombre   from authors

-- Uso de literales dentro de la consulta
-- un literal es un valor fijo.
select	'Autor: ' + au_lname + ', ' + au_fname as ApellidoYNombre   from authors


-- Distinct, valores únicos, quita los repetidos
select * from authors
-- quiero saber cuales son las ciudades donde viven los autores.
select	distinct	
	city
from authors
--order by city 

-- El distinct primero ordena los datos y luego quita los repetidos

-- Campos virtuales a modo de datos calculados
--Operación con datos numericos
Select 
	title as NombreLibro, 
	price as PrecioNeto, 
	price * 1.21 as PrecioConIVA	, 
	ROUND(price * 1.21,2) as PrecioConIVAR 
from titles 

--Operación con fechas
Select 
	title as NombreLibro, 
	pubdate as FechaPublicacion, 
	pubdate + 1 as FechaPublicacionMasUnDia,
	pubdate - 1 as FechaPublicacionMenosUnDia

from titles 


-- SELECT WHERE (Filtros)
SELECT 
	pub_name
FROM Publishers 
WHERE country= 'USA'

select * from publishers

-- WHERE BETWEEN (para filtrar rangos de valores, en gral números o fechas)
SELECT title, price
FROM titles
WHERE price BETWEEN 10 AND 20

--otra forma de escribir la misma consulta sin usar between
SELECT title, price
FROM titles
WHERE price >=10 AND price <=20


-- filtro fechas con between
--LAB: Seleccionar las ventas de tabla SALES, con fecha del 
--campo ORD_DATE entre el 24/05/1993 y el 29/05/1993
SELECT * 
FROM SALES
WHERE ord_date BETWEEN '19930524' and '19930529'


--LAB: Seleccionar las ventas de tabla SALES, con fecha del 
--campo ORD_DATE que no esté entre el 24/05/1993 y el 29/05/1993
SELECT * 
FROM SALES
WHERE ord_date NOT BETWEEN '19930524' and '19930529'
order by ord_date


SELECT * 
FROM SALES
order by ord_date


-- FILTRADO CON WHERE Y EL OPERADOR IN (inclusión)
SELECT pub_name, country
FROM Publishers
WHERE country IN ('USA','France')

--select * from publishers

-- Idem filtrado con IN, pero escrito de otra forma
SELECT pub_name, country
FROM Publishers
WHERE country ='USA' OR country='France'

-- EJEMPLO con NOT IN
SELECT pub_name, country
FROM Publishers
WHERE country NOT IN ('USA','France')

-- LAB: Mostrar los registros de la Tabla AUTHORS,
-- cuyo campo STATE tenga los valores 'OR' 'TN' 'UT'

SELECT STATE, au_lname, au_fname FROM AUTHORS WHERE STATE IN ('OR','TN','UT')

 -- mismo anterior pero con OR
 SELECT STATE, au_lname, au_fname FROM AUTHORS WHERE STATE ='OR' or STATE ='TN' or STATE ='UT'


 -- FILTRADO CON LIKE, patrones de caracteres
 select au_fname,au_lname from authors

 -- Autores cuyo apellido comienza con B
  select au_fname,au_lname 
  from authors
  where au_lname LIKE 'B%'

  -- Autores cuyo nombre termina con L
  select au_fname,au_lname 
  from authors
  where au_fname LIKE '%l'

  -- Autores que tienen al menos una H en el apellido
  select au_fname,au_lname 
  from authors
  where au_lname LIKE '%h%'

-- Combinación de patrones
--El siguiente ejemplo siguiente retorna los libros cuyo TITLE_ID 
--comienza con 'BU' sigue con un dígito entre 1 y 3 seguido de cualquier otro caracter: 
SELECT * FROM TITLES
WHERE (title_id LIKE 'BU[1-3]%')


-- lo contrario a lo anterior
SELECT * FROM TITLES
WHERE (title_id NOT LIKE 'BU[1-3]%')


-- Filtrado con NULL
--Mostrar las editoriales que tengan NULL en state:
SELECT pub_name, city, state, country
FROM publishers
WHERE state IS NULL
-- CUIDADO CON ESTO!!! no da error de sintaxis, pero no trae
SELECT pub_name, city, state, country
FROM publishers
WHERE state = NULL
-- Cualquier expresión compara con NULL, da NULL


--Mostrar las editoriales que tengan completo el campo state:
SELECT pub_name, city, state, country
FROM publishers
WHERE NOT state IS NULL

SELECT pub_name, city, state, country
FROM publishers
WHERE state IS NOT NULL

--Lab: Mostrar los libros de la tabla TITLES con NULL en el campo price.
--Y luego los que tienen precio.
select title, price 
from titles
where price is null
--order by price desc


select title, price 
from titles
where not price is null

-- Funciones que devuelven fecha hora del sistema
-- y que extraen partes de una fecha
print getdate()
print sysdatetime()

select getdate() as FechaGetDate
select sysdatetime() as FechaSysDateTime

select year(getdate()) as AnioActual
select month(getdate()) as MesActual
select day(getdate()) as DiaActual


-- FUNCIONES AGREGADAS
--Mostrar cuantas ventas hubo en 1994.
SELECT 
	COUNT(*) AS CantVentas1994
FROM sales
WHERE YEAR(ord_date) = 1994

--Mostrar el precio máximo de los libros
SELECT MAX(price) AS PrecioMayor
FROM titles

--Mostrar el precio mínimo de los libros
SELECT MIN(price) AS PrecioMayor
FROM titles

Select title, price from titles
order by price 

--Lab1: Mostrar la cantidad de ventas del libro 'PS2091'
select count(*)  as CantVtas
from sales
where title_id = 'PS2091'

--Lab2: Mostrar la suma de las cantidades vendidas (campo qty) del libro 'PS2091'
select sum(qty) as cantvendidasfrom salesWHERE title_id = 'ps2091'


-- GROUP BY
--Mostrar las cantidades de libros por categorías (campo type que es el género del libro)
SELECT 
	type, 
	COUNT(*) AS CantPorCategoria
FROM titles
GROUP BY type

--Lab1: Mostrar de la tabla Sales el promedio de cantidades (qty) por sucursal (stor_id)SELECT
	stor_id,
	AVG(qty) as PromedioCantidades
FROM SALES
GROUP BY stor_id


-- AGRUPAMIENTO COMPUESTO
--Lab2: Mostrar de la tabla Sales la suma de las cantidades (qty) agrupadas 
--y ordenadas por sucursal (stor_id) y título (title_id)
SELECT
	stor_id,
	title_id,
	SUM(qty) as SumaCantidades
FROM SALES
GROUP BY stor_id,title_id
ORDER BY stor_id,title_id


-- FILTRAR GRUPOS se usa HAVING
--Mostrar la cantidad de libros agrupada por categoría (campo type que es el género)
--pero solo de aquellas que tengan más de un libro:
SELECT 
	type, 
	COUNT(*) AS CantPorCategoria
FROM titles
GROUP BY type
HAVING (COUNT(*) > 1)
--Lab1 :Mostrar de la tabla Sales el promedio de las cantidades (qty) 
--agrupadas por sucursal y libro, que superen las 20 unidades.
SELECT
	stor_id,
	title_id,
	AVG(qty) as PromedioCantidades
FROM SALES
GROUP BY stor_id,title_id
HAVING AVG(qty)>20

--Lab2: Mostrar de la tabla Sales la suma de las cantidades (qty) 
--agrupadas por sucursal y libro, para la sucursal 7067 (stor_id) 
--con suma de cantidades mayor a 20 (hay que usar WHERE y HAVING)
SELECT						-- de entrada me quedo con los registros de la sucursal 7067
	stor_id,
	title_id,
	SUM(qty) as SumaCantidades
FROM SALES
WHERE STOR_ID = '7067'
GROUP BY stor_id,title_id
HAVING SUM(qty)>20

SELECT					-- trabajo con la info de todas las sucursales y al final filtro la sucursal 7067
	stor_id,
	title_id,
	SUM(qty) as SumaCantidades
FROM SALES
GROUP BY stor_id,title_id
HAVING SUM(qty)>20 AND STOR_ID = '7067'


-- ERROR del agrupamiento y/o aplicación de funciones agregadas: 
--Column 'titles.title' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.
SELECT 
	title, 
	MIN(price) AS PrecioMayor
FROM titles
--GROUP BY title


select title, price from titles order by price 



-- orden de evaluación del select
SELECT 
	type, 
	COUNT(*) AS CantPorCategoria
FROM titles
GROUP BY type
HAVING (CantPorCategoria > 1)
--HAVING (COUNT(*) > 1)

/*
El motor hace así
1	from		imaginen que el from tiene varias tablas
2	where
3	group by
4	having
5	select
6	order by
*/

-- JOINS 
-- INNER JOIN: es coincidencia total
--Ejemplo 1: Mostrar libros , pero en lugar del id de la editorial, mostrar su nombre
SELECT 
	t.title as Libro,
	t.price as Precio ,
	p.pub_name as Editorial 
FROM titles as t
	INNER JOIN publishers as p ON p.pub_id =t.pub_id

-- Otra versión del query anterior ordenada de otra forma
SELECT 
	p.pub_name as Editorial,
	t.title as Libro,
	t.price as Precio
	--,p.pub_id, t.pub_id
FROM titles as t
	INNER JOIN publishers as p ON p.pub_id =t.pub_id
ORDER BY Editorial, Libro

--Ejemplo 2: Mostrar las ventas y el nombre de la sucursal donde se realizó la venta
SELECT 
	st.stor_name as Sucursal, 
	sa.ord_num as NroVenta, 
	sa.ord_date as FechaVenta 
FROM Sales as sa
	INNER JOIN Stores as st ON sa.stor_id = st.stor_id--Lab: Mostrar los empleados y las editoriales 
--donde pertenecen (nombres) (Employee y Publishers)
SELECT	--emp_id as IdEmpleado,	CONCAT(lname, ', ', fname) as ApeYNom,	p.pub_id as IdEditorial,	pub_name as EditorialFROM employee e INNER JOIN publishers p		ON e.pub_id = p.pub_id--LEFT JOIN: todo lo de la izquierda y sólo lo que coincide de la derecha
--Ejemplo 3: Mostrar todas las editoriales tengan o no libros cargados, 
--ordenados alfabéticamente.
SELECT 
	p.pub_name as Editorial,
	t.title as Libro ,
	t.price as Precio

FROM publishers as p LEFT JOIN titles as t ON p.pub_id =t.pub_id
ORDER BY Editorial, Libro

--Lab: Mostrar todos los libros existentes y aún los 
--que no se hayan vendido en ninguna sucursal (Titles y Sales).
SELECT
	t.title_id,
	title,
	stor_id,
	ord_num
FROM titles as t  LEFT JOIN  sales	as s ON  t.title_id=s.title_id

--RIGHT JOIN: todo lo de la derecha y sólo lo que coincide de la izquierda
-- ¿cómo escribo el mismo query anterior, pero con un right join?
-- Mostrar todos los libros existentes y aún los que no se hayan vendido en ninguna sucursal (Titles y Sales).
SELECT
	t.title_id,
	title,
	stor_id,
	ord_num
FROM   sales as s RIGHT JOIN titles as t  ON  t.title_id=s.title_id

-- Con los JOINS puedo vincular 2 tablas o más
-- Al query anterior de agregamos mostrar el nombre de la sucursal
SELECT
	t.title_id,
	t.title,
	st.stor_id,
	st.stor_name,
	s.ord_num
FROM titles as t  LEFT JOIN  sales	as s ON  t.title_id=s.title_id
		LEFT JOIN STORES as st ON s.stor_id=st.stor_id

--FULL JOIN: si la integridad referencial está bien, base bien modelada
-- no debería haber casos de full join
-- Seleccionar todos los libros y todas las editoriales.
SELECT 
	t.title as Libro ,
	p.pub_name as Editorial 
FROM Titles t FULL JOIN publishers p ON p.pub_id = t.pub_id
ORDER BY Libro


--En este ejemplo se obtendría lo mismo usando RIGHT JOIN. No 
--siempre se logra el FULL JOIN, depende de la consistencia de la información.
SELECT t.title as Libro , p.pub_name as Editorial 
FROM Titles t
RIGHT JOIN publishers p ON p.pub_id = t.pub_id
ORDER BY Libro


-- CROSS JOIN o PRODUCTO CARTESIANO
--Realizar un cross join entre titles y publishers
SELECT					--Sintaxis ANSI 92
	t.title as Libro ,
	p.pub_name as Editorial 
FROM Titles t CROSS JOIN publishers p 
ORDER BY Libro
select count(*) from titles
select count(*) from publishers


-- SELF JOIN
print OBJECT_ID (N'dbo.Empleado', N'U')

 --Ejemplo SELF JOIN 
 -- Mostrar el nombre del empleado y su jefe
 IF OBJECT_ID (N'dbo.Empleado', N'U') IS NOT NULL 
	DROP TABLE Empleado; 
 
CREATE TABLE Empleado
(
	empid int primary key,
	nombre varchar(50),
	jefeid int
)


Insert into Empleado(empid,nombre,jefeid)values (1001,'Juan Perez',null); 
Insert into Empleado(empid,nombre,jefeid)values (1002,'María Lopez',1001);
Insert into Empleado(empid,nombre,jefeid)values (1003,'Josecito',1001);
Insert into Empleado(empid,nombre,jefeid)values (1004,'Sandra Bull',1002);
Insert into Empleado(empid,nombre,jefeid)values (1005,'Andrea Puente',1003);
Insert into Empleado(empid,nombre,jefeid)values (1006,'Mr. Enri',1002);

SELECT * from Empleado;

-- Obtener el nombre de los empleados y el jefe inmediato superior (Juan Perez el dueño, no tiene jefe)
SELECT 
	e.empid as IdEmple, 
	e.nombre as Emple, 
	j.nombre as Jefe 
FROM Empleado e LEFT JOIN Empleado j ON e.jefeid=j.empid;

-- Obtener el nombre de los empleados que tienen jefe inmediato superior
SELECT 
	e.empid as IdEmple, 
	e.nombre as Emple, 
	j.nombre as Jefe 
FROM Empleado e INNER JOIN Empleado j ON e.jefeid=j.empid;

SELECT 	e.empid IdEmple, 	e.nombre as Emple,	j.empid IdJefe,	j.nombre as Jefe FROM Empleado e LEFT JOIN Empleado j ON e.jefeid=j.empidwhere e.jefeid is not null;


--Existe un generador de código que hace todo esto, pero hay que entender bien los joins!
-- Todos los libros con el detalle de autores
SELECT        titles.title_id AS IdLibro, titles.title AS Titulo, authors.au_id AS IdAutor, authors.au_lname AS Autor
FROM            authors INNER JOIN
                         titleauthor ON authors.au_id = titleauthor.au_id INNER JOIN
                         titles ON titleauthor.title_id = titles.title_id
ORDER BY Titulo, Autor

-- Todos los autores que tengan o no libros cargados en la base
SELECT        titles.title_id AS IdLibro, titles.title AS Titulo, authors.au_id AS IdAutor, authors.au_lname AS Autor
FROM            titles INNER JOIN
                         titleauthor ON titles.title_id = titleauthor.title_id RIGHT OUTER JOIN
                         authors ON titleauthor.au_id = authors.au_id
ORDER BY Titulo, Autor


-- Todos los libros con título que comience con letra C
SELECT        titles.title_id AS IdLibro, titles.title AS Titulo, authors.au_id AS IdAutor, authors.au_lname AS Autor
FROM            titles INNER JOIN
                         titleauthor ON titles.title_id = titleauthor.title_id INNER JOIN
                         authors ON titleauthor.au_id = authors.au_id
WHERE        (titles.title LIKE 'C%')
ORDER BY Titulo, Autor

-- UNION con duplicados y sin duplicados

-- Obtener sólo los nombres de empleados y autores
-- sin duplicados	--recupera 64 filas	(internamente es similar a un DISTINCT)
SELECT fname FROM employee
UNION
SELECT au_fname FROM authors

-- con duplicados	--recupera 66 filas
SELECT fname FROM employee
UNION ALL
SELECT au_fname FROM authors

SELECT fname FROM employee --order by fname	--43 filas

SELECT au_fname FROM authors --order by au_fname --23 filas


--  UNION CON 3 tablas y 2 columnas
SELECT city,state FROM stores	--6 registros
UNION ALL
SELECT city,state FROM authors		--23 registros
UNION ALL
SELECT city,state FROM publishers	--8 registros

-- SUBCONSULTA COMO TABLA DERIVADA
--Las tablas derivadas representan una tabla virtual no almacenada en la base de datos.
--⚫ Son expresiones con nombre creadas dentro de un SELECT.
--⚫ Su alcance es la consulta donde está definida.

--Mostrar por año la cantidad de libros únicos vendidos
SELECT 
	orderyear , 
	COUNT(DISTINCT title_id) AS CantLibros
FROM (
		SELECT YEAR(ord_date) AS orderyear, 
		title_id
		FROM Sales ) AS TablaDerivada
GROUP BY orderyear;

-- equivalente sin subconsulta
SELECT 
	YEAR(ord_date) AS orderyear , 
	COUNT(DISTINCT title_id) AS CantLibros
FROM Sales
GROUP BY YEAR(ord_date);


-- SUBCONSULTA COMO UNA EXPRESION
-- Recupera la venta con más unidades vendidas
SELECT 
	ord_num, 
	ord_date, 
	qty,
	title
FROM Sales AS S
		INNER JOIN titles AS T ON S.title_id = T.title_id
WHERE qty =  (SELECT MAX(qty) FROM Sales);

-- Mismo objetivo sin subconsultas

SELECT top 1
	ord_num, 
	ord_date, 
	qty,
	title
FROM Sales AS S
		INNER JOIN titles AS T ON S.title_id = T.title_id
ORDER BY qty DESC

--Lab: Mostrar el libro, precio y tipo, de aquellos libros cuyo precio supere al 
--promedio de la categoria psychology (tabla Titles).

Select title, price, type
from titles
where price > (select avg(price) as PrecioPromedioPsy 
				from titles
				where type ='psychology')



-- TOP para restringir la cantidad de registros a mostrar
-- TOP n (n es cantidad registros)  TOP PERCENT (el porcentaje de registros que quiero mostrar)
select * from employee	--todos son 43 empleados

-- recuperar los 10 primeros empleados con mayor puntaje acumulado
-- si bien son los primeros,  Laurence Lebihan tiene 175 puntos y la que sigue Mary Saveley también, 
-- y faltaría mostrar un registro más
select top 10
	emp_id as IdEmpleado, 
	concat(fname,' ', lname) as NombreYApellido,
	job_lvl  as Puntaje
from employee
order by job_lvl desc

-- con top with ties, aparecerá también el registro con 175 puntos de Mary Saveley
select top 10 with ties
	emp_id as IdEmpleado, 
	concat(fname,' ', lname) as NombreYApellido,
	job_lvl  as Puntaje
from employee
order by job_lvl desc

--mostrar el 10% de los empleados
select top 10 percent
	emp_id as IdEmpleado, 
	concat(fname,' ', lname) as NombreYApellido
from employee

-- SUBCONSULTA como expresión con operador IN
-- Recupera las ventas de las sucursales de zona CA
SELECT ord_num, ord_date, stor_id
FROM Sales
WHERE stor_id in
	(SELECT stor_id FROM Stores
		WHERE state = 'CA')

--SELECT ord_num, ord_date, stor_id
--FROM Sales
--WHERE stor_id IN
--	(7066, 7067, 7896)

-- lo opuesto , ventas que no son de las sucursales de la zona 'CA'
SELECT ord_num, ord_date, stor_id
FROM Sales
WHERE stor_id not in
	(SELECT stor_id FROM Stores
		WHERE state = 'CA')


-- SUBCONSULTAS CORRELACIONADAS
-- no se pueden probar en forma separada como las subconsultas que vimos antes
USE Pubs
SELECT stor_id,ord_num, ord_date
	FROM Sales AS S1
	WHERE ord_date =
				(SELECT MAX(ord_date)
				FROM Sales AS S2
				WHERE S2.stor_id = S1.stor_id )
	ORDER BY stor_id;

-- Ejercicio subconsulta correlacionadas
--Lab: Recuperar los datos de las ordenes del primer día de venta  para cada libro, 
--ordenado por fecha (tabla Sales)
SELECT title_id, stor_id,ord_num, ord_date
	FROM Sales AS S1
	WHERE ord_date =
				(SELECT MIN(ord_date)
				FROM Sales AS S2
				WHERE S2.title_id = S1.title_id )
	ORDER BY title_id;



-- SUBCONSULTAS CORRELACIONAS con EXISTS
--Mostrar todos los autores que han escrito al menos un libro.
SELECT au_id, concat(au_fname, ' ', au_lname) as ApellidoYNombre
	FROM authors a
	WHERE EXISTS
		(SELECT * from titleauthor ta WHERE a.au_id = ta.au_id)--Mostrar todos los autores que  no han escrito al menos un libro.SELECT au_id, concat(au_fname, ' ', au_lname) as ApellidoYNombre
	FROM authors a
	WHERE NOT EXISTS
		(SELECT * from titleauthor ta WHERE a.au_id = ta.au_id)

-- INSTRUCCIONES PARA GENERAR REGISTROS EN TABLAS PERMANENTES O TEMPORALES
-- SELECT INTO
SELECT 
	title_id as Codigo, 
	title AS Libro,
	price AS PrecioNeto,
	(price * 1.21) AS PrecioConIVA
INTO ListaPrecios
FROM titles

SELECT * FROM ListaPrecios





 -- MISMO CON JOIN
SELECT 
	a.au_id, 
	concat(au_fname, ' ', au_lname) as ApellidoYNombre
FROM authors a inner join titleauthor ta ON a.au_id = ta.au_idWHERE ta.au_id is not null














--CLASE MIERCOLES 2/11
-- SUBCONSULTAS PDF 4 DIAPO 7, ejercicio con subconsulta como expresión.








-- link de todas las funciones.



