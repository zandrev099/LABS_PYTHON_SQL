# Lab 3.05 | SQL Subqueries
USE sakila;
show tables;

# INTRUCTIONS
# 1. How many copies of the film Hunchback Impossible exist in the inventory system?

select count(*) as num_copies FROM (
select f.film_id, i.inventory_id 
FROM film f
JOIN inventory i
USING (film_id)
where f.title = "Hunchback Impossible"
) sub1;

# 2. List all films whose length is longer than the average of all the films.
select AVG(length) from film;

select film_id, title, length from film
where length > (select AVG(length) from film
);

# 3. Use subqueries to display all actors who appear in the film Alone Trip.

select title, film_id from film
where title = 'Alone Trip'; 					 # film_id = 17

select actor_id,film_id from film_actor
where film_id = 17;								# actor_id (3, 12, 13, 82, 100, 160, 167, 187)

select first_name, last_name from actor
where actor_id IN (3, 12, 13, 82, 100, 160, 167, 187);		# esto lo hacemo para confirmar el nombre de los actores


select first_name, last_name from actor
where actor_id in(								# tercero este querie, donde vamos por el nombre de los actores
	select actor_id from film_actor
	where film_id in(							# segundo este querie, donde vamos por el actor_id 
		select film_id from film 
		where title= 'Alone Trip')				# primero este querie, donde vamos por el film_id
);


# 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films

select * from category where name= 'Family';
select * from film_category where category_id = 8; 		# arroja 69 peliculas
select * from film;


select title from film
where film_id in(										# tercero este querie, donde vemos el titulo de las peliculas con categoria de familia.
	select film_id from film_category 
	where category_id in (								# segundo este querie, donde vemos film_id tienen las peliculas con category_id de familia
		select category_id from category
		where name = 'Family')							# primero este querie, donde revisamos que category_id tienen la categoria de familia
);

# 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the 
#    correct tables with their primary keys and foreign keys, that will help you get the relevant information.

select  first_name, last_name, email from customer where address_id in (481,468,1,3,193,415, 441) ;
select * from address where city_id in (179, 196, 300, 313, 383, 430, 565);
select * from city where country_id = 20;
select * from country where country = 'Canada'; 		# country_id = 20


select  first_name, last_name, email from customer
where address_id in(										# querie 4
	select address_id from address
	where city_id in(										# querie 3
		select city_id from city
		where country_id in(								# querie 2		
			select country_id from country
			where country = 'Canada')						# querie 1
)); 


# 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you
#    will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.


SELECT actor_id, COUNT(actor_id) 
FROM film_actor
group by actor_id										# Para saber cual es el actor que a actuado en más peliculas (actor_id = 107)
ORDER BY COUNT(actor_id) desc
limit 1;


select * from film where film_id in (...;
select * from film_actor where actor_id = 107;			# aqui nos arroja el film_id de todas las peliculas hechas por la actriz más prolifica
select * from actor where actor_id = 107; 				# aqui nada mas para saber el nombre

select title from film
where film_id in(
	select film_id from film_actor
	where actor_id = 107);


# 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has
#    made the largest sum of payments

select * from payment;
select * from customer;

select customer_id, sum(amount) from payment
group by customer_id
order by sum(amount) desc								# para saber quien es el customer más profitable (customer = 526)
limit 1;

select title from film;
select * from inventory;
select * from rental where customer_id = 526 ;

select title from film
where film_id in(
	select film_id from inventory
	where inventory_id in(
		select inventory_id from rental 
		where customer_id = 526)
);


# 8. Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
select * from customer;
select avg(amount) from payment;

select * from customer 
where customer_id in (
    select customer_id from payment
	where amount >(
		select avg(amount) from payment)
);

