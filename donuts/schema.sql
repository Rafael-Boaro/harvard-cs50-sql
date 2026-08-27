CREATE TABLE ingredients (
    id INTEGER,
    name TEXT NOT NULL,
    price_per_unit NUMERIC NOT NULL,
    unit TEXT NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE donuts (
    id INTEGER,
    name TEXT NOT NULL,
    gluten_free INTEGER NOT NULL,
    price NUMERIC NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE customers (
    id INTEGER,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE orders (
    id INTEGER,
    customer_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);
