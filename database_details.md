# Table and column names and descriptions for UW Madison Courses and Grades Dataset

## course_offerings	
|             | data_format | as_type | description                                                                             |
|-------------|-------------|---------|-----------------------------------------------------------------------------------------|
| uuid        | string      | text    | unique id generated for a course offering                                               |
| course_uuid | string      | text    | uuid of the course this offering belongs to                                             |
| term_code   | numeric     | text    | code of the term http://www.bussvc.wisc.edu/bursar/termcode.html                        |
| name        | string      | text    | name of the course for this particular offering. (Course name my change btwn semesters) |


## courses
|        | data_format | as_type | description                                          |
|--------|-------------|---------|------------------------------------------------------|
| uuid*  | string      | text    | uuid generated for this course                       |
| name   | string      | text    | official, latest name of the course (sometimes null) |
| number | numeric     | text    | number of the course                            

## 