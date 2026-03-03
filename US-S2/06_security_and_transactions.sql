-- Create role academic_reviewer
CREATE ROLE academic_reviewer;

-- Autorized to login
CREATE ROLE academic_reviewer LOGIN PASSWORD 'reviewer123';

-- Grant select on view
GRANT SELECT ON academic_history_view TO academic_reviewer;

-- Revoke data modification 
REVOKE INSERT, UPDATE, DELETE ON enrollments FROM academic_reviewer;


-- TRANSACTION SIMULATION
BEGIN;

-- First update
UPDATE enrollments
SET final_grade = 4.9
WHERE enrollment_id = 1;

SAVEPOINT after_first_update;

-- Second update
UPDATE enrollments
SET final_grade = 1.0
WHERE enrollment_id = 2;

-- Oops, we decide to undo the second change
ROLLBACK TO SAVEPOINT after_first_update;

-- Confirm final result
COMMIT;

-- Verify
SELECT enrollment_id, final_grade
FROM enrollments
WHERE enrollment_id IN (1,2);
