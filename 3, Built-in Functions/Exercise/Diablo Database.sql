# Query 12. Games From 2011 and 2012 Year
USE diablo;

SELECT
    `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS `start`
FROM
    games
WHERE
        YEAR(`start`) IN (2011 , 2012)
ORDER BY `start` , `name`
LIMIT 50;

# Query 13. User Email Providers
SELECT
    `user_name`,
    SUBSTRING(`email`,
              LOCATE('@', `email`) + 1) AS `email provider`
FROM
    users
ORDER BY `email provider` , `user_name`;

# Query 14. Get Users with IP Address Like Pattern
SELECT
    `user_name`, `ip_address`
FROM
    users
WHERE
        `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

# Query 15. Show All Games with Duration
SELECT
    `name` AS `game`,
    CASE
        WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
        END AS `Part of the Day`,
    CASE
        WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` BETWEEN 4 AND 6 THEN 'Short'
        WHEN `duration` BETWEEN 7 AND 10 THEN 'Long'
        ELSE 'Extra Long'
        END AS `Duration`
FROM
    games;-- DATABASE diablo
# Query 12. Games From 2011 and 2012 Year
USE diablo;

SELECT
    `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS `start`
FROM
    games
WHERE
        YEAR(`start`) IN (2011 , 2012)
ORDER BY `start` , `name`
LIMIT 50;

# Query 13. User Email Providers
SELECT
    `user_name`,
    SUBSTRING(`email`,
              LOCATE('@', `email`) + 1) AS `email provider`
FROM
    users
ORDER BY `email provider` , `user_name`;

# Query 14. Get Users with IP Address Like Pattern
SELECT
    `user_name`, `ip_address`
FROM
    users
WHERE
        `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

# Query 15. Show All Games with Duration
SELECT
    `name` AS `game`,
    CASE
        WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
        END AS `Part of the Day`,
    CASE
        WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` BETWEEN 4 AND 6 THEN 'Short'
        WHEN `duration` BETWEEN 7 AND 10 THEN 'Long'
        ELSE 'Extra Long'
        END AS `Duration`
FROM
    games;