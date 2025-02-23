use films;

-- 1
select * from film;

-- 2
select title, rental_duration, length from film where rental_duration > 5 and length > 150;

-- 3
select title, length from film where length between 150 and 170 order by length asc;

-- 4
select last_name, first_name from customer where (last_name like "_A%" or "_O%") and first_name like "F%" order by last_name asc, first_name asc;

-- 5
select payment_date, customer_id, amount from payment where payment_date between "2005-07-28" and "2005-07-30";

-- 6
select payment_date, customer_id, staff_id, amount from payment where customer_id in(20, 30, 40, 50) and staff_id = 2 and payment_date like "%-08-%" order by payment_date desc, customer_id asc;

-- 7
select concat(last_name, ", ", first_name) as "nom_complet",  email from customer where active = 0 and store_id = 1 and (last_name like "%UN%" or first_name like "%ER%") order by nom_complet asc;