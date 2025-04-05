-- Q3: Count of all the users who were acquired in Jan 2025 and only placed one order in Jan and did not place any other order after that.

# Approach 1

SELECT customer_code  
FROM orders o1  
WHERE MONTH(o1.placed_at) = 1  
AND YEAR(o1.placed_at) = 2025  
AND NOT EXISTS (
    SELECT 1  
    FROM orders o2  
    WHERE o2.customer_code = o1.customer_code  
    AND (MONTH(o2.placed_at) <> 1 OR YEAR(o2.placed_at) <> 2025)
)  
GROUP BY customer_code  
HAVING COUNT(order_id) = 1  
ORDER BY customer_code;

# Approach 2

WITH CTE AS (  
    SELECT *  
    FROM orders  
    WHERE MONTH(placed_at) = 1  
      AND YEAR(placed_at) = 2025  
      AND customer_code NOT IN (  
          SELECT DISTINCT customer_code  
          FROM orders  
          WHERE NOT (MONTH(placed_at) = 1 AND YEAR(placed_at) = 2025)  
      )  
)  
SELECT customer_code  
FROM CTE  
GROUP BY customer_code  
HAVING COUNT(order_id) = 1  
ORDER BY customer_code;

/*
Use the direct query (without CTE) for better performance.
Use CTE only if you need modularity or reuse.
Using Not Exists helps when value is Null in dataset and it works more efficiently for large dataset.
/*