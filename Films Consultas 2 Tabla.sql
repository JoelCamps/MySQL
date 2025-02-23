use films;

-- 1
select film.title, film.description from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
where category.name = "horror" and film.description like "%crocodile%";

-- 2
select * from address
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
where country.country = "Argentina";

-- 3
select country.country, customer.first_name, customer.last_name from customer
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
where country = "Spain" or country = "France"
order by country asc, last_name asc, first_name asc;

-- 4
select staff.first_name, staff.last_name, city.city, country.country from staff
inner join address on staff.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id;

-- 5
select film.title, film.description from language
inner join film on film.language_id = language.language_id
where language.name in("Italian", "French", "German") and language.language_id = film.original_language_id
order by film.title desc;

-- 6
select film.title, film.description, film.rating from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
where category.name in("Animation", "Children") and film.rating in("G", "PG", "PG-13")
order by film.rating asc, film.title asc;

-- 7
select actor.first_name, film.title, film.description, language.name from actor
inner join film_actor on actor.actor_id = film_actor.actor_id
inner join film on film_actor.film_id = film.film_id
inner join language on film.language_id = language.language_id
where language.name = "French" and film.original_language_id = film.language_id and actor.first_name in("Penelope", "Cameron")
order by film.title asc;

-- 8
select customer.first_name, customer.last_name from customer
inner join payment on customer.customer_id = payment.customer_id
where payment_date between "2005-08-10" and "2005-08-20" and payment.amount > 1;

-- 9
select distinct film.title from film
inner join inventory on film.film_id = inventory.film_id
inner join store on inventory.store_id = store.store_id
inner join staff on store.store_id = staff.store_id
where film.special_features like "%Trailers%" and staff.last_name = "Stephens";

-- 10
set @length = 150;
set @category_name1 = "Horror";
set @category_name2 = "Sci_Fi";

select film.title, film.length, category.name from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
where film.length > @length and (category.name = @category_name1 or category.name = @category_name2);

-- 11
set @date_start = "2005-07-12"; 
set @date_end = "2005-07-31";
set @last_name = "Cruise";

select customer.first_name, customer.last_name from customer
inner join rental on customer.customer_id = rental.customer_id
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film on inventory.film_id = film.film_id
inner join film_actor on film.film_id = film_actor.film_id
inner join actor on film_actor.actor_id = actor.actor_id
where rental_date between @date_start and @date_end and actor.last_name = @last_name;