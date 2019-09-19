/*
Object:         Materialized View
Author:         Aaron Chen
Script Date:    September 19, 2019
Description:    Returns the classes that start after 12:00 noon.
*/

CREATE MATERIALIZED VIEW all_afternoon_classes AS
    SELECT * 
    FROM 
        (SELECT c.uuid, courses.name, courses.number, 
            CAST(start_time AS float) / 60 AS start_time_in_hours, 
            CAST(end_time AS float) / 60 AS end_time_in_hours,
            subjects.name AS subject_name
        FROM schedules
        JOIN sections ON schedules.uuid = sections.schedule_uuid 
        JOIN course_offerings AS c ON sections.course_offering_uuid = c.uuid
        JOIN courses ON c.course_uuid = courses.uuid
        JOIN subject_memberships ON sections.course_offering_uuid = subject_memberships.course_offering_uuid
        JOIN subjects on subject_memberships.subject_code = subjects.code 
        GROUP BY c.uuid, courses.name, courses.number, subjects.name, start_time_in_hours, end_time_in_hours
        ORDER BY start_time_in_hours ASC
        ) AS afternoon_start_times_converted
    WHERE start_time_in_hours BETWEEN 12.00000000001 AND 23.9 AND name != 'null';
