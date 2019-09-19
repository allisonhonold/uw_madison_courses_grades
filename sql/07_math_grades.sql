/*
Object:         Materialized View
Author:         Allison Honold
Script Date:    September 17, 2019
Description:    Creates a marterialized view 'math_grades_clean':
                Removed courses with average GPA = 4,
                courses with no students graded on A-F scale
                Added a column with the number of sections taught by
                the instructor
                For Math sections: Calculates the GPA from grade 
                distribution. Only includes GPA-affecting grade 
                categories. Returns course name, term, section number,
                instructor number, #of sections taught by same instructor, 
                and gpa.
                
*/

CREATE MATERIALIZED VIEW math_grades_clean AS
    SELECT  
            course_offerings.name AS course_name,
            course_offerings.term_code AS term,
            sections.number AS section_number,
            new_teachings.instructor_id,
            new_teachings.sections_taught,
            section_gpa
            

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

    JOIN grade_distributions_casted
        ON sections.course_offering_uuid = grade_distributions_casted.course_offering_uuid
            AND CAST(sections.number AS SMALLINT) = grade_distributions_casted.section_number

    JOIN subject_memberships AS m
        ON sections.course_offering_uuid = m.course_offering_uuid

    JOIN course_offerings
        ON sections.course_offering_uuid = course_offerings.uuid

    WHERE m.subject_code = '600' 
        AND section_gpa != 4
    ORDER BY instructor_id
    ;