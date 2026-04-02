WITH monthly_revenue AS (
    -- Calculate total revenue and total orders for each month
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        SUM(oi.quantity * oi.unit_price) AS revenue,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY 1
)
SELECT 
    month,
    revenue,
    -- Use LAG to retrieve the previous month's revenue for comparison
    LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue,
    -- Calculate the percentage growth rate compared to the previous month
    (revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month) * 100 AS growth_rate
FROM monthly_revenue;