create Database HospitalDB;
use HospitalDB;

-- Create Tables
 CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id)
    REFERENCES Departments(department_id)
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    FOREIGN KEY (patient_id)
    REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id)
    REFERENCES Doctors(doctor_id)
);

CREATE TABLE Treatments (
    treatment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis VARCHAR(100),
    FOREIGN KEY (patient_id)
    REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id)
    REFERENCES Doctors(doctor_id)
);

CREATE TABLE Bills (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (patient_id)
    REFERENCES Patients(patient_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    bill_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY (bill_id)
    REFERENCES Bills(bill_id)
);

CREATE TABLE Nurses (
    nurse_id INT PRIMARY KEY,
    nurse_name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id)
    REFERENCES Departments(department_id)
);

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(50),
    floor_no INT
);

CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    room_id INT,
    FOREIGN KEY (patient_id)
    REFERENCES Patients(patient_id),
    FOREIGN KEY (room_id)
    REFERENCES Rooms(room_id)
);

CREATE TABLE Medicines (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    medicine_id INT,
    FOREIGN KEY (patient_id)
    REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id)
    REFERENCES Doctors(doctor_id),
    FOREIGN KEY (medicine_id)
    REFERENCES Medicines(medicine_id)
);

CREATE TABLE Lab_Tests (
    test_id INT PRIMARY KEY,
    patient_id INT,
    test_name VARCHAR(100),
    FOREIGN KEY (patient_id)
    REFERENCES Patients(patient_id)
);

CREATE TABLE Test_Results (
    result_id INT PRIMARY KEY,
    test_id INT,
    result VARCHAR(50),
    FOREIGN KEY (test_id)
    REFERENCES Lab_Tests(test_id)
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100),
    role VARCHAR(50)
);