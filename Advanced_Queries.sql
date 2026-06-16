CREATE TABLE Patient_Logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    action_performed VARCHAR(50) DEFAULT 'NEW PATIENT ADDED',
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

create table Bills_logs (
log_id int auto_increment primary key,
bill_id int not null,
old_amount decimal(10,2),
new_amount decimal(10,2),
updated_at timestamp default current_timestamp
);

create table deleted_patient_log (
log_id int auto_increment primary key,
patient_id int,
patient_name varchar(50),
deleted_at timestamp current_timestamp
);


-- 1.Total appointments per doctor
select d.doctor_name,count(a.appointment_id) as Total_appointment
from doctors d
join appointments as a
on d.doctor_id=a.doctor_id
group by d.doctor_name
order by Total_appointment desc;

--  2.total revenue
SELECT SUM(amount) AS total_revenue
FROM Bills;

-- 3.Top 10 patients with highest bills
SELECT p.patient_name,
       SUM(b.amount) AS total_bill
FROM Patients p
JOIN Bills b
ON p.patient_id = b.patient_id
GROUP BY p.patient_id, p.patient_name
ORDER BY total_bill DESC
LIMIT 10;

-- 4.Most visited doctor
SELECT d.doctor_name,
       COUNT(*) AS visits
FROM Doctors d
JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
ORDER BY visits DESC
LIMIT 1;

-- 5.Find all patients aged above 60
SELECT *
FROM Patients
WHERE age > 60;

-- 6.Find all female patients
SELECT *
FROM Patients
WHERE gender='Female';

-- 7.Find patient names with appointment dates
SELECT p.patient_name,
       a.appointment_date
FROM Patients p
JOIN Appointments a
ON p.patient_id=a.patient_id;

-- 8.Find doctor names and their department
SELECT d.doctor_name,
       dp.department_name
FROM Doctors d
JOIN Departments dp
ON d.department_id=dp.department_id;

-- 9.Find patients and their treating doctors
select p.patient_name,d.doctor_name
from patients as p
join appointments as a
on a.patient_id=p.patient_id
join doctors as d
on a.doctor_id=d.doctor_id

-- 10.Count total patients
select count(*) as total_patients
from patients

-- 11.Count appointments per doctor
select d.doctor_name,count(a.appointment_id) as total_appointments
from doctors as d
join appointments as a
group by d.doctor_name
order by total_appointments desc

-- 12.Find average bill amount
select avg(amount) as avg_bill_amt
from bills

-- 13. Number of doctors in each department
select de.department_name,count(d.doctor_name) as total_doctors
from departments as de
join doctors as d
on de.department_id=d.department_id
group by de.department_name

-- 14. Number of patients by gender
select gender, count(patient_id) as total_patients
from patients
group by gender

-- 15. Departments having more than 10 doctors
select de.department_name,count(d.doctor_id) as total_doctors
from departments as de
join doctors as d
on d.department_id=de.department_id
group by de.department_name
having count(d.doctor_id) > 10

-- 16. Find patients whose bill is above average
select * from bills 
where amount > 
(
select avg(amount)
from bills
)

-- 17. Find highest bill
select * from bills 
where amount =
(select max(amount)
from bills
limit 1)

-- 18. Find doctor with maximum appointments
SELECT doctor_id
FROM Appointments
GROUP BY doctor_id
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 19. Find patients without appointments
select * from patients 
where patient_id not in
(
select patient_id
from appointments
)

-- 20. Find doctors who have no appointments
select doctor_id,doctor_name
from doctors
where doctor_id not in (
select doctor_id
from appointments 
where appointment_id is null
)

-- 21. Find patients admitted more than once
select patient_id,count(admission_id)
from admissions
group by patient_id
having count(admission_id) > 1

-- 22. Find total revenue department-wise
select department_id
(
select sum(amount) as revenue
from bills
)from departments

-- 23. Find monthly revenue
select monthname(bill_date) as Month_name
from bills
group by monthname(bill_date),month(bill_date)
order by month(bill_date)

-- 24.Treatment history of a patient
select p.patient_id,t.treatment_id,d.doctor_name,de.department_name,a.appointment_date
from patients as p
join treatments as t
on p.patient_id =t.patient_id
join doctors as d
on t.doctor_id=d.doctor_id
join departments as de
on de.department_id=d.department_id
join appointments as a
on p.patient_id=a.patient_id

-- 25.Count admissions by room
select r.room_id,count(a.admission_id)
from admissions as a
join rooms as r
on r.room_id=a.room_id
group by r.room_id

-- 26. Display all patients
select * from patients

-- 27. Display all doctors from Cardiology department
select d.doctor_id,d.doctor_name,de.department_name
from doctors as d
join departments As de
on d.department_id=de.department_id
where department_name like "Cardiology%"

-- 28. Find all female patients
select patient_name,gender
from patients
where gender = "Female"

-- 29. Find patients older than 50
select patient_name, age
from patients
where age > "50"

-- 30. Count total patients
select count(*) as total_patients
from patients

-- 31. Display patient name and appointment date
select p.patient_name,a.appointment_date
from patients as p
join appointments as a
on p.patient_id=a.patient_id

-- 32. Display patient name and doctor name
select p.patient_name,d.doctor_name
from patients as p
join appointments as a
on p.patient_id=a.patient_id
join doctors as d
on a.doctor_id=d.doctor_id

-- 33. Display doctor name and department name
select d.doctor_name,de.department_name
from doctors as d
join departments as de
on d.department_id=de.department_id

-- 34. Display patient name and diagnosis
select p.patient_name,t.diagnosis
from patients as p
join treatments as t
on p.patient_id=t.patient_id

-- 35. Display admitted patients with room numbers
select p.patient_name,a.admission_id,a.room_id
from admissions as a
join patients as p
on p.patient_id=a.patient_id

-- 36. Count appointments per doctor
select d.doctor_name,count(a.appointment_id) Total_appointments
from doctors as d
join appointments as a
on d.doctor_id = a.doctor_id
group by d.doctor_name

-- 37. Find total hospital revenue
select sum(amount) as Total_revenue
from bills

-- 38. Find average bill amount
select avg(amount) as avg_billamount
from bills

-- 39. Find highest bill amount
select amount 
from bills
order by amount desc
limit 1;

-- 40. Departments having more than 5 doctors
select de.department_name,count(d.doctor_name)Total_doctors
from doctors as d
join departments as de
on d.department_id=de.department_id
group by de.department_name
having count(d.doctor_name) > 6

-- 41. Patients having more than 2 appointments
select p.patient_name,count(a.appointment_id) as total_appointments
from patients as p
join appointments as a
on p.patient_id=a.patient_id
group by p.patient_name
having count(a.appointment_id) >2

-- 42. Doctors who handled more than 20 patients
select d.doctor_name,count(p.patient_id) as total_patients
from doctors as d
join appointments as a
on a.doctor_id=d.doctor_id
join patients as p
on p.patient_id=a.patient_id
group by d.doctor_name
having count(p.patient_id) > 20

-- 43. Find patients whose bill amount is above average
select p.patient_name ,b.amount
from patients as p
join bills as b
on p.patient_id=b.patient_id
where b.amount >
(
select avg(amount) 
from bills
)

-- 44. Find patient with highest total bill
select p.patient_name,sum(b.amount) as total_bill
from patients as p
join bills as b
on p.patient_id=b.patient_id
group by p.patient_name
order by total_bill desc
limit 1

-- 45.Find patients whose bill amount is less than the highest bill amount.
SELECT *
FROM Bills
WHERE amount =
(
    SELECT MAX(amount)
    FROM Bills
    WHERE amount <
    (
        SELECT MAX(amount)
        FROM Bills
    )
);

-- 46.Find doctors who have more appointments than the average number of appointments per doctor.

SELECT d.doctor_name,
       COUNT(*) total_appointments
FROM Doctors d
JOIN Appointments a
ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
HAVING COUNT(*) >
(
    SELECT AVG(total_appointments)
    FROM (
        SELECT doctor_id,
               COUNT(*) total_appointments
        FROM Appointments
        GROUP BY doctor_id
    ) x
);

-- 47.Find the Top 3 doctors based on appointment count using a window function.
WITH doctor_stats AS
(
    SELECT d.doctor_id,
           d.doctor_name,
           COUNT(*) AS total_appointments
    FROM Doctors d
    JOIN Appointments a
    ON d.doctor_id = a.doctor_id
    GROUP BY d.doctor_id, d.doctor_name
),
doctor_rank AS
(
    SELECT *,
           DENSE_RANK() OVER(
               ORDER BY total_appointments DESC
           ) rnk
    FROM doctor_stats
)
SELECT *
FROM doctor_rank
WHERE rnk <= 3;


-- USING SUBQUERY
-- 48. Patients older than average age
SELECT *
FROM Patients
WHERE age >
(
    SELECT AVG(age)
    FROM Patients
);

-- 49. Bill amount greater than average 
SELECT *
FROM Bills
WHERE amount >
(
    SELECT AVG(amount)
    FROM Bills
);

-- 50. Highest bill amount
 SELECT *
FROM Bills
WHERE amount =
(
    SELECT MAX(amount)
    FROM Bills
);

-- 51. Doctor with highest salary
SELECT *
FROM Doctors
WHERE salary =
(
    SELECT MAX(salary)
    FROM Doctors
);

-- 52. Second highest bill amount
SELECT *
FROM Bills
WHERE amount =
(
    SELECT MAX(amount)
    FROM Bills
    WHERE amount <
    (
        SELECT MAX(amount)
        FROM Bills
    )
);

-- 53. Doctors above average appointments
SELECT doctor_id,
       COUNT(*) total_appointments
FROM Appointments
GROUP BY doctor_id
HAVING COUNT(*) >
(
    SELECT AVG(total_appointments)
    FROM
    (
        SELECT doctor_id,
               COUNT(*) total_appointments
        FROM Appointments
        GROUP BY doctor_id
    ) x
);

-- 54. Patients above average total bill
SELECT patient_id,
       SUM(amount) total_bill
FROM Bills
GROUP BY patient_id
HAVING SUM(amount) >
(
    SELECT AVG(total_bill)
    FROM
    (
        SELECT patient_id,
               SUM(amount) total_bill
        FROM Bills
        GROUP BY patient_id
    ) x
);

-- 55. Departments above average doctor count
SELECT department_id,
       COUNT(*) total_doctors
FROM Doctors
GROUP BY department_id
HAVING COUNT(*) >
(
    SELECT AVG(total_doctors)
    FROM
    (
        SELECT department_id,
               COUNT(*) total_doctors
        FROM Doctors
        GROUP BY department_id
    ) x
);

-- 56. Patients with visits above average
SELECT patient_id,
       COUNT(*) visits
FROM Appointments
GROUP BY patient_id
HAVING COUNT(*) >
(
    SELECT AVG(visits)
    FROM
    (
        SELECT patient_id,
               COUNT(*) visits
        FROM Appointments
        GROUP BY patient_id
    ) x
);

-- 57. Doctors treating more patients than Cardiology doctors
SELECT doctor_id,
       COUNT(DISTINCT patient_id)
FROM Appointments
GROUP BY doctor_id
HAVING COUNT(DISTINCT patient_id) >
ALL
(
    SELECT COUNT(DISTINCT a.patient_id)
    FROM Appointments a
    JOIN Doctors d
    ON a.doctor_id = d.doctor_id
    WHERE d.department_id = 1
    GROUP BY d.doctor_id
);

-- UDING CTE
-- 58. Top 5 patients by bill
WITH patient_bill AS
(
    SELECT patient_id,
           SUM(amount) total_bill
    FROM Bills
    GROUP BY patient_id
)
SELECT *
FROM patient_bill
ORDER BY total_bill DESC
LIMIT 5;

-- 59. Top 3 doctors by appointments
WITH doctor_count AS
(
    SELECT doctor_id,
           COUNT(*) total_app
    FROM Appointments
    GROUP BY doctor_id
)
SELECT *
FROM doctor_count
ORDER BY total_app DESC
LIMIT 3;

-- 60. Patients with bills > 10000
WITH patient_bill AS
(
    SELECT patient_id,
           SUM(amount) total_bill
    FROM Bills
    GROUP BY patient_id
)
SELECT *
FROM patient_bill
WHERE total_bill > 10000;

-- 61. Department-wise doctor count
WITH dept_count AS
(
    SELECT department_id,
           COUNT(*) total_doctors
    FROM Doctors
    GROUP BY department_id
)
SELECT *
FROM dept_count;

-- 62. Patients and total bill
WITH patient_bill AS
(
    SELECT patient_id,
           SUM(amount) total_bill
    FROM Bills
    GROUP BY patient_id
)
SELECT *
FROM patient_bill;

-- 63. Doctors with more than 20 appointments
WITH doctor_count AS
(
    SELECT doctor_id,
           COUNT(*) total_app
    FROM Appointments
    GROUP BY doctor_id
)
SELECT *
FROM doctor_count
WHERE total_app > 20;

-- 64. Department with highest revenue
WITH dept_rev AS
(
    SELECT department_id,
           SUM(amount) revenue
    FROM Bills
    GROUP BY department_id
)
SELECT *
FROM dept_rev
ORDER BY revenue DESC
LIMIT 1;

-- 65. Top revenue patient
WITH patient_rev AS
(
    SELECT patient_id,
           SUM(amount) revenue
    FROM Bills
    GROUP BY patient_id
)
SELECT *
FROM patient_rev
ORDER BY revenue DESC
LIMIT 1;

-- 66. Doctors above average appointments
WITH doctor_count AS
(
    SELECT doctor_id,
           COUNT(*) total_app
    FROM Appointments
    GROUP BY doctor_id
)
SELECT *
FROM doctor_count
WHERE total_app >
(
    SELECT AVG(total_app)
    FROM doctor_count
);

-- 67. Patients above average admissions
WITH admission_count AS
(
    SELECT patient_id,
           COUNT(*) total_admissions
    FROM Admissions
    GROUP BY patient_id
)
SELECT *
FROM admission_count
WHERE total_admissions >
(
    SELECT AVG(total_admissions)
    FROM admission_count
);

-- WINDOW FUNCTION
-- 68. Latest appointment per patient
WITH x AS
(
    SELECT *,
           ROW_NUMBER() OVER(
           PARTITION BY patient_id
           ORDER BY appointment_date DESC
           ) rn
    FROM Appointments
)
SELECT *
FROM x
WHERE rn = 1;

-- 69. First appointment per patient
WITH x AS
(
    SELECT *,
           ROW_NUMBER() OVER(
           PARTITION BY patient_id
           ORDER BY appointment_date ASC
           ) rn
    FROM Appointments
)
SELECT *
FROM x
WHERE rn = 1;

-- 70. Latest treatment per patient
WITH x AS
(
    SELECT *,
           ROW_NUMBER() OVER(
           PARTITION BY patient_id
           ORDER BY treatment_date DESC
           ) rn
    FROM Treatments
)
SELECT *
FROM x
WHERE rn = 1;

-- 71. Rank doctors by appointment count
WITH doctor_count AS
(
    SELECT doctor_id,
           COUNT(*) total_app
    FROM Appointments
    GROUP BY doctor_id
)
SELECT *,
       RANK() OVER(
       ORDER BY total_app DESC
       ) rnk
FROM doctor_count;

-- 72. Rank patients by total bill
WITH patient_bill AS
(
    SELECT patient_id,
           SUM(amount) total_bill
    FROM Bills
    GROUP BY patient_id
)
SELECT *,
       RANK() OVER(
       ORDER BY total_bill DESC
       ) rnk
FROM patient_bill;

-- 73. Rank departments by revenue
WITH dept_rev AS
(
    SELECT de.department_id,
           SUM(b.amount) AS revenue
    FROM Bills b
    join patients as p
    on p.patient_id=b.patient_id
    JOIN Appointments a
        ON p.patient_id = a.patient_id
     JOIN Doctors d
        ON a.doctor_id = d.doctor_id
    join departments as de
    on de.department_id=d.department_id
    GROUP BY de.department_id
)
SELECT *,
       RANK() OVER(
           ORDER BY revenue DESC
       ) AS rnk
FROM dept_rev;

-- 74. Top 3 doctors using DENSE_RANK
WITH doctor_count AS
(
    SELECT doctor_id,
           COUNT(*) total_app
    FROM Appointments
    GROUP BY doctor_id
),
doctor_rank AS
(
    SELECT *,
           DENSE_RANK() OVER(
           ORDER BY total_app DESC
           ) rnk
    FROM doctor_count
)
SELECT *
FROM doctor_rank
WHERE rnk <= 3;

-- 75. Second highest bill
WITH bill_rank AS
(
    SELECT *,
           DENSE_RANK() OVER(
           ORDER BY amount DESC
           ) rnk
    FROM Bills
)
SELECT *
FROM bill_rank
WHERE rnk = 2;

-- 76. Third highest bill
WITH bill_rank AS
(
    SELECT *,
           DENSE_RANK() OVER(
           ORDER BY amount DESC
           ) rnk
    FROM Bills
)
SELECT *
FROM bill_rank
WHERE rnk = 3;

-- 77. Top 5 patients by bill
WITH patient_bill AS
(
    SELECT patient_id,
           SUM(amount) total_bill
    FROM Bills
    GROUP BY patient_id
),
patient_rank AS
(
    SELECT *,
           DENSE_RANK() OVER(
           ORDER BY total_bill DESC
           ) rnk
    FROM patient_bill
)
SELECT *
FROM patient_rank
WHERE rnk <= 5;

-- USING PARTITION BY

-- 78. Find the latest appointment for each patient
with patient_app as (
select *, 
row_number() over ( partition by patient_id order by appointment_date desc)rnk 
from appointments )
select *
from patient_app 
where rnk= 1;

-- 79. Find the highest bill for each patient
WITH patient_bill AS
(
    SELECT *,
           RANK() OVER(
               PARTITION BY patient_id
               ORDER BY amount DESC
           ) rnk
    FROM Bills
)
SELECT *
FROM patient_bill
WHERE rnk = 1;

-- 80. Find the highest revenue doctor in each department
WITH doctor_rev AS
(
    SELECT de.department_id,
           d.doctor_id,
           d.doctor_name,
           SUM(b.amount) AS revenue
    FROM Doctors d
    join departments as de
    on de.department_id=d.department_id
    JOIN Appointments a
        ON d.doctor_id = a.doctor_id
        join patients as p
        on p.patient_id=a.patient_id
    JOIN Bills b
        ON b.patient_id=p.patient_id
    GROUP BY de.department_id,
             d.doctor_id,
             d.doctor_name
),
doctor_rank AS
(
    SELECT *,
           DENSE_RANK() OVER(
               PARTITION BY department_id
               ORDER BY revenue DESC
           ) rnk
    FROM doctor_rev
)
SELECT *
FROM doctor_rank
WHERE rnk = 1;

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

-- 92. Transfer a patient from ICU to Private using transaction
start transaction ;
update rooms
set room_type = "Private"
where room_id = 1;
commit ;

-- 93. Update patient gender and age using SAVEPOINT start transaction ;
start transaction ;
update patients
set age = 22 ;
savepoint sp1 ;
update patients
set gender = "Female"
where patient_id = 1;
rollback to sp1;