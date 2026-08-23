

CREATE DATABASE  OrderManagementDB;
USE OrderManagementDB;


-- =========================
-- 1. CUSTOMER TABLE
-- =========================
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15)
);


-- =========================
-- 2. PRODUCT TABLE
-- =========================
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);



-- ============================
-- 3. ORDERS TABLE—
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
);


-- =========================
-- 4. ORDER DETAILS TABLE
-- =========================

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES Product(product_id))
-- =========================
-- 5. INSERT CUSTOMERS
-- =========================


INSERT INTO Customer
(customer_id, customer_name, email, phone)
VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', '9876543210'),
(2, 'Priya Singh', 'priya@gmail.com', '9876543211'),
(3, 'Aman Verma', 'aman@gmail.com', '9876543212'),
(4, 'Sneha Yadav', 'sneha@gmail.com', '9876543213'),
(5, 'Rohit Kumar', 'rohit@gmail.com', '9876543214');


-- =========================
-- 6. INSERT PRODUCTS
-- =========================

INSERT INTO Product
(product_id, product_name, price)
VALUES
(101, 'Laptop', 55000.00),
(102, 'Mobile Phone', 25000.00),
(103, 'Keyboard', 1500.00),
(104, 'Mouse', 800.00),
(105, 'Headphones', 2000.00),
(106, 'Monitor', 12000.00);


-- =========================
-- 7. INSERT ORDERS
-- =========================

INSERT INTO Orders
(order_id, customer_id, order_date, total_amount)
VALUES
(1001, 1, '2026-08-10', 57300.00),
(1002, 2, '2026-08-11', 25000.00),
(1003, 1, '2026-08-12', 2300.00),
(1004, 3, '2026-08-13', 14000.00),
(1005, 4, '2026-08-14', 2000.00);


-- =========================
-- 8. INSERT ORDER DETAILS
-- =========================

INSERT INTO Order_Details
(order_detail_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 1, 55000.00),
(2, 1001, 104, 1, 800.00),
(3, 1001, 103, 1, 1500.00),

(4, 1002, 102, 1, 25000.00),

(5, 1003, 104, 1, 800.00),
(6, 1003, 103, 1, 1500.00),

(7, 1004, 106, 1, 12000.00),
(8, 1004, 103, 1, 1500.00),
(9, 1004, 104, 1, 500.00),

(10, 1005, 105, 1, 2000.00);


-- =========================
-- 9. DISPLAY ORDERS
-- =========================

SELECT * FROM Orders;


-- =========================
-- 10. DISPLAY ORDER DETAILS
-- =========================

SELECT * FROM Order_Details;


-- =========================
-- 11. UPDATE ORDER
-- =========================

UPDATE Orders
SET total_amount = 58000.00
WHERE order_id = 1001;


-- =========================
-- 12. UPDATE QUANTITY
-- =========================

UPDATE Order_Details
SET quantity = 2
WHERE order_detail_id = 2;


-- =========================
-- 13. CUSTOMER ORDER HISTORY
-- =========================

SELECT
    Customer.customer_name,
    Orders.order_id,
    Orders.order_date,
    Product.product_name,
    Order_Details.quantity,
    Order_Details.unit_price,
    Orders.total_amount

FROM Customer

JOIN Orders
    ON Customer.customer_id = Orders.customer_id

JOIN Order_Details
    ON Orders.order_id = Order_Details.order_id

JOIN Product
    ON Order_Details.product_id = Product.product_id

ORDER BY Orders.orde