import psycopg2
import pandas as pd
import numpy as numpy
import matplotlib.pyplot as plt

# Connect to a local database named 'uw_madison' 
conn = psycopg2.connect(host='localhost',
                        database='uw_madison')

# Open a cursor to perform database operations
cur = conn.cursor()



def Query_Executor(table_name):

    query = f"""SELECT * 
            FROM {table_name};"""
        
    cur.execute(query)
    df = pd.DataFrame(cur.fetchall())
    df.columns = [x[0] for x in cur.description]
    return df


teachings_query = Query_Executor("teachings")
print(teachings_query.describe())

