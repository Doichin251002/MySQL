# Query 21. All Mountain Peaks
USE `geography`;

SELECT `peak_name`
FROM `peaks`
ORDER BY `peak_name`;

# Query 22. Biggest Countries by Population
SELECT `country_name`,
       `population`
FROM `countries`
WHERE `continent_code` LIKE 'EU'
ORDER BY `population` DESC, `country_name`
LIMIT 30;

# Query 23. Countries and Currency (Euro / Not Euro)
SELECT `country_name`,
       `country_code`,
       IF(`currency_code` = 'EUR',
          'Euro',
          'Not Euro') AS 'currency'
FROM `countries`
ORDER BY `country_name`;