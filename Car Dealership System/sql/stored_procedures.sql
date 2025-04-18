/*
 * STORED PROCEDURES FOR REPORTING
 * 
 * 1. SOLD_CARS_ALL:
 *    - Generates complete list of all sold vehicles
 *    - Includes customer ID, car ID, and brand
 *    - Uses cursor for efficient data retrieval
 *    - Implements error handling for cursor operations
 * 
 * 2. SOLD_CARS_CUSTOMER:
 *    - Generates purchase history for specific customer
 *    - Displays car details (ID, brand, model) with customer name
 *    - Parameter: p_cust_id (customer ID to filter)
 *    - Robust error handling for database operations
 */
create or replace PROCEDURE sold_cars_all IS
CURSOR c1 IS
SELECT p.customer_id, p.car_id, c.car_brand
FROM purchase p
JOIN cars c ON p.car_id = c.car_id;
v_customer_id purchase.customer_id%TYPE;
v_car_id purchase.car_id%TYPE;
v_car_brand cars.car_brand%TYPE;
BEGIN
OPEN c1;
LOOP
FETCH c1 INTO v_customer_id, v_car_id, v_car_brand;
EXIT WHEN c1%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer_id || ', Car ID: ' || v_car_id || ', Brand: ' || v_car_brand);
END LOOP;
CLOSE c1;
EXCEPTION
WHEN OTHERS THEN
IF SQLCODE = -6511 THEN
DBMS_OUTPUT.PUT_LINE('Cursor is already open.');
ELSE
DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END IF;
END;
3:
create or replace PROCEDURE sold_cars_customer(p_cust_id IN customers.customer_id%TYPE) IS
CURSOR c1 IS
SELECT p.CAR_ID, c.car_brand, c.car_model, cust.customer_name
FROM purchase p
JOIN cars c ON p.car_id = c.car_id
JOIN customers cust ON p.CUSTOMER_ID = cust.customer_id
WHERE p.CUSTOMER_ID = p_cust_id;
v_id_car PURCHASE.CAR_ID %TYPE;
v_brand cars.car_brand%TYPE;
v_model cars.car_model%TYPE;
v_name_c customers.customer_name%TYPE;
BEGIN
OPEN c1;
LOOP
FETCH c1 INTO v_id_car, v_brand, v_model, v_name_c;
EXIT WHEN c1%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Car ID: ' || v_id_car || ', Brand: ' || v_brand || ', Model: '|| v_model || ', Name: ' || v_name_c);
END LOOP;
CLOSE c1;
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;