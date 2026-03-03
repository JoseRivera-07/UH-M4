
-- 1. Students with average grade above overall average
SELECT 
    s.full_name,
    ROUND(AVG(e.final_grade), 2) AS student_average
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.final_grade) > (
    SELECT AVG(final_grade)
    FROM enrollments
);

-- 2. Majors with students enrolled in semester >= 2 courses
SELECT DISTINCT s.major
FROM students s
WHERE s.student_id IN (
    SELECT e.student_id
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE c.semester >= 2
);

-- 3. Majors using EXISTS
SELECT DISTINCT s.major
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE e.student_id = s.student_id
    AND c.semester >= 2
);

-- 4. Academic performance indicators
SELECT
    ROUND(AVG(final_grade), 2) AS overall_average,
    ROUND(MAX(final_grade), 2) AS highest_grade,
    ROUND(MIN(final_grade), 2) AS lowest_grade,
    COUNT(final_grade) AS total_grades_recorded,
    ROUND(SUM(final_grade), 2) AS total_grade_sum
FROM enrollments;

