# Lab 3.02| SQL Joins on multiple tables
use sakila;

# INSTRUCTIONS

# 1. Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, c.city, co.country 
FROM store s
JOIN address a
ON s.address_id= a.address_id
JOIN city c
ON a.city_id= c.city_id
JOIN country co
ON c.country_id=co.country_id;

# 2. Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, SUM(p.amount)
FROM staff s
JOIN payment p
ON p.staff_id=s.staff_id
JOIN store sto
ON sto.store_id=s.store_id
GROUP BY s.store_id;

# 3. What is the average running time of films by category?
select * from film;

SELECT c.name, AVG(f.length) 
FROM category c
JOIN film_category fc
ON c.category_id=fc.category_id
JOIN film f
ON fc.film_id=f.film_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC;

# 4. Which film categories are longest?

SELECT c.name, AVG(f.length)
FROM category c
JOIN film_category fc
ON c.category_id=fc.category_id
JOIN film f
ON fc.film_id=f.film_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC
limit 3;

# 5. Display the most frequently rented movies in descending order.

SELECT count(f.film_id) AS "rental frequency", f.title
FROM film f
JOIN inventory i
USING (film_id)
JOIN rental r
USING (inventory_id)
GROUP BY f.title
ORDER BY count(f.film_id) DESC;

# 6. List the top five genres in gross revenue in descending order.

SELECT c.category_id, c.name, SUM(p.amount) 
FROM payment p
JOIN rental r
ON p.rental_id=r.rental_id
JOIN inventory i
ON i.inventory_id=r.inventory_id
JOIN film_category fc
ON i.film_id=fc.film_id
JOIN category c
ON c.category_id=fc.category_id
GROUP BY c.category_id
ORDER BY SUM(p.amount) DESC
LIMIT 5;

# 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT COUNT(*) AS Available_copies_of_Academy_Dinosaur_in_Store_1 
FROM inventory i
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN film f
ON i.film_id=f.film_id
WHERE i.film_id=1 AND i.store_id=1 AND return_date is null;
