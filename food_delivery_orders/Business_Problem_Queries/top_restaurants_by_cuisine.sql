-- Q1: Top outlets by cusisine type (without using limit and top function).

# Approach 1

WITH CTE AS (
    SELECT cuisine, restaurant_id, COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY cuisine, restaurant_id
)
SELECT * 
FROM (
    SELECT *, 
           Dense_rank() OVER (PARTITION BY cuisine ORDER BY total_orders DESC) AS rn
    FROM CTE
) a
WHERE rn =1;

# Approach 2 

WITH CTE AS (
    SELECT cuisine, restaurant_id, COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY cuisine, restaurant_id
)
SELECT t1.*
FROM CTE t1
LEFT JOIN CTE t2 
ON t1.cuisine = t2.cuisine 
AND t1.total_orders < t2.total_orders
WHERE t2.restaurant_id IS NULL
Order By Cuisine, Restaurant_id;

/*
Approach 1 is best for large datasets but requires MySQL 8+. 
In approach 2 self-join works in MySQL 5.x but is slower, as it run with complexity (O(N²)) while approach 1 runs with O(n log n). 
So always use window functions when available; self-join only if necessary.
*/
