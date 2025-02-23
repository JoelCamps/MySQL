-- Trigger Validacion 1
delimiter //
create trigger encrip
before insert on staff for each row
begin
	set new.password = sha1(new.password);
	set new.last_update = current_date();
end //
delimiter ;

insert into staff value(3, "Joel", "Camps", 1, null, "jcampsv2324@politecnics.barcelona", 2, 1, "Joel", "jcamps", null);
select * from staff;

-- Trigger Validacion 2
delimiter //
create trigger upper
before insert on actor for each row
begin
	set new.first_name = upper(trim(new.first_name));
    set new.last_name = upper(trim(new.last_name));
end //
delimiter ;

insert into actor value(201, "Joel", "Camps", "2024/05/08");
select * from actor;

-- Trigger Validacion 3
delimiter //
create trigger upper_update
before update on actor for each row
begin
	set new.first_name = upper(trim(new.first_name));
    set new.last_name = upper(trim(new.last_name));
end //
delimiter ;

update actor set first_name = "Alejandro" where actor_id = 200;
select * from actor;

-- Trigger Validacion 4
delimiter //
create trigger rental
before update on rental for each row
begin
	if datediff(new.return_date, old.rental_date)<0 then
		set new.return_date = date_add(old.rental_date, interval 3 day);
    end if;
end //
delimiter ;

update rental set return_date = "2005-05-23" where rental_id = 1;
update rental set staff_id = 2 where rental_id = 2;
select * from rental;

-- Trigger Control 1
delimiter //
create trigger staff
before update on staff for each row
begin
	set new.last_update = current_date();
end //
delimiter ;

update staff set active = 0 where staff_id = 1;
select * from staff;

-- Triger Control 2
delimiter //
create trigger log_staff
before update on staff for each row
begin
	set @id_staff = old.staff_id;
    set @mod_email = 0;
    if new.email != old.email then
		set @mod_email = 1;
	end if;
    insert into log_staff value(null, "actualitzacio", @id_staff, now(), @mod_email);
end //
delimiter ;

update staff set active = 1 where staff_id = 1;
update staff set email = "mikehilley@gmail.com" where staff_id = 1;
select * from log_staff;

-- Trigger Control 3
/delimiter //
create trigger log_staff_delete
before delete on staff for each row
begin
	set @id_staff = old.staff_id;
    insert into log_staff value(null, "esborrat", @id_staff, now(), 0);
end //
delimiter ;

set foreign_key_checks = 0;
delete from staff where staff_id = 3;
select * from log_staff;
set foreign_key_checks = 1;

-- Trigger Control 4
update customer set warnings = 0 where warnings is null;

delimiter //
create trigger rental_return
before update on rental for each row
begin
	set @id_customer = old.customer_id;
	if datediff(new.return_date, old.rental_date)>7 then        
        update customer set warnings = warnings + 1
		where customer.customer_id = @id_customer;
    end if;
end //

create trigger customer_warning
before update on customer for each row
begin
	if new.warnings = 3 then
		set new.active = 0;
	end if;
end //
delimiter ;

update rental set return_date = "2005-06-27" where rental_id = 2;
select * from customer
where warnings > 0;

-- Procedure 1
delimiter //
create procedure ingresos_fecha (in fecha_inicio date, fecha_final date, out total int)
	begin
		select sum(amount) into total from payment
        where payment_date between fecha_inicio and fecha_final;
    end//
delimiter ;

call ingresos_fecha("2005-05-25", "2005-06-21", @total);
select @total;

-- Procedure 2
delimiter //
create procedure ingresos_categoria (in categoria varchar(30), out total int)
	begin
		select sum(amount) into total from payment
        inner join rental on payment.rental_id = rental.rental_id
        inner join inventory on rental.inventory_id = inventory.inventory_id
        inner join film on inventory.film_id = film.film_id
        inner join film_category on film.film_id = film_category.film_id
        inner join category on film_category.category_id = category.category_id
        where category.name = categoria;
    end//
delimiter ;

call ingresos_categoria("Action", @total);
select @total;

-- Procedure 3
delimiter //
create procedure peli_dispo (in id_film int, id_store int, out disponible varchar(100))
	begin
		declare num_pelis int;
        select count(inventory_id) into num_pelis from inventory
        where film_id = id_film and store_id = id_store;
        if num_pelis > 0 then
			set disponible = "Esta disponible para alquilar";
		else
			set disponible = "No esta disponible para alquilar";
		end if;
    end//
delimiter ;

call peli_dispo(13, 1, @disponible);
select @disponible;
call peli_dispo(1, 1, @disponible);
select @disponible;

-- Procedure 4
delimiter //
create procedure del_clientes (in num_dias int, out mensaje varchar(50))
	begin
		declare num_del double;
        delete from customer where datediff(current_date(), last_update) >= num_dias and active = 0;
        set num_del = row_count();
        
        if num_del > 0 then
			set mensaje = num_del + " clientes han sido eliminados";
		else
			set mensaje = "No se ha borrado ningun cliente por inactividad";
		end if;
    end//
delimiter ;

set foreign_key_checks = 0;
call del_clientes(20, @mensaje);
select @mensaje;
set foreign_key_checks = 1;