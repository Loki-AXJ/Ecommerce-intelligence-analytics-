-- Module 4 Query 1: MoM Revenue Growth
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        COUNT(DISTINCT o.order_id) AS total_orders,
        ROUND(SUM(oi.quantity * oi.unit_price), 2) AS current_month_revenue
    FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT 
    sales_month,
    total_orders,
    current_month_revenue,
    LAG(current_month_revenue, 1) OVER (ORDER BY sales_month) AS previous_month_revenue,
    ROUND(current_month_revenue - LAG(current_month_revenue, 1) OVER (ORDER BY sales_month), 2) AS mom_revenue_change,
    ROUND(((current_month_revenue - LAG(current_month_revenue, 1) OVER (ORDER BY sales_month)) / LAG(current_month_revenue, 1) OVER (ORDER BY sales_month)) * 100.0, 2) AS mom_growth_percentage
FROM monthly_sales
ORDER BY sales_month;

-- Module 4 Query 2: Cumulative Revenue Trajectory
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
    FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT 
    sales_month,
    monthly_revenue,
    ROUND(SUM(monthly_revenue) OVER (ORDER BY sales_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS cumulative_revenue
FROM monthly_revenue
ORDER BY sales_month;

-- Module 4 Query 3: Monthly Active Customer Density
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    COUNT(DISTINCT o.customer_id) AS active_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(COUNT(DISTINCT o.order_id) * 1.0 / COUNT(DISTINCT o.customer_id), 2) AS orders_per_active_customer
FROM orders o
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;
