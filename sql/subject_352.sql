SELECT subjects.abbreviation, COUNT(course_offering_uuid)
FROM subjects
JOIN subject_memberships
ON subjects.code = subject_memberships.subject_code
WHERE subjects.code = '352'
GROUP BY subjects.abbreviation;