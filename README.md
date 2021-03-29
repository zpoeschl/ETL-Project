# Diversity vs Wealth | ETL Project
## Diversity vs. Unemployment vs. Income
This is the repo for the ETL project of UMN Data Analytics Bootcamp. Our final process report is contained within the Jupyter Notebook created for this project.

### Team members
* Jag Singh
* Zoe Poeschl

### Data used
* [Unemployment data](https://www.kaggle.com/jayrav13/unemployment-by-county-us)
* [Diversity data](https://www.kaggle.com/mikejohnsonjr/us-counties-diversity-index)
* [Median income data](https://data.world/tylerudite/2015-median-income-by-county/workspace/file?filename=2015+Median+Income+by+County.csv)

### Data transformation
* The county and state columns needed to be standardized across the three datasets
* For the unemployment data, ratings needed to be averaged after grouping by County and State
* The diversity file was the most complex to clean up. We:
    * Removed all full state names in the location column
    * Split the remaining data in the location column into county and state
* We removed useless columns and rows 

### Database creation
Once the three datasets were cleaned up, data was loaded into three tables in an SQL database.

# 
# INSTRUCTIONS
## Extract

1. Download CSVs from the following sources
    * [Unemployment data](https://www.kaggle.com/jayrav13/unemployment-by-county-us)
    * [Diversity data](https://www.kaggle.com/mikejohnsonjr/us-counties-diversity-index)
    * [Median income data](https://data.world/tylerudite/2015-median-income-by-county/workspace/file?filename=2015+Median+Income+by+County.csv)
2. Using `read_csv`, load the three CSVs into dataframes in a jupyter notebook
3. Clean up (transform) the data for each dataset per the below

## Transform
### Diversity dataset
4. Split the location column into separate county and state columns on the comma
5. Drop all rows with a value of 'NaN' in the newly created state column
6. Drop the location column as it is now redundant and no longer needed
7. Rename columns to be compatibile with the database which will be created in the Load portion of the process
    * `'Diversity-Index': 'diversity_index'`
    * `'Black or African American alone, percent, 2013': 'black'`
    * `'American Indian and Alaska Native alone, percent, 2013': 'native_am'`
    * `'Asian alone, percent, 2013': 'asian'`
    * `'Native Hawaiian and Other Pacific Islander alone, percent,': 'hawaiian'`
    * `'Two or More Races, percent, 2013': 'mixed'`
    * `'Hispanic or Latino, percent, 2013': 'latinx'`
    * `'White alone, not Hispanic or Latino, percent, 2013': 'white'`
    * `'County': 'county'`
    * `'State': 'state'`

### Unemployment dataset
8. Convert all state names to their state abbreviations so as to be compatible with the other datasets
    * ` {'Alabama': 'AL', 'Alaska': 'AK', 'Arizona': 'AZ', 'Arkansas': 'AR', 'California': 'CA', 'Colorado': 'CO',
'Connecticut': 'CT', 'Delaware': 'DE', 'Florida': 'FL', 'Georgia': 'GA', 'Hawaii': 'HI', 'Idaho': 'ID',
'Illinois': 'IL', 'Indiana': 'IN', 'Iowa': 'IA', 'Kansas': 'KS', 'Kentucky': 'KY', 'Louisiana': 'LA',
'Maine': 'ME', 'Maryland': 'MD', 'Massachusetts': 'MA', 'Michigan': 'MI', 'Minnesota': 'MN', 'Mississippi': 'MS',
'Missouri': 'MO', 'Montana': 'MT', 'Nebraska': 'NE', 'Nevada': 'NV', 'New Hampshire': 'NH', 'New Jersey': 'NJ',
'New Mexico': 'NM', 'New York': 'NY', 'North Carolina': 'NC', 'North Dakota': 'ND', 'Ohio': 'OH', 'Oklahoma': 'OK',
'Oregon': 'OR', 'Pennsylvania': 'PA', 'Rhode Island': 'RI', 'South Carolina': 'SC', 'South Dakota': 'SD',
'Tennessee': 'TN', 'Texas': 'TX', 'Utah': 'UT', 'Vermont': 'VT', 'Virginia': 'VA', 'Washington': 'WA',
'West Virginia': 'WV', 'Wisconsin': 'WI', 'Wyoming': 'WY'}`
9. Rename columns to be compatibile with the database which will be created in the Load portion of the process
    * `'County': 'county'`
    * `'State': 'state'`
    * `'Rate': 'rate'`
10. Drop any rows with a duplicate value of both county and state
    * Some county names occur across multiple states; this is correct. Counties which occur with the same name within the same state should be removed.
        * `df.drop_duplicates(subset=['county', 'state'])`

### Median Income dataset
10. Rename columns to be compatibile with the database which will be created in the Load portion of the process
    * `'County': 'county'`
    * `'State Code': 'state'`
    * `'Population': 'population'`
    * `'Median household income': 'median_household_income'`

## Load
11. In PGAdmin, create a new database named `diversity_wealth_db`
12. Within your new database, use the querytool to run the 3 `create table` queries which can be found in our *etl_queries.sql* file contained in this repo
12. Create a config.py file and store your postgres username and password in it
    * `username = "yourusernamehere"`
    * `password = "yourpasswordhere"`
13. In your jupyter notebook, connect to your database using the following formula so as to be compatible with the format of the config.py file
    * `rds_connection_string = f"{username}:{password}@localhost:5432/ETL_db"`
    * `engine = create_engine(f'postgresql://{rds_connection_string}')`
14. Using `to_sql`, load the income, diversity, and unemployment dataframes to your diversity_wealth_db
    * **Income**
        * `median_df.to_sql(name='income', con=engine, if_exists='append', index=False)`
    * **Diversity**
        * `diversity_df.to_sql(name='diversity', con=engine, if_exists='append', index=False)`
    * **Unemployment**
        * `unemp_df.to_sql(name='unemployment', con=engine, if_exists='append', index=False)`
15. Use `read_sql_query` to confirm data was loaded to your three database tables