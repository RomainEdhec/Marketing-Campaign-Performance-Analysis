# Marketing-Campaign-Performance-Analysis

This project analyszes a marketing campaign dataset to understand customer behavior, identify high-value segments and evaluate the effectiveness of marketing strategies.

The objective is to uncover actionable insights that can help optimize targeting, improve campaign performance, and maximize revenue.

Business main objectives : 

-Identify which cusotmer segments geneate the most revenue

-Understand which customers are more responsive to marketing campaigns

-Analyze purchasing behavior across different segments

-Evaluate sensitivity to disconts and premium products

The dataset contains customer-level information, including : 

-Demographics (income, education, marital status)

-Purchase behavior (spending, number of purchases, channels)

-Marketing interactions(campaign responses

-Product category (including premium products)

Data preparation :

The analysis was conducted using SQL with a structured pipeline :

-Raw import

-Data cleaning & Feature selection

-Feature engineering (mixing existing features to get more insights from our queries):

-Total spending, total purchase, average basket value, premium product ratio, etc.

Key Performance Indicators (KPIs) :

1. Marketing Performance :

   -Response rate (when the client responded to the latest marketing campaign)

   -Campaign acceptance rate (number of campaign accepted over the last five campaigns)

2. Customer Value :

   -Total spending per customer

   -Average basket value

   -Share of premium products

3. Purchase Behavior

   -Total number of purchases

   -Share of purchases made with a discount

4. Business Impact

   -Total revenue

   -Revenue contribution by segment

Analytical approach :

KPIs are first computed at a global level and then compared across key segments :

-Income level (low, medium high). This segment is equally divided across the dataset so there is the same amount of clients in each part. 

-Marital status (married, divorced, single, ...)

-Education level (graduation, master, phd, ...)

This comparative approach allows us to identify which segments :

-Generate the most value

-Respond best to marketing

-Take the most advantage of the discounts

Expected outcomes : 

The analysis aims to support accurate decision-making by answering :

-Which segments should be targeted to maximize campaign ROI ?

-Which customers are more sensitive to promotions ?

-Where should marketing efforts be focused : volums or value ?

Tools Used :

PgAdmin : postgreSQL platform (data preparation, feature engineering, KPI identification)

SQL : https://github.com/RomainEdhec/Marketing-Campaign-Performance-Analysis/tree/main/Sql

Excel : display of results 

Excel : https://github.com/RomainEdhec/Marketing-Campaign-Performance-Analysis/tree/main/Data_outputs

Tableau : data visualization

Dashboard : https://github.com/RomainEdhec/Marketing-Campaign-Performance-Analysis/blob/main/Dashboard/Dashboard%20Screenshot.png


