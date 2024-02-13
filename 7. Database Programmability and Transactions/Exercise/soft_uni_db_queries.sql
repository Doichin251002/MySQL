USE soft_uni;
# Query 1. Employees with Salary Above 35000
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
    DECLARE upper_limit INT;
    SET upper_limit = 35000;
    SELECT first_name, last_name
    FROM employees
    WHERE salary > upper_limit
    ORDER BY first_name, last_name, employee_id;
END;

CALL usp_get_employees_salary_above_35000();

# Query 2. Employees with Salary Above Number
CREATE PROCEDURE usp_get_employees_salary_above(salary_limit DECIMAL(19, 4))
BEGIN
    SELECT first_name, last_name
    FROM employees
    WHERE salary >= salary_limit
    ORDER BY first_name, last_name, employee_id;
END;

SET @salary_limit = 45000;
CALL usp_get_employees_salary_above(@salary_limit);

# Query 3. Town Names Starting With
CREATE PROCEDURE usp_get_towns_starting_with(letter VARCHAR(50))
BEGIN
    SELECT name FROM towns WHERE name LIKE CONCAT(letter, '%') ORDER BY name;
END;

SET @town_letter = 'B';
CALL usp_get_towns_starting_with(@town_letter);

# Query 4. Employees from Town
CREATE PROCEDURE usp_get_employees_from_town(town VARCHAR(50))
BEGIN
    SELECT e.first_name, e.last_name
    FROM employees AS e
             JOIN addresses a ON a.address_id = e.address_id
             JOIN towns t ON t.town_id = a.town_id
    WHERE t.name = town
    ORDER BY e.first_name, e.last_name, e.employee_id;
END;

SET @town_name = 'Sofia';
CALL usp_get_employees_from_town(@town_name);

# Query 5. Salary Level Function
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(19, 4))
    RETURNS VARCHAR(7)
    DETERMINISTIC
BEGIN
    RETURN (CASE
        WHEN salary < 30000
            THEN 'Low'
        WHEN salary <= 50000
            THEN 'Average'
        ELSE 'High'
        END);
END;

SET @salary = 50000;
SELECT ufn_get_salary_level(@salary);

# Query 6. Employees by Salary Level
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(7))
BEGIN
    SELECT first_name, last_name
    FROM employees
    WHERE ufn_get_salary_level(salary) = salary_level
    ORDER BY first_name DESC, last_name DESC;
END;

SET @salary_level = 'High';
CALL usp_get_employees_by_salary_level(@salary_level);

# Query 7. Define Function
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
    RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN word REGEXP CONCAT('^[', set_of_letters, ']+$');
END;

SET @set_of_letters = 'Nikolay';
SET @word = 'Nik';
SELECT ufn_is_word_comprised(@set_of_letters, @word);