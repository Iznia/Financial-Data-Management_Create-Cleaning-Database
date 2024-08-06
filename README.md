# Financial Data Management Project

## Overview

Welcome to the Financial Data Management Project! This project focuses on creating a relational database using PostgreSQL and performing data manipulation and cleaning using Pandas. The aim is to help the Finance division of a retail company organize their data more efficiently by moving from Excel files to a robust database system.

## Assignment Instructions

### Project Structure

This project consists of the following files:

1. **Notebook File** 
    - Contains data exploration, cleaning, and normalization processes using Pandas and Python.
    - Includes markdown cells explaining each step and its purpose.

2. **SQL Query File** 
    - Contains SQL queries for creating and managing the database and its tables.
    - Includes comments explaining each section of the SQL code.

3. **CSV Files**
    - Two CSV files containing cleaned and processed data to be used in the database.


### Steps and Instructions

#### 1. Data Exploration

- Load the data file using Pandas and display the data.
- Provide summary information and explain any findings.
- List the column names and explain the next steps based on these findings.
- List unique values in columns `Segment`, `Country`, `Product`, and `Discount Band` and provide insights.

#### 2. Data Cleaning

- Perform data cleaning based on the exploration findings.
- Rename columns, handle missing values, and convert data types as needed.
- Ensure the data is clean and ready for further processing.

#### 3. Data Normalization

- Normalize the cleaned data to the third normal form (3NF).
- Create five tables, including the main table.
- Use appropriate primary and foreign keys to maintain relationships between tables.
- Save each table as a CSV file without including the DataFrame index.

#### 4. Relational Database & SQL

- Create a PostgreSQL database (outside the transactional block).
- Write transactional queries to:
  - Create normalized tables with appropriate data types and constraints.
  - Load data from CSV files into the tables using the `COPY` command.
  - Create at least two users with different levels of access.
  - Grant appropriate permissions to each user.
- Save all SQL queries in a `.sql` file.

#### 5. Database Testing

- Test the database with specific queries:
  - Retrieve total profit for each segmentation type, excluding discount data.
  - Retrieve summary statistics (average, min, max) of sales for each country.
- Save the resulting tables in separate files and load them into the notebook for display.
- Include the SQL queries in markdown cells for reference.

### Summary

The Financial Data Management Project aims to transition the Finance division's data management from Excel to a PostgreSQL database. This project involves exploring, cleaning, and normalizing the data using Pandas, followed by creating and managing the database with SQL. The final steps include testing the database with specific queries and ensuring all operations are well-documented and executable.


