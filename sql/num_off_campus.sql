/*

*/

SELECT c.name, COUNT(DISTINCT c.name) as course_names, COUNT(DISTINCT c.number) as course_numbers, 
    COUNT(DISTINCT co.term_code) as term_codes, COUNT(DISTINCT co.name) as course_offering_name, 
    COUNT(DISTINCT sections.section_type) as section_types, 
    COUNT(DISTINCT inst.name) as instructor_names
FROM courses as c
JOIN course_offerings as co on c.uuid = co.course_uuid
JOIN sections on co.uuid = sections.course_offering_uuid
JOIN schedules as sch on sections.schedule_uuid = sch.uuid
JOIN rooms on sections.room_uuid = rooms.uuid
JOIN teachings on sections.uuid = teachings.section_uuid
JOIN instructors as inst on teachings.instructor_id = inst.id
WHERE start_time = '-1'
GROUP BY c.name;