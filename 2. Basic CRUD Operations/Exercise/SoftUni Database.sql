# Query 1. Find All Information About Departments
USE `soft_uni`;

SELECT *
FROM `departments`
ORDER BY `department_id`;

# Query 2. Find all Department Names
SELECT `name`
FROM `departments`
ORDER BY `department_id`;

# Query 3. Find Salary of Each Employee
SELECT `first_name`,
       `last_name`,
       `salary`
FROM `employees`
ORDER BY `employee_id`;

# Query 4. Find Full Name of Each Employee
SELECT `first_name`,
       `middle_name`,
       `last_name`
FROM `employees`
ORDER BY `employee_id`;

# Query 5. Find Email Address of Each Employee
SELECT CONCAT(`first_name`,
              '.',
              `last_name`,
              '@softuni.bg') AS `full_email_address`
FROM `employees`;

# Query 6. Find All Different Employee’s Salaries
SELECT DISTINCT `salary`
FROM `employees`;

# Query 7. Find all Information About Employees
SELECT `employee_id`   AS `id`,
       `first_name`    AS `First Name`,
       `last_name`     AS `Last Name`,
       `middle_name`   AS `Middle Name`,
       `job_title`     AS `Job Title`,
       `department_id` AS `Dept ID`,
       `manager_id`    AS `Mngr ID`,
       `hire_date`     AS `Hire Date`,
       `salary`,
       `address_id`
FROM `employees`
WHERE `job_title` = 'Sales Representative';

# Query 8. Find Names of All Employees by Salary in Range
SELECT `first_name`,
       `last_name`,
       `job_title`
FROM `employees`
WHERE `salary` BETWEEN 20000 AND 30000
ORDER BY `employee_id`;

# Query 9. Find Names of All Employees
SELECT CONCAT(`first_name`,
              ' ',
              `middle_name`,
              ' ',
              `last_name`) AS `Full Name`
FROM `employees`
WHERE `salary` IN (25000, 14000, 12500, 23600);

# Query 10. Find All Employees Without Manager
SELECT `first_name`,
       `last_name`
FROM `employees`
WHERE `manager_id` IS NULL;

# Query 11. Find All Employees with Salary More Than
SELECT `first_name`,
       `last_name`,
       `salary`
FROM `employees`
WHERE `salary` > 50000
ORDER BY `salary` DESC;

# Query 12. Find 5 Best Paid Employees
SELECT `first_name`,
       `last_name`
FROM `employees`
ORDER BY `salary` DESC
LIMIT 5;

# Query 13. Find All Employees Except Marketing
SELECT `first_name`,
       `last_name`
FROM `employees`
WHERE NOT `department_id` = 4;

# Query 14. Sort Employees Table
SELECT *
FROM `employees`
ORDER BY `salary` DESC, `first_name` ASC, `last_name` DESC, `middle_name` ASC, `employee_id` ASC;

# Query 15. Create View Employees with Salaries
CREATE VIEW `v_employees_salaries` AS
SELECT `first_name`,
       `last_name`,
       `salary`
FROM `employees`;

# Query 16. Create View Employees with Job Titles
CREATE VIEW `v_employees_job_titles` AS
SELECT CONCAT_WS(' ',
                 `first_name`,
                 `middle_name`,
                 `last_name`) AS `full_name`,
       `job_title`
FROM `employees`;

# Query 17. Distinct Job Titles
SELECT DISTINCT `job_title`
FROM `employees`
ORDER BY `job_title`;

# Query 18. Find First 10 Started Projects
SELECT *
FROM `projects`
ORDER BY `start_date`, `name`, `project_id`
LIMIT 10;

# Query 19. Last 7 Hired Employees
SELECT `first_name`,
       `last_name`,
       `hire_date`
FROM `employees`
ORDER BY `hire_date` DESC
LIMIT 7;

# Query 20. Increase Salaries
UPDATE `employees`
SET `salary` = `salary` * 1.12
WHERE `department_id` IN (1, 2, 4, 11);

SELECT `salary`
FROM `employees`;