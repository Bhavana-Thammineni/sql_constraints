CREATE DATABASE student_management;
USE student_management;
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_no BIGINT UNIQUE NOT NULL,
    name VARCHAR(30) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M','F')),
    dob DATE NOT NULL,
    dept VARCHAR(20) NOT NULL
);
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(30) UNIQUE NOT NULL,
    credits INT CHECK (credits BETWEEN 1 AND 5)
);
CREATE TABLE enrollment (
    enroll_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    attendance_percentage FLOAT CHECK (attendance_percentage BETWEEN 0 AND 100),
    
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
CREATE TABLE results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    marks FLOAT CHECK (marks BETWEEN 0 AND 100),
    
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
INSERT INTO students (roll_no, name, gender, dob, dept) VALUES
(401,'Bhavana','F','2004-11-26','ECE'),
(402,'Khushi','F','2004-12-26','CSE'),
(403,'Ravi','M','2003-10-12','EEE'),
(404,'Anil','M','2003-09-18','ECE'),
(405,'Sita','F','2004-01-05','CSE');
SELECT s.name, c.course_name, r.marks
FROM students s
JOIN results r ON s.student_id = r.student_id
JOIN courses c ON r.course_id = c.course_id;
SELECT dept, AVG(marks) AS avg_marks
FROM students s
JOIN results r ON s.student_id = r.student_id
GROUP BY dept;
SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id FROM results WHERE marks > 85
);
CREATE VIEW student_summary AS
SELECT s.name, c.course_name, r.marks, a.attendance_percentage
FROM students s
JOIN courses c
JOIN results r
JOIN attendance a
WHERE s.student_id = r.student_id
AND s.student_id = a.student_id
AND r.course_id = c.course_id;
DELIMITER //
CREATE PROCEDURE get_student_result(IN sid INT)
BEGIN
    SELECT s.name, c.course_name, r.marks
    FROM students s
    JOIN results r ON s.student_id = r.student_id
    JOIN courses c ON r.course_id = c.course_id
    WHERE s.student_id = sid;
END //
DELIMITER ;
DELIMITER //
CREATE TRIGGER fail_check
BEFORE INSERT ON results
FOR EACH ROW
BEGIN
    IF NEW.marks < 35 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Student failed';
    END IF;
END //
DELIMITER ;
INSERT INTO results (student_id, course_id, marks)
VALUES (1, 2, 30);

SELECT * FROM student_summary;
CALL get_student_result(1);
drop database  college;




