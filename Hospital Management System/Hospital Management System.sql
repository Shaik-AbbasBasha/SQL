CREATE DATABASE HospitalManagementSystem;

drop database HospitalManagementSystem;

USE HospitalManagementSystem;


CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    specialization VARCHAR(100),
    phone VARCHAR(15)
);


CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15)
);



-- CREATE TABLE appointments (
--     appointment_id INT PRIMARY KEY AUTO_INCREMENT,
--     patient_id INT,
--     doctor_id INT,
--     appointment_date DATE,
--     FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
--     FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
-- );



-- CREATE TABLE treatments (
--     treatment_id INT PRIMARY KEY AUTO_INCREMENT,
--     appointment_id INT,
--     diagnosis VARCHAR(255),
--     treatment_details VARCHAR(255),
--     FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
-- );



CREATE TABLE billing (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);



SELECT * FROM doctors;
SELECT * FROM patients;
SELECT * FROM appointments;
SELECT * FROM treatments;
SELECT * FROM billing;



#total amount is greater than 500
SELECT * 
FROM billing
WHERE total_amount > 500;



#Highest Bill with Patient & Status
SELECT 
    p.name AS patient_name,
    b.total_amount,
    b.payment_status
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
WHERE b.total_amount = (
    SELECT MAX(total_amount) FROM billing
);


#Patient with Doctor & Appointment
SELECT 
    p.name AS patient,
    d.name AS doctor,
    a.appointment_date
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;





# Patient Billing Details
SELECT 
    p.name,
    b.total_amount,
    b.payment_status
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id;



#Full Hospital Report
SELECT 
    p.name AS patient,
    d.name AS doctor,
    a.appointment_date,
    t.diagnosis,
    t.treatment_details,
    b.total_amount,
    b.payment_status
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN treatments t ON a.appointment_id = t.appointment_id
JOIN billing b ON p.patient_id = b.patient_id;


#(Patient + Payment Status)
SELECT 
    p.name AS patient,
    b.payment_status
FROM patients p
INNER JOIN billing b 
    ON p.patient_id = b.patient_id;