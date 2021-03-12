/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1;
 * That is, list all actors that have appeared in a film with 'RUSSEL BACALL'.
 * Do not list 'RUSSEL BACALL', since he has a Bacall Number of 0.
 */

SELECT "Actor Name"
FROM (
    SELECT actor.first_name || ' ' || actor.last_name AS "Actor Name"
    FROM (     
      SELECT film_actor.actor_id
      FROM (
            SELECT *
            FROM (
                SELECT film_actor.film_id, actor.first_name, actor.last_name
                FROM film_actor
                LEFT JOIN actor ON actor.actor_id=film_actor.actor_id
            ) AS full_names
            WHERE last_name LIKE 'BACALL' AND first_name LIKE 'RUSSELL'
      ) AS bacall_film_ids
      JOIN film_actor ON bacall_film_ids.film_id=film_actor.film_id
      GROUP BY actor_id
    ) AS bacall_actor_ids
    JOIN actor ON bacall_actor_ids.actor_id=actor.actor_id
) as bacall_actor_names
WHERE "Actor Name" NOT LIKE 'RUSSELL BACALL'
ORDER BY "Actor Name"
;
