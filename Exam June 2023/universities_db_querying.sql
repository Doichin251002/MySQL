USE universities_db;

# Query 5. Select Cities
SELECT *
FROM cities
ORDER BY population DESC;

# Query 6. Select Student age
SELECT first_name, last_name, age, phone, email
FROM students
WHERE age >= 21
ORDER BY first_name DESC, email, id
LIMIT 10;

# Query 7. Select New student
SELECT CONCAT_WS(' ', first_name, last_name) AS full_name,
       SUBSTRING(email FROM 2 FOR 10)        AS username,
       REVERSE(phone)                        AS password
FROM students s
         LEFT JOIN students_courses sc ON s.id = sc.student_id
WHERE sc.student_id IS NULL
ORDER BY password DESC;

# Query 8. Students count
SELECT COUNT(sc.student_id) AS students_count,
       u.name               AS university_name
FROM universities u
         JOIN courses c ON u.id = c.university_id
         JOIN students_courses sc ON c.id = sc.course_id
GROUP BY u.id, u.name
HAVING students_count >= 8
ORDER BY students_count DESC, university_name DESC;

# Query 9. Price rankings
SELECT u.name                     AS university_name,
       c.name                     AS city_name,
       u.address,
       (CASE
            WHEN tuition_fee < 800 THEN 'cheap'
            WHEN tuition_fee >= 800 AND tuition_fee < 1200 THEN 'normal'
            WHEN tuition_fee >= 1200 AND tuition_fee < 2500 THEN 'high'
            ELSE 'expensive' END) AS price_rank,
       u.tuition_fee
FROM universities u
         JOIN cities c ON c.id = u.city_id
ORDER BY u.tuition_fee;
