/*
Object:         Query
Author:         Allison Honold
Script Date:    September 17, 2019
Description:    Returns the subject abbreviation and count of course
                offerings for the subject code 352.
*/

SELECT subjects.abbreviation, COUNT(course_offering_uuid)
FROM subjects
JOIN subject_memberships
ON subjects.code = subject_memberships.subject_code
WHERE subjects.code = '352'
GROUP BY subjects.abbreviation;
