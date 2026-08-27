-- Represents customers of the retail store
CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at NUMERIC DEFAULT CURRENT_TIMESTAMP
);

-- Represents the inventory of products
CREATE TABLE products (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    price NUMERIC NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0
);

-- Represents customer orders
CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date NUMERIC DEFAULT CURRENT_TIMESTAMP,
    status TEXT NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Represents the items within each order
CREATE TABLE order_items (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Index to speed up customer searches by email
CREATE INDEX idx_customers_email ON customers(email);

-- Index to speed up order lookups by customer
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- View to summarize order details and total value
CREATE VIEW order_summary AS
SELECT
    o.id AS order_id,
    c.first_name,
    c.last_name,
    o.order_date,
    o.status,
    SUM(oi.quantity * oi.unit_price) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id;
