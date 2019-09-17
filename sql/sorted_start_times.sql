SELECT c.name as course_name, CAST(start_time as float) / 60 AS start_time_in_hours, 
    CAST(end_time as float) / 60 AS end_time_in_hours
FROM schedules
JOIN sections on schedules.uuid = sections.schedule_uuid 
JOIN course_offerings as c on sections.course_offering_uuid = c.uuid
GROUP BY course_name, start_time_in_hours, end_time_in_hours
ORDER BY start_time_in_hours ASC;