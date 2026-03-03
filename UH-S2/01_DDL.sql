-- TABLE: students
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    institutional_email VARCHAR(150) NOT NULL UNIQUE,
    gender VARCHAR(20) NOT NULL CHECK (gender IN ('Male', 'Female', 'Other')),
    national_id VARCHAR(50) NOT NULL UNIQUE,
    major VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL CHECK (birth_date <= CURRENT_DATE),
    enrollment_date DATE NOT NULL CHECK (enrollment_date <= CURRENT_DATE)
);

-- TABLE: professors
CREATE TABLE professors (
    professor_id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    institutional_email VARCHAR(150) NOT NULL UNIQUE,
    academic_department VARCHAR(100) NOT NULL,
    years_experience INT NOT NULL CHECK (years_experience >= 0)
);

-- TABLE: courses
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    credits INT NOT NULL CHECK (credits > 0),
    semester INT NOT NULL CHECK (semester > 0),
    professor_id INT,
    CONSTRAINT fk_professor
        FOREIGN KEY (professor_id)
        REFERENCES professors(professor_id)
        ON DELETE SET NULL
);

-- TABLE: enrollments
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    final_grade NUMERIC(4,2) CHECK (final_grade BETWEEN 0 AND 5),
    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE,
    CONSTRAINT unique_enrollment
        UNIQUE (student_id, course_id)
);
