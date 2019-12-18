# Investigating overall section GPA trends across time.

This notebook uses data from the UW Madison database to complete hyphothesis tests comparing mean section grades in each year to the mean section grades for all years.

$H_0$: The grading in this year is the same as the overall grading.

$H_A$: The grading in this year is different from the overall grading.

## Import necessary Python libraries and modules


```python
from sqlalchemy import create_engine
import pandas as pd
from matplotlib import pyplot as plt
import numpy as np
from scipy import stats
from statsmodels.stats.multitest import multipletests
```

## Query the database and create a dataframe of each year's mean grades for each section


```python
engine = create_engine('postgresql:///uw_madison')
df = pd.read_sql_query("""SELECT * FROM section_grades_term;""", engine)

all_years = df
oh_six = df.loc[df['term_code'].isin(['1072', '1074'])] #2006-2007
oh_seven = df.loc[df['term_code'].isin(['1082', '1084'])] #2007-2008
oh_eight = df.loc[df['term_code'].isin(['1092', '1094'])] #2008-2009
oh_nine = df.loc[df['term_code'].isin(['1102', '1104'])] #2009-2010
ten = df.loc[df['term_code'].isin(['1112', '1114'])] #2010-2011
eleven = df.loc[df['term_code'].isin(['1122', '1124'])] #2011-2012
twelve = df.loc[df['term_code'].isin(['1132', '1134'])] #2012-2013
thirteen = df.loc[df['term_code'].isin(['1142', '1144'])] #2013-2014
fourteen = df.loc[df['term_code'].isin(['1152', '1154'])] #2014-2015
fifteen = df.loc[df['term_code'].isin(['1162', '1164'])] #2015-2016
sixteen = df.loc[df['term_code'].isin(['1172', '1174'])] #2016-2017
```

## Visualize and test each year as compared to the entire population.


```python
years = [oh_six, oh_seven, oh_eight, oh_nine, ten, 
         eleven, twelve, thirteen, fourteen, fifteen, sixteen]

fig, ax = plt.subplots(nrows=len(years), ncols=1,
                      figsize=(15, len(years)*4))
for row, year in enumerate(years):
    year_dist = year['section_gpa']
    pop_dist = np.random.choice(all_years['section_gpa'], size=len(year_dist), replace=False)
    statistics = stats.ttest_ind(year_dist, pop_dist)
    
    ax[row].hist(year_dist, alpha = .5, label=row, range=(1, 4), bins=30)
    ax[row].hist(pop_dist, alpha = .5, label='All Years', range= (1, 4), bins=30)
    ax[row].axvline(all_years['section_gpa'].mean(), color='#ff7f0e', alpha=.75, 
               label='Overall Mean', linestyle='dashed')
    ax[row].axvline(year_dist.mean(), color='#1f77b4', alpha=.75, 
               label=f'{row} mean', linestyle='dashed')
    ax[row].set_title(f'year {row}: p-value: {round(statistics[1], 3)} mean: {round(year_dist.mean(), 3)}')
    ax[row].legend()
    ax[row].set_xlim(1,4)
```


![png](grade_inflation_all_years_files/grade_inflation_all_years_7_0.png)


# Using Bonferroni correction


```python
years = [oh_six, oh_seven, oh_eight, oh_nine, ten, 
         eleven, twelve, thirteen, fourteen, fifteen, sixteen]

all_p_vals = []
one_d_p_vals = []

# fig, ax = plt.subplots(nrows=len(years), ncols=1,figsize=(15, len(years)*4))
for row, year in enumerate(years):
    year_dist = year['section_gpa']
    pop_dist = np.random.choice(all_years['section_gpa'], size=len(year_dist), replace=False)
    statistics = stats.ttest_ind(year_dist, pop_dist)
    all_p_vals.append(statistics[1])
    one_d_p_vals.append(stats.ttest_ind(year_dist, pop_dist, equal_var=False)[1])
    
#     ax[row].hist(year_dist, alpha = .5, label=row, range=(1, 4), bins=30)
#     ax[row].hist(pop_dist, alpha = .5, label='All Years', range= (1, 4), bins=30)
#     ax[row].axvline(all_years['section_gpa'].mean(), color='#ff7f0e', alpha=.75, 
#                label='Overall Mean', linestyle='dashed')
#     ax[row].axvline(year_dist.mean(), color='#1f77b4', alpha=.75, 
#                label=f'{row} mean', linestyle='dashed')
#     ax[row].set_title(f"""year: {row}, 
#                             p-value: {round(statistics[1], 3)}, 
#                             mean: {round(year_dist.mean(), 3)}""")
#     ax[row].legend()
#     ax[row].set_xlim(1,4)

print(all_p_vals)
```

    [0.0030724455403739813, 0.05701168803349494, 0.08889187883765713, 0.0025429914513628955, 0.04316168557894617, 0.013177823654470538, 0.6334213945514046, 0.5598588087783257, 0.8131417268956107, 1.1140582071188692e-08, 3.84431493067845e-12]



```python
multipletests(one_d_p_vals)
```




    (array([ True, False, False,  True, False, False, False, False, False,
             True,  True]),
     array([2.43168870e-02, 2.54356026e-01, 3.10904127e-01, 2.26555002e-02,
            2.32583170e-01, 8.86771477e-02, 9.14733970e-01, 9.14733970e-01,
            9.14733970e-01, 1.11411522e-07, 4.22905044e-11]),
     0.004652171732197341,
     0.004545454545454546)



# Analysis

We reject the null hypothesis that there is no difference in grading for the years 2006-2007, 2007-2008, 2008-2009, 2009-2010, 2010-2011, 2011-2012, 2015-2016, 2016-2017 at a 95% confidence interval.

We fail to reject the null hypothesis for the years 2012-2013, 2013-2014, and 2014-2015.

After using the Bonferroni correction, we see that we can reject the null hypothesis for 2006-2007, 2009-2010, 2015-2016, 2016-2017 and fail to reject the null hypothesis for years 2007-2008, 2008-2009, 2010-2011, 2011-2012, 2012-2013, 2013-2014, 2014-2015.

Due to the random selection used for the comparison, it's possible for the answers to shift and change.


```python

```
