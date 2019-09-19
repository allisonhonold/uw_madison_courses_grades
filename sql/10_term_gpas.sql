/*
Object:         Materialized View
Author:         Allison Honold
Script Date:    September 17, 2019
Description:    Creates a materialized view with columns:
                term_code, course_offering_uuid, section_number, and section_gpa
                removes sections where gpa = 4.0
                Note: original data set does not contain information from summer 
                term at this time
                
*/

CREATE MATERIALIZED VIEW section_grades_term AS
    SELECT c.term_code, s.course_offering_uuid, grade_distributions_casted.section_number, section_gpa

    FROM course_offerings AS c   

    JOIN sections AS s
        ON s.course_offering_uuid = c.uuid

    JOIN grade_distributions_casted
        ON grade_distributions_casted.course_offering_uuid = s.course_offering_uuid
            AND CAST(grade_distributions_casted.section_number AS TEXT) = s.number

    WHERE section_gpa != 4
        AND (a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) > 0
    ORDER BY term_code;