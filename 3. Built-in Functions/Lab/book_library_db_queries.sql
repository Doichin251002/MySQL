USE `book_library`;

# Query 1. Find Book Titles
SELECT `title`
FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = 'The'
ORDER BY `id`;

# Query 2. Replace Titles
SELECT REPLACE(`title`, 'The', '***') AS `Title`
FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = 'The';

# Query 3. Sum Cost of All Books
SELECT FORMAT(SUM(`cost`), 2) AS `Sum`
FROM `books`;

# Query 4. Days Lived
SELECT CONCAT_WS(' ', `first_name`, `last_name`) AS `Full Name`,
       TIMESTAMPDIFF(DAY, `born`, `died`)        AS `Days Lived`
FROM `authors`;

# Query 5. Harry Potter Books
SELECT `title`
FROM `books`
WHERE `title` LIKE 'Harry Potter%';

