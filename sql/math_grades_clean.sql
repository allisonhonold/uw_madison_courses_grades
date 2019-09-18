/*
Object:         Materialized View
Author:         Allison Honold
Script Date:    September 17, 2019
Description:    Removed courses with average GPA = 4, teachers
                Added a column with the number of sections taught by
                the instructor
                For Math sections: Calculates the GPA from grade 
                distribution. Only includes GPA-affecting grade 
                categories. Returns course name, term, section number,
                instructor number, and gpa.
                
*/

CREATE MATERIALIZED VIEW math_grades_clean AS
    SELECT  
            course_offerings.name AS course_name,
            course_offerings.term_code AS term,
            sections.number AS section_number,
            new_teachings.instructor_id,
            new_teachings.sections_taught,
            gpas.section_gpa
            

    FROM sections

    JOIN teachings
        ON teachings.section_uuid = sections.uuid

    JOIN (SELECT instructor_id, COUNT(section_uuid) AS sections_taught
            FROM teachings
            JOIN sections ON sections.uuid = teachings.section_uuid
            JOIN subject_memberships ON subject_memberships.course_offering_uuid = sections.course_offering_uuid
            JOIN grade_distributions_casted ON grade_distributions_casted.course_offering_uuid = sections.course_offering_uuid
                AND grade_distributions_casted.section_number = CAST(sections.number AS SMALLINT)
            WHERE subject_memberships.subject_code = '600'
                AND ((a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) > 0)
            GROUP BY instructor_id
            ORDER BY instructor_id
        ) AS new_teachings
        ON new_teachings.instructor_id = teachings.instructor_id

    JOIN (SELECT course_offering_uuid, section_number,
            (a_count * 4 + ab_count * 3.5 + b_count * 3 + bc_count * 2.5 + c_count * 2 
            + d_count * 1) / (a_count + ab_count + b_count + bc_count + c_count 
            + d_count + f_count) AS section_gpa
            
           FROM grade_distributions_casted
           WHERE ((a_count + ab_count + b_count + bc_count + c_count + d_count + f_count) > 0)
        ) AS gpas
        ON sections.course_offering_uuid = gpas.course_offering_uuid
            AND CAST(sections.number AS SMALLINT) = gpas.section_number


    JOIN subject_memberships AS m
        ON sections.course_offering_uuid = m.course_offering_uuid

    JOIN course_offerings
        ON sections.course_offering_uuid = course_offerings.uuid

    WHERE m.subject_code = '600' 
        AND section_gpa != 4
    ORDER BY instructor_id
    ;