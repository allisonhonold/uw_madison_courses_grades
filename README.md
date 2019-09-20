# Hypothesis Testing with Grades from University of Wisconsin at Madison
This project is formed from https://www.kaggle.com/Madgrades/uw-madison-courses and conducts hypothesis testing to observe the effects of days of the week, year, teachers, class start time, and subject material upon GPAs.

In order to access this data, please make a Kaggle account at the link above and download the zip file.

This project assumes that the user will fork and clone this project locally and that the data will be downloaded into a data subfolder in the project directory.


## Hypothesis Testing
### Question 1: Does the class meeting day of the week have a significant effect upon GPA?
> If the class meets on weekdays, we did not find an effect upon GPA. However, we found classes that meet on weekends to be statistically distinct at a 95% confidence interval. [Day of Week and GPA](days_of_week/README.md)


### Question 2: Is there a difference between grades of the 2016-2017 school year vs those of the 2006-2007 school year?
> We did not find a significant difference in GPAs between these two school years, which were a decade apart. [Grade Inflation from 2006/2007 to 2016/2017](grade_inflation/README.md)


### Question 3: Is there a difference between grades of each year vs all other years in the data set?
> We found that the earlier and later years in the data set that were statistically distinct from the overall data set at a 95% confidence interval. [Each Academic Year Compared to the Others](grade_inflation_all_years/README.md)


### Question 4: Do teachers in the math department grade similarly to other teachers in the math department?
> We did find some teachers (~12) in the math department that graded differently from the rest of the department. We did not find that the others graded differently on a statistically significant basis. [Math Teacher Grading Consistency](math_teacher/README.md)


### Question 5: Does the start time for a class have a significant effect upon GPA?
> We did not find a difference in GPAs for classes that start in the morning vs classes that start in the afternoon. [Time of Day and GPA](morning_afternoon_gpa/README.md)


### Question 6: Do STEM classes grade differently from non-STEM classes?
> We found that STEM classes have a different GPA than non-STEM classes to a statistically significant degree at a 95% confidence interval. [STEM vs Non-STEM GPA](stem_classes/README.md)


## Requirements
> If you are curious about technical documentation for conducting these hypothesis tests, please read [REQUIREMENTS.md](REQUIREMENTS.md)