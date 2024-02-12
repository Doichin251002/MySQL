# Task 11. Movies Database
CREATE DATABASE `movies`;
USE `movies`;

CREATE TABLE `directors`
(
    `id`            INT PRIMARY KEY AUTO_INCREMENT,
    `director_name` VARCHAR(20) NOT NULL,
    `notes`         TEXT
);

INSERT INTO `directors`(`director_name`, `notes`)
VALUES ('TestName1', 'TestNotes'),
       ('TestName2', 'TestNotes'),
       ('TestName3', 'TestNotes'),
       ('TestName4', 'TestNotes'),
       ('TestName5', 'TestNotes');

CREATE TABLE `genres`
(
    `id`         INT PRIMARY KEY AUTO_INCREMENT,
    `genre_name` VARCHAR(20) NOT NULL,
    `notes`      TEXT
);

INSERT INTO `genres`(`genre_name`, `notes`)
VALUES ('TestName1', 'TestNotes'),
       ('TestName2', 'TestNotes'),
       ('TestName3', 'TestNotes'),
       ('TestName4', 'TestNotes'),
       ('TestName5', 'TestNotes');

CREATE TABLE `categories`
(
    `id`            INT PRIMARY KEY AUTO_INCREMENT,
    `category_name` VARCHAR(20) NOT NULL,
    `notes`         TEXT
);

INSERT INTO `categories`(`category_name`, `notes`)
VALUES ('TestName1', 'TestNotes'),
       ('TestName2', 'TestNotes'),
       ('TestName3', 'TestNotes'),
       ('TestName4', 'TestNotes'),
       ('TestName5', 'TestNotes');

CREATE TABLE `movies`
(
    `id`             INT PRIMARY KEY AUTO_INCREMENT,
    `title`          VARCHAR(20) NOT NULL,
    `director_id`    INT,
    `copyright_year` YEAR,
    `length`         DOUBLE(10, 2),
    `genre_id`       INT,
    `category_id`    INT,
    `rating`         DOUBLE(2, 2),
    `notes`          TEXT,
    CONSTRAINT `fk_movies_directors`
        FOREIGN KEY `movies` (`director_id`)
            REFERENCES `directors` (`id`),
    CONSTRAINT `fk_movies_genres`
        FOREIGN KEY `movies` (`genre_id`)
            REFERENCES `genres` (`id`),
    CONSTRAINT `fk_movies_categories`
        FOREIGN KEY `movies` (`category_id`)
            REFERENCES `categories` (`id`)
);

INSERT INTO `movies`(`title`, `director_id`, `genre_id`, `category_id`)
VALUES ('test', 1, 2, 3),
       ('test1', 1, 2, 5),
       ('test2', 1, 2, 4),
       ('test3', 1, 2, 3),
       ('test4', 1, 2, 3);
