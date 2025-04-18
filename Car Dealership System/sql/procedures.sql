/*
 * PURCHASE PROCESSING PROCEDURE
 * 
 * COMPLETE_PURCHASE:
 *    - Finalizes car sales transactions
 *    - Parameters: custo_id (customer), caro_id (car)
 * 
 * Workflow:
 * 1. Calls CHECK_PURCHASE for validation
 * 2. If approved:
 *    - Records transaction in PURCHASE table
 *    - Sets purchase_date to current date
 * 3. If denied:
 *    - Returns explanatory message
 * 
 * Business Rules:
 * - Enforces inventory limits
 * - Maintains data integrity through FK constraints
 */
create or replace procedure complete_purchase(custo_id in CUSTOMERS.CUSTOMER_ID%type,caro_id in CARS.CAR_ID%type)
is
begin
if(check_purchase(custo_id,caro_id) = 0) then
dbms_output.put_line('You cant purchase the following car, please try again !!');
else
insert into purchase values(custo_id,caro_id,sysdate);
dbms_output.put_line('your purchase to the car is completed');
end if;
end;