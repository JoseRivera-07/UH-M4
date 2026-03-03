-- INSERT PROFESSORS
INSERT INTO professors (full_name, institutional_email, academic_department, years_experience)
VALUES
('Dr. Michael Smith', 'michael.smith@university.edu', 'Engineering', 10),
('Dr. Laura Johnson', 'laura.johnson@university.edu', 'Mathematics', 4),
('Dr. Robert Brown', 'robert.brown@university.edu', 'Social Sciences', 8);

-- INSERT STUDENTS
INSERT INTO students (full_name, institutional_email, gender, national_id, major, birth_date, enrollment_date)
VALUES
('John Peterson', 'john.peterson@university.edu', 'Male', 'ID1001', 'Computer Engineering', '2002-05-10', '2021-01-15'),
('Emily Davis', 'emily.davis@university.edu', 'Female', 'ID1002', 'Mathematics', '2001-08-22', '2020-08-01'),
('Daniel Wilson', 'daniel.wilson@university.edu', 'Male', 'ID1003', 'Business Administration', '2003-02-14', '2022-01-20'),
('Sophia Martinez', 'sophia.martinez@university.edu', 'Female', 'ID1004', 'Computer Engineering', '2002-11-03', '2021-08-10'),
('William Taylor', 'william.taylor@university.edu', 'Male', 'ID1005', 'Mathematics', '2001-03-30', '2020-01-12');

-- INSERT COURSES
INSERT INTO courses (course_name, course_code, credits, semester, professor_id)
VALUES
('Database Systems', 'DB101', 4, 1, 1),
('Calculus I', 'MATH101', 3, 1, 2),
('Organizational Management', 'BUS201', 3, 2, 3),
('Advanced Programming', 'CS201', 4, 2, 1);

-- INSERT ENROLLMENTS
INSERT INTO enrollments (student_id, course_id, final_grade)
VALUES
(1, 1, 4.5),
(1, 4, 4.0),
(2, 2, 3.8),
(2, 3, 3.5),
(3, 3, 4.2),
(4, 1, 4.7),
(4, 4, 4.3),
(5, 2, 2.9);

SELECT * FROM students;
SELECT * FROM professors;
SELECT * FROM courses;
SELECT * FROM enrollments;