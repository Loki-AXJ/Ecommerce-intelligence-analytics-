-- Module 2 Query 1: RFM Metrics
SELECT 
    c.customer_id,
    c.customer_name,
    c.acquisition_channel,
    DATEDIFF('2025-01-01', MAX(o.order_date)) AS recency_days,
    COUNT(DISTINCT o.order_id) AS frequency,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monetary_value
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.acquisition_channel
ORDER BY monetary_value DESC;

-- Module 2 Query 2: Customer Tiers
WITH customer_spend AS (
    SELECT 
        c.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_spend
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id
)
SELECT 
    CASE 
        WHEN total_spend >= 10000 THEN 'VIP / High Value (>= $10k)'
        WHEN total_spend BETWEEN 5000 AND 9999.99 THEN 'Mid-Tier ($5k - $10k)'
        ELSE 'Low-Tier (< $5k)'
    END AS customer_segment,
    COUNT(customer_id) AS total_customers,
    ROUND(SUM(total_spend), 2) AS segment_revenue,
    ROUND(AVG(total_spend), 2) AS avg_customer_spend
FROM customer_spend
GROUP BY customer_segment
ORDER BY segment_revenue DESC;

-- Module 2 Query 3: Acquisition Channel Value
SELECT 
    c.acquisition_channel,
    COUNT(DISTINCT c.customer_id) AS total_acquired_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_channel_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT c.customer_id), 2) AS avg_ltv_per_customer
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.acquisition_channel
ORDER BY total_channel_revenue DESC;
