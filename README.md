# Hypothesis Testing with Grades from University of Wisconsin at Madison

## Authors:
### Aaron Washington Chen [GitHub](https://github.com/AaronWChen)
### Allison Honold [GitHub](https://github.com/allisonhonold)

## Executive Summary
This project is formed from [this Kaggle page](https://www.kaggle.com/Madgrades/uw-madison-courses) 
and conducts hypothesis testing to observe the effects of days of the week, year, teachers, class start time, 
and subject material upon GPAs.

## Hypothesis Testing
### Question 1: Does the class meeting day of the week have a significant effect upon GPA?
> If the class meets on weekdays, we did not find an effect upon GPA. However, we found classes that meet on weekends 
to be statistically distinct at a 95% confidence interval. After factoring in the Bonferroni correction, we found that 
not only are weekends still distinct from the weekdays, but Fridays are also distinct from the other weekdays. 
[Day of Week and GPA](days_of_week/days_of_week_gpas.md)


### Question 2: Is there a difference between grades of the 2016-2017 school year vs those of the 2006-2007 school year?
> We did not find a significant difference in GPAs between these two school years, which were a decade apart. 
[Grade Inflation from 2006/2007 to 2016/2017](grade_inflation/grade_inflation.md)


### Question 3: Is there a difference between grades of each year vs all other years in the data set?
> We found that earlier and later years in the data set that were statistically distinct from the overall data set at a 
95% confidence interval. Even factoring in the Bonferroni correction revealed some differences. 
[Each Academic Year Compared to the Others](grade_inflation_all_years/grade_inflation_all_years.md)


### Question 4: Do teachers in the math department grade similarly to other teachers in the math department?
> We did originall find some teachers (~12) in the math department that graded differently from the rest of the 
department. We did not find that the others graded differently on a statistically significant basis. However, after 
factoring in the Bonferroni correction, we found that only 3 teachers graded differently from the rest of the 
department. [Math Teacher Grading Consistency](math_teacher/math_teacher_gpa.md)


### Question 5: Does the start time for a class have a significant effect upon GPA?
> We did not find a difference in GPAs for classes that start in the morning vs classes that start in the afternoon. 
[Time of Day and GPA](morning_afternoon_gpa/morning_afternoon_gpa.md)


### Question 6: Do STEM classes grade differently from non-STEM classes?
> We found that STEM classes have a different GPA than non-STEM classes to a statistically significant degree at a 95% 
confidence interval. [STEM vs Non-STEM GPA](stem_classes/stem_non_stem_gpas.md)


## Project Information
In order to access this data, please make a Kaggle account and download the zip file 
[here](https://www.kaggle.com/Madgrades/uw-madison-courses).

This project assumes that the user will fork and clone this project locally and that the data will be downloaded into a 
data subfolder in the project directory.


## Improvements and Next Steps
1. The original presentation and results of this project did not check for multiple tests and was written in a way that 
only works on Macs. As such, more specific instructions should be used to get this to work on PC. However, looking at
the results/summaries does not require additional work.

2. Should add more explicit statistical results in individual presentations. These include power and especially effect 
size. Hopefully these will still be valid despite the small sample sizes. 

3. Currently, the individual result summaries do factor in the Bonferroni correction where appropriate, but the
technical setup instructions still could use some work to walk through setting up and running on PC. Bonferroni 
correction is good as a baseline way to correct for testing multiple hypotheses at once, but may be too strict.
Using Bonferroni correction drastically reduces the required significance for each test.

## Running the Code
If you are curious about technical documentation for conducting these hypothesis tests, please be aware that you will:

1. Need to create a Kaggle account to download the original data.
2. Install Python 3 (I prefer Anaconda)
3. Install postgresql
4. Clone this repo
5. Install the packages in the requirements via pip (pip install -r requirements.txt while in the base project 
directory)
6. Read [REQUIREMENTS.md](REQUIREMENTS_MAC.md)

If you want to see the individual summaries, you can open a Jupyter Notebook server in the base project directory and 
navigate to each individual hypothesis folder to read the notebook files. 