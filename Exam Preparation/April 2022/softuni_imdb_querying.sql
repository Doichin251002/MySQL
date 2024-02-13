USE softuni_imdb;

# Query 5. Select Countries
SELECT *
FROM countries
ORDER BY currency DESC, id;

# Query 6. Select Old movies
SELECT mai.id,
       m.title,
       mai.runtime,
       mai.budget,
       mai.release_date
FROM movies_additional_info mai
         JOIN movies m ON mai.id = m.movie_info_id
WHERE YEAR(release_date) BETWEEN 1996 AND 1999
ORDER BY runtime, id
LIMIT 20;

# Query 7. Movie casting
SELECT CONCAT_WS(' ', first_name, last_name)                           AS full_name,
       CONCAT(reverse(last_name), CHAR_LENGTH(last_name), '@cast.com') AS email,
       (2022 - year(birthdate))                                        AS age,
       height
FROM actors
         LEFT JOIN movies_actors ma ON actors.id = ma.actor_id
WHERE ma.actor_id IS NULL
ORDER BY height;

# Query 8. International festival
SELECT name,
       COUNT(country_id) AS movies_count
FROM countries
         JOIN movies m ON countries.id = m.country_id
GROUP BY country_id, name
HAVING movies_count >= 7
ORDER BY name DESC;

# Query 9. Rating system
SELECT title,
       (SELECT CASE
                   WHEN rating <= 4 THEN 'poor'
                   WHEN rating > 4 AND rating <= 7 THEN 'good'
                   ELSE 'excellent' END)     AS rating,
       IF(has_subtitles = 1, 'english', '-') AS subtitles,
       budget
FROM movies
         JOIN movies_additional_info mai ON mai.id = movies.movie_info_id
ORDER BY budget DESC;