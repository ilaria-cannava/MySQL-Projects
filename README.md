## STORE SALES ANALYSIS

Sales analysis involves collecting and examining sales data to discover trends and insights into how sales, store operations, and teams are performing, as well as understanding customer behaviour. 
By analyzing sales data, we can identify patterns in product performance, segment customers based on their buying habits, and evaluate the effectiveness of sales channels, marketing efforts, 
and operational strategies.

For this project, I'm analysing sales data from three retail stores situated in different cities over a period of three months. 
The aim is to conduct a comprehensive data analysis to address questions regarding business performance, product line success, sales trends, and customer behaviour.



## AREAS OF ANALYSIS AND AIMS

## Business and sales analysis<br/>
The aim of business and sales analysis is to gain insights into various aspects of a company's sales operations and performance. This analysis involves examining sales data, identifying trends, patterns, 
and key metrics to understand how well the business is performing and what factors are driving or hindering its success.<br/>

By conducting business and sales analysis, organizations aim to:<br/>

* Understand Performance: Gain a comprehensive understanding of how the business is performing in terms of sales, revenue, profitability, and other key performance indicators (KPIs).
* Identify Trends and Patterns: Identify trends and patterns in sales data to uncover opportunities for growth, as well as potential challenges or areas for improvement.
* Optimize Operations: Evaluate the effectiveness of sales strategies, marketing campaigns, and operational processes to optimize resources and improve efficiency.
* Inform Decision-Making: Provide valuable insights to stakeholders, including executives, managers, and sales teams, to inform strategic decision-making and resource allocation.
* Forecast Future Performance: Use historical sales data and trends to forecast future sales performance, enabling better planning and resource allocation.
* Enhance Customer Experience: Understand customer behavior, preferences, and buying habits to tailor products, services, and marketing efforts to meet customer needs and enhance the overall customer experience.
### Overall, the aim of business and sales analysis is to drive informed decision-making, improve performance, and ultimately achieve the organization's sales and business objectives.








## Product Analysis<br/>
The aim of product analysis is to gain a deeper understanding of how individual products or product lines are performing within a business. 
This analysis involves examining various aspects of products, including their sales performance, customer demand, profitability, and market trends.<br/>

The primary goals of product analysis include:

* Evaluate Performance: Assess the performance of individual products or product lines in terms of sales volume, revenue, profitability, and market share. Identify top-performing products and those that may require improvement or phase-out.
* Identify Trends: Identify trends in product demand, pricing, and customer preferences. Understand shifts in market demand and emerging opportunities or threats.
* Optimize Product Mix: Analyze the product mix to ensure it aligns with customer needs and market trends. Identify opportunities to introduce new products, discontinue underperforming ones, or adjust pricing and positioning strategies.
* Forecast Demand: Use historical sales data and market trends to forecast future demand for products. This helps in inventory planning, production scheduling, and resource allocation.
* Inform Product Development: Gather insights from customer feedback, sales data, and market research to inform product development efforts. Identify areas for product innovation, improvement, or expansion.
* Maximize Profitability: Analyze the profitability of individual products to identify opportunities to increase margins, reduce costs, or optimize pricing strategies.
* Support Marketing Efforts: Tailor marketing strategies and campaigns to promote products effectively based on their unique characteristics, target audience, and market positioning.
### Overall, product analysis aims to provide actionable insights to support decision-making, optimize product performance, and drive




## Customer Analysis<br/>
The aim of customer analysis is to gain a comprehensive understanding of a company's customers, their behaviors, preferences, needs, and characteristics. 
This analysis involves examining various aspects of customer data to uncover insights that can inform marketing strategies, improve customer experiences, and drive business growth.<br/>

The primary goals of customer analysis include:

* Segmentation: Segment customers based on demographic, geographic, psychographic, or behavioral factors to better understand their distinct needs and preferences. This allows for targeted marketing
  and personalized communication strategies.
* Behavior Analysis: Analyze customer behavior patterns such as purchase frequency, product preferences, channel preferences, and interactions with the brand across different touchpoints.
  Identify trends and opportunities to optimize marketing efforts and improve customer retention.
* Customer Lifetime Value (CLV): Calculate the lifetime value of customers to understand their long-term profitability and prioritize efforts to acquire, retain, and nurture high-value customers.
* Churn Prediction: Identify customers who are at risk of churning (i.e., discontinuing their relationship with the company) and implement targeted retention strategies to reduce churn rates.
* Cross-Selling and Upselling: Analyze customer purchase history and behavior to identify opportunities for cross-selling related products or upselling higher-value products or services.
* Personalization: Use customer data to personalize marketing messages, product recommendations, and customer experiences across various channels, such as email, website, and mobile apps.
* Customer Satisfaction and Loyalty: Measure customer satisfaction and loyalty through surveys, feedback analysis, and Net Promoter Score (NPS) to identify areas for improvement and
  enhance customer loyalty and advocacy.
* Customer Journey Mapping: Map the customer journey across various touchpoints and interactions with the brand to identify pain points, opportunities for improvement, and moments of truth
  that impact the overall customer experience.
### By conducting customer analysis, businesses aim to deepen their understanding of their target audience, improve customer engagement and satisfaction, increase retention rates, and ultimately drive long-term profitability and sustainable growth.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## PROJECT'S QUESTIONS

### BUSINESS AND SALES ANALYSIS
* How many unique cities does the data have?
* In which city is each branch?
* What is the city with the largest revenue?
* Number of sales made in each time of the day per weekday
* Which city has the largest tax percent/ VAT (Value Added Tax)?
* What is the total revenue by month?
* What month had the largest COGS?
* Which branch sold more products than average product sold?
* What is the most common payment method?

### PRODUCT ANALYSIS
* How many unique product lines does the data have?
* What is the most selling product line?
* What product line had the largest revenue?
* What product line had the largest VAT?
* What is the most common product line by gender?
* What is the average rating of each product line?
  
### CUSTOMER ANALYSIS
* How many unique customer types does the data have?
* Which customer type buys the most?
* Which of the customer types brings the most revenue?
* How many unique payment methods does the data have?
* What is the most common payment method?
* What is the most common customer type?
* Which customer type buys the most?
* Which customer type pays the most in VAT?
* What is the gender of most of the customers?
* What is the gender distribution per branch?
* Which time of the day do customers give most ratings?
* Which time of the day do customers give most ratings per branch?
* Which day fo the week has the best avg ratings?
* Which day of the week has the best average ratings per branch?

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## PROJECT'S WORKFLOW
### With MySQL
* Identify features, measure units and data types
* Create Database and import data
* Creating new columns ( parts of the day, day of the week name, month name) to help identify sales trends
* Using MySQL queries to answer the questions (SELECT, SELECT DISTINC, SUM, AVG, GROUP BY, ORDER BY, etc.)

### With Python
(Couldn't stay away from it, could I?)
* Load the data in a DATAFRAME 
* Exploratory data analysis using Pandas
* Data visualisation with Matplotlib and Seaborn
