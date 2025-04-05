-- Q6: List customers who placed more than 1 order and all their orderd on a promo only.

SELECT 
    customer_code,
    COUNT(*) AS total_orders,
    SUM(CASE
        WHEN promo_code_name IS NOT NULL THEN 1
        ELSE 0
    END) AS promo_orders,
    SUM(CASE
        WHEN promo_code_name IS NULL THEN 1
        ELSE 0
    END) AS non_promo_orders
FROM
    orders
GROUP BY customer_code
HAVING total_orders > 1 AND non_promo_orders = 0;
 
