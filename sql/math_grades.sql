/*
Object:         Materialized View
Author:         Allison Honold
Script Date:    September 17, 2019
Description:    For Math sections: Calculates the GPA from grade 
                distribution. Only includes GPA-affecting grade 
                categories. Returns course name, term, section number,
                instructor number, and gpa.
*/

CREATE MATERIALIZED VIEW math_grades AS
    SELECT  
            course_offerings.name AS course_name,
            course_offerings.term_code AS term,
            s.number AS section_number,
            t.instructor_id,

            (a_count * 4 + ab_count * 3.5 + b_count * 3 + bc_count * 2.5 + c_count * 2 
            + d_count * 1) / (a_count + ab_count + b_count + bc_count + c_count 
            + d_count + f_count) AS section_gpa

    FROM teachings AS t

    JOIN sections AS s
        ON s.uuid = t.section_uuid

    JOIN grade_distributions_casted AS g
        ON s.course_offering_uuid = g.course_offering_uuid
            AND CAST(s.number AS SMALLINT) = g.section_number

    JOIN subject_memberships AS m
        ON s.course_offering_uuid = m.course_offering_uuid

    JOIN course_offerings
        ON s.course_offering_uuid = course_offerings.uuid

    WHERE m.subject_code = '600' 
        AND ((a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) > 0)
    ORDER BY instructor_id;