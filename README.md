# ETL-Project
This is the repo for the ETL project of UMN Data Analytics Bootcamp

Project goals (keep it simple)
Get some data
Clean it up
Stick it in a database

Steps
Find 2 data sources
Examples:
2 csv files
1 csv, 1 json
2 csv files from different sources
Transform the data
Load it into a database of your choice
SQL
MongoDB
Write a final technical report
** Can use markup within Jupyter Notebook to write your report within your code
Here’s where we got our data
Code showing loading data
Here’s how we transformed it
Code showing cleanup


Proposal Requirements
Names of team members
The data you intend to extract
Some idea of how you’ll transform your data
Something about your load

Team members
Jag Singh
Zoe Poeschl

Data used
Unemployment data
Diversity data
Median income data

Data transformation
County and state columns need to be standardized
Remove useless columns and rows 
In the unemployment data we will need to average the unemployment rate after grouping them by County and State. 
Diversity Index file needs the following changes:
Remove all state names 
Split columns where county and state are combined


Load plans
Create tables for the 3 CSVs in a SQL database
