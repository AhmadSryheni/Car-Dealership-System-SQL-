/*
 * PURCHASE VALIDATION FUNCTION
 * 
 * CHECK_PURCHASE:
 *    - Validates if a customer can purchase a specific car
 *    - Parameters: cust_id (customer), car_id1 (vehicle)
 *    - Returns: 1 (approved) or 0 (denied)
 * 
 * Validation Logic:
 * 1. Verifies customer exists (throws -20001 if not)
 * 2. Verifies car exists (throws -20002 if not)
 * 3. Checks available inventory vs already purchased
 *    - Prevents buying more than available stock
 * 
 * Error Handling:
 * - Custom exceptions for missing data
 * - Clear error messages for troubleshooting
 */
create or replace FUNCTION check_purchase (
cust_id IN customers.customer_id%TYPE,
car_id1 IN cars.car_id%TYPE
)
RETURN NUMBER
IS
existing_customer customers.customer_id%TYPE;
existing_car cars.car_id%TYPE;
available_cars NUMBER;
purchased_cars NUMBER;
BEGIN
begin
SELECT customer_id INTO existing_customer FROM customers WHERE customer_id = cust_id;
exception when NO_DATA_FOUND then
RAISE_APPLICATION_ERROR(-20001, 'Customer not found');
end;
begin
SELECT car_id INTO existing_car FROM cars WHERE cars.car_id = car_id1;
exception when NO_DATA_FOUND then
RAISE_APPLICATION_ERROR(-20002, 'Car not found');
end;
SELECT car_count INTO available_cars FROM cars WHERE cars.car_id = car_id1;
SELECT COUNT(*) INTO purchased_cars
FROM purchase pur
JOIN cars c ON pur.car_id = c.car_id
WHERE c.car_brand = (SELECT car_brand FROM cars c WHERE c.car_id = car_id1)
AND pur.customer_id = cust_id;
IF purchased_cars < available_cars THEN
RETURN 1;
ELSE
RETURN 0;
END IF;
END;