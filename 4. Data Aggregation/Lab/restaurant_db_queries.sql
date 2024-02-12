USE `restaurant`;

# Query 1. Departments Info
SELECT `department_id`,
       COUNT(`department_id`) AS `Number of employees`
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`, `Number of employees`;

# Query 2. Average Salary
SELECT `department_id`,
       ROUND(AVG(`salary`), 2) AS `Average Salary`
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;

# Query 3. Minimum Salary
SELECT `department_id`,
       ROUND(MIN(`salary`), 2) AS `Min Salary`
FROM `employees`
GROUP BY `department_id`
HAVING `Min Salary` > 800;

# Query 4. Appetizers Count
SELECT COUNT(`category_id`)
FROM `products`
WHERE `category_id` = 2
  AND `price` > 8;

# Query 5. Menu Prices
SELECT `category_id`,
       ROUND(AVG(`price`), 2) AS `Average Price`,
       MIN(`price`)           AS `Cheapest Product`,
       MAX(`price`)           AS `Most Expensive Product`
FROM `products`
GROUP BY `category_id`;