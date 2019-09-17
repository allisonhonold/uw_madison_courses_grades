import psycopg2
from matplotlib import pyplot as plt
import pandas as pd

conn = psycopg2.connect(host='localhost', database="uw_madison")
cur = conn.cursor()

# Select data for population 1
cur.execute("""SELECT subjects.abbreviation, COUNT(course_offering_uuid)
                FROM subjects
                JOIN subject_memberships
                ON subjects.code = subject_memberships.subject_code
                WHERE subjects.code = '352'
                GROUP BY subjects.abbreviation
                ;
            """)

pop1 = pd.DataFrame(cur.fetchall(), columns= [x[0] for x in cur.description])

print(pop1)

# # Select data for population 2
# cur.execute("""SELECT
#                 FROM
#             """)

# pop2 = pd.DataFrame(cur.fetchall())

# # Plot histograms
# fig = plt.figure(figsize=(10,5))

# fig.hist(pop1)
# fig.hist(pop2)

# fig.show()

cur.close()
conn.close()

q3 = """SELECT course_offering_uuid, section_number, (CAST(a_count AS int) + 
CAST(ab_count AS int) + CAST(b_count AS int) + CAST(bc_count AS int) + 
CAST(c_count AS int) + CAST(d_count AS int) + CAST(f_count AS int) + 
CAST(s_count AS int) + CAST(u_count AS int) + CAST(cr_count AS int) +
CAST(n_count AS int) + CAST(p_count AS int) + CAST(i_count AS int) + 
CAST(nw_count AS int) + CAST(nr_count AS int) + CAST(other_count AS int)) AS tot_count 
FROM grade_distributions LIMIT 5;"""


q4 = """SELECT (CAST(a_count AS int) + CAST(ab_count AS int)) AS tot_count FROM grade_distributions LIMIT 5;"""