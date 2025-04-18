# 🚗 Car Dealership Management System

An Oracle PL/SQL database project for tracking vehicle sales, customers, and inventory.

## 🌟 Features
| Component         | Description                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| Tables        | cars, customers, purchase, customer_change (audit log)              |
| Procedures    | sold_cars_all, sold_cars_customer                                       |
| Functions     | check_purchase validates inventory before sales                           |
| Triggers      | information_store logs all customer CRUD operations                       |
| Error Handling| Custom exceptions (-20001 for missing customer, -20002 for missing car)     |

### Key Tables
`sql
-- Cars Inventory
CREATE TABLE cars (
    car_id INT PRIMARY KEY,
    car_brand VARCHAR(115),
    car_model VARCHAR(155),
    car_count INT,
    car_price INT
);

-- Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(105),
    customer_mobile_number VARCHAR(20)
);
