-- Identification of KPIs : For each and every KPI we compare the different income segment, family profile and education_level to the global KPI

-- 1 Global Response Rate, Acceptance rate, Marketing responsive rate

SELECT AVG(response) AS avg_response_rate, 
       AVG(campaign_acceptance_rate) AS avg_acceptance_rate,
       AVG(is_marketing_responsive) AS avg_marketing_responsive

FROM marketing_features

-- GROUP BY income_segment, marital_status, education_level

SELECT income_segment, AVG(response) AS avg_response_rate, 
       AVG(campaign_acceptance_rate) AS avg_acceptance_rate,
       AVG(is_marketing_responsive) AS avg_marketing_responsive

FROM marketing_features
GROUP BY income_segment

SELECT marital_status, AVG(response) AS avg_response_rate, 
       AVG(campaign_acceptance_rate) AS avg_acceptance_rate,
       AVG(is_marketing_responsive) AS avg_marketing_responsive

FROM marketing_features
GROUP BY marital_status

SELECT education_level, AVG(response) AS avg_response_rate, 
       AVG(campaign_acceptance_rate) AS avg_acceptance_rate,
       AVG(is_marketing_responsive) AS avg_marketing_responsive

FROM marketing_features
GROUP BY education_level

-- 2 KPIs about client spending : average total spending by client, average basket price, proportion of premium products in orders

SELECT AVG(mnt_total) AS avg_total_spent,
       AVG(avg_spent_per_purchase) AS avg_basket_value,
       AVG(premium_ratio) AS avg_premium_ratio

FROM marketing_features

SELECT income_segment, AVG(mnt_total) AS avg_total_spent,
       AVG(avg_spent_per_purchase) AS avg_basket_value,
       AVG(premium_ratio) AS avg_premium_ratio

FROM marketing_features
GROUP BY income_segment

SELECT marital_status, AVG(mnt_total) AS avg_total_spent,
       AVG(avg_spent_per_purchase) AS avg_basket_value,
       AVG(premium_ratio) AS avg_premium_ratio

FROM marketing_features
GROUP BY marital_status

SELECT education_level, AVG(mnt_total) AS avg_total_spent,
       AVG(avg_spent_per_purchase) AS avg_basket_value,
       AVG(premium_ratio) AS avg_premium_ratio

FROM marketing_features
GROUP BY education_level

-- 3 Average total purchases and proportion of purchases using a discount

SELECT AVG(total_purchases) AS avg_total_purchases,
       AVG(deal_ratio) AS purchases_using_discount

FROM marketing_features

SELECT income_segment, AVG(total_purchases) AS avg_total_purchases,
       AVG(deal_ratio) AS purchases_using_discount

FROM marketing_features
GROUP BY income_segment

SELECT marital_status, AVG(total_purchases) AS avg_total_purchases,
       AVG(deal_ratio) AS purchases_using_discount

FROM marketing_features
GROUP BY marital_status

SELECT education_level, AVG(total_purchases) AS avg_total_purchases,
       AVG(deal_ratio) AS purchases_using_discount

FROM marketing_features
GROUP BY education_level

-- 4 Total Turnover. Which segment has the most impact on turnover

SELECT SUM(mnt_total) AS total_turnover
FROM marketing_features

SELECT income_segment, SUM(mnt_total) AS total_turnover
FROM marketing_features
GROUP BY income_segment

SELECT marital_status, SUM(mnt_total) AS total_turnover
FROM marketing_features
GROUP BY marital_status

SELECT education_level, SUM(mnt_total) AS total_turnover
FROM marketing_features
GROUP BY education_level
