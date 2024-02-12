USE `hotel`;

# Query 1. Select Employee Information
SELECT `id`         AS 'No.',
       `first_name` AS 'First name',
       `last_name`  AS 'Last name',
       `job_title`  AS 'Job title'
FROM `employees`
ORDER BY `id`;

# Query 2. Select Employees with Filter
SELECT `id`                                 AS 'No.',
       CONCAT_WS(`first_name`, `last_name`) AS 'Full name',
       `job_title`                          AS 'Job title',
       `salary`                             AS 'Salary'
FROM `employees`
WHERE `salary` > 1000
ORDER BY `id`;

# Query 3. Update Salary and Select
UPDATE `employees`
SET `salary` = `salary` + 100
WHERE `job_title` = 'Manager';

SELECT `salary`
FROM `employees`;

# Query 4. Top Paid Employee
CREATE VIEW `v_top_paid_employee` AS
SELECT *
FROM `employees`
ORDER BY `salary` DESC
LIMIT 1;

# Query 5. Select Employees by Multiple Filters
SELECT *
FROM `employees`
WHERE `department_id` = 4
  AND `salary` >= 1000
ORDER BY `id`;

# Query 6. Delete from Table
DELETE
FROM `employees`
WHERE `department_id` = 1
   OR `department_id` = 2;

SELECT *
FROM `employees`
ORDER BY `id`;