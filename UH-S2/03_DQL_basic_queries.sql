
-- 1. Students with their courses and final grades
SELECT 
    s.full_name AS student_name,
    c.course_name,
    c.course_code,
    e.final_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.full_name;

-- 2. Courses taught by professors with > 5 years experience
SELECT 
    c.course_name,
    c.course_code,
    p.full_name AS professor_name,
    p.years_experience
FROM courses c
JOIN professors p ON c.professor_id = p.professor_id
WHERE p.years_experience > 5;

-- 3. Average grade per course
SELECT 
    c.course_name,
    ROUND(AVG(e.final_grade), 2) AS average_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY average_grade DESC;

-- 4. Students enrolled in more than one course
SELECT 
    s.full_name,
    COUNT(e.course_id) AS total_courses
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.full_name
HAVING COUNT(e.course_id) > 1;

-- 5. Add academic_status column
ALTER TABLE students
ADD COLUMN academic_status VARCHAR(30) DEFAULT 'Active';

SELECT * FROM students;

-- 6. Test ON DELETE behavior
-- First, look current courses
SELECT * FROM courses;

-- Now, Delete an professor at more of 5 years (for example professor_id = 1):
DELETE FROM professors
WHERE professor_id = 1;

-- Now, Check courses again
SELECT course_name, professor_id
FROM courses;

-- 7. Courses with more than 2 students
SELECT 
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
HAVING COUNT(e.student_id) > 2;
