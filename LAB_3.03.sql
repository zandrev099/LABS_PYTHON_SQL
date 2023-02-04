# Lab 3.03| SQL Self and cross join
USE sakila;
SHOW TABLES;


# INSTRUCTIONS

# 1. Get all pairs of actors that worked together.

SELECT fa1.film_id, fa1.actor_id, fa2.actor_id
FROM film_actor fa1
JOIN film_actor fa2
ON (fa1.actor_id <> fa2.actor_id) 
AND (fa1.film_id = fa2.film_id);


# 2. Get all pairs of customers that have rented the same film more than 3 times.

SELECT * FROM rental;

SELECT c.first_name, c.last_name, COUNT(DISTINCT(r.rental_id)) AS Times_rented
FROM customer c
JOIN rental r USING (customer_id)
GROUP BY c.first_name, c.last_name
HAVING COUNT(r.rental_id) > 3
ORDER BY COUNT(DISTINCT(r.rental_id)) DESC;


# 3.Get all possible pairs of actors and films.
select * from actor;
select * from film;

select * from (
select distinct title from film) sub1
cross join (
select distinct(first_name) from actor
order by first_name asc) sub2
cross join (
select distinct(first_name) from actor
order by first_name desc) sub3;













