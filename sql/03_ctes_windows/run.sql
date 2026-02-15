-- BASIC CTE EXAMPLE (READABILITY)


WITH txn_summary AS ( 
    SELECT 
        customer_id, 
        COUNT(*) AS txn_count,
        SUM(amount) AS total_spent
    FROM transactions
    GROUP BY customer_id 
    ORDER BY customer_id ASC
    )

SELECT * FROM txn_summary;


---  cte + filtering

WITH txn_summary AS ( 
    SELECT   
        customer_id,  
        SUM(amount) AS total_spent
    FROM  transactions 
    GROUP BY customer_id 
 )

SELECT * 
FROM txn_summary 
WHERE total_spent > 550;


--- WINDOW FUNCTION : ROW EXAMPLE

SELECT
    customer_id,
    amount,
    txn_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id
        ORDER BY txn_date DESC
    ) AS rn
FROM transactions;


--LATEST  TRANSACTION PER   CUSTOMER/Dedup event streams
WITH ranked_txns AS (
    SELECT
        customer_id,
        amount,
        txn_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY txn_date DESC
        ) AS rn
    FROM transactions
)
SELECT
    customer_id,
    amount,
    txn_date
FROM ranked_txns
WHERE rn = 1;


--MOST RECENT TRANSACTIONS PER CUSTOMER
WITH ranked_txns AS (
    SELECT
        customer_id,
        amount,
        txn_date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY txn_date DESC
        ) AS rn
    FROM transactions
)
SELECT
    customer_id,
    amount,
    txn_date    
FROM ranked_txns
WHERE rn <= 5


--- RUNNIN TOTALS (WINDOW FUNCTION : SUM)

SELECT
    customer_id,
    txn_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY txn_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM transactions;


-- 6️  RANK vs DENSE_RANK
SELECT
    customer_id,
    amount,
    RANK() OVER (
        PARTITION BY customer_id
        ORDER BY amount DESC
    ) AS rank_val,
    DENSE_RANK() OVER (
        PARTITION BY customer_id
        ORDER BY amount DESC
    ) AS dense_rank_val
FROM transactions;

-- 7️  DEDUPLICATION
WITH deduped AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id, txn_date
               ORDER BY txn_id
           ) AS rn
    FROM transactions
)
SELECT *
FROM deduped
WHERE rn = 1;