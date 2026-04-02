WITH daily_revenue AS (
    -- Calculate total revenue for each specific day
    SELECT 
        order_date,
        SUM(oi.quantity * oi.unit_price) AS daily_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY 1
)
SELECT 
    order_date,
    daily_total,
    -- Calculate the 7-day moving average using a window function
    AVG(daily_total) OVER (ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg_7d
FROM daily_revenue;