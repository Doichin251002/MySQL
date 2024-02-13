USE softuni_imdb;

# Query 2. Insert
INSERT INTO actors(first_name, last_name, birthdate, height, awards, country_id)
SELECT REVERSE(first_name),
       REVERSE(last_name),
       ADDDATE(birthdate, INTERVAL -2 DAY),
       height + 10,
       country_id,
       (SELECT id
        FROM countries
        WHERE name LIKE 'Armenia')
FROM actors
WHERE id <= 10;

# Query 3. Update
UPDATE movies_additional_info
SET runtime = runtime - 10
WHERE id BETWEEN 15 AND 25;

# Query 4. Delete
DELETE c
FROM countries c
         LEFT JOIN movies m ON c.id = m.country_id
WHERE m.country_id IS NULL;