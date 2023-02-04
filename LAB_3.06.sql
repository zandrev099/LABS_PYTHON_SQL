# Lab 3.06| SQL Advanced queries
USE sakila;
show tables;

# INSTRUCTIONS

# 1. List each pair of actors that have worked together.
SELECT fa1.film_id, fa1.actor_id, fa2.actor_id
FROM film_actor fa1
JOIN film_actor fa2
ON (fa1.actor_id <> fa2.actor_id) 
AND (fa1.film_id = fa2.film_id);


# 2. For each film, list actor that has acted in more films. (Elegir el actor que en más pelicula ha actuado de cada pelicula)

select * from film_actor;		# film_id
select * from film;

select fa.actor_id, f.title, count(distinct(fa.actor_id)) 
from film f
join film_actor fa using (film_id)
group by fa.actor_id, f.title
order by count(distinct(fa.actor_id)) ASC;

# en este tengo dudas

