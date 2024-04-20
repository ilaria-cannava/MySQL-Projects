CREATE DATABASE walmart_sales;
USE walmart_sales;

CREATE TABLE sales
(
invoice_id varchar(50) NOT NULL,
branch varchar(10) NOT NULL,
city varchar(50) NOT NULL,
customer_type varchar(6) NOT NULL,
gender varchar(25) NOT NULL,
product_line varchar(100) NOT NULL,
unit_price decimal(6,2) NOT NULL,
quantity INT NOT NULL,
tax_5pct decimal(10,4) NOT NULL,
total decimal(12,4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment varchar(20) NOT NULL,
cogs decimal(8,2) NOT NULL,
gross_mergine_pct decimal (10,2) NOT NULL,
gross_income decimal(8,4) NOT NULL,
rating decimal (3,1) NOT NULL
);

ALTER TABLE sales
ADD PRIMARY KEY (invoice_id);

-- Dividing the day in 3 sections Morning, Afternoon and Evening -------------------------------------------------------------------------------------------------------
SELECT
	time,
    (CASE
		WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN `time` BETWEEN '12:00:01' AND '18:00:00' THEN 'Afternoon'
        ELSE 'Evening'
	END) AS time_of_day
FROM sales;

-- Adding a column to allocate new day partition, the column has null values--
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(50);

-- Adding data to the column--
UPDATE sales
SET time_of_day = 
(
CASE
		WHEN `time` BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN `time` BETWEEN '12:00:01' AND '18:00:00' THEN 'Afternoon'
        ELSE 'Evening'
	END
);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ADD NAME OF THE DAYS-------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
	date,
    DAYNAME(date)
FROM sales;

-- Add a column to allocate day name
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

-- Adding data to the column
UPDATE sales
SET day_name = DAYNAME(date);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ADD NAME OF THE MONTHS ----------------------------------------------------------------------------------------------------------------------------------------------
SELECT
	date,
    MONTHNAME(date)
FROM sales;

-- Add a column to allocate month names
ALTER TABLE sales ADD COLUMN month_name varchar(25);

-- Add data to the new column
UPDATE sales
SET month_name = MONTHNAME(date);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ANSWERING BUSINESS QUESTIONS-----------------------------------------------------------------------------------------------------------------------------------------

-- How many cities are represented in the dataset?---------------------------------------
SELECT DISTINCT city
FROM sales;
-- If I want the count of them:
SELECT COUNT(*) AS distinct_city_count
FROM (
    SELECT DISTINCT city
    FROM sales
) AS unique_cities;
-- --------------------------------------------------------------------------------------

-- How many branches?--------------------------------------------------------------------
SELECT DISTINCT branch
FROM sales;
-- Count how many branches there are in total
SELECT COUNT(*) AS distinct_branch_count
FROM(
	SELECT DISTINCT branch
    FROM sales
) AS unique_branches;
-- --------------------------------------------------------------------------------------
-- Which branch belongs to which city?---------------------------------------------------
SELECT
	DISTINCT city, branch
FROM sales;
/****************************************************************************************/
/* PRODUCT QUESTIONS */
/* How many unique product lines the data set has?*/

SELECT 
	DISTINCT product_line
FROM sales;
-- Count of product lines
SELECT COUNT(*) AS count_product_lines
FROM (
		SELECT DISTINCT product_line
        FROM sales
) AS unique_product_lines;

SELECT
	COUNT(DISTINCT product_line)
FROM sales;


 /* What is the most common payment method? */
SELECT 
	payment,
	COUNT(payment) as count
FROM sales
GROUP BY payment
ORDER by count DESC;

/* What is the best selling product line */
SELECT 
	product_line,
    COUNT(product_line) as count
FROM sales
GROUP BY product_line
ORDER BY count DESC;

/* What is the total revenue by month? */
SELECT 
	month_name AS month,
    SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

/* What month as the largets cogs? */
SELECT
	month_name AS month, 
    SUM(cogs) AS total_cogs
FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC;

/* What product line has the largest revenue? */
SELECT 
	product_line,
    SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

/* What product line has the largest tax? */
SELECT 
	product_line,
    AVG(tax_5pct) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

/* What is the city with the largest revenue? */
SELECT 
	branch,
	city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue DESC;

/* Whic branch sold more product than the average product sold? */
SELECT 
	branch,
    SUM(quantity) as quantity_sold
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

/* Most common product by gender? */
SELECT 
		gender,
        product_line,
        COUNT(gender) as total_count
FROM sales
GROUP BY gender, product_line
ORDER BY total_count DESC;
    
/* What is average rating of each product */
SELECT
	ROUND(AVG(rating),2) AS avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;


/*


