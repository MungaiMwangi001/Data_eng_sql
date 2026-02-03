DROP TABLE   IF EXISTS  customers;
DROP TABLE   IF EXISTS  orders;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name TEXT,
    country TEXT
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT  NOT NULL,
    amount  NUMERIC (10, 2),
    order_date DATE
);

INSERT INTO  customers (name, country)  VALUES
('Alice', 'KENYA'),
('Bob', 'KENYA'),
('Carol', 'uganda'),
('David', 'Tanzania');


INSERT INTO orders (customer_id, amount, order_date) 
VALUES
    (1, 1200, '2024-01-10'),
    (1, 800,  '2024-01-15'),
    (2, 500,  '2024-01-12'),
    (3, 700,  '2024-01-18'),
    (3, 300,  '2024-01-20');


SELECT * FROM customers;
SELECT  * FROM orders;