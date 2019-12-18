# Comparing GPAs of Days of the Week at UW Madison since 2006

This notebook performs a SQL query on the UW Madison database and does a hypothesis test on each day's GPA compared against all of the other days' GPAs

For each day:

$H_0$ = There is no difference between this day's GPAs and the other days' GPAs

$H_A$ = There is a difference between this day's GPAs and the other days' GPAs

---

## Import necessary Python libraries and modules


```python
from sqlalchemy import create_engine
from scipy import stats
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from statsmodels.stats.multitest import multipletests
```

## Query the database to create one overall Pandas dataframe which is then filtered to remove any classes where the GPA is 4.0


```python
engine = create_engine('postgresql:///uw_madison')
```


```python
query = """SELECT * FROM days_gpas;"""
```


```python
all_days_df = pd.read_sql(query, engine)
all_days_df.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>section_number</th>
      <th>section_gpa</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>175962.000000</td>
      <td>175962.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>5.318677</td>
      <td>3.414629</td>
    </tr>
    <tr>
      <th>std</th>
      <td>11.613988</td>
      <td>0.363838</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1.000000</td>
      <td>3.154255</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1.000000</td>
      <td>3.447619</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>4.000000</td>
      <td>3.716216</td>
    </tr>
    <tr>
      <th>max</th>
      <td>234.000000</td>
      <td>3.998418</td>
    </tr>
  </tbody>
</table>
</div>




```python
all_days_df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>uuid</th>
      <th>name</th>
      <th>mon</th>
      <th>tues</th>
      <th>wed</th>
      <th>thurs</th>
      <th>fri</th>
      <th>sat</th>
      <th>sun</th>
      <th>subject_name</th>
      <th>section_number</th>
      <th>section_gpa</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>00015734-b612-3152-bf5f-7f6855e1c0c0</td>
      <td>Fundamentals of Analytical Sci</td>
      <td>false</td>
      <td>false</td>
      <td>true</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>Chemistry</td>
      <td>1</td>
      <td>3.117647</td>
    </tr>
    <tr>
      <th>1</th>
      <td>00015734-b612-3152-bf5f-7f6855e1c0c0</td>
      <td>Fundamentals of Analytical Sci</td>
      <td>false</td>
      <td>true</td>
      <td>false</td>
      <td>true</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>Chemistry</td>
      <td>1</td>
      <td>3.117647</td>
    </tr>
    <tr>
      <th>2</th>
      <td>0002389b-0bda-3f47-b5e7-e9d8973cb2e9</td>
      <td>Corporate&amp;Special Info Serv</td>
      <td>true</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>Library and Information Studies</td>
      <td>1</td>
      <td>3.818182</td>
    </tr>
    <tr>
      <th>3</th>
      <td>00028b06-6e42-3a3e-b484-69fd61baf978</td>
      <td>Spectrochemical Measuremts</td>
      <td>true</td>
      <td>false</td>
      <td>true</td>
      <td>false</td>
      <td>true</td>
      <td>false</td>
      <td>false</td>
      <td>Chemistry</td>
      <td>1</td>
      <td>3.425926</td>
    </tr>
    <tr>
      <th>4</th>
      <td>0006b3f8-3403-35d5-bda2-9489e3c84434</td>
      <td>Consultatn&amp;Suprvsn-Soc Work</td>
      <td>false</td>
      <td>true</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>false</td>
      <td>Social Work</td>
      <td>1</td>
      <td>3.730769</td>
    </tr>
  </tbody>
</table>
</div>




```python
all_days_df = all_days_df.loc[all_days_df['section_gpa'] != 4.0]
all_days_df.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>section_number</th>
      <th>section_gpa</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>175962.000000</td>
      <td>175962.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>5.318677</td>
      <td>3.414629</td>
    </tr>
    <tr>
      <th>std</th>
      <td>11.613988</td>
      <td>0.363838</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000000</td>
      <td>0.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1.000000</td>
      <td>3.154255</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1.000000</td>
      <td>3.447619</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>4.000000</td>
      <td>3.716216</td>
    </tr>
    <tr>
      <th>max</th>
      <td>234.000000</td>
      <td>3.998418</td>
    </tr>
  </tbody>
</table>
</div>



## The overall dataframe is then used to make dataframes for each day and for all other days. E.g. a Monday dataframe with a dataframe for all days besides Monday. Then randomly pick 70 from each dataframe to make plots and conduct hypothesis testing on.


```python
days = ['mon', 'tues', 'wed', 'thurs', 'fri', 'sat', 'sun']
```


```python
gpas = []
p_vals = {}
one_d_p_vals = []

for day in days:
    day_df = all_days_df.loc[all_days_df[str(day)] == 'true', 'section_gpa']
    day_choice = np.random.choice(day_df, size=70, replace=False)
    
    not_day_df = all_days_df.loc[all_days_df[str(day)] != 'true', 'section_gpa']
    not_day_choice = np.random.choice(not_day_df, size=70, replace=False)
    gpas.append({"day": day_choice, "not_day": not_day_choice})
    p_vals[str(day)] = stats.ttest_ind(day_choice, not_day_choice, equal_var=False)
    one_d_p_vals.append(stats.ttest_ind(day_choice, not_day_choice, equal_var=False)[1])
```

## Generate plots comparing each day against all other days


```python
full_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
```


```python
fig, ax = plt.subplots(nrows=7, ncols=1, figsize=(15,20))

counter = 0

for row in range(ax.shape[0]):
    ax[row].hist(gpas[counter]["day"], alpha=0.5, bins=25, range=(2.5, 4.0), label=f'{full_days[counter]} GPAs')
    ax[row].axvline(gpas[counter]["day"].mean(), color='#1f77b4', alpha=1, linestyle='dashed',label=f'{full_days[counter]} Mean')
    ax[row].hist(gpas[counter]["not_day"], color='#ff7f0e', alpha=0.5, bins=25, range=(2.5, 4.0), label=f'GPAs from Days Other than {full_days[counter]}')
    ax[row].axvline(gpas[counter]["not_day"].mean(), color='#ff7f0e', alpha=1, linestyle='dashed',label=f'Days Other than {full_days[counter]} Mean')
    ax[row].legend()
    ax[row].set_xlabel('GPA');
    counter += 1
    
fig.tight_layout()
```


![png](days_of_week_gpas_files/days_of_week_gpas_16_0.png)


## Display the T statistic and p-values for each day against all other days


```python
p_vals
```




    {'mon': Ttest_indResult(statistic=0.3861586905726627, pvalue=0.6999807413618497),
     'tues': Ttest_indResult(statistic=1.158900732637778, pvalue=0.24868242363225904),
     'wed': Ttest_indResult(statistic=0.1702067405316272, pvalue=0.865101860131468),
     'thurs': Ttest_indResult(statistic=-0.7744049316301642, pvalue=0.4400190061996502),
     'fri': Ttest_indResult(statistic=-2.8518213298163033, pvalue=0.0050304608883447715),
     'sat': Ttest_indResult(statistic=4.211019878637128, pvalue=4.8332157044897395e-05),
     'sun': Ttest_indResult(statistic=5.624870922850782, pvalue=1.1384256658117605e-07)}



We can see from the plots and the T statistics of the random samples from the weekday populations that the GPAs are not different to a statistically significant amount. In these cases, we fail to reject the null hypothesis for each weekday.

However, the classes that meet on weekends have GPAs that are statistically distinct from the other days. For Saturday and Sunday, we reject the null hypothesis.

# Use Bonferroni Correction


```python
multipletests(one_d_p_vals)
```




    (array([False, False, False, False,  True,  True,  True]),
     array([9.92773724e-01, 8.64354734e-01, 8.64354734e-01, 8.64354734e-01,
            3.30240674e-03, 2.19425913e-06, 5.30000743e-06]),
     0.007300831979014655,
     0.0071428571428571435)



When using the Bonferroni correction to account for multiple tests, we can see that we fail to reject the null hypothesis for Monday through Thursday, and reject the null hypothesis for Friday through Sunday.

Due to the random selection of classes however, the results can change.


```python

```
