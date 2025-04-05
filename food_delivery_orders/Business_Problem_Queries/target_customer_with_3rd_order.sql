/* Q5: Growth team is planning to create a trigger that will target customers after their every
third order with a personalized communication and they have asked you to create a query for this.
*/
WITH order_number AS (
    SELECT 
        customer_code, placed_at,
        rank() OVER (PARTITION BY customer_code ORDER BY placed_at) AS every_third_order
    FROM orders
)
SELECT 
    customer_code, placed_at, every_third_order
FROM order_number
WHERE every_third_order % 3 = 0
AND Date(placed_at) = '2025-03-15';
# AND Date(placed_at) = curdate();  # For real time data, use this.





