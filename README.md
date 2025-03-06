<div align="center">
<img src="images/banner.png" alt="Business Loan">
<h1> Business Loan Database Analysis </h1>
</div>

# // Summary //

This project revolves around analyzing the **business_loan_db**, a comprehensive dataset consisting of `400,000` entries. The database captures data on loans availed by prominent businesses to finance their operations and growth. The dataset includes notable companies such as **Zomato**, **Bharti Airtel**, **Infosys**, and **Kotak Mahindra Bank**, among others. 


## Key Objectives

1. **Loan Utilization Analysis**: Assess how companies allocate loan amounts across different operational and growth activities.

2. **Repayment Trends**: Identify patterns in loan repayments and highlight factors influencing timely repayments or defaults.

3. **Industry Insights**: Derive sector-specific insights into loan dependency and financial strategies.

4. **Growth Correlation**: Examine how loans impact business growth and revenue generation.

5. **Risk Assessment**: Understand risk levels based on company size, sector, and loan amount.


## Purpose

This analysis aims to provide actionable insights for:

- **Businesses**: To enhance decision-making regarding loan utilization.

- **Financial Institutions**: To better assess loan risks and repayment trends.

- **Policymakers**: To create strategies for fostering sustainable business growth.

---

# // Workflow //

## Python

- **Importing Required Libraries**

    ```python
    import pandas as pd 
    import numpy as np
    import pymysql
    from sqlalchemy import create_engine


    df = pd.read_csv('business_loan_data.csv')
    ```
- **Analysis of the Business Loan Dataset**

    ```python
    df.columns

    df.shape

    df.head()

    df.isnull().sum()

    df.duplicated().sum()

    df.info()
    ```

- **Data Cleaning and Standardization**

--- Fixing alingment of data to left

    ```python
    pd.options.display.colheader_justify = 'left'

    df.head()
    ```

--- Cleaning the special characters from columns and changing the data type of the column

    ```python
    df['emp_length_year'] = (
    df['emp_length']
    .str.replace('<', '', regex=False)
    .str.replace('years', '', regex=False)
    .str.replace('year', '', regex=False)
    .str.strip()
    )

    df['emp_length_year'] = df['emp_length_year'].astype('int64')

    df.drop(columns=['emp_length'], inplace=True)

    df.head()
    ```

--- change the term to int64 and removing the 'months' string

    ```python
    df['term'] = df['term'].str.replace('months', '', regex=False).str.strip()

    df['term'] = df['term'].astype('int64')

    df.head()

    df.info()
    ```

--- Trim the rows and columns of the dataframe

    ```python
    df = df.applymap(lambda x: x.strip() if isinstance(x, str) else x)

    print(df)
    ```

--- Fixing the date format from string to date

    ```python
    date_columns = ['issue_date', 'last_credit_pull_date', 'last_payment_date', 'next_payment_date']

    for column in date_columns:
    invalid_dates = df[df[column].isna()]
    print(f"Invalid or NaT values in {column}:\n", invalid_dates)


    print(df[date_columns].head())
    df[column].fillna('0001-01-01', inplace=True)


    date_columns = ['issue_date', 'last_credit_pull_date', 'last_payment_date', 'next_payment_date']

    for column in date_columns:

    df[column] = pd.to_datetime(df[column], errors='coerce')
    df[column] = df[column].dt.strftime('%Y-%m-%d')


    df.info()
    df.head()
    ```
- **Exporting the cleaned data to a CSV file**

    ```python
    df.to_csv('business_loan_cleaned.csv', index=False)

    print("DataFrame successfully exported to 'business_loan_cleaned.csv'")
    ```

- **Connecting to the MySQL database**
    
    ```python
    ```