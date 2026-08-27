# Design Document

By Rafael Boaro

Video overview: [(https://youtu.be/h5ZNNmf-OzM)]

## Scope

* What is the purpose of your database?
The purpose of this database is to serve as the core backend for a retail Enterprise Resource Planning (ERP) system, specifically modeled for daily operations like those of "Tudo Aqui Variedades". It handles the essential flow of customer registration, inventory tracking, and order processing.

* Which people, places, things, etc. are you including in the scope of your database?
The scope includes the store's customers, the products available in the inventory, the orders placed, and the specific items that make up each order.

* Which people, places, things, etc. are *outside* the scope of your database?
Employees, payroll, shift management, and supplier/vendor tracking are currently outside the scope. Additionally, complex shipping logistics and physical store aisle locations are not tracked in this core iteration.

## Functional Requirements

* What should a user be able to do with your database?
A user (store manager or system backend) should be able to register new customers, add or update products in the inventory, log new sales/orders, deduct purchased quantities from the stock, and generate summaries showing the total amount spent per order.

* What's beyond the scope of what a user should be able to do with your database?
Users cannot process credit card transactions directly within the database, track real-time delivery GPS routes, or handle automated multi-step return and refund workflows.

## Representation

### Entities

* Which entities will you choose to represent in your database?
I chose to represent four main entities: `customers`, `products`, `orders`, and `order_items`.

* What attributes will those entities have?
  * `customers`: `id`, `first_name`, `last_name`, `email`, `created_at`.
  * `products`: `id`, `name`, `category`, `price`, `stock_quantity`.
  * `orders`: `id`, `customer_id`, `order_date`, `status`.
  * `order_items`: `order_id`, `product_id`, `quantity`, `unit_price`.

* Why did you choose the types you did?
I used `INTEGER` for all primary keys, foreign keys, and whole-number quantities (like stock). `TEXT` was used for names, emails, and categories because strings can vary in length. `NUMERIC` was chosen for prices and dates (`CURRENT_TIMESTAMP`) because SQLite handles monetary values and timestamps well using numeric affinities, preventing floating-point precision errors.

* Why did you choose the constraints you did?
I applied `PRIMARY KEY` to uniquely identify records. `NOT NULL` was used extensively on essential fields (like names, prices, and quantities) to prevent incomplete data entry. I used `UNIQUE` on the customer's email to avoid duplicate accounts. Finally, `DEFAULT` was used for timestamps and default stock values (0) to simplify `INSERT` statements. `FOREIGN KEY` constraints ensure referential integrity so an order cannot exist without a valid customer.

### Relationships
![ER Diagram](diagram.png)
* Entity Relationship Diagram details:
  * A **customer** can place zero to many **orders** (1 to N).
  * An **order** is placed by exactly one **customer** (1 to 1).
  * An **order** can contain one to many **products** (1 to N through `order_items`).
  * A **product** can be part of zero to many **orders** (1 to N through `order_items`).
  * The `order_items` table acts as a junction table to resolve the many-to-many (N to M) relationship between `orders` and `products`.

## Optimizations

* Which optimizations (e.g., indexes, views) did you create? Why?
  * `idx_customers_email`: Created on the `email` column of the `customers` table to significantly speed up login verifications and customer lookups.
  * `idx_orders_customer_id`: Created on `customer_id` in the `orders` table to accelerate queries that fetch a specific customer's order history, preventing full table scans.
  * `order_summary` View: Created to encapsulate a complex query involving three `JOIN`s (`orders`, `customers`, and `order_items`) and an aggregate `SUM` function. This prevents the application from repeatedly calculating total order amounts, saving processing time and simplifying dashboard queries.

## Limitations

* What are the limitations of your design?
The design currently relies on a static snapshot of the `unit_price` inside the `order_items` table. While this correctly preserves the historical price paid at the time of purchase, the system does not keep a dedicated historical log of when a product's base price changed in the `products` table over time.

* What might your database not be able to represent very well?
It does not represent complex order fulfillment very well. For example, if a customer orders 5 items and they are shipped in 3 different boxes on different dates, the single `status` column in the `orders` table is insufficient to track partial fulfillments or multi-address shipments.
