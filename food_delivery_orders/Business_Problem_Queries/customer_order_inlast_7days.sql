-- Q4: List all customers with no order in last 7 days but were acquired one month ago with their first order on promo.

WITH customer_order AS (
    SELECT
        customer_code,
        MIN(DATE(placed_at)) AS first_order,
        MAX(DATE(placed_at)) AS last_order
    FROM orders
    GROUP BY customer_code
)
SELECT 
    co.*, 
    o.promo_code_name  
FROM customer_order co 
INNER JOIN orders o
    ON o.customer_code = co.customer_code 
    AND DATE(o.placed_at) = co.first_order
WHERE 
    co.last_order < DATE_SUB(CURDATE(), INTERVAL 7 DAY) 
    AND co.first_order < DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    AND o.promo_code_name IS NOT NULL;







