CREATE DATABASE universities_db;
USE universities_db;

# Query 1. Table Design
CREATE TABLE countries
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE cities
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(40) NOT NULL UNIQUE,
    population INT,
    country_id INT         NOT NULL,
    CONSTRAINT fk_cities_countries FOREIGN KEY (country_id) REFERENCES countries (id)
);

CREATE TABLE universities
(
    id              INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(60) NOT NULL UNIQUE,
    address         VARCHAR(80) NOT NULL UNIQUE,
    tuition_fee     DEC(19, 2)  NOT NULL,
    number_of_staff INT,
    city_id         INT,
    CONSTRAINT fk_universities_cities FOREIGN KEY (city_id) REFERENCES cities (id)
);

CREATE TABLE students
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    first_name   VARCHAR(40)  NOT NULL,
    last_name    VARCHAR(40)  NOT NULL,
    age          INT,
    phone        VARCHAR(20)  NOT NULL UNIQUE,
    email        VARCHAR(255) NOT NULL UNIQUE,
    is_graduated TINYINT(1)   NOT NULL,
    city_id      INT,
    CONSTRAINT fk_students_cities FOREIGN KEY (city_id) REFERENCES cities (id)
);

CREATE TABLE courses
(
    id             INT PRIMARY KEY AUTO_INCREMENT,
    name           VARCHAR(40) NOT NULL UNIQUE,
    duration_hours DEC(19, 2),
    start_date     DATE,
    teacher_name   VARCHAR(60) NOT NULL UNIQUE,
    description    TEXT,
    university_id  INT         NOT NULL,
    CONSTRAINT fk_courses_universities FOREIGN KEY (university_id) REFERENCES universities (id)
);

CREATE TABLE students_courses
(
    grade      DEC(19, 2) NOT NULL,
    student_id INT        NOT NULL,
    course_id  INT        NOT NULL,
    CONSTRAINT fk__students_courses__students FOREIGN KEY (student_id) REFERENCES students (id),
    CONSTRAINT fk__students_courses__courses FOREIGN KEY (course_id) REFERENCES courses (id)
);