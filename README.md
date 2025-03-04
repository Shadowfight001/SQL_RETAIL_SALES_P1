# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database sql_project_1;

CREATE TABLE retail_sales
(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id	INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(15),	
	quantity INT,
	price_per_unit	FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT * FROM retail_sales;
SELECT COUNT(*) FROM retail_sales;

SELECT * FROM retail_sales
where 
	transactions_id IS NULL	OR sale_date IS NULL OR	sale_time IS NULL OR
	customer_id IS NULL OR gender IS NULL OR age IS NULL OR category IS NULL
	OR quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;

DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL	OR sale_date IS NULL OR	sale_time IS NULL OR
	customer_id IS NULL OR gender IS NULL OR age IS NULL OR category IS NULL
	OR quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL OR total_sale IS NULL;

SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(*) AS total_Sale FROM retail_sales;
SELECT COUNT(DISTINCT(customer_id)) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * FROM retail_sales
where sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM retail_sales
where category = 'Clothing' 
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantity >= 4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT
    category, 
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orders
from retail_sales
GROUP BY 1; 
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT ROUND(AVG(age),2) AS avg_age
from retail_sales
where category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * from retail_sales
where total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT
    category,
    gender,
    COUNT(transactions_id)
from retail_sales
group by category, gender
order by 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT
    year,
    month,
    avg_sale
FROM (
	SELECT
	    EXTRACT(YEAR FROM sale_date) as year,
	    EXTRACT(MONTH from sale_date) as month,
	    AVG(total_sale) as avg_Sale,
	    RANK() over (Partition by EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as Rank
	from retail_sales	
	group by 1,2
	order by 1,3 desc) as t1
WHERE RANK = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT
    customer_id,
    SUM(total_sale) as total_sales
from retail_sales
group by 1
order by total_sales DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT
    category,
    COUNT(DISTINCT(customer_id)) AS unique_cust
from retail_sales
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sales
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
		ELSE 'EVENING'
	END AS shift
FROM retail_sales
)
SELECT
	shift,
	COUNT(*) as total_orders
from hourly_sales
group by shift;
```

## Findings

- **Customer Demographics**: The dataset covers customers from different age groups, with sales spread across categories like Clothing, Beauty, and Electronics.
- **High-Value Transactions**: Multiple transactions exceed 1000 in value, highlighting premium purchases by certain customers.
- **Seasonal Sales Patterns**: Monthly trends show fluctuations, helping identify peak shopping periods.
- **Top Buyers & Products**: The analysis highlights the highest-spending customers and the most popular product categories.
- **Location Impact**: Sales vary across different locations, suggesting opportunities for targeted marketing.

## Reports

- **Sales Summary**: A detailed overview of total sales, customer demographics, and category performance.
- **Trend Analysis**: Monthly sales trends to identify peak sales periods.
- **Customer Insights**: Reports on high-spending customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - UDIT PATEL

This project is part of my portfolio, showcasing my SQL skills for a data analyst role. I worked with a retail sales dataset to clean the data, analyze customer demographics, track sales trends, and identify top-spending customers. By using SQL, I was able to find patterns, such as peak sales months and high-value transactions. These insights can help businesses make better decisions, like which products to focus on or when to run promotions. This project proves my ability to handle real-world data, write effective queries, and extract meaningful insights, which are essential skills for data analysis. 


Thank you for your support, and I look forward to connecting with you!
