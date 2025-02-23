-- View 1
create view info_peli
as select film.title, film.length, film.rating, original.name as "original language", dub.name as "dubbed language"
from film
inner join language original on original.language_id = film.original_language_id
inner join language dub on dub.language_id = film.language_id;

-- View 2
create view info_alquiler
as select film.title, customer.first_name, customer.last_name, rental.rental_date, rental.return_date, store.store_id, city.city
from film
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join customer on rental.customer_id = customer.customer_id
inner join store on customer.store_id = store.store_id
inner join address on store.address_id = address.address_id
inner join city on address.city_id = city.city_id
where customer.active = 1;

-- View 3
create view info_cliente
as select first_name, substring(last_name, 1,1) as "last name", email, active
from customer;

-- View 4
create view info_staff
as select staff_id, username, email, password, active
from staff;

-- Crear roles y permisos
create role administracion, desarrolladores, practicas;

grant update (first_name, last_name, email, active) on films.customer to administracion;
grant insert on films.customer to administracion;
grant update on films.staff to administracion;
grant select on films.* to administracion;

grant all privileges on films.* to desarrolladores;

grant select on films.* to practicas;
grant update, delete on films.actor to practicas;
grant update, delete on films.film to practicas;
grant update, delete on films.film_actor to practicas;
grant update, delete on films.inventory to practicas;
grant update, delete on films.rental to practicas;

-- Crear usuarios y dar roles
create user admin@localhost identified by "1234";
create user dev1@localhost identified by "1234";
create user dev2@localhost identified by "1234";
create user practicas@localhost identified by "1234";

grant administracion to admin@localhost;
grant desarrolladores to dev1@localhost, dev2@localhost;
grant practicas to practicas@localhost;