-- Q7: What percent of customers were organically acquired in Jan 2025. (Placed their first order without promo)

WITH jan_customers AS (
    SELECT customer_code, promo_code_name,
        ROW_NUMBER() OVER(PARTITION BY customer_code ORDER BY DATE(placed_at)) AS rn
    FROM orders
    WHERE MONTH(placed_at) = 1 AND YEAR(placed_at) = 2025
),
organic_customer_jan AS (
    SELECT * FROM jan_customers
    WHERE rn = 1 AND promo_code_name IS NULL
)
SELECT 
    ROUND((SELECT COUNT(*) FROM organic_customer_jan) * 100.0 / 
        (SELECT (COUNT(Distinct(customer_code))) FROM jan_customers),2) AS organic_Customer_per;
