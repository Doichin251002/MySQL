# Task 12. Car Rental Database
CREATE DATABASE `car_rental`;
USE `car_rental`;

CREATE TABLE `categories`
(
    `id`           INT PRIMARY KEY AUTO_INCREMENT,
    `category`     VARCHAR(20) NOT NULL,
    `daily_rate`   DOUBLE,
    `weekly_rate`  DOUBLE,
    `monthly_rate` DOUBLE,
    `weekend_rate` DOUBLE
);

INSERT INTO `categories` (`category`)
VALUES ('test1'),
       ('test2'),
       ('test3');

CREATE TABLE `cars`
(
    `id`            INT PRIMARY KEY AUTO_INCREMENT,
    `plate_number`  VARCHAR(20) NOT NULL,
    `make`          VARCHAR(20),
    `model`         VARCHAR(20),
    `car_year`      YEAR,
    `category_id`   INT         NOT NULL,
    `doors`         INT,
    `picture`       BLOB,
    `car_condition` VARCHAR(100),
    `available`     BOOLEAN DEFAULT TRUE
);

INSERT INTO `cars` (`plate_number`, `category_id`)
VALUES ('test1', 1),
       ('test2', 2),
       ('test3', 3);

CREATE TABLE `employees`
(
    `id`         INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(20) NOT NULL,
    `last_name`  VARCHAR(20) NOT NULL,
    `title`      VARCHAR(20),
    `notes`      TEXT
);

INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Test1', 'test1'),
       ('Test2', 'test2'),
       ('Test3', 'test3');

CREATE TABLE `customers`
(
    `id`                    INT PRIMARY KEY AUTO_INCREMENT,
    `driver_licence_number` VARCHAR(50) NOT NULL,
    `full_name`             VARCHAR(60),
    `address`               VARCHAR(50),
    `city`                  VARCHAR(40),
    `zip_code`              VARCHAR(10),
    `notes`                 TEXT
);

INSERT INTO `customers` (`driver_licence_number`, `full_name`)
VALUES ('test1', 'Test1'),
       ('test2', 'Test2'),
       ('test3', 'Test3');

CREATE TABLE `rental_orders`
(
    `id`                INT PRIMARY KEY AUTO_INCREMENT,
    `employee_id`       INT NOT NULL,
    `customer_id`       INT NOT NULL,
    `car_id`            INT NOT NULL,
    `car_condition`     VARCHAR(50),
    `tank_level`        INT,
    `kilometrage_start` DOUBLE,
    `kilometrage_end`   DOUBLE,
    `total_kilometrage` DOUBLE,
    `start_date`        DATE,
    `end_date`          DATE,
    `total_days`        INT,
    `rate_applied`      DOUBLE,
    `tax_rate`          DOUBLE,
    `order_status`      VARCHAR(20),
    `notes`             TEXT
);

INSERT INTO `rental_orders` (`employee_id`, `customer_id`, `car_id`)
VALUES (1, 2, 3),
       (1, 2, 3),
       (1, 2, 3);

# Task 13. Basic Insert
CREATE DATABASE `soft_uni`;
USE `soft_uni`;

CREATE TABLE `towns`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL
);

CREATE TABLE `addresses`
(
    `id`           INT PRIMARY KEY AUTO_INCREMENT,
    `address_text` TEXT,
    `town_id`      INT
);

CREATE TABLE `departments`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

CREATE TABLE `employees`
(
    `id`            INT PRIMARY KEY AUTO_INCREMENT,
    `first_name`    VARCHAR(30)  NOT NULL,
    `middle_name`   VARCHAR(30)  NOT NULL,
    `last_name`     VARCHAR(30)  NOT NULL,
    `job_title`     VARCHAR(40),
    `department_id` INT          NOT NULL,
    `hire_date`     DATETIME DEFAULT NOW(),
    `salary`        DOUBLE(6, 2) NOT NULL,
    `address_id`    INT,
    FOREIGN KEY (`department_id`)
        REFERENCES `departments` (`id`),
    FOREIGN KEY (`address_id`)
        REFERENCES `addresses` (`id`)
);

INSERT INTO `towns`(`name`)
VALUES ('Sofia'),
       ('Plovdiv'),
       ('Varna'),
       ('Burgas');

INSERT INTO `departments`(`name`)
VALUES ('Engineering'),
       ('Sales'),
       ('Marketing'),
       ('Software Development'),
       ('Quality Assurance');

INSERT INTO `employees`(`first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`, `salary`)
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01 00:00:00', 3500.00),
       ('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02 00:00:00', 4000.00),
       ('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28 00:00:00', 525.25),
       ('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09 00:00:00', 3000.00),
       ('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28 00:00:00', 599.88);

# Task 14. Basic Select All Fields,
# Task 15. Basic Select All Fields and Order Them
# Task 16. Basic Select Some Fields
SELECT `name`
FROM `towns` AS `t`
ORDER BY `t`.`name`;
SELECT `name`
FROM `departments` AS `d`
ORDER BY `d`.`name`;
SELECT `first_name`,
       `last_name`,
       `job_title`,
       `salary`
FROM `employees` AS `e`
ORDER BY `e`.`salary` DESC;

# Task 17. Increase Employees Salary
UPDATE `employees`
SET `salary` = `salary` * 1.1;

SELECT `salary`
FROM `employees`;