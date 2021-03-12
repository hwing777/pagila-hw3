/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */
select actor.first_name || ' ' || actor.last_name as "Actor Name"
FROM (
SELECT film_actor.actor_id
FROM film
RIGHT JOIN film_actor ON film_actor.film_id=film.film_id
WHERE 'Behind the Scenes' = ANY (special_features)
GROUP BY film_actor.actor_id
) as actor_features
LEFT JOIN actor ON actor_features.actor_id=actor.actor_id
GROUP BY "Actor Name"
ORDER BY "Actor Name"
;
