# Query 1. Mountains and Peaks Tables
CREATE TABLE `mountains`
(
    `id`   INT AUTO_INCREMENT NOT NULL,
    `name` VARCHAR(20)        NOT NULL,
    CONSTRAINT `pk_mountains_id` PRIMARY KEY (`id`)
);

CREATE TABLE `peaks`
(
    `id`          INT PRIMARY KEY AUTO_INCREMENT,
    `name`        VARCHAR(30) NOT NULL,
    `mountain_id` INT         NOT NULL,
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains`(`id`)
);

USE `camp`;

# Query 2. Trip Organization
SELECT `driver_id`,
       `vehicle_type`,
       CONCAT_WS(' ', `first_name`, `last_name`) AS `driver_name`
FROM `vehicles`     AS `v`
     JOIN `campers` AS `c` ON `v`.`driver_id` = `c`.`id`;

# Query 3. SoftUni Hiking
SELECT `starting_point` AS `route_starting_point`,
       `end_point` AS `route_ending_point`,
       `leader_id`,
       CONCAT_WS(' ', `first_name`, `last_name`) AS `leader_name`
FROM `routes`       AS `r`
     JOIN `campers` AS `c` ON `r`.`leader_id` = `c`.`id`;

# Query 4. Delete Mountains
DROP
    TABLE `mountains`, `peaks`;

CREATE TABLE `mountains`
(
    `id`   INT AUTO_INCREMENT NOT NULL,
    `name` VARCHAR(20)        NOT NULL,
    CONSTRAINT `pk_mountains_id` PRIMARY KEY (`id`)
);

INSERT INTO `mountains` (`name`)
VALUES ('Rila'),
       ('Pirin'),
       ('Rodopi'),
       ('Stara planina'),
       ('Strandzha');

CREATE TABLE `peaks`
(
    `id`          INT PRIMARY KEY AUTO_INCREMENT,
    `name`        VARCHAR(20) NOT NULL,
    `mountain_id` INT         NOT NULL,
    CONSTRAINT `fk_peaks_mountains`
        FOREIGN KEY (`mountain_id`)
            REFERENCES `mountains`(`id`)
            ON DELETE CASCADE
);

INSERT INTO `peaks` (`name`, `mountain_id`)
VALUES ('Musala', 1),
       ('Vihren', 2),
       ('Golyam Perelik', 3),
       ('Botev Peak', 4),
       ('Golyamo Gradishte', 5);

DELETE
FROM `mountains`
WHERE `id` = 5;

SELECT *
FROM `peaks`;