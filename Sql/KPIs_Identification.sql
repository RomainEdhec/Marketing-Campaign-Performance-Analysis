-- Identification of KPIs : For each and every KPI we compare the different income segment, family profile and education_level to the global KPI

-- 1 KPIs related to marketing : response rate, acceptance rate, marketing responsive rate

SELECT 
    income_segment,
    marital_status,
    education_level,

    AVG(response) AS avg_response_rate, 
    AVG(campaign_acceptance_rate) AS avg_acceptance_rate,
    AVG(is_marketing_responsive) AS avg_marketing_responsive

FROM marketing_features

GROUP BY GROUPING SETS (
    (),                    
    (income_segment),
    (marital_status),
    (education_level)
);

-- 2 KPIs related to client spending : average total spending by client, average basket price, proportion of premium products in orders

SELECT 
    income_segment,
    marital_status,
    education_level,

    AVG(mnt_total) AS avg_total_spent,
    AVG(avg_spent_per_purchase) AS avg_basket_value,
    AVG(premium_ratio) AS avg_premium_ratio

FROM marketing_features

GROUP BY GROUPING SETS (
    (),                    
    (income_segment),
    (marital_status),
    (education_level)
);

-- 3 KPIs related to purchases : average total purchases and proportion of purchases using a discount

SELECT 
    income_segment,
    marital_status,
    education_level,

    AVG(total_purchases) AS avg_total_purchases,
    AVG(deal_ratio) AS purchases_using_discount

FROM marketing_features

GROUP BY GROUPING SETS (
    (),                    
    (income_segment),
    (marital_status),
    (education_level)
);

-- 4 KPI related to turnover : total turnover by segment compared to the global turnover

SELECT 
    income_segment,
    marital_status,
    education_level,

    SUM(mnt_total) AS total_turnover

FROM marketing_features

GROUP BY GROUPING SETS (
    (),                    
    (income_segment),
    (marital_status),
    (education_level)
);
