# Hypothesis Testing with Grades from University of Wisconsin at Madison
This project formed from https://www.kaggle.com/Madgrades/uw-madison-courses and conducts hypothesis testing to observe the effects of teachers, subject material, time of day, days of the week, and year upon GPAs.

In order to access this data, please make a Kaggle account at the link above and download the zip file.

This project assumes that the user will fork and clone this project locally and that the data will be downloaded into a data subfolder in the project directory.


## Hypothesis Testing
### i. Question
    Summary of hypothesis and result?
    [Link to notebook file?](https://docs.google.com/presentation/d/11V0-adv0NVOYEDxgFU63aqocT8mTLvqO9DpQ7odTpPs/edit#slide=id.p)

    Convert to link to README of other directories. Each directory contains one hypothesis test

## Requirements
If you're curious about technical documentation for conducting these hypothesis tests, please read [REQUIREMENTS.md](link to )


------ The below goes to REQUIREMENTS.md ---
## Summary Look at Tables in Database
[Summary Look at Database](tech_docs/)

## Entity Relationship Diagram for Database
![Entity Relationship Diagram for UW Madison Courses and Grades Database](ERD.png)

## Setting Up the Working Environment
Order of operations to generate the data used in our hypothesis tests:
1. Run bash script create_uw_madison_database.sh
2. Open postgres with "psql uw_madison"
3. \i create_grade_distributions_casted.sql
4. \i sorted_start_times_morning.sql
5. \i sorted_start_times_afternoon.sql
6. \i morning_classes_gpa.sql
7. \i afternoon_classes_gpa.sql
8. \i days_of_week_gpas.sql
9. \i stem_class_gpa.sql
10. \i non_stem_class_gpa.sql

