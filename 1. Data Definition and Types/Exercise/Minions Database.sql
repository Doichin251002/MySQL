# Task 0. Minions Database
CREATE DATABASE `minions`;
USE `minions`;

# Task 1. Create Tables
CREATE TABLE `minions`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50),
    `age`  INT
);

CREATE TABLE `towns`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
);

# Task 2. Alter Table
ALTER TABLE `minions`
    ADD COLUMN`town_id` INT;

ALTER TABLE `minions`
    ADD CONSTRAINT `fk_minions_towns`
        FOREIGN KEY `minions` (`town_id`)
            REFERENCES `towns` (`id`);

# Task 3. Insert Records in Both Tables
INSERT INTO `towns`(`id`, `name`)
VALUES (1, 'Sofia'),
       (2, 'Plovdiv'),
       (3, 'Varna');

INSERT INTO `minions`(`id`, `name`, `age`, `town_id`)
VALUES (1, 'Kevin', 22, 1),
       (2, 'Bob', 15, 3),
       (3, 'Steward', NULL, 2);

# Task 4. Truncate Table Minions
TRUNCATE TABLE `minions`;

# Task 5. Drop All Tables
DROP
    TABLE `minions`, `towns`;

# Task 6. Create Table People
CREATE TABLE `people`
(
    `id`        INT PRIMARY KEY AUTO_INCREMENT,
    `name`      VARCHAR(200) NOT NULL,
    `picture`   BLOB,
    `height`    DOUBLE(10, 2),
    `weight`    DOUBLE(10, 2),
    `gender`    CHAR(1)      NOT NULL,
    `birthdate` DATE         NOT NULL,
    `biography` TEXT
);

INSERT INTO `people`(`name`, `gender`, `birthdate`)
VALUES ('test', 'm', DATE(NOW())),
       ('test1', 'f', DATE(NOW())),
       ('test2', 'm', DATE(NOW())),
       ('test3', 'f', DATE(NOW())),
       ('test4', 'f', DATE(NOW()));

# Task 7. Create Table Users
CREATE TABLE `users`
(
    `id`              INT PRIMARY KEY AUTO_INCREMENT,
    `username`        VARCHAR(30) NOT NULL,
    `password`        VARCHAR(26) NOT NULL,
    `profile_picture` BLOB,
    `last_login_time` DATETIME,
    `is_deleted`      BOOLEAN
);

INSERT INTO `users`(`username`, `password`)
VALUES ('test', 'test'),
       ('test1', 'test'),
       ('test2', 'test'),
       ('test3', 'test'),
       ('test5', 'test');

# Task 8. Change Primary Key
ALTER TABLE `users`
    DROP PRIMARY KEY,
    ADD CONSTRAINT `pk_users2`
        PRIMARY KEY `users` (`id`, `username`);

# Task 9. Set Default Value of a Field
ALTER TABLE `users`
    CHANGE COLUMN `last_login_time`
        `last_login_time` DATETIME DEFAULT NOW();

# Task 10. Set Unique Field
ALTER TABLE `users`
    DROP PRIMARY KEY,
    ADD CONSTRAINT `pk_users`
        PRIMARY KEY `users` (`id`),
    CHANGE COLUMN `username`
        `username` VARCHAR(30) UNIQUE;