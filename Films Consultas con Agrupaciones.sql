use films;

-- 1
select film.title, count(actor.first_name) from film
inner join film_actor on film.film_id = film_actor.film_id
inner join actor on film_actor.actor_id = actor.actor_id
group by film.title;

-- 2
select actor.last_name, actor.first_name, count(film.title) from actor
inner join film_actor on actor.actor_id = film_actor.actor_id
inner join film on film_actor.film_id = film.film_id
inner join language on film.language_id = language.language_id
where film.original_language_id = film.language_id and language.name = "French"
group by actor.last_name, actor.first_name;

-- 3
select actor.last_name, actor.first_name, count(film.title) from actor
inner join film_actor on actor.actor_id = film_actor.actor_id
inner join film on film_actor.film_id = film.film_id
inner join language on film.language_id = language.language_id
group by actor.last_name, actor.first_name
order by count(film.title) desc;

-- 4
select customer.last_name, customer.first_name, datediff(rental.return_date, rental.rental_date) from customer
inner join rental on customer.customer_id = rental.customer_id
where rental.return_date is not null
group by customer.last_name, customer.first_name, datediff(rental.return_date, rental.rental_date)
order by customer.last_name asc, customer.first_name;

-- 5
select country.country, avg(payment.amount) from payment
inner join customer on payment.customer_id = customer.customer_id
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
group by country.country
order by country.country;

-- 6
select film.film_id, film.title, sum(payment.amount) from film
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.rental_id = payment.rental_id
group by film.film_id, film.title
order by sum(payment.amount) desc;