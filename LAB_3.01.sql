# Lab 3.01| SQL Join
use sakila;

# INSTRUCTIONS

# 1. List the number of films per category.
SELECT c.category_id,c.name, COUNT(f.film_id) AS number_of_films
FROM sakila.film_category f
JOIN sakila.category c
ON f.category_id = c.category_id
GROUP BY c.name, c.category_id
ORDER BY c.category_id ASC;

# 2. Display the first and the last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, s.address_id, a.address
FROM staff s
JOIN address a
ON s.address_id = a.address_id;

# 3. Display the total amount rung up by each staff member in August 2005.
SELECT s.staff_id,s.first_name, s.last_name, SUM(p.amount)
FROM sakila.payment p
JOIN sakila.staff s
ON p.staff_id = s.staff_id
WHERE YEAR(p.payment_date) = 2005 AND MONTH(p.payment_date) = 8
GROUP BY s.staff_id,s.first_name, s.last_name
ORDER BY SUM(p.amount) DESC;

# 4. List all films and the number of actors who are listed for each film.
SELECT fa.film_id,f.title, count(fa.actor_id) AS number_of_actors_listed_per_film
FROM film_actor fa
JOIN film f
ON f.film_id = fa.film_id
GROUP BY fa.film_id;

# 5. Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. 
#    List the customers alphabetically by their last names.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount)
FROM customer c
JOIN payment p
ON c.customer_id= p.customer_id
GROUP BY p.customer_id
ORDER BY c.last_name ASC;


