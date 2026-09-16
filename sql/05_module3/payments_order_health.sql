
-- Module 3 Query 1: Payment Method Breakdown
SELECT 
    p.payment_method,
    COUNT(DISTINCT p.payment_id) AS total_transactions,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_processed_amount,
    ROUND(SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT p.payment_id), 2) AS avg_transaction_value
FROM payments p
INNER JOIN order_items oi ON p.order_id = oi.order_id
GROUP BY p.payment_method
ORDER BY total_processed_amount DESC;

-- Module 3 Query 2: Order Status Metrics
SELECT 
    o.order_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(COUNT(DISTINCT o.order_id) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS order_percentage,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS gross_value
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY total_orders DESC;

-- Module 3 Query 3: Payment Method by Order Status
SELECT 
    p.payment_method,
    o.order_status,
    COUNT(DISTINCT o.order_id) AS order_count,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_amount
FROM payments p
INNER JOIN orders o ON p.order_id = o.order_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY p.payment_method, o.order_status
ORDER BY p.payment_method, order_count DESC;
