-- EXPLICACION Y PASOS DE LOS EJERCICIOS:
-- 0. Uso de Base de datos Sakila.
USE sakila; 

-- 0.1 Apertura del Diagrama para ver la relación de las tablas. EER Diagram. Database - Reverse Engineer.

-- 0.2 Selección de las tablas a usar:
SELECT *
	FROM `film`;

SELECT *
	FROM `film_actor`;

SELECT *
	FROM `film_category`;
    
SELECT *
	FROM `actor`;

SELECT *
	FROM `customer`;

SELECT *
	FROM `rental`;

SELECT *
	FROM `category`;

SELECT *
	FROM `inventory`;
    
-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
-- Explicación: Utilizamos la cláusula `DISTINCT`para seleccionar los nombres de peliculas únicos (sin duplicados) de la tabla.
SELECT DISTINCT `title`
	FROM `film`;
    
-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
-- Explicación: Utilizamos la cláusula `WHERE` para filtrar las peliculas por la clasificacion "PG-13" en la columna `rating`de la tabla `film`.
-- Además, para su verificación, seleccionamos también la columna de `rating` para comprobar en el resultado la claisificacion "PG-13"
SELECT `title`, `rating`
	FROM `film`
    WHERE `rating` = "PG-13";
    
-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- Explicación: Utilizamos la cláusula `WHERE` para poner una condición, con la cláusula LIKE y el patrón %amazing% para buscar películas cuya descripción contenga la palabra "amazing".
SELECT `title`, `description`
	FROM `film`
    WHERE `description` LIKE "%amazing%";
    
-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
-- Explicación: Utilizamos la cláusula WHERE para filtrar las películas según su duración (length), seleccionando solo aquellas con una duración mayor o igual a 120 minutos.
-- Además, para su verificación, seleccionamos también la columna de `length` de la tabla film para comprobar en el resultado la duracion es mayor (usar el operador `>`) a 120 minutos. 
SELECT `title`, `length`
	FROM `film` 
    WHERE `length` >= 120;
    
-- 5. Recupera los nombres de todos los actores.
-- Explicación: Seleccionamos la columna first_name (Nombre) de la tabla actor para recuperar los nombres de todos los actores.
-- No se necesita ninguna condición adicional ya que queremos todos los actores sin ningún filtro.
SELECT `first_name`
	FROM `actor`;
    
-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
-- Explicación: Usamos la cláusula WHERE con LIKE y el patrón %Gibson% para buscar todos los actores cuyo apellido contenga la palabra "Gibson".
-- Seleccionamos las columnas first_name (Nombre) y last_name (apellido) de la tabla actor.
SELECT `first_name`, `last_name`
	FROM `actor`
    WHERE `last_name` LIKE "%Gibson%";
    
-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
-- Explicación: Utilizamos la cláusula WHERE para filtrar los actores por su actor_id, usando el operador BETWEEN para especificar el rango de actor_id deseado (valor inicial y valor final).
-- Además, para su verificación seleccionamos también la columna `actor_id` de la tabla actor para comprobar en el resultado esté entre el rango deseado. 
SELECT `first_name`, `actor_id`
	FROM `actor`
    WHERE `actor_id` BETWEEN 10 AND 20; 
    
-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- Explicación: Usamos la cláusula WHERE para filtrar las películas por su clasifiacaion (rating), excluyendo aquellos que sean "R" o "PG-13", mediante el uso de la cláusula NOT LIKE.
-- Además, para su verificación seleccionamos también la columna de la clasificacion(rating) de la tabla film para comprobar en el resultado no estén las clasificaciones indicadas. 
SELECT `title`, `rating`
	FROM `film`
    WHERE `rating` NOT LIKE "R" AND `rating` NOT LIKE "PG-13";

-- Opción 2:
SELECT `title`, `rating`
	FROM `film`
    WHERE `rating` NOT IN ("R", "PG-13");
    
-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
-- Explicación: Utilizamos la función de agregación COUNT() (función para contar) junto con la cláusula GROUP BY (función para agrupar) para contar el número de películas en cada clasificación.
-- Seleccionamos las columnas rating y COUNT(rating) para mostrar la clasificación junto con el recuento de películas.
SELECT COUNT(`rating`), `rating`
	FROM `film`
    GROUP BY `rating`;
    
-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
-- Explicación: Utilizamos la cláusula INNER JOIN para combinar las tablas customer y rental basándonos en el customer_id,para contar las películas alquiladas por cada cliente . Además, utilizamos la función de agregación COUNT() para contar el número de alquileres por cliente.
-- Seleccionamos las columnas customer_id, first_name, last_name de la tabla customer, y COUNT(customer_id) para mostrar la cantidad de películas alquiladas. Y usamos la cláusula GROUP BY para agrupar los resultados por cliente.
-- Además, se ha utilizado la palabra clave `AS` para proporcionar un alias a la columna generada para contar la cantidad de películas alquiladas.
SELECT `c`.`customer_id`, `c`.`first_name`, `c`.`last_name`, COUNT(`c`.`customer_id`) AS "Rented_movies"
    FROM `customer` AS `c`
    INNER JOIN `rental`AS `r`
		ON `c`.`customer_id` =  `r`.`customer_id`
    GROUP BY `c`.`customer_id`;

-- 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
-- Explicación: Utilizamos INNER JOIN para combinar las tablas category, film_category, film, inventory, y rental. Para obtener la cantidad total de películas alquiladas por categoría. 
-- Utilizamos la función de agregación COUNT() para contar el número de alquileres por categoría. y la cláusula GROUP BY para agruparlo por el nombre de la categoria. Seleccionamos las columnas `name` de la tabla category, y COUNT(rental_id) para mostrar el recuento de alquileres.
-- Además, se ha utilizado la palabra clave `AS` para proporcionar un alias a la columna generada para contar la cantidad de películas alquiladas por categoría.
SELECT `c`.`name`, COUNT(`rental_id`) AS "Rental_count"
	FROM `category`AS `c`
    INNER JOIN `film_category` AS `fc`
		ON `c`.`category_id` =  `fc`.`category_id`
    INNER JOIN `film` AS `f`
		ON `fc`.`film_id` =  `f`.`film_id`
    INNER JOIN `inventory` AS `i`
		ON	`f`.`film_id` =  `i`.`film_id`
	INNER JOIN `rental` AS `r`
		ON	`i`.`inventory_id` =  `r`.`inventory_id`
    GROUP BY `c`.`name`;
    
-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
-- Explicación: Utiliza la función `AVG()` para calcular el promedio de duración de las películas con la función `ROUND()` para su redondeo con 2 decimales, y la cláusula GROUP BY para agrupa los resultados por clasificación.
-- Además, se ha utilizado la palabra clave `AS` para proporcionar un alias a la columna generada para ver el promedio de la duracion de las películas por clasificación.
SELECT `rating`, ROUND(AVG(`length`), 2) AS "Average_duration"
	FROM `film`
    GROUP BY `rating`;
    
-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
-- Explicación: Utilizamos la union de las tablas, mediante la operación INNER JOIN para combinar las tablas actor, film_actor, y film. Posteriormente, utilizamos la cláusula WHERE para filtrar las películas con el título "Indian Love".
-- Seleccionamos las columnas first_name, last_name de la tabla actor, y title de la tabla film.
-- Además, para su verificación también seleccionamos la columna del título (`title`) de la tabla film para comprobar en el resultado que aparezca el título solicitado. 
SELECT `a`.`first_name`, `a`.`last_name`, `f`.`title`
	FROM `actor` AS `a`
    INNER JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
     INNER JOIN `film` AS `f`
		ON `fa`.`film_id` = `f`.`film_id` 
	WHERE `f`.`title` LIKE "%Indian Love%"; 
-- PASO A PASO:
-- 1. Seleccionar las columnas necesarias: Queremos obtener el nombre (first_name) y apellido (last_name) de los actores, así como el título (title) de la película en la que han actuado.
SELECT `a`.`first_name`, `a`.`last_name`, `f`.`title` -- seleccionamos a.first_name, a.last_name de la tabla actor, y f.title de la tabla film.
-- 2. Unir las tablas necesarias: Utilizamos la cláusula INNER JOIN para combinar las tablas actor, film_actor, y film.
INNER JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id` -- Conectamos la tabla actor con film_actor a través del actor_id.
INNER JOIN `film` AS `f`
		ON `fa`.`film_id` = `f`.`film_id` -- Luego, unimos la tabla film_actor con film mediante el film_id.
-- 3. Filtrar las películas con el título "Indian Love":Utilizamos la cláusula WHERE para filtrar las películas que tengan el título "Indian Love".
WHERE `f`.`title` LIKE "%Indian Love%" -- Usamos f.title LIKE "%Indian Love%" para buscar títulos que contengan la frase "Indian Love".


-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
-- Explicación: Utilizamos la cláusula WHERE con LIKE para buscar películas cuya descripción contenga las palabras "dog" o "cat". 
-- Además, para su verificación también seleccionamos la columna de la descripción (`description`) de la tabla film para comprobar que en el resultado que aparezca "dog" o "cat" en la descrición de la película. 
SELECT `title`, `description` 
	FROM `film`
    WHERE `description` LIKE "%dog%" OR `description` LIKE "%cat%";
    
    
-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.
-- Explicación: Utilizamos la operación LEFT JOIN para incluir todos los actores de la tabla actor y aquellos que no tienen correspondencia en la tabla film_actor.
-- Verificamos si hay algún valor nulo en la columna actor_id de la tabla film_actor. Si no hay valores nulos, significa que todos los actores han aparecido en al menos una película.
-- Utilizamos la cláusula WHERE para poner la condición de que sea nulo. 
SELECT `first_name`, `last_name`
	FROM `actor` AS `a`
    LEFT JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
    WHERE `fa`.`actor_id` IS NULL;
-- OUTPUT: la consulta devuelve una tabla vacía, significa que no hay actores o actrices que no aparezcan en ninguna peicula en la tabla film_actor. Es decir, todos los actores y actrices tienen al menos una pelicula asociada en la tabla film_actor. 
-- Explicación: En la consulta adicional, comprobamos si hay algún actor que no tenga películas asociadas en la tabla film_actor mostrando las filas donde film_actor.actor_id sea nulo.
-- Verificar si hay actores o actrices que no tengan películas asociadas en la tabla film_actor:
SELECT *
	FROM `actor` AS `a`
	LEFT JOIN `film_actor`AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
	WHERE `fa`.`actor_id` IS NULL;
-- NOTA: Se utiliza LEFT JOIN para asegurarse de que se obtengan todos los actores de la tabla actor, incluso aquellos que no tienen correspondencia en la tabla film_actor.
-- Si usáramos INNER JOIN, solo obtendríamos los actores que tienen una correspondencia en la tabla film_actor, solo aquellos que han aparecido en al menos una película.


-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
-- Explicación: Utilizamos la cláusula WHERE con la cláusula BETWEEN para buscar las películas por su año de lanzamiento en el rango entre  valor de inicio 2005 y valor de fin 2010.
-- Además, para su verificación también seleccionamos la columna del año de lanzamiento (`release_year`) de la tabla film para la comprobacion del año en el rango solicitado.
SELECT `title`, `release_year`
	FROM `film`
    WHERE `release_year` BETWEEN 2005 AND 2010;


-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
-- Explicación: Utilizamos la operacion de INNER JOIN para unir las tablas film, film_category y category para relacionar las películas con sus categorías.
-- Y utilizamos la cláusula WHERE para filtrar las películas y mostrar solo aquellas que pertenecen a la categoría "Family".
-- Además, para su verificación también seleccionamos la columna del nombre de la tabla categoria (`name`). 
SELECT `title`, `c`.`name`
	FROM `film` AS `f`
    INNER JOIN `film_category` AS `fc`
		ON `f`.`film_id` = `fc`.`film_id`
	INNER JOIN  `category` AS `c`
		ON `fc`.`category_id` = `c`.`category_id`
	WHERE `c`.`name` = "Family";

-- PASO A PASO:
-- 1. Seleccionamos las columnas `title` de la tabla film y `name` de la tabla category.
SELECT `title`, `c`.`name`
-- 2. Utilizamos la cláusula FROM para especificar las tablas involucradas y les asignamos alias (f, fc, c) para hacer más legible la consulta.
FROM `film` AS `f`
-- 3. Usamos la operación INNER JOIN para unir las tablas film, film_category, y category basándonos en las claves primarias y extranjeras correspondientes (film_id y category_id).
INNER JOIN `film_category` AS `fc`
		ON `f`.`film_id` = `fc`.`film_id`
	INNER JOIN  `category` AS `c`
		ON `fc`.`category_id` = `c`.`category_id`
-- 4. Filtramos las filas resultantes utilizando la cláusula WHERE, asegurándonos de que solo se seleccionen las películas que pertenecen a la categoría "Family".
WHERE `c`.`name` = "Family";


-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
-- Explicación: Utilizamos el operador INNER JOIN para relacionar las tablas actor y film_actor, para relacionar los actores con las peliculas en las que han actuado mediante la columna `actor_id`.
-- Utilizamos la sentencia GROUP BY para agrupar los resultados por actor y utilizamos la función de agregación COUNT con el objetivo de contar las la aparicion de los actores en las peliculas.
-- Y la sentencia HAVING la utilizamos para filtrar los actores que aparecen en más de 10 películas. 
-- La cláusula HAVING, se utiliza para filtrar filas después de que se hayan agrupado los datos mediante la cláusula GROUP BY. Se aplica a las filas resultantes de la operación de agrupación.
SELECT `a`.`first_name`, `a`.`last_name`, COUNT(`fa`.`film_id`) AS "Movies_count"
	FROM `actor` AS `a`
    INNER JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
	GROUP BY `a`.`actor_id`
	HAVING COUNT(`fa`.`film_id`) > 10;
-- PASO A PASO:
-- 1. Seleccionamos las columnas first_name y last_name de la tabla actor junto con el recuento de las películas en las que han actuado (Movies_count).
SELECT `a`.`first_name`, `a`.`last_name`, COUNT(`fa`.`film_id`) AS "Movies_count"
-- 2. Usamos la cláusula FROM para especificar las tablas actor y film_actor y les asignamos alias (a, fa).
FROM `actor` AS `a`
-- 3.Empleamos un INNER JOIN para unir las tablas actor y film_actor según la columna actor_id.
INNER JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
-- 4. Agrupamos los resultados por actor_id utilizando la cláusula GROUP BY.
GROUP BY `a`.`actor_id`
-- 5. Filtramos los resultados utilizando la cláusula HAVING para mostrar solo aquellos actores que han aparecido en más de 10 películas.
HAVING COUNT(`fa`.`film_id`) > 10;


-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
-- Explicación: Utilizamos la tabla film donde se almacenan los datos de las películas.
-- Usaremos la cláusula WHERE con una doble condición: para seleccionar películas con clasificación (`rating`) "R" y con una duración (`length`) mayor (`>`) a 120 minutos (2 horas).
-- Además, para su verificación también seleccionamos las columnas `rating` (clasificación) y `length` (duración) para una mayor comprobación.
SELECT `title`, `rating`, `length`
	FROM `film`
    WHERE `rating` = "R" AND `length` > 120;


-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.
-- Explicación: Utilizamos INNER JOIN para unir las tablas category, film_category y film. Usamos GROUP BY para agrupar los resultados por categoría y calculamos el promedio de duración de las películas en cada categoría utilizando la funcion de agregación AVG().
-- Filtramos los resultados con HAVING para mostrar solo aquellas categorías cuyo promedio de duración sea superior a 120 minutos.
SELECT `c`.`name` AS "Category", AVG(`f`.`length`) AS "Average_duration"
	FROM `category` AS `c`
	INNER JOIN `film_category` AS `fc`
		ON `c`.`category_id` = `fc`.`category_id` 
	INNER JOIN `film` AS `f`
		ON `fc`.`film_id` = `f`.`film_id` 
	GROUP BY `c`.`category_id`
	HAVING AVG(`f`.`length`) > 120;

-- PASO A PASO:
-- 1. Seleccionamos el nombre de la categoría (name) de la tabla category y el promedio de duración de las películas (length) de la tabla film.
SELECT `c`.`name` AS "Category", AVG(`f`.`length`) AS "Average_duration"
-- 2. Utilizamos las tablas category, film_category y film para obtener información sobre las categorías y las películas.
FROM `category` AS `c`
-- 3. Aplicamos un INNER JOIN para combinar las tablas según las correspondientes claves primarias y extranjeras (category_id y film_id).
INNER JOIN `film_category` AS `fc`
		ON `c`.`category_id` = `fc`.`category_id` 
	INNER JOIN `film` AS `f`
		ON `fc`.`film_id` = `f`.`film_id` 
-- 4.Agrupamos los resultados por category_id utilizando la cláusula GROUP BY. 
GROUP BY `c`.`category_id`
-- 5. Usamos la cláusula HAVING para filtrar las categorías cuyo promedio de duración de películas sea superior a 120 minutos.
HAVING AVG(`f`.`length`) > 120;


-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
-- Explicación: Utiliza GROUP BY y HAVING para filtrar actores que han actuado en al menos 5 películas. Aplicamos la operación INNER JOIN para relacionar las tablas actor y film_actor.
-- Y agrupamos los resultados por actor usando GROUP BY, además de filtrar los resultados con HAVING para mostrar solo aquellos actores que han actuado en al menos 5 películas, mediante el uso de la función de agregación COUNT.
SELECT `a`.`first_name`, COUNT(`fa`.`film_id`) AS "Movies_count"
	FROM `actor` AS `a`
    INNER JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
	GROUP BY `a`.`actor_id`
	HAVING COUNT(`fa`.`film_id`) >= 5;

-- PASO A PASO:
-- 1. Seleccionamos el nombre (first_name) del actor de la tabla actor y usamos la función de agregación COUNT para contar el número de películas en las que ha actuado (Movies_count).
SELECT `a`.`first_name`, COUNT(`fa`.`film_id`) AS "Movies_count"
-- 2. Utilizamos las tablas actor y film_actor 
FROM `actor` AS `a`
-- 3. Unimos las tablas mediante un INNER JOIN usando la columna actor_id.
INNER JOIN `film_actor` AS `fa`
		ON `a`.`actor_id` = `fa`.`actor_id`
-- 4. Agrupamos los resultados por actor_id utilizando la cláusula GROUP BY.
GROUP BY `a`.`actor_id`	
-- 5.Usamos la cláusula HAVING para filtrar y mostrar solo aquellos actores que han actuado en al menos 5 películas.
HAVING COUNT(`fa`.`film_id`) >= 5;


-- 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.
-- Explicación: La consulta selecciona solo el título de las peliculas de la tabla film, Se filtran las películas basadas en el film_id obtenido de una subconsulta que involucra las tablas inventory y rental.
-- Y usando DATEDIFF se calcula la diferencia en días entre la fecha de retorno y la fecha de alquiler, seleccionando solo aquellas películas que han sido alquiladas por más de 5 días.
SELECT `title`
FROM `film` 
WHERE `film_id` IN (SELECT DISTINCT `i`.`film_id`  
                          FROM `inventory` as `i`
                          JOIN `rental` as `r`
							ON `i`.`inventory_id` = `r`.`inventory_id`
                            WHERE DATEDIFF(`return_date`, `rental_date`) > 5 );
-- PASO A PASO:
-- 1. Realizamos la subconsulta para obtener aquellas películas que han sido alquiladas por más de 5 días.
(SELECT DISTINCT `i`.`film_id`  
                          FROM `inventory` as `i`
                          JOIN `rental` as `r`
							ON `i`.`inventory_id` = `r`.`inventory_id`
                            WHERE DATEDIFF(`return_date`, `rental_date`) > 5 )
-- 2. Y posteriormente seleccionamos el título de la tabla film, utilizando la cláusula WHERE y NOT IN.
SELECT `title`
FROM `film` 
WHERE `film_id` IN ;


-- 23.Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
-- Explicación: Utilizamos las tablas actor, film_actor, film_category y category. Empleamos una subconsulta para obtener los actor_id de los actores que han actuado en películas de la categoría "Horror".
-- Y seleccionamos los nombres y apellidos de los actores que no estén presentes (utilizando una condición con WHERE y NOT IN) en la lista obtenida en la subconsulta.
SELECT `a`.`first_name`, `a`.`last_name`
	FROM `actor` AS `a`
    WHERE `actor_id` NOT IN (SELECT DISTINCT `fa`.`actor_id`
								FROM `film_actor` AS `fa`
								INNER JOIN `film_category` AS `fc`
									ON `fa`.`film_id`= `fc`.`film_id`
								INNER JOIN `category` AS `c`
									ON `fc`.`category_id`= `c`.`category_id`
								WHERE `c`.`name` = "Horror");
-- PASO A PASO: 
-- 1. Utilizamos una subconsulta para encontrar los actor_id de los actores que han actuado en películas de la categoría "Horror".
-- La subconsulta se realiza uniendo las tablas film_actor, film_category, y category mediante INNER JOIN para obtener las películas de la categoría "Horror" y los actores que las han interpretado.
SELECT DISTINCT `fa`.`actor_id`
	FROM `film_actor` AS `fa`
	INNER JOIN `film_category` AS `fc`
		ON `fa`.`film_id`= `fc`.`film_id`
	INNER JOIN `category` AS `c`
		ON `fc`.`category_id`= `c`.`category_id`
	WHERE `c`.`name` = "Horror"
-- 2. Y posteriormente seleccionamos los nombres y apellidos de los actores que no estén presentes en la lista obtenida en la subconsulta, utilizando la cláusula WHERE y NOT IN.
SELECT `a`.`first_name`, `a`.`last_name`
	FROM `actor` AS `a`
    WHERE `actor_id` NOT IN (SUBCONSULTA);

-- BONUS:
-- 24.BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
-- Explicación: Utilizamos la operación INNER JOIN para relacionar las tablas film, film_category y category. 
-- Y filtramos usando la cláusula WHERE mediante una doble condicion para mostrar solo aquellas películas que pertenecen a la categoría "Comedy" y tienen una duración mayor a 180 minutos.
SELECT `f`.`title`
	FROM `film` AS `f`
	INNER JOIN `film_category` AS `fc`
		ON `f`.`film_id`= `fc`.`film_id`
	INNER JOIN `category` AS `c`
		ON `fc`. `category_id`= `c`. `category_id`
	WHERE `c`.`name` = "Comedy" AND`f`.`length` > 180;
    
-- 1. Seleccionamos el `title`(título) de las peliculas de la tabla film. 
SELECT `f`.`title`
	FROM `film` AS `f`
-- 2. Utilizamos la operación INNER JOIN para unir las tablas film, film_category, y category para obtener información sobre las películas y sus categorías.
INNER JOIN `film_category` AS `fc`
		ON `f`.`film_id`= `fc`.`film_id`
	INNER JOIN `category` AS `c`
		ON `fc`. `category_id`= `c`. `category_id`
-- 3. Filtramos los resultados utilizando la cláusula WHERE para seleccionar solo aquellas películas que pertenecen a la categoría "Comedy" y tienen una duración mayor a 180 minutos.
WHERE `c`.`name` = "Comedy" AND`f`.`length` > 180;


-- 25.BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.
-- Explicación: Utiliza una auto-join o self-join (JOIN) de la tabla film_actor para encontrar actores que han actuado juntos en al menos una película.
-- Uso de subconsulta (recibe un alias "Movies_together") para contar el número de películas en las que cada par de actores ha actuado juntos. Utilizando la funcion de agregación COUNT(), JOIN, y la cláusula WHERE, la condición actor1.actor_id < actor2.actor_id asegura que no contemos el mismo par de actores más de una vez. 
-- Y, en la consulta principal, seleccionamos los nombres y apellidos de los actores y el número de películas en las que han actuado juntos.
SELECT `a1`.`first_name` AS "actor1_Name", `a1`.`last_name` AS "actor1_Last_name",
       `a2`.`first_name` AS "actor2_Name", `a2`.`last_name` AS "actor2_Last_name", 
		(SELECT COUNT(*) 
			FROM `film_actor` AS `fa1`
			JOIN `film_actor` AS `fa2`
				ON `fa1`.`film_id` = `fa2`.`film_id`
			WHERE `fa1`.`actor_id` = `a1`.`actor_id` AND `fa2`.`actor_id` = `a2`.`actor_id`) AS "Movies_together"
	FROM `actor` AS `a1`
	JOIN `actor` AS `a2`
		ON `a1`.`actor_id`< `a2`.`actor_id`
	GROUP BY 
		`a1`.`actor_id`, `a2`.`actor_id`;
-- 1. Utilizamos un auto-join o self-join (JOIN) de la tabla film_actor para encontrar actores que han actuado juntos en al menos una película.
-- Usamos una subconsulta para contar el número de películas en las que cada par de actores ha actuado juntos. La condición actor1.actor_id < actor2.actor_id asegura que no contamos el mismo par de actores más de una vez.
(SELECT COUNT(*) 
			FROM `film_actor` AS `fa1`
			JOIN `film_actor` AS `fa2`
				ON `fa1`.`film_id` = `fa2`.`film_id`
			WHERE `fa1`.`actor_id` = `a1`.`actor_id` AND `fa2`.`actor_id` = `a2`.`actor_id`) AS "Movies_together" -- Alias que recibe la subconsulta.
-- 2. En la consulta principal
-- Seleccionamos los nombres y apellidos de los actores (actor1_Name, actor1_Last_name, actor2_Name, actor2_Last_name) y el número de películas en las que han actuado juntos (Movies_together). Utilizamos un alias para distinguir los nombres de los actores y el número de películas juntos.
 SELECT `a1`.`first_name` AS "actor1_Name", `a1`.`last_name` AS "actor1_Last_name",
       `a2`.`first_name` AS "actor2_Name", `a2`.`last_name` AS "actor2_Last_name", 
		(SUBCONSULTA) AS "Movies_together"
	FROM `actor` AS `a1` -- Utilizamos la tabla actor que recibe el alias de a1
	JOIN `actor` AS `a2` -- Hacemos un join o union de la tabla actor consigo misma usando el alias a2. Creando una combinación de todas las combinaciones posibles de pares de actores.
		ON `a1`.`actor_id`< `a2`.`actor_id` -- Condición que garantiza que cada par de actores sea único y que no se dupliquen.
	GROUP BY  -- Agrupamos los resultados por los identificadores únicos de los actores
		`a1`.`actor_id`, `a2`.`actor_id`; 
        
-- Opción 2: Solución mediante una CTE:
WITH `ActoresRelacionados` AS (SELECT `a1`.`actor_id` AS `actor_id1`, `a2`.`actor_id` AS `actor_id2`, COUNT(*) AS `cantidad_actuaciones`
								FROM `film_actor` AS `a1`
                                JOIN `film_actor` AS `a2`
                                ON `a1`.`film_id` = `a2`.`film_id` AND `a1`.`actor_id` < `a2`.`actor_id`
                                GROUP BY `a1`.`actor_id`, `a2`.`actor_id`  HAVING COUNT(*) >= 1 )
SELECT `actor1`.`first_name` AS `actor1_nombre`, `actor1`.`last_name` AS `actor1_apellido`,
`actor2`.`first_name` AS `actor2_nombre`, `actor2`.`last_name` AS `actor2_apellido`, `cantidad_actuaciones`
	FROM `ActoresRelacionados`
	JOIN `actor` AS `actor1`
	ON `actor1`.`actor_id` = `actor_id1`
	JOIN `actor` AS `actor2`
	ON `actor2`.`actor_id` = `actor_id2`
	ORDER BY `cantidad_actuaciones` DESC;
    