-- 1. Identify the first purchase date for each customer using a WINDOW FUNCTION (OVER)
WITH first_purchases AS (
    SELECT 
        customer_id,
        order_date,
        MIN(order_date) OVER (PARTITION BY customer_id) AS first_purchase_date,
        DATE_TRUNC('month', MIN(order_date) OVER (PARTITION BY customer_id)) AS cohort_month
    FROM orders
),

-- 2. Join all orders to track customer return behavior
order_intervals AS (
    SELECT DISTINCT -- DISTINCT removes duplicate rows from the window result
        customer_id,
        cohort_month,
        order_date,
        order_date - first_purchase_date AS days_since_first
    FROM first_purchases
)

-- 3. Aggregate data for retention metrics
SELECT 
    cohort_month,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN days_since_first > 0 AND days_since_first <= 30 THEN customer_id END) AS retained_30d,
    COUNT(DISTINCT CASE WHEN days_since_first > 30 AND days_since_first <= 60 THEN customer_id END) AS retained_60d,
    COUNT(DISTINCT CASE WHEN days_since_first > 60 AND days_since_first <= 90 THEN customer_id END) AS retained_90d
FROM order_intervals
GROUP BY cohort_month
ORDER BY cohort_month;







