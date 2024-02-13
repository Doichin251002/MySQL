USE universities_db;

# Query 10. Function Average grades
CREATE FUNCTION udf_average_alumni_grade_by_course_name(course_name VARCHAR(60))
    RETURNS DEC(3, 2)
    DETERMINISTIC
BEGIN
    RETURN (SELECT AVG(sc.grade)
            FROM students_courses sc
                     JOIN courses c ON c.id = sc.course_id
                     JOIN students s ON s.id = sc.student_id
            WHERE c.name LIKE course_name
              AND s.is_graduated = 1);
END;

SELECT c.name, udf_average_alumni_grade_by_course_name('Quantum Physics') AS average_alumni_grade
FROM courses c
WHERE c.name = 'Quantum Physics';

# Query 11. Procedure Graduate students
CREATE PROCEDURE udp_graduate_all_students_by_year(year_started INT)
BEGIN
    UPDATE students s
        JOIN students_courses sc ON s.id = sc.student_id
        JOIN courses c ON c.id = sc.course_id
    SET s.is_graduated = 1
    WHERE YEAR(c.start_date) = year_started;
END;

CALL udp_graduate_all_students_by_year(2017);