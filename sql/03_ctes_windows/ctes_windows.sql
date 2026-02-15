DROP TABLE IF EXISTS transactions;



--- TRANSACTIONS TABLE 

CREATE TABLE  transactions (
    txn_id SERIAL PRIMARY KEY,
    customer_id INT,
    amount NUMERIC (10, 2),
    txn_date DATE
);


INSERT INTO transactions (customer_id, amount, txn_date) VALUES
(1, 100, '2024-01-01'),
(1, 200, '2024-01-05'),
(1, 300, '2024-01-10'),
(2, 400, '2024-01-03'),
(2, 150, '2024-01-08'),
(3, 500, '2024-01-02');



SELECT * FROM transactions;