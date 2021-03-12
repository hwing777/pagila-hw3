/*
 * Management is planning on purchasing new inventory.
 * Films with special features cost more to purchase than films without special features,
 * and so management wants to know if the addition of special features impacts revenue from movies.
 *
 * Write a query that for each special_feature, calculates the total profit of all movies rented with that special feature.
 *
 * HINT:
 * Start with the query you created in pagila-hw1 problem 16, but add the special_features column to the output.
 * Use this query as a subquery in a select statement similar to answer to the previous problem.
 */

SELECT feature as "special_feature", sum(profit) as "profit"
FROM  (
    SELECT film_id, sum(amount) as profit, special_features
    FROM (
        SELECT payment.payment_id, payment.amount, rental_title.film_id, rental_title.special_features
        FROM PAYMENT
        LEFT JOIN (
            SELECT rental.rental_id, inventory_title.film_id, inventory_title.special_features
            FROM rental
            LEFT JOIN (
                SELECT inventory.inventory_id, film.film_id, film.special_features
                FROM inventory
                LEFT JOIN film ON inventory.film_id=film.film_id
            ) AS inventory_title ON rental.inventory_id=inventory_title.inventory_id
        ) AS rental_title ON payment.rental_id=rental_title.rental_id
    ) AS payment_title
    GROUP BY film_id, special_features
) i, unnest(special_features) x(feature)
GROUP BY feature
ORDER BY feature;

