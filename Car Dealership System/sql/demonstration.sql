/*
 * SYSTEM DEMONSTRATION SCRIPTS
 * 
 * Shows end-to-end functionality:
 * 
 * 1. Purchase Simulation:
 *    - Processes 2 purchase attempts (1 success, 1 failure)
 *    - Takes customer/car IDs as user input
 * 
 * 2. Reporting:
 *    - Displays all sold cars
 *    - Shows purchases for specific customer
 * 
 * 3. Customer Management:
 *    - Tests CRUD operations with audit logging
 *    - Inserts, updates, then deletes test customer
 * 
 * 4. Review:
 *    - Displays complete change history
 *    - Verifies trigger functionality
 */

--1.
declare
cust1_id customers.customer_id%TYPE;
cust2_id customers.customer_id%TYPE;
car1_id cars.car_id%TYPE;
car2_id cars.car_id%TYPE;
begin
cust1_id :=&customer_id_1;
car1_id :=&car_id_1;
cust2_id :=&customer_id_2;
car2_id :=&car_id_2;
complete_purchase(cust1_id, car1_id);
complete_purchase(cust2_id, car2_id);
end;
--2.
declare
cust1_id customers.customer_id%type;
begin
cust1_id :=&customer_id;
dbms_output.put_line('The sold cars : ');
sold_cars_all;
dbms_output.put_line('the sold cars for the customer with id : ' || cust1_id);
sold_cars_customer(cust1_id);
end;
--3.
declare
cust1_id customers.customer_id%type;
begin
cust1_id :=&customer_id;
insert into customers values (cust1_id, 'Customer', '123');
update customers set customer_mobile_number = '91' where customer_id = cust1_id;
delete from customers where CUSTOMER_ID = cust1_id;
end;
--4.
begin
for cust in
(select * from customer_change)
loop
DBMS_OUTPUT.PUT_LINE('customer id ' || cust.customer_id || ' operation: ' || cust.operation ||
' user ' || cust.user_customer || ' date ' || cust.operation_date || ' old name: ' || cust.old_name || ' new name: '|| cust.new_name ||
' old phone: ' || cust.old_phone || ' new phone: ' || cust.new_phone);
end loop;
end;