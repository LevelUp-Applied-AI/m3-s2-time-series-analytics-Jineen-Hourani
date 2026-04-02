-- 1. Identify the first purchase date and cohort month for each customer
WITH first_purchases AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_purchase_date,
        DATE_TRUNC('month', MIN(order_date)) AS cohort_month
    FROM orders
    GROUP BY customer_id
),

-- 2. Join all orders to the first purchase date to track customer return behavior
order_intervals AS (
    SELECT 
        o.customer_id,
        fp.cohort_month,
        o.order_date,
        -- Calculate the difference in days between the current order and the first purchase
        o.order_date - fp.first_purchase_date AS days_since_first
    FROM orders o
    JOIN first_purchases fp ON o.customer_id = fp.customer_id
)

-- 3. Aggregate data to calculate retention metrics per cohort
SELECT 
    cohort_month,
    COUNT(DISTINCT customer_id) AS total_customers,
    -- Count how many customers returned within 30, 60, and 90-day windows
    COUNT(DISTINCT CASE WHEN days_since_first > 0 AND days_since_first <= 30 THEN customer_id END) AS retained_30d,
    COUNT(DISTINCT CASE WHEN days_since_first > 30 AND days_since_first <= 60 THEN customer_id END) AS retained_60d,
    COUNT(DISTINCT CASE WHEN days_since_first > 60 AND days_since_first <= 90 THEN customer_id END) AS retained_90d
FROM order_intervals
GROUP BY cohort_month
ORDER BY cohort_month;