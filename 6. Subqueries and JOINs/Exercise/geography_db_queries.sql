USE geography;

# Query 12. Highest Peaks in Bulgaria
SELECT mc.`country_code`, m.`mountain_range`, p.`peak_name`, p.`elevation`
FROM mountains_countries AS mc
         JOIN mountains m
              ON mc.`mountain_id` = m.`id`
         JOIN peaks p
              ON m.`id` = p.`mountain_id`
WHERE mc.`country_code` LIKE 'BG'
  AND p.`elevation` > 2835
ORDER BY p.`elevation` DESC;

# Query 13. Count Mountain Ranges
SELECT c.`country_code`, COUNT(mc.`mountain_id`) AS `mountain_range`
FROM countries AS c
         JOIN mountains_countries mc
              ON c.`country_code` = mc.`country_code`
GROUP BY c.`country_code`
HAVING c.country_code IN ('US', 'RU', 'BG')
ORDER BY `mountain_range` DESC;

# Query 14. Countries with Rivers
SELECT c.`country_name`, r.`river_name`
FROM countries AS c
         LEFT JOIN countries_rivers AS cr
                   ON c.`country_code` = cr.`country_code`
         LEFT JOIN rivers r
                   ON r.`id` = cr.`river_id`
WHERE c.`continent_code` LIKE 'AF'
ORDER BY c.`country_name`
LIMIT 5;

# Query 15. Continents and Currencies
SELECT COUNT(`country_code`) AS country_count
FROM countries
WHERE `country_code` NOT IN (SELECT `country_code`
                             FROM mountains_countries);

# Query 16. Countries Without Any Mountains
SELECT c1.`continent_code`, c1.`currency_code`, COUNT(*) AS `currency_usage`
FROM countries AS c1
GROUP BY c1.`continent_code`, c1.`currency_code`
HAVING `currency_usage` > 1
   AND `currency_usage` = (SELECT COUNT(*) AS `count_of_currencies`
                           FROM countries AS c2
                           WHERE c2.`continent_code` = c1.`continent_code`
                           GROUP BY c2.`currency_code`
                           ORDER BY `count_of_currencies` DESC
                           LIMIT 1)
ORDER BY c1.`continent_code`, c1.`currency_code`;

# Query 17. Highest Peak and Longest River by Country
SELECT c.`country_name`, MAX(p.`elevation`) AS `highest_peak_elevation`, MAX(r.`length`) `longest_river_length`
FROM countries AS c
         JOIN mountains_countries mc
              ON c.`country_code` = mc.`country_code`
         JOIN peaks p
              ON mc.`mountain_id` = p.`mountain_id`
         JOIN countries_rivers cr
              ON c.`country_code` = cr.`country_code`
         JOIN rivers r
              ON r.`id` = cr.`river_id`
GROUP BY c.`country_name`
ORDER BY `highest_peak_elevation` DESC, `longest_river_length` DESC, c.`country_name` ASC
LIMIT 5;