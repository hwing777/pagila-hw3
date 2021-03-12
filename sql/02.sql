/*
 * Count the number of movies that contain each type of special feature.
 */

SELECT feature as "special_features", count(film_id) as "count"
FROM  (
   SELECT *
   FROM   film
   ) i, unnest(special_features) x(feature)
GROUP BY feature
ORDER BY feature
;
