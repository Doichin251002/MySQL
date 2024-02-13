USE `soft_uni`;

# Query 1. Managers
SELECT `e`.`employee_id`,
       CONCAT_WS(' ', `first_name`, `last_name`) AS `full_name`,
       `d`.`department_id`,
       `d`.`name` AS `department_name`
FROM `departments`    AS `d`
     JOIN `employees` AS `e`
          ON `d`.`manager_id` = `e`.`employee_id`
ORDER BY `employee_id`
LIMIT 5;

# Query 2. Towns Addresses
SELECT `t`.`town_id`,
       `t`.`name` AS `town_name`,
       `a`.`address_text`
FROM `towns`          AS `t`
     JOIN `addresses` AS `a`
          ON `t`.`town_id` = `a`.`town_id`
WHERE `t`.`name` IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY `t`.`town_id`, `a`.`address_id`;

SELECT `t`.`town_id`,
       `t`.`name` AS `town_name`,
       `a`.`address_text`
FROM `towns`     AS `t`
     JOIN `addresses` AS `a`
          ON `t`.`town_id` = `a`.`town_id`
WHERE `t`.`name` IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY `t`.`town_id`, `a`.`address_id`;

# Query 3. Employees Without Managers
SELECT `employee_id`,
       `first_name`,
       `last_name`,
       `department_id`,
       `salary`
FROM `employees`
WHERE `manager_id` IS NULL;

# Query 4. Higher Salary
SELECT COUNT(`salary`)
FROM `employees`
WHERE `salary` > (SELECT AVG(`salary`)
                  FROM `employees`);