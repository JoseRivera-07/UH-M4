-- CREATE VIEW: academic_history_view
CREATE VIEW academic_history_view AS
SELECT
    s.full_name AS student_name,
    c.course_name,
    p.full_name AS professor_name,
    c.semester,
    e.final_grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
LEFT JOIN professors p ON c.professor_id = p.professor_id;

SELECT * FROM academic_history_view;