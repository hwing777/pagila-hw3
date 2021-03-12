/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSEL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT "Actor Name"
FROM (
    SELECT actor.first_name || ' ' || actor.last_name AS "Actor Name"
    FROM (
        SELECT actor_id
        FROM (
            SELECT film_actor.actor_id
            FROM (
                SELECT film_actor.film_id
                FROM film_actor
                JOIN (
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
                ) AS one_actor_ids ON film_actor.actor_id=one_actor_ids.actor_id
                GROUP BY film_id
            ) AS one_film_ids
            JOIN film_actor ON one_film_ids.film_id=film_actor.film_id
            GROUP BY actor_id
        ) as all_two_actor_ids
        WHERE actor_id NOT IN (
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
        )
    ) as two_actor_ids
    JOIN actor ON two_actor_ids.actor_id=actor.actor_id
) as two_actor_names
ORDER BY "Actor Name"
;
