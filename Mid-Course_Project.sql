-- @block 1) List of all staff members, including their first and last names, email addresses, and the store identification number where they work.
SELECT
    first_name,
    last_name,
    email,
    store_id
FROM
    staff;

-- @block 2) Get separate counts of inventory items held at each of your two stores.
SELECT
    COUNT(DISTINCT inventory_id) AS Total_inventory_at_each_store,
    store_id
FROM
    inventory
GROUP BY
    store_id;

-- @block 3) Count the number of active customers for each of your stores. Separately, please.
SELECT
    COUNT(DISTINCT customer_id) AS Store_1_total_customers,
    store_id
FROM
    customer
WHERE active = 1
GROUP BY store_id;

-- @block 4) Provide a count of all customer email addresses stored in the database.
SELECT
    COUNT(DISTINCT email) AS Total_email_addresses
FROM
    customer;

-- @block 5) Provide a count of unique film titles you have in inventory at each store and (see 5b below)
SELECT
    COUNT(DISTINCT film_id) AS Total_unique_film_titles,
    store_id
FROM
    inventory
GROUP BY
    store_id
ORDER BY
    store_id;

-- @block 5b) then provide a count of the unique categories of films you provide.
SELECT
    COUNT(DISTINCT name) AS Total_unique_categories
FROM
    category;

-- @block 6) Provide the replacement cost for the film that is least expensive to replace, the most expensive to replace, and the average of all films.

SELECT
    MIN(replacement_cost) AS least_expensive,
    MAX(replacement_cost) AS most_expensive,
    ROUND(AVG(replacement_cost), 2) AS average_replacement_cost
FROM
    film;

-- @block 7a) Please provide the average payment you process, as well as the 7b) maximum payment you have processed.
SELECT
    ROUND(AVG(amount), 2) AS Average_payment,
    MAX(amount) AS Max_payment
FROM
    payment;

-- @block 8) Please provide a list of all customer identification values, with a count of rentals they have made all-time, with your highest volume customers at the top of the list.
SELECT
    customer_id,
    COUNT(DISTINCT rental_id) AS number_of_rentals
FROM
    rental
GROUP BY
    customer_id
ORDER BY
    number_of_rentals DESC;
