USE `soft_uni`;

# Query 12. Employees Minimum Salaries
SELECT `department_id`,
       MIN(`salary`) AS `minimum_salary`
FROM `employees`
WHERE `department_id` IN (2, 5, 7)
  AND `hire_date` > '2000-01-01'
GROUP BY `department_id`
ORDER BY `department_id`;

# Query 13. Employees Average Salaries
CREATE TABLE `high_paid_employees`
AS
SELECT *
FROM `employees`
WHERE `salary` > 30000;

DELETE
FROM `high_paid_employees`
WHERE `manager_id` = 42;

UPDATE `high_paid_employees`
SET `salary` = `salary` + 5000
WHERE `department_id` = 1;

SELECT `department_id`,
       AVG(`salary`) AS `avg_salary`
FROM `high_paid_employees`
GROUP BY `department_id`
ORDER BY `department_id`;

# Query 14. Employees Maximum Salaries
SELECT `department_id`,
       MAX(`salary`) AS `max_salary`
FROM `employees`
GROUP BY `department_id`
HAVING `max_salary` NOT BETWEEN 30000 AND 70000
ORDER BY `department_id`;

# Query 15. Employees Count Salaries
SELECT COUNT(*)
FROM `employees`
WHERE `manager_id` IS NULL;

# Query 16. 3rd Highest Salary
SELECT DISTINCT `department_id`,
                (SELECT DISTINCT `salary`
                 FROM `employees` AS `e1`
                 WHERE `e1`.`department_id` = `employees`.`department_id`
                 ORDER BY `salary` DESC
                 LIMIT 1 OFFSET 2) AS `third_highest_salary`
FROM `employees`
HAVING `third_highest_salary` IS NOT NULL
ORDER BY `department_id`;

# Query 17. Salary Challenge
SELECT `first_name`,
       `last_name`,
       `department_id`
FROM `employees` AS `e1`
WHERE `salary` >
      (SELECT AVG(`salary`)
       FROM `employees` AS `e2`
       WHERE `e1`.`department_id` = `e2`.`department_id`)
ORDER BY `department_id`, `employee_id`
LIMIT 10;

# Query 18. Departments Total Salaries
SELECT `department_id`, SUM(`salary`) AS `total_salary`
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;
