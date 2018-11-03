use sakila;

-- 1a. Display the first and last names of all actors from the table actor.
select last_name, first_name
from sakila.actor;

-- 1b. column Actor Name, display first and last name of each actor in a single column
Select last_name, first_name, concat(last_name, ' ' , first_name) AS full_name
FROM sakila.actor;


-- 2a. find ID number, first name and last name of an actor with first name "Joe"
select actor_id, first_name, last_name
from sakila.actor
where first_name = "joe";

-- 2b. all actors whose last name contain the letters GEN:
select *
from sakila.actor
where last_name LIKE '%GEN%';

-- 2c. Find all actors whose last names contain the leters LI.  Order the rows by last name and first name
select *
from sakila.actor
where last_name LIKE '%LI%'
ORDER BY LAST_NAME, first_name;


-- 2d. use IN, display country_id and country columns of Afghanistan, Bangladesh, China
select country_id, country
from sakila.country
where country IN ('Afghanistan','Bangladesh','China');

-- 3a. create description column in table actor. use data type BLOB
alter table sakila.actor
add column description BLOB;

-- 3b drop previous
alter table sakila.actor
drop column description;

-- 4a List last names and how many per last name
select last_name, count(*)
from sakila.actor
group by last_name
order by last_name;


-- 4b List last names of actors and number of actors but only shared by at least two
select last_name, count(*) as at_least_two
-- when last_name>1 then 1 else 0
-- ,if(last_name>2,0,3) as only_2_or_more
from sakila.actor
group by last_name
having at_least_two <>1;
-- where count(last_name)<>1

select *
from sakila.actor
where first_name ='Groucho'and last_name = 'williams';

-- 4c change Groucho Williams to Harpo Williams
update sakila.actor
set first_name = 'Harpo'
where first_name ='groucho'and last_name = 'williams';

-- 4d Reverse previous query to Groucho Williams
update sakila.actor
set first_name ='Groucho'
where actor_id = 172;

select * from sakila.address;

select * from sakila.staff;


-- 5a create a copy of address
use sakila;
create table address2

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:

select * from sakila.address;

select s.first_name, s.last_name, a.address
from staff as s
inner join address as a
on s.address_id = a.address_id;



-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.

select s.first_name,s.last_name,a.address
from address as a
join staff as s
on a.address_id = s.address_id;


-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
select * from staff;
select * from payment;

select concat(s.last_name," ",s.first_name) as full_name, sum(amount) as August_amount
From payment as p
join staff as s
on s.staff_id = p.staff_id
where year(p.payment_date) = 2005 and month(p.payment_date) = 08
group by s.staff_id;


-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.

select * from film;
select * from film_actor;

select f.title,count(f.film_id)
from film as f
join film_actor as fa
on f.film_id = fa.film_id
group by f.title;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?

select count(f.title = 'Huchback Impossible')
from film as f
where film_id in (select film_id from film
where title in ("Hunchback Impossible"));



-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
select * from payment;
select * from customer;



select c.first_name, c.last_name, 
sum(distinct amount) as Total_Cust_paid
From payment as p
join customer as c
on c.customer_id = p.customer_id
group by c.last_name;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
-- As an unintended consequence, films starting with the letters K and Q 
-- have also soared in popularity. Use subqueries to display the titles of movies
-- starting with the letters K and Q whose language is English.

select * from film;
select * from film_actor;


select * from film
where title like "k%"
	OR title like "q%"
;

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

select "Alone Trip" from film as f
-- where title like "k%"
-- 	OR title like "q%"
join film_actor as fa
on fa.actor_id = actor_id
group by actor_id;


