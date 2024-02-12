# Task 0. Gamebar Database
CREATE DATABASE IF NOT EXISTS `gamebar`;
USE `gamebar`;

# Task 1. Create Tables
CREATE TABLE `employees`
(
    `id`         INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(20) NOT NULL,
    `last_name`  VARCHAR(20) NOT NULL
);

CREATE TABLE `categories`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL
);

CREATE TABLE `products`
(
    `id`          INT PRIMARY KEY AUTO_INCREMENT,
    `name`        VARCHAR(20) NOT NULL,
    `category_id` INT         NOT NULL
);

# Task 2. Insert Data in Tables
INSERT INTO `employees`(`first_name`, `last_name`)
VALUES ('test1', 'Test1'),
       ('test2', 'Test2'),
       ('test3', 'Test3');

# Task 3. Add Column
ALTER TABLE `employees`
    ADD COLUMN `middle_name` VARCHAR(20) NOT NULL;

# Task 4. Add Constraint
ALTER TABLE `products`
    ADD CONSTRAINT `fk_products_categories`
        FOREIGN KEY (`category_id`)
            REFERENCES `categories` (`id`);

# Task 5. Modify Column
ALTER TABLE `employees`
    MODIFY `middle_name` VARCHAR(100);