/*
Object:         Materialized View
Author:         Aaron Chen
Script Date:    September 19, 2019
Description:    Returns classes and their meeting days of the week.
*/

CREATE MATERIALIZED VIEW days_gpas AS 
    SELECT c.uuid, c.name,
            sch.mon, sch.tues, sch.wed, sch.thurs, sch.fri, sch.sat, sch.sun,
            subj.name as subject_name,
            gdc.section_number,
            section_gpa
        FROM schedules AS sch
        JOIN sections ON sch.uuid = sections.schedule_uuid 
        JOIN course_offerings AS c ON sections.course_offering_uuid = c.uuid
        JOIN courses ON c.course_uuid = courses.uuid
        JOIN subject_memberships ON sections.course_offering_uuid = subject_memberships.course_offering_uuid
        JOIN subjects AS subj on subject_memberships.subject_code = subj.code
        JOIN grade_distributions_casted AS gdc ON c.uuid = gdc.course_offering_uuid

    WHERE section_gpa != 4
        AND ((sch.mon = 'true') OR (sch.tues = 'true') OR (sch.wed = 'true') OR (sch.thurs = 'true') 
            OR (sch.fri = 'true') OR (sch.sat = 'true') OR (sch.sun = 'true'))
    GROUP BY c.uuid, c.name, section_gpa, sch.mon, sch.tues, sch.wed, sch.thurs, sch.fri, sch.sat, sch.sun, subj.name, gdc.section_number;