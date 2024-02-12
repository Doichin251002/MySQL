# Query 10. Countries Holding 'A'
USE geography;

SELECT country_name,
       iso_code
FROM countries
WHERE country_name LIKE '%A%A%A%'
ORDER BY iso_code;

# Query 11. Mix of Peak and River Names
SELECT p.peak_name,
       r.river_name,
       LOWER(CONCAT(LEFT(p.peak_name,
                         LENGTH(p.peak_name) - 1),
                    r.river_name)) AS mix
FROM peaks AS p,
     rivers AS r
WHERE LOWER(RIGHT(p.peak_name, 1)) = LOWER(LEFT(r.river_name, 1))
ORDER BY mix;