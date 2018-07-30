USE sakila;

#1a
SELECT first_name, last_name FROM actor;

#1b
SELECT CONCAT(first_name, ' ', last_name) AS 'Actor Name' FROM actor;

#2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

#2b
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';

#2c
SELECT last_name, first_name FROM actor WHERE last_name LIKE '%LI%';

#2d
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China')

#3a
ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_update;

#3b
ALTER TABLE actor
DROP COLUMN description;

#4a
SELECT last_name as 'Last Name', COUNT(last_name) as 'Count'
FROM actor 
GROUP BY last_name;

#4b
SELECT last_name as 'Last Name', COUNT(last_name) as 'Count'
FROM actor 
GROUP BY last_name
HAVING Count >=2;

#4c
UPDATE actor
SET first_name = REPLACE(first_name, 'GROUCHO', 'HARPO')
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

#4d
UPDATE actor
SET first_name = REPLACE(first_name, 'HARPO', 'GROUCHO')
WHERE first_name = 'HARPO';

#5a
SHOW CREATE TABLE address;

#6a
SELECT s.first_name, s.last_name, a.address  
FROM staff s
LEFT JOIN address a
ON s.address_id = a.address_id;

#6b
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount) as 'Total Amount'
FROM staff s
LEFT JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY staff_id;

#6c
SELECT f.title, COUNT(fa.actor_id) AS 'Number of Actors'
FROM film_actor fa
INNER JOIN film f
ON fa.film_id = f.film_id
GROUP BY title;

#6d
SELECT COUNT(*) AS 'Hunchback Impossible Count'
	FROM inventory
    WHERE film_id IN
	(SELECT film_id
	FROM film
	WHERE title = 'Hunchback Impossible');
    
#6e
SELECT customer.first_name, customer.last_name, SUM(payment.amount) as 'Total Amount Paid'
	FROM customer
    LEFT JOIN payment
		ON customer.customer_id = payment.customer_id
	GROUP BY customer.customer_id
    ORDER BY 2 ASC;

#7a 
#Subquery
SELECT title,(
	SELECT language_id
    FROM language 
    WHERE name = 'English') AS 'English'
 FROM film WHERE title LIKE 'K%' OR title LIKE 'Q%';
 
 #Joins
 SELECT title
	FROM film 
    LEFT JOIN language 
		ON film.language_id = language.language_id
	WHERE name = 'English' AND title LIKE 'K%' OR title LIKE 'Q%';

#7b
SELECT first_name, last_name
	FROM actor 
    WHERE actor_id IN
    (SELECT actor_id
    FROM film_actor
    WHERE film_id IN
		(SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'));
        
#7c
SELECT customer.first_name, customer.last_name, customer.email, country.country
FROM customer 
	LEFT JOIN address  
		ON customer.address_id = address.address_id
	LEFT JOIN city 
		ON address.city_id = city.city_id
	LEFT JOIN country
		ON city.country_id = country.country_id
WHERE country = 'Canada';

#7d
SELECT title
	FROM film 
    WHERE film_id IN
    (SELECT film_id
    FROM film_category
    WHERE category_id IN
		(SELECT category_id
        FROM category
        WHERE name = 'Family'));
        
#7e
SELECT title, COUNT(rental.inventory_id) as 'Rental Count'
	FROM film
    LEFT JOIN inventory
		ON film.film_id = inventory.film_id
    LEFT JOIN rental
		ON rental.inventory_id = inventory.inventory_id
	GROUP BY title
    ORDER BY 2 DESC;
    
#7f
SELECT store.store_id, SUM(payment.amount) as 'Total Revenue'
	FROM store
    LEFT JOIN inventory
		ON store.store_id = inventory.store_id
	LEFT JOIN rental
		ON inventory.inventory_id = rental.inventory_id
	LEFT JOIN payment
		ON rental.rental_id = payment.rental_id
	GROUP BY store_id;
    
#7g
SELECT store.store_id, city.city, country.country
	FROM store
    LEFT JOIN address
		ON store.address_id = address.address_id
	LEFT JOIN city
		ON address.city_id = city.city_id
	LEFT JOIN country
		ON city.country_id = country.country_id;

#7h
SELECT category.name, SUM(payment.amount) as 'Total Revenue'
	FROM category
    LEFT JOIN film_category
		ON category.category_id = film_category.category_id
	LEFT JOIN inventory	
		ON film_category.film_id = inventory.film_id
	LEFT JOIN rental
		ON inventory.inventory_id = rental.inventory_id
	LEFT JOIN payment
		ON rental.rental_id = payment.rental_id
	GROUP BY category.name
    ORDER BY 2 DESC
    LIMIT 5;

#8a
CREATE VIEW top_five_genres
AS
SELECT category.name, SUM(payment.amount) as 'Total Revenue'
	FROM category
    LEFT JOIN film_category
		ON category.category_id = film_category.category_id
	LEFT JOIN inventory	
		ON film_category.film_id = inventory.film_id
	LEFT JOIN rental
		ON inventory.inventory_id = rental.inventory_id
	LEFT JOIN payment
		ON rental.rental_id = payment.rental_id
	GROUP BY category.name
    ORDER BY 2 DESC
    LIMIT 5;
    
#8b
SELECT * FROM top_five_genres

#8c
DROP VIEW top_five_genres


