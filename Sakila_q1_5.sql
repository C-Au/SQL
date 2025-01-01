-- @block Testing the database
SELECT
    *
FROM
    actor;

-- @block 1) Retrieve the first name and last name of customers along with the rental dates of the movies they rented.
SELECT
    c.first_name,
    c.last_name,
    r.rental_date
FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id;

-- @block 2) Get the film title, the customer's full name (first and last), and the rental date for all movies rented.
-- This query works ONLY in MySQL Workbench. *Need to talk to Adi about this query.
SELECT
    title,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    r.rental_date
FROM
    customer c
    JOIN inventory i ON c.store_id = i.store_id
    JOIN film f ON i.film_id = f.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id;

-- @block 3) Find all films rented by customers whose first name is "MARY". Include the film title, rental date, and customer last name in the result.
-- This query works ONLY in MySQL Workbench. *Need to talk to Adi about this query.
SELECT
    title,
    r.rental_date,
    c.last_name
FROM
    customer c
    JOIN inventory i ON c.store_id = i.store_id
    JOIN film f ON i.film_id = f.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
WHERE
    c.first_name LIKE 'MARY%'
ORDER BY
    r.rental_date ASC;

-- @block 4) Find the total number of films rented by each customer. Include the customer's ID and the total rentals in the result.
SELECT
    r.customer_id,
    COUNT(r.customer_id) AS total_rentals
FROM
    customer c
    JOIN rental r ON c.customer_id = r.customer_id
GROUP BY
    r.customer_id
ORDER BY
    r.customer_id;

-- @block 5) Retrieve the film titles and their actors, including films with no actors assigned. If a film has no associated actors, display NULL for actor names.
SELECT
    f.title,
    a.first_name,
    a.last_name
FROM
    actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN film f ON fa.film_id = f.film_id
ORDER BY
    f.title;