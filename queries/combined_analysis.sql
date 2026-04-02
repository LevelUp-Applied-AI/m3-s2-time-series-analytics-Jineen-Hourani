SELECT 
    p.category,
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(oi.quantity * oi.unit_price) AS monthly_category_revenue,
    
    -- Combine SUM with a Window Function to calculate total revenue across all categories for that month
    SUM(SUM(oi.quantity * oi.unit_price)) OVER (PARTITION BY DATE_TRUNC('month', o.order_date)) AS total_monthly_revenue,
    
    -- Calculate a 3-month moving average specifically for each category to track category-specific trends
    AVG(SUM(oi.quantity * oi.unit_price)) OVER (
        PARTITION BY p.category 
        ORDER BY DATE_TRUNC('month', o.order_date) 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS category_3month_moving_avg
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category, month
ORDER BY month, p.category;