# Table and column names and descriptions for UW Madison Courses and Grades Dataset

## courses
|        | data_format | as_type | description                                          |
|--------|-------------|---------|------------------------------------------------------|
| uuid*  | string      | text    | uuid generated for this course                       |
| name   | string      | text    | official, latest name of the course (sometimes null) |
| number | numeric     | text    | number of the course       


## course_offerings	
|             | data_format | as_type | description                                                                             |
|-------------|-------------|---------|-----------------------------------------------------------------------------------------|
| uuid*        | string      | text    | unique id generated for a course offering                                               |
| course_uuid | string      | text    | uuid of the course this offering belongs to                                             |
| term_code   | numeric     | text    | code of the term http://www.bussvc.wisc.edu/bursar/termcode.html                        |
| name        | string      | text    | name of the course for this particular offering. (Course name my change btwn semesters) |


## grade_distributions
|                       | data_format | as_type | description                           |
|-----------------------|-------------|---------|---------------------------------------|
| course_offering_uuid* | string      | text    | uuid generated for this course        |
| section_number        | string      | text    | section number for this course        |
| a_count               | numeric     | text    | number of As given                    |
| ab_count              | numeric     | text    | number of ABs given                   |
| b_count               | numeric     | text    | number of Bs given                    |
| bc_count              | numeric     | text    | number of BCs given                   |
| c_count               | numeric     | text    | number of Cs given                    |
| d_count               | numeric     | text    | number of Ds given                    |
| f_count               | numeric     | text    | number of Fs given                    |
| s_count               | numeric     | text    | number of "Satisfactory"s given       |
| u_count               | numeric     | text    | number of "Unsatisfactory"s given     |
| cr_count              | numeric     | text    | number of "Credit"s given             |
| n_count               | numeric     | text    | number of "No Credit"s given          |
| p_count               | numeric     | text    | number of "Progress"s given           |
| i_count               | numeric     | text    | number of "Incomplete"s given         |
| nw_count              | numeric     | text    | number of "No Work"s given            |
| nr_count              | numeric     | text    | number of "No Report"s given          |
| other_count           | numeric     | text    | number of all other grade codes given |


## sections
|                      | data_format | as_type | description                            |
|----------------------|-------------|---------|----------------------------------------|
| uuid*                | string      | text    | uuid generated for this section        |
| course_offering_uuid | string      | text    | uuid generated for this course         |
| section_type         | string      | text    | classification of section              |
| number               | numeric     | text    | section number                         |
| room_uuid            | string      | text    | uuid generated for location of section |
| schedule_uuid        | string      | text    | uuid generated for schedule of section |


## schedules
|            | data_format | as_type | description                      |
|------------|-------------|---------|----------------------------------|
| uuid*      | string      | text    | uuid generated for this schedule |
| start_time | numeric     | text    | start time in minutes            |
| end_time   | numeric     | text    | end time in minutes              |
| mon        | numeric     | text    | true or false                    |
| tues       | string      | text    | true or false                    |
| wed        | string      | text    | true or false                    |
| thurs      | string      | text    | true or false                    |
| fri        | string      | text    | true or false                    |
| sat        | string      | text    | true or false                    |
| sun        | string      | text    | true or false                    |


## rooms
|               | data_format | as_type | description                  |
|---------------|-------------|---------|------------------------------|
| uuid*         | string      | text    | uuid generated for this room |
| facility_code | numeric     | text    | location code                |
| room_code     | numeric     | text    | room number                  |


## subjects
|              | data_format | as_type | description               |
|--------------|-------------|---------|---------------------------|
| code*        | numeric     | text    | subject code              |
| name         | text        | text    | subject name              |
| abbreviation | text        | text    | subject name abbreviation |


## subject_memberships
|                      | data_format | as_type | description                             |
|----------------------|-------------|---------|-----------------------------------------|
| subject_code         | text        | text    | subject code                            |
| course_offering_uuid* | text        | text    | uuid generated for this course offering |


## instructors
|      | data_format | as_type | description        |
|------|-------------|---------|--------------------|
| id*  | numeric     | text    | instructor id      |
| name | text        | text    | name of instructor |


## teachings
|               | data_format | as_type | description                     |
|---------------|-------------|---------|---------------------------------|
| instructor_id | numeric     | text    | instructor id                   |
| section_uuid* | text        | text    | uuid generated for this section |