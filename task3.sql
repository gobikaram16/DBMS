CREATE DATABASE SellerInventoryDB;
USE SellerInventoryDB;
CREATE TABLE Seller (
	seller_id INT PRIMARY KEY,
    seller_name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
CREATE TABLE Inventory (
    inventory_id INT PRIMARY KEY,
    seller_id INT,
    product_id INT,
    stock_quantity INT,
    status VARCHAR(20),
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
INSERT INTO Seller VALUES
(1, 'Arun Traders', '9876543210', 'arun@gmail.com'),
(2, 'Kumar Stores', '9876543211', 'kumar@gmail.com');
INSERT INTO Product VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mouse', 'Accessories', 800),
(103, 'Printer', 'Electronics', 12000);
INSERT INTO Inventory VALUES
(1, 1, 101, 10, 'Available'),
(2, 1, 102, 0, 'Unavailable'),
(3, 2, 103, 5, 'Available');
SELECT * FROM Seller;
SELECT * FROM Product;
SELECT * FROM Inventory;
SELECT
    s.seller_name,
    p.product_name,
    p.category,
    p.price,
    i.stock_quantity,
    i.status
FROM Seller s
JOIN Inventory i ON s.seller_id = i.seller_id
JOIN Product p ON i.product_id = p.product_id;
SELECT
     p.product_name,
     s.seller_name,
     i.stock_quantity
FROM Inventory i 
JOIN Product p ON i.product_id = p.product_id
JOIN Seller s ON i.seller_id = s.seller_id
WHERE i.stock_quantity > 0;
SELECT
	p.product_name,
    s.seller_name,
    i.stock_quantity
FROM Inventory i
JOIN Product p ON i.product_id = p.product_id
JOIN Seller s ON i.seller_id = s.seller_id
WHERE i.stock_quantity = 0;