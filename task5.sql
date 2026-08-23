CREATE DATABASE IF NOT EXISTS payment_transaction_db;
USE payment_transaction_db;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

INSERT INTO customers (customer_name, email, phone) VALUES
('Arun Kumar','arun@gmail.com','9876543210'),
('Priya Sharma','priya@gmail.com','9876543211'),
('Rahul Kumar','rahul@gmail.com','9876543212'),
('Divya Sri','divya@gmail.com','9876543213'),
('Karthik Raj','karthik@gmail.com','9876543214'),
('Anjali Devi','anjali@gmail.com','9876543215'),
('Vignesh S','vignesh@gmail.com','9876543216'),
('Sneha R','sneha@gmail.com','9876543217');

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    payment_mode ENUM('UPI','CREDIT CARD','DEBIT CARD','NET BANKING','CASH') NOT NULL,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('SUCCESS','FAILED','PENDING') NOT NULL,
    transaction_reference VARCHAR(50) UNIQUE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO payments
(customer_id, payment_mode, payment_date, amount, payment_status, transaction_reference)
VALUES
(1,'UPI','2025-08-01 10:15:00',1500.00,'SUCCESS','TXN10001'),
(2,'CREDIT CARD','2025-08-01 11:20:00',2500.00,'SUCCESS','TXN10002'),
(3,'DEBIT CARD','2025-08-02 09:30:00',1200.00,'FAILED','TXN10003'),
(4,'NET BANKING','2025-08-02 14:10:00',3500.00,'SUCCESS','TXN10004'),
(5,'UPI','2025-08-03 16:45:00',800.00,'SUCCESS','TXN10005'),
(6,'CREDIT CARD','2025-08-03 18:20:00',4200.00,'FAILED','TXN10006'),
(7,'DEBIT CARD','2025-08-04 12:30:00',1800.00,'SUCCESS','TXN10007'),
(8,'UPI','2025-08-04 15:15:00',950.00,'SUCCESS','TXN10008'),
(1,'NET BANKING','2025-08-05 10:00:00',5000.00,'SUCCESS','TXN10009'),
(2,'UPI','2025-08-05 13:25:00',750.00,'FAILED','TXN10010'),
(3,'CREDIT CARD','2025-08-06 17:40:00',2200.00,'SUCCESS','TXN10011'),
(4,'DEBIT CARD','2025-08-06 19:10:00',1600.00,'SUCCESS','TXN10012'),
(5,'UPI','2025-08-07 09:45:00',1100.00,'SUCCESS','TXN10013'),
(6,'NET BANKING','2025-08-07 11:30:00',3000.00,'PENDING','TXN10014'),
(7,'CREDIT CARD','2025-08-08 14:20:00',4500.00,'SUCCESS','TXN10015'),
(8,'DEBIT CARD','2025-08-08 16:50:00',1300.00,'FAILED','TXN10016'),
(1,'UPI','2025-08-09 10:35:00',900.00,'SUCCESS','TXN10017'),
(2,'CREDIT CARD','2025-08-09 12:40:00',2800.00,'SUCCESS','TXN10018'),
(3,'NET BANKING','2025-08-10 15:20:00',3700.00,'SUCCESS','TXN10019'),
(4,'UPI','2025-08-10 18:00:00',650.00,'FAILED','TXN10020');

SELECT * FROM customers;

SELECT * FROM payments;

SELECT
    p.payment_id,
    c.customer_name,
    c.email,
    p.payment_mode,
    p.payment_date,
    p.amount,
    p.payment_status,
    p.transaction_reference
FROM payments p
JOIN customers c
ON p.customer_id = c.customer_id
ORDER BY p.payment_date;

SELECT
    payment_status,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount
FROM payments
GROUP BY payment_status;

SELECT
    payment_mode,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount
FROM payments
GROUP BY payment_mode
ORDER BY total_transactions DESC;

SELECT
    payment_mode,
    COUNT(*) AS successful_transactions,
    SUM(amount) AS successful_amount
FROM payments
WHERE payment_status = 'SUCCESS'
GROUP BY payment_mode
ORDER BY successful_transactions DESC;

SELECT
    payment_mode,
    COUNT(*) AS failed_transactions,
    SUM(amount) AS failed_amount
FROM payments
WHERE payment_status = 'FAILED'
GROUP BY payment_mode
ORDER BY failed_transactions DESC;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(p.payment_id) AS total_transactions,
    SUM(p.amount) AS total_payment_amount,
    SUM(CASE WHEN p.payment_status = 'SUCCESS' THEN 1 ELSE 0 END) AS successful_transactions,
    SUM(CASE WHEN p.payment_status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions
FROM customers c
LEFT JOIN payments p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_payment_amount DESC;

SELECT
    p.payment_id,
    c.customer_name,
    p.payment_mode,
    p.amount,
    p.payment_date,
    p.payment_status,
    p.transaction_reference
FROM payments p
JOIN customers c
ON p.customer_id = c.customer_id
WHERE p.payment_status = 'SUCCESS'
ORDER BY p.payment_date DESC;

SELECT
    p.payment_id,
    c.customer_name,
    p.payment_mode,
    p.amount,
    p.payment_date,
    p.payment_status,
    p.transaction_reference
FROM payments p
JOIN customers c
ON p.customer_id = c.customer_id
WHERE p.payment_status = 'FAILED'
ORDER BY p.payment_date DESC;

SELECT
    p.payment_id,
    c.customer_name,
    p.payment_mode,
    p.amount,
    p.payment_date,
    p.payment_status
FROM payments p
JOIN customers c
ON p.customer_id = c.customer_id
WHERE p.payment_status = 'PENDING';

SELECT
    DATE(payment_date) AS payment_date,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount,
    SUM(CASE WHEN payment_status = 'SUCCESS' THEN 1 ELSE 0 END) AS successful_transactions,
    SUM(CASE WHEN payment_status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions,
    SUM(CASE WHEN payment_status = 'PENDING' THEN 1 ELSE 0 END) AS pending_transactions
FROM payments
GROUP BY DATE(payment_date)
ORDER BY payment_date;

SELECT
    payment_mode,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN payment_status = 'SUCCESS' THEN 1 ELSE 0 END) AS successful_transactions,
    SUM(CASE WHEN payment_status = 'FAILED' THEN 1 ELSE 0 END) AS failed_transactions,
    ROUND(
        SUM(CASE WHEN payment_status = 'SUCCESS' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS success_percentage
FROM payments
GROUP BY payment_mode
ORDER BY success_percentage DESC;

SELECT
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_transaction_value,
    SUM(CASE WHEN payment_status = 'SUCCESS' THEN amount ELSE 0 END) AS successful_payment_value,
    SUM(CASE WHEN payment_status = 'FAILED' THEN amount ELSE 0 END) AS failed_payment_value,
    SUM(CASE WHEN payment_status = 'PENDING' THEN amount ELSE 0 END) AS pending_payment_value
FROM payments;

SELECT
    c.customer_name,
    p.payment_mode,
    COUNT(*) AS transaction_count,
    SUM(p.amount) AS total_amount
FROM payments p
JOIN customers c
ON p.customer_id = c.customer_id
GROUP BY c.customer_name, p.payment_mode
ORDER BY c.customer_name, total_amount DESC;

SELECT
    payment_mode,
    COUNT(*) AS usage_count
FROM payments
GROUP BY payment_mode
ORDER BY usage_count DESC
LIMIT 1;

SELECT
    payment_id,
    customer_id,
    payment_mode,
    payment_date,
    amount,
    payment_status,
    transaction_reference
FROM payments
WHERE amount > 2000
ORDER BY amount DESC;

SELECT
    p.payment_id,
    c.customer_name,
    p.payment_mode,
    p.amount,
    p.payment_status,
    p.transaction_reference
FROM payments p
JOIN customers c
ON p.customer_id = c.customer_id
WHERE p.payment_date BETWEEN '2025-08-01 00:00:00'
AND '2025-08-05 23:59:59'
ORDER BY p.payment_date;

SELECT
    c.customer_name,
    COUNT(p.payment_id) AS total_transactions,
    SUM(p.amount) AS total_spent
FROM customers c
JOIN payments p
ON c.customer_id = p.customer_id
WHERE p.payment_status = 'SUCCESS'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(p.amount) > 3000
ORDER BY total_spent DESC;

SELECT
    payment_mode,
    COUNT(*) AS total_transactions,
    ROUND(AVG(amount),2) AS average_transaction_amount,
    MIN(amount) AS minimum_amount,
    MAX(amount) AS maximum_amount,
    SUM(amount) AS total_transaction_amount
FROM payments
GROUP BY payment_mode
ORDER BY total_transaction_amount DESC;
