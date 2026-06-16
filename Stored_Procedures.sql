-- Stored Procedure

-- 81. Create a procedure to get patient details by patient_id
delimiter //
create procedure getpatient_id()
begin
select * from patients ;
END // 
delimiter ;
call getpatient_id();

-- 82. Create a procedure to show all appointments of a patient
delimiter //
create procedure getapp_detail()
begin
select * from appointments ;
end //
delimiter ;
call getapp_detail();

-- 83. Create a procedure to calculate total bill amount of a patient
call gettotal_bill();

--  84. Create a procedure to show all doctors in a department
call doctor_list();

-- 85. Create a procedure to display top 5 highest billed patients
call top_patients();

-- 86. Create a procedure to count appointments of a doctor
call total_app();