# uw_madison_courses_grades
Hypothesis testing with UW Madison grades. Project formed from https://www.kaggle.com/Madgrades/uw-madison-courses


In order to access this data, please make a Kaggle account at the link above and download the zip file.

This project assumes that the user will fork and clone this project locally and that the data will be downloaded into a data subfolder in the project directory.

![Entity Relationship Diagram for UW Madison Courses and Grades Database](ERD.png)


Order of operations to generate the data used in our hypothesis tests:
1. Run bash script create_uw_madison_database.sh
2. Open postgres with "psql uw_madison"
3. \i create_grade_distributions_casted.sql
3. \i sorted_start_times_morning.sql
4. \i sorted_start_times_afternoon.sql
5. 

First run the bash script, then run the sql scripts in the following order to generate the 
data used in our hypothesis tests
