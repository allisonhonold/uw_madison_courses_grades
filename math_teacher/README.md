
# Investigating GPA Trends of Math Instructors Compared to the Math Department as a Whole at UW Madison since 2006

This notebook uses data from the UW Madison database to complete hypothesis tests on each math teacher that has taught more than 15 sections graded on A-F scale.

$H_0$: The teacher's section mean GPA's are no different than that of the math department as a whole.

$H_A$: The teacher's section mean GPA's are higher or lower than that of the math department as a whole.

---

## Import necessary Python libraries and modules


```python
from sqlalchemy import create_engine
import pandas as pd
from matplotlib import pyplot as plt
import numpy as np
from scipy import stats
```

## Query the database and create a dataframe of math_grades_clean


```python
engine = create_engine('postgresql:///uw_madison')
```


```python
df = pd.read_sql_query("""SELECT * FROM math_grades_clean;""", engine)
```

## Example analysis for a single instructor


```python
teacher = df.loc[df['instructor_id'] == '3089128']
teacher_dist = teacher['section_gpa']
pop_dist = np.random.choice(df['section_gpa'], size = len(teacher_dist), replace=False)
pval = stats.ttest_ind(teacher_dist, pop_dist, equal_var=False)[1]

print('instructor: 3089128')
print(f'p-value: {pval}')

fig, ax = plt.subplots(figsize = (15, 8))
ax.hist(teacher_dist, alpha = .5, label='Instructor: 3089128', range=(1, 4), bins=30)
ax.hist(pop_dist, alpha = .5, label='Math Department', range= (1, 4), bins=30)
ax.axvline(df['section_gpa'].mean(), color='#ff7f0e', alpha=.75, 
           label='Math Mean', linestyle='dashed')
ax.axvline(teacher_dist.mean(), color='#1f77b4', alpha=.75, 
           label='Instructor 3089128 Mean', linestyle='dashed')
ax.legend()
ax.set_xlim(1,4);
```

    instructor: 3089128
    p-value: 0.09445482502957685



![png](math_teacher_gpa_files/math_teacher_gpa_9_1.png)


## For each instructor with more than 15 sections taught, complete hypothesis test. If there is a statistically significant difference in grading α=0.05 level, we log the p-value, and instructor


```python
p_values = []
exceptional_instructors = []

for instructor in df['instructor_id'].unique():
    gpas = df.loc[df['instructor_id'] == instructor, 'section_gpa']
    if len(gpas) > 15:
        teacher_dist = gpas
        pop_dist = np.random.choice(df['section_gpa'], size=len(gpas), replace=False)
        pval = stats.ttest_ind(teacher_dist, pop_dist, equal_var=False)[1]
        p_values.append(pval)
        if pval <= .05:
            exceptional_instructors.append(instructor)
    
```

## List summary results from teacher analysis


```python
print (f'% significantly different: {round(len(exceptional_instructors)/len(p_values),3)*100}')
print (f'number significantly different: {len(exceptional_instructors)}')

```

    % significantly different: 20.599999999999998
    number significantly different: 7


## Plot histogram for each instructor whose grading is statistically significantly different at a α=0.05 level from the Math department as a whole


```python
fig, ax = plt.subplots(nrows=len(exceptional_instructors), ncols=1, 
                       figsize = (15, len(exceptional_instructors)*4))
for row, instructor in enumerate(exceptional_instructors):
    ax[row].hist(df.loc[df['instructor_id']==instructor, 'section_gpa'], density=True,
                 alpha=0.5, bins=15, range=(1,4), label=f'Instructor {instructor}')
    ax[row].hist(df['section_gpa'], density=True,
                 alpha=0.5, bins=15, range=(1,4), label=f'Math department')
    ax[row].set_xlabel('GPA')
    ax[row].set_title(f'Instructor {instructor} Section Mean GPAs')
    ax[row].set_ylim((0,4.5))
    ax[row].axvline(df['section_gpa'].mean(), color='#ff7f0e', alpha=.75, 
                    label='Math Mean', linestyle='dashed')
    ax[row].axvline(df.loc[df['instructor_id']==instructor, 'section_gpa'].mean(), 
                    color='#1f77b4', alpha=.75, label='Instructor Mean', linestyle='dashed')
    ax[row].legend()
    
fig.tight_layout()
```


![png](math_teacher_gpa_files/math_teacher_gpa_15_0.png)


## Analysis

We reject the null hypothesis that there is no difference between the teacher and the math department as a whole for these instructors at a 95% confidence level.

For the remaining instructors, we do not reject the null hypothesis.


```python

```
