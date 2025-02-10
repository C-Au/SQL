-- @block 1) My partner and I want to come by each of the stores in person and meet the managers. Please send over the managers' names at each store, with the full address of each property (street address, district, city, and country please).
SELECT
    first_name,
    last_name,
    address,
    district,
    city,
    country
FROM
    staff s
    INNER JOIN store st ON s.store_id = st.store_id
    INNER JOIN address a ON st.address_id = a.address_id
    INNER JOIN city c ON a.city_id = c.city_id
    INNER JOIN country co ON c.country_id = co.country_id;

-- @block 2) I would like to get a better understanding of all of the inventory that would come along with the business. Please pull together a list of each inventory item you have stocked, including the store_id number, the inventory_id, the name of the film, the film's rating, its rental rate and replacement cost.
SELECT
    store_id,
    inventory_id,
    title AS title_of_film,
    rating AS film_rating,
    rental_rate,
    replacement_cost
FROM
    film f
    INNER JOIN inventory i ON f.film_id = i.film_id;

-- @block 3) From the same list of films you just pulled, please roll that data up and provide a summary level overview of your inventory. We would like to know how many inventory items you have with each rating at each store.
SELECT
    store_id,
    rating AS film_rating,
    COUNT(rating) AS number_of_movies_per_rating
FROM
    film f
    INNER JOIN inventory i ON f.film_id = i.film_id
    AND store_id = 1
GROUP BY
    rating
UNION
SELECT
    store_id,
    rating AS film_rating,
    COUNT(rating) AS number_of_movies_per_rating
FROM
    film f
    INNER JOIN inventory i ON f.film_id = i.film_id
    AND store_id = 2
GROUP BY
    rating;

-- @block Check on question 3
SELECT
    store_id,
    rating,
    title
FROM
    film f
    INNER JOIN inventory i ON f.film_id = i.film_id
    AND store_id = 2
    AND rating = 'G';

-- @block 4) Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to see how big of a hit it would be if a certain category of film became unpopular at a certain store. We would like to see the number of films, as well as the average replacement cost, and total replacement cost, sliced by store and film category.
SELECT
    store_id,
    c.name AS film_category_name,
    COUNT(*) AS number_of_films,
    ROUND(AVG(replacement_cost), 2) AS avg_replacement_cost,
    ROUND(SUM(replacement_cost), 2) AS total_replacement_cost
FROM
    film f
    INNER JOIN film_category fc ON f.film_id = fc.film_id
    INNER JOIN category c ON fc.category_id = c.category_id
    INNER JOIN inventory i ON f.film_id = i.film_id
    AND store_id = 1
GROUP BY
    film_category_name
UNION
SELECT
    store_id,
    c.name AS film_category_name,
    COUNT(*) AS number_of_films,
    ROUND(AVG(replacement_cost), 2) AS avg_replacement_cost,
    ROUND(SUM(replacement_cost), 2) AS total_replacement_cost
FROM
    film f
    INNER JOIN film_category fc ON f.film_id = fc.film_id
    INNER JOIN category c ON fc.category_id = c.category_id
    INNER JOIN inventory i ON f.film_id = i.film_id
    AND store_id = 2
GROUP BY
    film_category_name;

-- @block 5) We want to make sure you folks have a good handle on who your customers are. Please provide a list of all customer names, which store they go to, whether or not they are currently active, and their full addresses - street address, city, and country.
SELECT
    first_name,
    last_name,
    store_id,
    CASE
        WHEN active = 1 THEN 'active'
        WHEN active = 0 THEN 'inactive'
        ELSE 'Check your logic'
    END AS status,
    address,
    district,
    city,
    country
FROM
    customer cu
    INNER JOIN address a ON cu.address_id = a.address_id
    INNER JOIN city ci ON a.city_id = ci.city_id
    INNER JOIN country co ON ci.country_id = co.country_id
ORDER BY
    first_name;

-- @block 6) We would like to understand how much your customers are spending with you, and also to know who your most valuable customers are. Please pull together a list of customer names, their total lifetime rentals, and the sum of all payments you have collected from them. It would be great to see this ordered on total lifetime value, with the most valuable customers at the top of the list.
SELECT
    cu.first_name,
    cu.last_name,
    COUNT(r.rental_id) AS number_of_rentals,
    SUM(p.amount) AS sum_of_all_payments
FROM
    customer cu
    LEFT JOIN rental r ON cu.customer_id = r.customer_id
    LEFT JOIN payment p ON r.customer_id = p.customer_id
GROUP BY
    cu.first_name,
    cu.last_name
ORDER BY
    SUM(p.amount) DESC;

-- @block 7) My partner and I would like to get to know your board of advisors and any current investors. Could you please provide a list of advisor and investor names in one table? Could you please note whether they are an investor or an advisor, and for the investors, it would be good to include which company they work with.
SELECT
    'advisor' AS type,
    first_name,
    last_name,
    ' ' AS company_name
FROM
    advisor
UNION
SELECT
    'investor' AS type,
    first_name,
    last_name,
    company_name
FROM
    investor;

