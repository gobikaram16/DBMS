CREATE DATABASE IF NOT EXISTS clv_bgnbd;
USE clv_bgnbd;

DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    transaction_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);

INSERT INTO transactions (transaction_id, customer_id, transaction_date, amount) VALUES
(1,101,'2025-01-05',500.00),
(2,101,'2025-02-10',650.00),
(3,101,'2025-03-15',450.00),
(4,101,'2025-05-20',700.00),
(5,101,'2025-07-25',550.00),
(6,102,'2025-01-12',300.00),
(7,102,'2025-03-18',450.00),
(8,102,'2025-06-22',500.00),
(9,103,'2025-01-20',800.00),
(10,103,'2025-02-25',750.00),
(11,103,'2025-04-10',900.00),
(12,103,'2025-05-15',850.00),
(13,103,'2025-07-01',950.00),
(14,103,'2025-08-10',1000.00),
(15,104,'2025-02-05',250.00),
(16,104,'2025-05-10',350.00),
(17,105,'2025-01-08',600.00),
(18,105,'2025-02-12',700.00),
(19,105,'2025-03-20',550.00),
(20,105,'2025-06-18',800.00);

SELECT * FROM transactions;

DROP VIEW IF EXISTS customer_bgnbd_data;

CREATE VIEW customer_bgnbd_data AS
SELECT
    customer_id,
    COUNT(*) - 1 AS frequency,
    DATEDIFF(MAX(transaction_date),MIN(transaction_date)) AS recency,
    DATEDIFF(
        (SELECT MAX(transaction_date) FROM transactions),
        MIN(transaction_date)
    ) AS T,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_spend,
    AVG(amount) AS average_order_value
FROM transactions
GROUP BY customer_id;

SELECT
    customer_id,
    frequency,
    recency,
    T,
    total_transactions,
    total_spend,
    ROUND(average_order_value,2) AS average_order_value
FROM customer_bgnbd_data
ORDER BY customer_id;

SELECT
    COUNT(*) AS total_customers,
    SUM(total_transactions) AS total_transactions,
    SUM(total_spend) AS total_revenue,
    ROUND(AVG(frequency),2) AS average_frequency,
    ROUND(AVG(recency),2) AS average_recency,
    ROUND(AVG(T),2) AS average_customer_age
FROM customer_bgnbd_data;

SELECT
    customer_id,
    frequency,
    recency,
    T,
    total_spend,
    average_order_value
FROM customer_bgnbd_data
WHERE frequency > 0
ORDER BY frequency DESC;

SELECT
    customer_id,
    frequency,
    recency,
    T,
    total_spend,
    average_order_value,
    ROUND(
        total_spend / NULLIF(total_transactions,0),
        2
    ) AS calculated_average_order_value
FROM customer_bgnbd_data
ORDER BY total_spend DESC;

SELECT
    customer_id,
    frequency,
    recency,
    T,
    CASE
        WHEN frequency = 0 THEN 'ONE TIME CUSTOMER'
        WHEN frequency BETWEEN 1 AND 2 THEN 'LOW FREQUENCY'
        WHEN frequency BETWEEN 3 AND 5 THEN 'MEDIUM FREQUENCY'
        ELSE 'HIGH FREQUENCY'
    END AS customer_segment
FROM customer_bgnbd_data
ORDER BY frequency DESC;
