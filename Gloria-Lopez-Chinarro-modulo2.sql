USE sakila;

/* EJERCICIO 1 */
-- Selecciona todos los nombres de las películas sin que aparezcan duplicados

SELECT DISTINCT title
FROM film;

/* EJERCICIO 2 */
-- Muestra los nombres de las películas que tengan clasificación "PG-13"

-- Hago una selección total para ver donde está PG-13

SELECT *
FROM film;

-- Como está en rating hago:

SELECT title AS Title_Film, rating
FROM film
WHERE rating = 'PG-13';

/* EJERCICIO 3 */
-- Encuentra el título y la descripcion de todas las películas que contengan la palabra "amazing" en su descripción

SELECT f.title AS Title_Film, f.description AS Description_Film
FROM film as f
WHERE description LIKE '%amazing%';

/* EJERCICIO 4 */
-- Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos

SELECT title AS Title_Film
FROM film
WHERE length >= 120;

/* EJERCICIO 5 */
-- Recupera los nombres de todos los actores

SELECT first_name
FROM actor;

/* EJERCICIO 6 */
-- Encuentra el nombre y apellido de los actores que tengan "Gibson en su apellido

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%Gibson%';

/* EJERCICIO 7 */
-- Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20

SELECT first_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

/* EJERCICIO 8 */
-- Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación

SELECT title AS Title_Film, rating
FROM film
WHERE rating NOT IN ('R', 'PG-13');

/* EJERCICIO 9 */
-- Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT rating, COUNT(*) AS Total_Films
FROM film
GROUP BY rating;

/* EJERCICIO 10 */
-- Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido 
-- junto con la cantidad de películas alquiladas.

SELECT *
FROM film;

SELECT * 
FROM customer;

SELECT * 
FROM rental;

SELECT * 
FROM inventory;

SELECT c.customer_id, c.first_name, c.last_name, COUNT(f.film_id) AS Total_Rentals_Films
FROM film AS f
INNER JOIN customer AS c 
ON c.customer_id = f.film_id
INNER JOIN inventory AS I
ON i.film_id = f.film_id
INNER JOIN rental AS r
ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentals_films ASC;

/* EJERCICIO 11 */
-- Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT *
FROM film;

SELECT * 
FROM customer;

SELECT * 
FROM rental;

SELECT * 
FROM inventory;

SELECT c.name AS Category_Name, COUNT(f.film_id) AS Total_Rentals_Films
FROM category AS c
INNER JOIN film AS f
ON c.category_id = f.film_id
INNER JOIN inventory AS I
ON i.film_id = f.film_id
INNER JOIN rental AS r
ON r.inventory_id = i.inventory_id
GROUP BY category_name
ORDER BY Total_Rentals_Films ASC;

/* EJERCICIO 12 */
-- Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto 
-- con el promedio de duración.

SELECT *
FROM film;

SELECT rating AS Rating_Film,  AVG(length) AS Average_Movie
FROM film 
GROUP BY rating
ORDER BY Average_Movie ASC;

/* EJERCICIO 13 */
-- Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love"

SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;

SELECT a.first_name, a.last_name
FROM actor AS a
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
JOIN film AS f 
ON fa.film_id = f.film_id
WHERE f.title = 'Indian Love';

/* EJERCICIO 14 */
-- Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción

SELECT title, description
FROM film;

SELECT title
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';

/* EJERCICIO 15 */
-- Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.

SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT a.actor_id, a.first_name, a.last_name
FROM actor AS a
LEFT JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL;

/* EJERCICIO 16 */
-- Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT *
FROM film;

SELECT title
FROM film
WHERE release_year BETWEEN 2006 AND 2010;

/* EJERCICIO 17 */
-- Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT *
FROM film;

SELECT *
FROM category;

SELECT *
FROM film_category;

SELECT f.title
FROM film f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id
INNER JOIN category AS c 
ON fc.category_id = c.category_id
WHERE c.name = 'Family';

/* EJERCICIO 18 */
-- Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT *
FROM film;

SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT CONCAT(a.first_name," ",a.last_name) AS FirstName_LastName, COUNT(fa.film_id) AS Film_Count
FROM actor AS a
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10;

/* EJERCICIO 19 */
-- Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

SELECT title, rating, length
FROM film;

SELECT title, rating, length
FROM film
WHERE rating = 'R' AND length >= '120';

/* EJERCICIO 20 */
-- Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra 
-- el nombre de la categoría junto con el promedio de duración.

SELECT *
FROM film;

SELECT *
FROM film_category;

SELECT *
FROM category;

SELECT c.name AS Category_Name, AVG(f.length) AS Average_Movie
FROM category AS c
INNER JOIN film_category AS fc 
ON c.category_id = fc.category_id
INNER JOIN film AS f 
ON f.film_id = fc.film_id
GROUP BY c.name
HAVING AVG(f.length) >= 120;

/* EJERCICIO 21 */
-- Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la 
-- cantidad de películas en las que han actuado.

SELECT *
FROM film;

SELECT *
FROM film_actor;

SELECT *
FROM actor;

SELECT CONCAT(a.first_name, a.last_name) AS FirstName_LastName, COUNT(fa.film_id) AS Films_Amount
FROM actor AS a
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) >= 5;

/* EJERCICIO 22 */
-- Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar 
-- los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.

SELECT *
FROM film;

SELECT *
FROM rental;

SELECT *
FROM inventory;

-- Sin subconsulta:
SELECT DISTINCT f.title
FROM film AS f
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
INNER JOIN rental AS r 
ON i.inventory_id = r.inventory_id
WHERE r.rental_id > 5;

-- Con subconsulta:
SELECT DISTINCT f.title
FROM film AS f
WHERE f.film_id IN (
    SELECT i.film_id
    FROM inventory AS i
    INNER JOIN rental AS r 
    ON i.inventory_id = r.inventory_id
    WHERE r.rental_id > 5);

/* EJERCICIO 23 */
-- Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
-- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" 
-- y luego exclúyelos de la lista de actores.

SELECT *
FROM actor;

SELECT *
FROM film_actor;

SELECT *
FROM category;

SELECT *
FROM film_category;

-- Sin subconsulta:

SELECT DISTINCT a.first_name, a.last_name
FROM actor AS a
LEFT JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
LEFT JOIN film_category AS fc 
ON fa.film_id = fc.film_id
LEFT JOIN category AS c 
ON fc.category_id = c.category_id AND c.name = 'Horror'
WHERE c.category_id IS NULL;

-- Con subconsulta:

SELECT first_name, last_name
FROM actor
WHERE actor_id NOT IN (
    SELECT DISTINCT a.actor_id
    FROM actor AS a
    INNER JOIN film_actor AS fa 
    ON a.actor_id = fa.actor_id
    INNER JOIN film_category AS fc 
    ON fa.film_id = fc.film_id
    INNER JOIN category AS c 
    ON fc.category_id = c.category_id
    WHERE c.name = 'Horror');
    

/* EJERCICIO 24 */
-- BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
-- tabla film.

SELECT *
FROM film;

SELECT *
FROM category;

SELECT *
FROM film_category;

SELECT f.title, f.length
FROM film AS f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON c.category_id = fc.category_id
WHERE c.name = 'Comedy' AND length > 180;

/* EJERCICIO 25 */
-- BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe
-- mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.

SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;

SELECT 
    CONCAT(a1.first_name, ' ', a1.last_name) AS Actor1_Full_Name,
    CONCAT(a2.first_name, ' ', a2.last_name) AS Actor2_Full_Name,
    COUNT(fa1.film_id) AS Amount_Films_Together
FROM actor As a1
INNER JOIN film_actor AS fa1 
ON a1.actor_id = fa1.actor_id
INNER JOIN film_actor AS fa2 
ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
INNER JOIN actor AS a2 
ON fa2.actor_id = a2.actor_id
GROUP BY  Actor1_Full_Name, Actor2_Full_Name
HAVING COUNT(fa1.film_id) >= 1
ORDER BY Amount_Films_Together ASC;



