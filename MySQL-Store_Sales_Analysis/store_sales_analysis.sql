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
-- BUSINESS AND SALES ANALYSIS
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* 	How many unique cities does the data have?
	In which city is each branch?
	What is the city with the largest revenue?
	Number of sales made in each time of the day per weekday
	Which city has the largest tax percent/ VAT (Value Added Tax)?
	What is the total revenue by month?
	What month had the largest COGS?
	Which branch sold more products than average product sold?
	How many unique payment methods does the data have?
	What is the most common payment method?*/
    
-- How many cities are represented in the dataset?
SELECT DISTINCT city
FROM sales;
-- If I want the count of them:
SELECT COUNT(*) AS distinct_city_count
FROM (
    SELECT DISTINCT city
    FROM sales
) AS unique_cities;

-- How many branches?
SELECT DISTINCT branch
FROM sales;
-- Count how many branches there are in total
SELECT COUNT(*) AS distinct_branch_count
FROM(
	SELECT DISTINCT branch
    FROM sales
) AS unique_branches;

-- Which branch belongs to which city?
SELECT
	DISTINCT city, branch
FROM sales;

-- What is the city with the largest revenue?
SELECT 
	branch,
	city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- Number of sales made in each time of the day per weekday
SELECT 
	day_name,
	time_of_day,
	COUNT(quantity) as total_sales
FROM sales
GROUP BY day_name, time_of_day
ORDER BY 
    FIELD(day_name, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    FIELD(time_of_day, 'Morning', 'Afternoon', 'Evening');

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT
	city,
    AVG(tax_5pct) as highest_average_tax
    FROM sales
    GROUP BY city
    ORDER BY highest_tax DESC;

-- What is the total revenue by month?
SELECT 
	month_name AS month,
    SUM(total) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month as the largets cogs?
SELECT
	month_name AS month, 
    SUM(cogs) AS total_cogs
FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC;

-- What is the city with the largest revenue?
SELECT 
	branch,
	city,
    SUM(total) AS total_revenue
FROM sales
GROUP BY city, branch
ORDER BY total_revenue DESC;

-- Whic branch sold more product than the average product sold?
SELECT 
	branch,
    SUM(quantity) as quantity_sold
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- How many unique payment methods does the data have?
SELECT DISTINCT payment
	FROM sales;
    
-- Count how many payment methods are accepted
SELECT
	COUNT(DISTINCT payment) AS payment_types
FROM sales;

 -- What is the most common payment method?
SELECT 
	payment,
	COUNT(payment) as count
FROM sales
GROUP BY payment
ORDER by count DESC;

    


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PRODUCT ANALYSIS
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*How many unique product lines does the data have?
* What is the most selling product line?
* What product line had the largest revenue?
* What product line had the largest VAT?
* What is the most common product line by gender?
* What is the average rating of each product line?*/


-- How many unique product lines the data set has?
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

-- What is the best selling product line?
SELECT 
	product_line,
    COUNT(product_line) as count
FROM sales
GROUP BY product_line
ORDER BY count DESC;

-- What product line has the largest revenue?
SELECT 
	product_line,
    SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What product line has the largest tax? 
SELECT 
	product_line,
    AVG(tax_5pct) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;

-- Most common product by gender?
SELECT 
		gender,
        product_line,
        SUM(quantity) as total_count
FROM sales
GROUP BY gender, product_line
ORDER BY product_line DESC;

SELECT 
    product_line,
    MAX(IF(gender = 'Female', total_count, NULL)) AS Female,
    MAX(IF(gender = 'Male', total_count, NULL)) AS Male
FROM (
    SELECT 
        gender,
        product_line,
        SUM(quantity) AS total_count
    FROM 
        sales
    GROUP BY 
        gender, product_line
) AS subquery
GROUP BY 
    product_line;

-- What is average rating of each product 
SELECT
	ROUND(AVG(rating),2) AS avg_rating,
    product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

-- ---------------------------------------------------------------------------------------------------
-- CUSTOMER ANALYSIS
-- ---------------------------------------------------------------------------------------------------
/*	How many unique customer types does the data have?
	Which customer type buys the most?
	Which of the customer types brings the most revenue?
	What is the most common customer type?
	Which customer type buys the most?
	Which customer type pays the most in VAT?
	What is the gender of most of the customers?
	What is the gender distribution per branch?
	Which time of the day do customers give most ratings?
	Which time of the day do customers give most ratings per branch?
	Which day fo the week has the best avg ratings?
	Which day of the week has the best average ratings per branch? */


-- How many unique customer types does the data have?
SELECT DISTINCT customer_type
	FROM sales;
SELECT 
	COUNT(DISTINCT customer_type) AS customer_types
    FROM sales;
    
-- Which customer type buys the most?
SELECT 
	customer_type,
    SUM(quantity) as total_item_bought
	FROM sales
    GROUP BY customer_type
    ORDER BY total_item_bought DESC;
    
-- Which of the customer types brings the most revenue?
SELECT 
	customer_type,
    SUM(total) as total_revenue
	FROM sales
    GROUP BY customer_type
    ORDER BY total_revenue DESC;
    
-- What is the most common customer type?
SELECT 
	customer_type,
    COUNT(customer_type) AS total_customers
    FROM sales
    GROUP BY customer_type
    ORDER BY total_customers DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
    AVG(tax_5pct) AS average_tax
    FROM sales
    GROUP BY customer_type
    ORDER BY average_tax DESC;
    
-- What is the gender of most of the customers?
SELECT
	gender,
    COUNT(gender) AS total_count
    FROM sales
    GROUP BY gender
    ORDER BY total_count;
    
-- What is the gender distribution per branch?
SELECT
	gender,
    COUNT(gender) AS total_count
    FROM sales
    GROUP BY gender
    HAVING branch = 'A'
    ORDER BY total_count DESC;
    
-- Which time of the day do customers give most ratings?
SELECT 
	s.time_of_day,
    COUNT(rating) AS rating_counts
    FROM sales AS s
    GROUP BY s.time_of_day
    ORDER BY rating_counts DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT 
	s.branch,
	s.time_of_day,
    COUNT(rating) AS rating_counts
    FROM sales AS s
    GROUP BY s.time_of_day, branch
    ORDER BY rating_counts DESC;
-- Which day fo the week has the best avg ratings?
SELECT 
	s.day_name,
    AVG(rating) AS average_rating
    FROM sales AS s
    GROUP BY s.day_name
    ORDER BY average_rating DESC;

-- Which day of the week has the best average ratings per branch?
SELECT 
	branch,
	s.day_name,
    AVG(rating) AS average_rating
    FROM sales AS s
    GROUP BY s.day_name, branch
    ORDER BY average_rating DESC;
