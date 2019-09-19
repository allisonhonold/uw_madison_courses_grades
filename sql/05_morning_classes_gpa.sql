/*
Object:         Materialized View
Author:         Aaron Chen
Script Date:    September 19, 2019
Description:    Returns morning classes and their GPAs.
*/

CREATE MATERIALIZED VIEW morning_classes_gpas AS
    SELECT course_offering_uuid,
            section_number,
            section_gpa
    FROM all_morning_classes 
    JOIN grade_distributions_casted AS gdc
        ON all_morning_classes.uuid = gdc.course_offering_uuid
    JOIN course_offerings ON course_offerings.uuid = gdc.course_offering_uuid
    WHERE section_gpa != 4;