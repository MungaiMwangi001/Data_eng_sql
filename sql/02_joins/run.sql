SELECT * FROM customers;
SELECT  * FROM orders;
 

 -- basic aggregation
SELECT   
    customer_id,
    COUNT(*) AS order_count,
    SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY customer_id ASC;


-- 2. WHERE VS HAVING
-- where - filtrers before grouping  while having filters grouped results after aggregation

SELECT 
    customer_id,
    SUM(amount) AS  total_spent
FROM orders
GROUP BY customer_id
HAVING  SUM(amount) > 1000
ORDER BY customer_id ASC;



--INNER JOIN

SELECT 
    c.name,
    c.country,
    o.amount
FROM customers c
INNER JOIN orders o
    ON  c.customer_id = o.customer_id;

---4 left join

SELECT  c.name,  o.amount  
FROM customers c 
LEFT  JOIN orders o  
    ON  c.customer_id = o.customer_id;

--5 right join 

SELECT  c.name,  o.amount  
FROM customers c     
RIGHT  JOIN orders o
    ON  c.customer_id = o.customer_id;


--- 6 JOIN + AGGREGATION

SELECT  c.country,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS  revenue
FROM customers c 
LEFT JOIN  orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.country

--7 FAN-OUT  problem demo (this will inflat metrics)

SELECT c.name, o.amount
FROM customers C
JOIN orders o 
    ON c.customer_id = o.customer_id;


SELECT
    c.customer_id,
    c.name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id ASC;

-- to solve fan-out we can use subqueries or CTEs
-- using subqueries
-- SELECT  
--     (SELECT COUNT(*) FROM customers) AS customer_c,  
--     (SELECT SUM(amount) FROM orders) AS total_customer_spent;
-- using CTEs
-- WITH customer_cte AS (
--     SELECT COUNT(*) AS customer_c
--     FROM customers
-- ),
-- order_cte AS (
--     SELECT SUM(amount) AS total_customer_spent
--     FROM orders
-- )
-- SELECT
--     c.customer_c,
--     o.total_customer_spent
-- FROM customer_cte c, order_cte o;


--8 ANTI JOIN
SELECT   c.customer_id,
    c.name
FROM customers c
LEFT JOIN orders O 
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
