-- creating database--

create database sql_project_1;

--CREATING TABLE--
DROP TABLE IF EXISTs retail_sales;
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

SELECT * FROM retail_sales;

SELECT COUNT(*) FROM retail_sales;

-- CHECKING WHETHER OUR DATASET CONTAIN NULL VALUES OR NOT--
-- SO WE NEED TO CHECK FOR EVERY COLUMN AND BELOW QUERY WILL CHECK EACH COLUMN FOR NULL VALUES--

-- DATA CLEANING --

SELECT * FROM retail_sales
where 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- NOW DELETE THE RECORDS THAT CONTAIN NULL VALUES--

DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- NOW CHECK, NO. OF ROWS GETS REDUCED.--

SELECT COUNT(*) FROM retail_sales;


-- DATA EXPLORATION --

-- Q1 - HOW MANY SALES DO WE HAVE ? --

SELECT COUNT(*) AS total_Sale FROM retail_sales;

-- Q2 - HOW MANY CUSTOMER DO WE HAVE ? --

-- below query will return everything but we need count. 
-- it return 1987 rows with records but the second query will return just 1987 as customer count in a single row.
SELECT COUNT(*) FROM retail_sales;    

SELECT COUNT(customer_id) FROM retail_sales;


-- Q3 - THERE MAY BE DUPLICATE CUSTOMERS. HOW MANY DISTINCT CUSTOMERS DO WE HAVE ? --

SELECT COUNT(DISTINCT(customer_id)) FROM retail_sales;


-- Q4 - HOW MANY CATEGORY ARE THERE AND WHAT THEY ARE ? --

SELECT COUNT(DISTINCT(category)) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;




-- MAIN DATA ANALYSIS & BUSINESS KEY PROBLEMS --

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * FROM retail_sales
where sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 10 in the month of Nov-2022.

SELECT * FROM retail_sales
where category = 'Clothing' 
	AND
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantity>=4;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, 
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orders from retail_sales
GROUP BY 1; 


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT ROUND(AVG(age),2) AS avg_age from retail_sales
where category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * from retail_sales
where total_sale > 1000;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category, gender, COUNT(transactions_id) from retail_sales
group by category, gender
order by 1;



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT * FROM (
	SELECT
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH from sale_date) as month,
	AVG(total_sale) as avg_Sale,
	RANK() over (Partition by EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as Rank
	from retail_sales	
	group by 1,2
	order by 1,3 desc) as t1
WHERE RANK = 1;



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id, SUM(total_sale) as total_sales
from retail_sales
group by 1
order by total_sales DESC
LIMIT 5;




-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category, COUNT(DISTINCT(customer_id)) AS unique_cust from retail_sales
group by category;


-- SELECT * FROM retail_sales;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- SELECT COUNT(*) AS TOTAL_SALES,
-- CASE
-- 	WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
-- 	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
-- 	ELSE 'EVENING'
-- END AS shift
-- FROM retail_sales
-- group by shift;


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

SELECT shift, COUNT(*) from hourly_sales
group by shift;


-- END OF PROJECT - 01 --
	