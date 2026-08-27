-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database
-- Add a new customer to the database
INSERT INTO customers (first_name, last_name, email)
VALUES ('Maria', 'Silva', 'maria.silva@example.com');

-- Add a new product to the inventory
INSERT INTO products (name, category, price, stock_quantity)
VALUES ('Wireless Mouse', 'Electronics', 49.99, 100);

-- Create a new order for a customer
INSERT INTO orders (customer_id, status)
VALUES (1, 'Processing');

-- Add an item to the recently created order
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (1, 1, 2, 49.99);

-- Update the stock quantity of a product after a sale
UPDATE products
SET stock_quantity = stock_quantity - 2
WHERE id = 1;

-- Retrieve all processing orders with their total amounts
SELECT * FROM order_summary
WHERE status = 'Processing';

-- Delete a canceled order from the system
DELETE FROM orders
WHERE id = 1 AND status = 'Canceled';

-- Find all products that have low stock (less than 10 items)
SELECT * FROM products
WHERE stock_quantity < 10;
