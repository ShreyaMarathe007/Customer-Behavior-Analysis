# Importing file to mysql
import pandas as pd
data = pd.read_csv(r"C:\Users\Shreya Marathe\Desktop\Project\Customer_Behaviour_Analysis\Data\cleaned_customer_data.csv")
print(data.head(5))

from sqlalchemy import create_engine

username = "root"
password = "shreya"
host = "localhost"
port = "3306"
database = "project_db"

# MySQL connection
engine = create_engine(f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}")

# Write DataFrame to MySQL
table_name = "customer"   
data.to_sql(table_name, engine, if_exists="replace", index=False)

print("Written Dataframe to MySQL")
