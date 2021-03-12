/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 */


SELECT title
FROM film
WHERE 'Trailers' = ANY (special_features) and rating = 'G'
ORDER BY title DESC
;
