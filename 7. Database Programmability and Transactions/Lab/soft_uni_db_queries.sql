USE soft_uni;

# Query 1. Count Employees by Town
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50)) RETURNS INT
    DETERMINISTIC
BEGIN
    RETURN (SELECT COUNT(*)
            FROM employees AS e
                      JOIN addresses a
                          ON a.address_id = e.address_id
                      JOIN towns t
                          ON t.town_id = a.town_id
            WHERE t.name = town_name );
END;

SELECT ufn_count_employees_by_town('Sofia') AS `count`;

# Query 2. Employees Promotion
CREATE PROCEDURE usp_raise_salaries(`department_name` VARCHAR(50))
BEGIN
    UPDATE employees AS e
        JOIN departments AS d
                ON d.department_id = e.department_id
    SET e.salary = salary + (salary * 0.05)
    WHERE d.name = `department_name`;
END;

CALL usp_raise_salaries('Finance');

SELECT first_name, salary
FROM employees AS e
         JOIN departments d ON d.department_id = e.department_id
WHERE d.name = 'Finance'
ORDER BY first_name, salary;

# Query 3. Employees Promotion by ID
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
    START TRANSACTION;
    IF (id NOT IN ( SELECT employee_id
                    FROM employees ))
        THEN ROLLBACK;
    ELSE
        UPDATE employees
        SET salary = salary + (salary * 0.05)
        WHERE employee_id = `id`;
    END IF;
END;

CALL usp_raise_salary_by_id(17);

SELECT salary
FROM employees
WHERE employee_id = 17;

# Query 4. Triggered
CREATE TABLE deleted_employees
(
    employee_id  INT PRIMARY KEY AUTO_INCREMENT,
    first_name   VARCHAR(50),
    last_name    VARCHAR(50),
    middle_name  VARCHAR(50),
    job_title    VARCHAR(50),
    department_id INT,
    salary       DECIMAL(19, 4)
);

CREATE TRIGGER tr_deleted_employees
    AFTER DELETE
    ON employees
    FOR EACH ROW
BEGIN
    INSERT INTO deleted_employees(first_name, last_name, middle_name, job_title, department_id, salary)
    VALUES (OLD.first_name, OLD.last_name, OLD.middle_name, OLD.job_title, OLD.department_id, OLD.salary);
END;

SELECT * FROM deleted_employees;