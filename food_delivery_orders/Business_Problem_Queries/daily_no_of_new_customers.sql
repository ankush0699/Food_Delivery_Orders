-- Q2: Find the daily new customer count from the launch date (everyday how many new customers are we acquiring?).

# Approach 1

WITH CTE AS (
    SELECT 
        customer_code, 
        placed_at, 
        DENSE_RANK() OVER (PARTITION BY customer_code ORDER BY DATE(placed_at) ASC) AS dr
    FROM Orders
)
SELECT 
    DATE(placed_at) AS date_of_order, 
    COUNT(customer_code) AS new_customer_count
FROM CTE 
WHERE dr = 1
GROUP BY DATE(placed_at)
Order By date_of_order;

# Approach 2

WITH CTE AS (
    SELECT 
        customer_code, 
        placed_at, 
        DENSE_RANK() OVER (PARTITION BY customer_code ORDER BY DATE(placed_at) ASC) AS dr
    FROM Orders
)  
SELECT DISTINCT 
    DATE(placed_at) AS date_of_order,  
    COUNT(customer_code) OVER (PARTITION BY DATE(placed_at)) AS new_customer_count  
FROM (  
    SELECT * FROM CTE WHERE dr = 1  
) t;

