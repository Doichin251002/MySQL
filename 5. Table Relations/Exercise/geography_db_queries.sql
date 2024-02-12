# Query 9. Peaks in Rila
USE `geography`;

SELECT `mountain_range`, `peak_name`, `elevation` AS `peak_elevation`
FROM `mountains`  AS `m`
     JOIN `peaks` AS `p` ON `p`.`mountain_id` = `m`.`id`
WHERE `mountain_range` = 'Rila'
ORDER BY `peak_elevation` DESC;