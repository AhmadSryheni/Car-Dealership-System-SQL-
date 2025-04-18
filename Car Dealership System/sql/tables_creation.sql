/*
 * Database Schema Creation Script
 * Creates all tables required for the Car Dealership Management System:
 * 
 * 1. CARS - Stores inventory of available vehicles with:
 *    - car_id (PK), brand, model, count, price, description
 * 
 * 2. CUSTOMERS - Maintains customer records with:
 *    - customer_id (PK), name, mobile number
 * 
 * 3. PURCHASE - Tracks sales transactions with:
 *    - customer_id (FK to CUSTOMERS)
 *    - car_id (FK to CARS)
 *    - purchase_date
 * 
 * 4. CUSTOMER_CHANGE - Audit log for tracking changes to customer records
 *    - Tracks inserts, updates, deletes with timestamps
 *    - Stores before/after values for name and phone
 */
Create tables :
CREATE TABLE cars (
car_id INT PRIMARY KEY,
car_brand VARCHAR(115),
car_model VARCHAR(155),
car_count INT,
car_price int,
car_description varchar
);
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(105),
customer_mobile_number VARCHAR(20)
);
CREATE TABLE purchase (
customer_id INT,
car_id INT,
purchase_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (car_id) REFERENCES cars(car_id)
);