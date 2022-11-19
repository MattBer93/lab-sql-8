-- lab-sql-8
use sakila;
select * from film;


-- 1) Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.
select rank() over(order by length) as ranking,
	film_id, title, length
from film
having length is not null and length > 0;


-- 2) Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
select rank() over(partition by rating order by length) as ranking,
	title, length, rating
from film
having length is not null and length > 0;


-- 3) How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".
select * from film;
select * from category;
select * from film_category;

select c.name, count(film_id) as film_count
from film_category fc 
join category c on fc.category_id = c.category_id
group by c.name;


-- 4) Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
select * from actor;
select * from film_actor;

select fa.actor_id, count(fa.film_id) as film_count, a.first_name, a.last_name
from film_actor fa
join actor a on fa.actor_id = a.actor_id
group by actor_id
order by film_count desc;


-- 5) Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
select * from customer;
select * from rental;

select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as rental_count
from rental r
join customer c on c.customer_id = r.customer_id
group by c.customer_id
order by rental_count desc
limit 1;


-- BONUS
-- Which is the most rented film? (The answer is Bucket Brotherhood).
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.
select * from film;
select * from inventory;
select * from rental;

select f.film_id, f.title, count(r.rental_id) as rental_count
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id, f.title
order by rental_count desc
limit 1;




















