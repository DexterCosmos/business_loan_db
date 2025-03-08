<div align="center">
<img src="images/Business_loan_DB.png" alt="Business Loan" width="600">
</div>

<h1 align="center"> Business Loan Analysis </h1> 

---

## // Summary //

This project revolves around analyzing the **business_loan_db**, a comprehensive dataset consisting of `400,000` entries. The database captures data on loans availed by prominent businesses to finance their operations and growth. The dataset includes notable companies such as **Zomato**, **Bharti Airtel**, **Infosys**, and **Kotak Mahindra Bank**, among others including those associated through business loan accounts.


### Key Objectives

- **Loan Utilization Analysis**: Assess how companies allocate loan amounts across different operational and growth activities.

- **Repayment Trends**: Identify patterns in loan repayments and highlight factors influencing timely repayments or defaults.

- **Industry Insights**: Derive sector-specific insights into loan dependency and financial strategies.

- **Growth Correlation**: Examine how loans impact business growth and revenue generation.

- **Risk Assessment**: Understand risk levels based on company size, sector, and loan amount.


### Purpose

This analysis aims to provide actionable insights for:

- **Businesses**: To enhance decision-making regarding loan utilization.

- **Financial Institutions**: To better assess loan risks and repayment trends.

- **Policymakers**: To create strategies for fostering sustainable business growth.

---

## // Workflow //

Python to clean and preprocess data, ensuring it was ready for analysis. SQL was then employed to address business requirements and resolve complex data-related challenges. Finally, Power BI was used to visualize key insights, enabling data-driven decision-making effectively

### Python

#### **Importing Required Libraries**

 - Importing the necessary libraries for data analysis and database connection.

    ```python
     import pandas as pd 
     import numpy as np
     import pymysql
     from sqlalchemy import create_engine

     df = pd.read_csv('business_loan_data.csv')
   ```
    
#### **Analysis of Dataset**

 - Checking the shape, columns, and data types of the dataset

    ```python
     df.columns

     df.shape

     df.head()

     df.isnull().sum()

     df.duplicated().sum()

     df.info()
   ```

#### **Data Cleaning and Standardization**

 - Fixing alingment of data

    ```python
     pd.options.display.colheader_justify = 'left'

     df.head()
   ```

 - Cleaning the special characters from columns and changing the data type

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

 - change the term column to int64 and removing the 'months' string

    ```python
     df['term'] = df['term'].str.replace('months', '', regex=False).str.strip()

     df['term'] = df['term'].astype('int64')

     df.head()

     df.info()
   ```

 - Triming the rows and columns of the dataframe

    ```python
     df = df.applymap(lambda x: x.strip() if isinstance(x, str) else x)

     print(df)
   ```

 - Fixing the date format from string to date

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

#### **Exporting the Dataset**

 - Exporting the cleaned dataset as a .CSV file

    ```python
     df.to_csv('business_loan_cleaned.csv', index=False)

     print("DataFrame successfully exported to 'business_loan_cleaned.csv'")
   ```
    
 - Connecting to the MySQL database

    ```python
     engine_sql = create_engine('mysql+pymysql://root:Cosmos.90@localhost:3306/business_loan_db')

     try:engine_sql
        print ('connected')
     except:
        print ('not connected')
   ```

   ```python
     df.to_sql(name='store', con=engine_sql, if_exists='replace', index=False)
   ```
### SQL

 #### Business Loan Database

 - Queries

   More queries please refer to the document titled `business_requirement.md` for detailed business requirements. For the proposed solutions, kindly consult the `business_loan_db.sql` file.

 - Example

   ```sql
    1. -- Understand how companies use their loans across activities.

    SELECT purpose, AVG(loan_amount) AS avg_loan_amount, SUM(loan_amount) AS total_loan_amount
    FROM business_loan
    GROUP BY purpose
    ORDER BY total_loan_amount DESC;


    2. -- Identify patterns in loan repayments and influencing factors.

    -- Loan status and payment patterns

    SELECT loan_status, ROUND(AVG(total_payment)) AS avg_payment, COUNT(*) AS loan_count
    FROM business_loan
    WHERE loan_status IN ('Current', 'Fully Paid', 'Late', 'Charged Off')
    GROUP BY loan_status;

    -- Delinquencies and late payments

    SELECT loan_status, member_id, loan_amount, last_payment_date, emp_title
    FROM business_loan
    WHERE loan_status = 'Late' OR loan_status = 'Charged Off'
    ORDER BY loan_status DESC, emp_title DESC
    LIMIT 100000;
   ```


### Power BI

#### Summary

This Power BI project focuses on visualizing key insights from a dataset with columns such as loan_status, total_payment, emp_length, home_ownership, purpose, and more. The project includes a variety of advanced visualizations that provide a comprehensive understanding of the data and help in making data-driven decisions.

1. Gauge Charts

 - Purpose: Visualize key metrics like Total Payments, Annual Income, Interest Rate, and Debt-to-Income Ratio  (DTI).

 - Details: Configured gauges to reflect performance against targets. Each gauge provides a clear indication of how well the measures are performing.


2. Area Charts:

 - Trends in Total Payments Made over time.
 
 - Segmentation by Loan Status and additional filters for granular analysis.


3. Ribbon Charts:

 - Rank changes over time based on Total Payments Made.
 
 - Comparative analysis and trend identification.


4. Tree Maps:

 - Hierarchical visualization of Loan Status by Total Payment.

 - Visualization of Purpose by Loan Amount with added customizations for enhanced analysis.

###### Key Insights

 - **Loan Distribution by State:** Visualize the distribution of loans across different states.

 - **Loan Status Analysis:** Breakdown of loans by status (e.g., fully paid, charged off).

 - **Employment Length Impact:** Relationship between employment length and loan default rates.

 - **Home Ownership vs. Loan Amount:** Comparison of loan amounts based on home ownership status.

 - **Interest Rate by Grade:** Display of average interest rates for each loan grade.

 - **Annual Income Distribution:** Distribution of annual incomes of borrowers.

 - **Debt-to-Income Ratio (DTI) Analysis:** Average DTI ratio for different loan statuses.

 - **Purpose of Loans:** Visualization of loans based on their purpose.

 - **Installment Trends:** Trends in loan installments over time.

 - **Total Payments Made:** Total payments made by borrowers, segmented by loan grade.

This project provides a robust set of visualizations that offer valuable insights into the dataset. It demonstrates the power of Power BI in transforming raw data into meaningful and actionable information.

##### Dashborad 1

<img src="images/Dashboard (1).png" alt="Dashboard" align="center">
    
##### Dashborad 2

<img src="images/Dashboard (2).png" alt="Dashboard" align="center">

##### Dashborad 3 

<img src="images/Dashboard (3).png" alt="Dashboard" align="center">

---

## // Tools Utilized //

- Excel

- Python

- libraries: (pandas, numpy, pymysql, sqlalchemy)

- Jupyter Notebook

- SQL

- Power BI

---

<p align="center">
  <i>This project was solely exicuted by // Nomaan Ansari //</i>
</p>