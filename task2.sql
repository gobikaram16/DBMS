CREATE TABLE Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    category_id INT,
    price DECIMAL(10,2),
    stock INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

INSERT INTO Category (category_name)
VALUES ('Electronics'), ('Clothing'), ('Books');

INSERT INTO Product (product_name, category_id, price, stock)
VALUES
('Laptop', 1, 50000, 10),
('Shirt', 2, 800, 20),
('Python Book', 3, 600, 15);

SELECT * FROM Category;
SELECT * FROM Product;