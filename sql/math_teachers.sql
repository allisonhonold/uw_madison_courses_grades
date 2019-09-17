/*
Object:         Query
Author:         Allison Honold
Script Date:    September 17, 2019
Description:    Returns the math instructors and the number of 
                sections they teach.
*/

SELECT  instructor_id,
        n_sections
FROM    (SELECT  instructor_id,
                COUNT(section_uuid) AS n_sections
        FROM teachings
        JOIN sections
        ON sections.uuid = teachings.section_uuid
        JOIN subject_memberships
        ON subject_memberships.course_offering_uuid = sections.course_offering_uuid
        WHERE subject_code = '600'
        GROUP BY instructor_id) AS test
WHERE n_sections > 10;
