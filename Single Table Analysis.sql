-- @block 1) Testing the database
SELECT
    *
FROM
    payment;

-- @block 2) Selecting Specific columns
SELECT
    customer_id,
    rental_date
FROM
    rental;

-- @block 3) ASSIGNMENT: SELECT & FROM
SELECT
    first_name,
    last_name,
    email
FROM
    customer;

-- @block 4) ASSIGNMENT: SELECT DISTINCT
SELECT
    DISTINCT rental_duration
FROM
    film;

-- @block 5) ASSIGNMENT: WHERE
-- This query selects the customer_id, rental_id, amount, and payment_date
-- from the payment table for customers with an ID less than or equal to 100.
SELECT
    customer_id,
    rental_id,
    amount,
    payment_date
FROM
    payment
WHERE
    customer_id <= 100;

-- @block 6) ASSIGNMENT: Combining WHERE & AND
SELECT
    customer_id,
    rental_id,
    amount,
    payment_date
FROM
    payment
WHERE
    customer_id <= 100
    AND amount >= 5
    AND payment_date > '2006-01-01';

-- @block 7a) ASSIGNMENT: Combining WHERE & OR
SELECT
    customer_id,
    rental_id,
    amount,
    payment_date
FROM
    payment
WHERE
    amount >= 5
    OR customer_id = 42
    OR customer_id = 53
    OR customer_id = 60
    OR customer_id = 75;

-- @block 7b) Where to use "IN"
-- better to use "IN" on line 80
SELECT
    customer_id,
    rental_id,
    amount,
    payment_date
FROM
    payment
WHERE
    amount >= 5
    OR customer_id IN (42, 53, 60, 75);

-- @block 8) ASSIGNMENT: The "Like" operator
SELECT
    title,
    special_features
FROM
    film
WHERE
    special_features LIKE '%Behind the Scenes%';

-- @block 9) ASSIGNMENT: GROUP BY
SELECT
    rental_duration,
    COUNT(film_id) AS films_with_this_rental_duration
FROM
    film
GROUP BY
    rental_duration;

-- @block Example: Multiple Dimension GROUP BY Clauses
SELECT
    rating,
    replacement_cost,
    COUNT(film_id) AS films_with_this_rating_and_cost
FROM
    film
GROUP BY
    rental_duration,
    rating,
    replacement_cost;

-- @block 10) ASSIGNMENT: GROUP BY
SELECT
    replacement_cost,
    COUNT(film_id) AS number_of_films,
    MIN(rental_rate) AS cheapest_rental,
    MAX(rental_rate) AS most_expensive_rental,
    AVG(rental_rate) AS average_rental
FROM
    film
GROUP BY
    replacement_cost
ORDER BY
    replacement_cost DESC;

-- @block 11) ASSIGNMENT: HAVING 
SELECT
    customer_id,
    COUNT(rental_id) AS number_of_rentals
FROM
    rental
GROUP BY
    customer_id
HAVING
    COUNT(rental_id) < 15;

-- @block 12) ASSIGNMENT: ORDER BY
SELECT
    title,
    length,
    rental_rate
FROM
    film
ORDER BY
    length DESC;

-- @block 13) ASSIGNMENT: The "CASE" statement
SELECT
    first_name,
    last_name,
    CASE
        WHEN store_id = 1
        AND active = 1 THEN 'store 1 active'
        WHEN store_id = 1
        AND active = 0 THEN 'store 1 inactive'
        WHEN store_id = 2
        AND active = 1 THEN 'store 2 active'
        WHEN store_id = 2
        AND active = 0 THEN 'store 2 inactive'
        ELSE 'Check your logic'
    END AS store_and_status
FROM
    customer;

-- @block 14) DEMO: COUNT & CASE
SELECT
    film_id,
    COUNT(
        CASE
            WHEN store_id = 1 THEN inventory_id
            ELSE NULL
        END
    ) AS count_of_store_1_inventory,
    COUNT(
        CASE
            WHEN store_id = 2 THEN inventory_id
            ELSE NULL
        END
    ) AS count_of_store_2_inventory
FROM
    inventory
GROUP BY
    film_id
ORDER BY
    film_id;

-- @block 14) ASSIGNMENT: COUNT & CASE

SELECT
    store_id,
    COUNT(
        CASE
            WHEN active = 1 THEN customer_id
            ELSE NULL
        END
    ) AS active,
    COUNT(
        CASE
            WHEN active = 0 THEN customer_id
            ELSE NULL
        END
    ) AS inactive
FROM
    customer
GROUP BY
    store_id
ORDER BY
    store_id;