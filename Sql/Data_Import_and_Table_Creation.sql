#Importing the data in a raw table


CREATE TABLE raw_marketing(
    "Income" NUMERIC(10,2),
    "Kidhome" INTEGER,
    "Teenhome" INTEGER,
    "Recency" INTEGER,
    "MntWines" INTEGER,
    "MntFruits" INTEGER,
    "MntMeatProducts" INTEGER,
    "MntFishProducts" INTEGER,
    "MntSweetProducts" INTEGER,
    "MntGoldProds" INTEGER,
    "NumDealsPurchases" INTEGER,
    "NumWebPurchases" INTEGER,
    "NumCatalogPurchases" INTEGER,
    "NumStorePurchases" INTEGER,
    "NumWebVisitsMonth" INTEGER,
    "AcceptedCmp3" INTEGER,
    "AcceptedCmp4" INTEGER,
    "AcceptedCmp5" INTEGER,
    "AcceptedCmp1" INTEGER,
    "AcceptedCmp2" INTEGER,
    "Complain" INTEGER,
    "Response" INTEGER,
    "Age" INTEGER,
    "Customer_Days" INTEGER,
    "marital_Divorced" INTEGER,
    "marital_Married" INTEGER,
    "marital_Single" INTEGER,
    "marital_Together" INTEGER,
    "marital_Widow" INTEGER,
    "education_2n Cycle" INTEGER,
    "education_Basic" INTEGER,
    "education_Graduation" INTEGER,
    "education_Master" INTEGER,
    "education_PhD" INTEGER,
    "MntTotal" INTEGER,
    "MntRegularProds" INTEGER,
    "AcceptedCmpOverall" INTEGER
);



#From the raw table, add new columns which joins several existing columns for greater relevance

CREATE TABLE clean_marketing AS
SELECT
    -- =========================
    -- CUSTOMER PROFILE
    -- =========================
    "Income" AS income,
    "Age" AS age,
    "Kidhome" AS kid_home,
    "Teenhome" AS teen_home,
    ("Kidhome" + "Teenhome") AS children_count,
    "Customer_Days" AS customer_days,
    "Recency" AS recency,

    -- =========================
    -- SPENDING
    -- =========================
    "MntWines" AS mnt_wines,
    "MntFruits" AS mnt_fruits,
    "MntMeatProducts" AS mnt_meat_products,
    "MntFishProducts" AS mnt_fish_products,
    "MntSweetProducts" AS mnt_sweet_products,
    "MntGoldProds" AS mnt_gold_prods,
    "MntRegularProds" AS mnt_regular_prods,
    "MntTotal" AS mnt_total,

    -- =========================
    -- PURCHASE BEHAVIOR
    -- =========================
    "NumDealsPurchases" AS num_deals_purchases,
    "NumWebPurchases" AS num_web_purchases,
    "NumCatalogPurchases" AS num_catalog_purchases,
    "NumStorePurchases" AS num_store_purchases,
    "NumWebVisitsMonth" AS num_web_visits_month,

    (
        "NumWebPurchases" +
        "NumCatalogPurchases" +
        "NumStorePurchases"
    ) AS total_purchases,

    -- =========================
    -- MARKETING
    -- =========================
    "AcceptedCmp1" AS accepted_cmp1,
    "AcceptedCmp2" AS accepted_cmp2,
    "AcceptedCmp3" AS accepted_cmp3,
    "AcceptedCmp4" AS accepted_cmp4,
    "AcceptedCmp5" AS accepted_cmp5,
    "AcceptedCmpOverall" AS accepted_cmp_overall,
    "Response" AS response,

    -- =========================
    -- CUSTOMER QUALITY
    -- =========================
    "Complain" AS complain,

    -- =========================
    -- DEMOGRAPHICS
    -- =========================
    CASE
        WHEN "marital_Divorced" = 1 THEN 'divorced'
        WHEN "marital_Married" = 1 THEN 'married'
        WHEN "marital_Single" = 1 THEN 'single'
        WHEN "marital_Together" = 1 THEN 'together'
        WHEN "marital_Widow" = 1 THEN 'widow'
        ELSE 'unknown'
    END AS marital_status,

    CASE
        WHEN "education_Basic" = 1 THEN 'basic'
        WHEN "education_2n Cycle" = 1 THEN '2nd_cycle'
        WHEN "education_Graduation" = 1 THEN 'graduation'
        WHEN "education_Master" = 1 THEN 'master'
        WHEN "education_PhD" = 1 THEN 'phd'
        ELSE 'unknown'
    END AS education_level

FROM raw_marketing;

#Creating a table for specific marketing features

CREATE TABLE marketing_features AS
WITH base AS(
    SELECT
        *,
        NTILE(3) OVER (ORDER BY income) AS income_tile
    FROM clean_marketing
)
SELECT
    -- Keep core columns
    income,
    age,
    kid_home,
    teen_home,
    children_count,
    customer_days,
    recency,

    mnt_wines,
    mnt_fruits,
    mnt_meat_products,
    mnt_fish_products,
    mnt_sweet_products,
    mnt_gold_prods,
    mnt_regular_prods,
    mnt_total,

    num_deals_purchases,
    num_web_purchases,
    num_catalog_purchases,
    num_store_purchases,
    num_web_visits_month,
    total_purchases,

    accepted_cmp1,
    accepted_cmp2,
    accepted_cmp3,
    accepted_cmp4,
    accepted_cmp5,
    accepted_cmp_overall,
    response,
    complain,

    marital_status,
    education_level,

    -- 1) Income segmentation
    CASE
        WHEN income_tile = 1 THEN 'low_income'
        WHEN income_tile = 2 THEN 'medium_income'
        WHEN income_tile = 3 THEN 'high_income'
        ELSE 'unknown'
    END AS income_segment,

    -- 2) Average spend per purchase
    ROUND(mnt_total::numeric / NULLIF(total_purchases, 0), 2) AS avg_spent_per_purchase,

    -- 3) Share of premium products in total spending
    ROUND(mnt_gold_prods::numeric / NULLIF(mnt_total, 0), 3) AS premium_ratio,

    -- 4) Share of purchases made with deals
    ROUND(num_deals_purchases::numeric / NULLIF(total_purchases, 0), 3) AS deal_ratio,

    -- 5) Channel purchase ratios
    ROUND(num_web_purchases::numeric / NULLIF(total_purchases, 0), 3) AS web_purchase_ratio,
    ROUND(num_store_purchases::numeric / NULLIF(total_purchases, 0), 3) AS store_purchase_ratio,
    ROUND(num_catalog_purchases::numeric / NULLIF(total_purchases, 0), 3) AS catalog_purchase_ratio,

    -- 6) Web conversion proxy
    ROUND(num_web_purchases::numeric / NULLIF(num_web_visits_month, 0), 3) AS web_conversion_rate,

    -- 7) Campaign acceptance rate
    ROUND(accepted_cmp_overall::numeric / 5, 3) AS campaign_acceptance_rate,

    -- 8) Marketing responsiveness flag
    CASE
        WHEN accepted_cmp_overall >= 2 OR response = 1 THEN 1
        ELSE 0
    END AS is_marketing_responsive,

    -- 9) Family profile
    CASE
        WHEN children_count = 0 THEN 'no_child'
        ELSE 'parent'
    END AS family_profile,

    -- 10) Customer tenure in years
    ROUND(customer_days::numeric / 365, 2) AS customer_tenure_years

FROM base;



