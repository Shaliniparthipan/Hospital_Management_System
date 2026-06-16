-- TRIGGER
-- 87. Create a trigger that stores a log whenever a new patient is added

DELIMITER //
CREATE TRIGGER after_patient_insert
AFTER INSERT ON Patients
FOR EACH ROW
BEGIN
    INSERT INTO Patient_Logs (patient_id)
    VALUES (NEW.patient_id);
END //

DELIMITER ;
-- 
INSERT INTO Patients (patient_id, patient_name,age,gender) VALUES ( 2002,'John Doe',25,'Male');
SELECT * FROM Patient_Logs;

-- 88. Create a trigger that stores old and new bill amounts whenever Bills table is updated
delimiter //
create trigger after_bill_update
after update on bills
for each row
begin
if old_amount<>new_amount then
insert into bill_logs (bill_id,old.amount,new.amount)
values (old.bill_id,old.bill_id,new.bill_id);
end if;
end //
delimiter ;

-- 89. Create a trigger to prevent inserting a patient with age < 0
delimiter //
create trigger before_patient_insert_age_check
before insert on patients
for each row 
begin
if new.age < 0 then
signal sqlstate '45000'
set message_text = 'Error : patient age cannot be less than 0,';
end if ;
end //
delimiter ;

-- 90. Create a trigger to automatically set appointment status as 'Pending' when a new appointment is inserted
delimiter //
create trigger before_app_insert
before insert on appointments
for each row
begin
insert into payments (appointment_id,amount,status)
values (new.appointment_id,0.00,'pending');
end //
delimiter ;

-- 91. Create a trigger to log deleted patient records
delimiter //
create trigger deleted_patient_log
after delete on patients
for each row
begin
insert into delete_patients_log(patient_id,patient_name)
values (old.patient_id,old.patient_name);
end //
delimiter ;