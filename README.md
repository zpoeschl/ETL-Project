# ETL-Project
## Diversity vs. Population vs. Income
This is the repo for the ETL project of UMN Data Analytics Bootcamp. Our final process report is contained within the Jupyter Notebook created for this project.

### Team members
* Jag Singh
* Zoe Poeschl

### Data used
* [Unemployment data] (https://www.kaggle.com/jayrav13/unemployment-by-county-us)
* [Diversity data] (https://www.kaggle.com/mikejohnsonjr/us-counties-diversity-index)
* [Median income data] (https://data.world/tylerudite/2015-median-income-by-county/workspace/file?filename=2015+Median+Income+by+County.csv)

### Data transformation
* The county and state columns needed to be standardized across the three datasets
* For the unemployment data, ratings needed to be averaged after grouping by County and State
* The diversity file was the most complex to clean up. We:
    * Removed all full state names in the location column
    * Split the remaining data in the location column into county and state
* We removed useless columns and rows 

### Database creation
Once the three datasets were cleaned up, data was loaded into three tables in an SQL database.
