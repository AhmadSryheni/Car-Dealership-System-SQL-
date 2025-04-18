/*
 * TRIGGER FOR CUSTOMER CHANGES
 * 
 * INFORMATION_STORE:
 *    - AFTER INSERT/UPDATE/DELETE on CUSTOMERS
 *    - Tracks all DML operations on customer records
 * 
 * Captures:
 * - Operation type (insert/update/delete)
 * - User who made changes
 * - Timestamp of change
 * - Before/after values for:
 *   - Customer name
 *   - Mobile number
 * 
 * Trail:
 * - Stores history in CUSTOMER_CHANGE table
 * - Essential for compliance and troubleshooting
 */

create or replace trigger information_store
after insert or update or delete on customers
for each row
begin
if INSERTING then
insert into CUSTOMER_CHANGE (customer_id, operation, user_customer, operation_date, OLD_NAME, NEW_NAME, OLD_PHONE, NEW_PHONE)
values (:new.customer_id, 'insert', USER, SYSDATE, null, :NEW.customer_name, null, :NEW.customer_mobile_number);
elsif UPDATING then
insert into CUSTOMER_CHANGE (customer_id, operation, user_customer, operation_date, OLD_NAME, NEW_NAME, OLD_PHONE, NEW_PHONE)
values (:new.customer_id, 'update', USER, SYSDATE, :OLD.customer_name, :NEW.customer_name, :OLD.customer_mobile_number, :NEW.customer_mobile_number);
elsif DELETING then
insert into CUSTOMER_CHANGE (customer_id, operation, user_customer, operation_date, OLD_NAME, NEW_NAME, OLD_PHONE, NEW_PHONE)
values (:old.customer_id, 'delete', USER, SYSDATE, :OLD.customer_name, null, :OLD.customer_mobile_number, null);
end if;
end;