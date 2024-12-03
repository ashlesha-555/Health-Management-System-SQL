CREATE DATABASE HealthManagement;
USE HealthManagement;

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    DateOfBirth DATE,
    Gender CHAR(1),
    Phone VARCHAR(15),
    LastVisit DATE
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialty VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Reason VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY,
    AppointmentID INT,
    Medication VARCHAR(255),
    Dosage VARCHAR(50),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

INSERT INTO Patients (PatientID, Name, DateOfBirth, Gender, Phone, LastVisit)
VALUES 
(1,'John Doe', '1980-05-15', 'M', '1234567890', '2023-05-20'),
(2,'Jane Smith', '1992-07-22', 'F', '0987654321', '2022-11-10'),
(3,'Alice Brown', '2000-01-15', 'F', '1122334455', '2023-06-18');

INSERT INTO Doctors (DoctorID, Name, Specialty, Phone)
VALUES 
(1,'Dr. Emily White', 'Cardiologist', '4445556666'),
(2,'Dr. Mark Green', 'Dermatologist', '7778889999'),
(3,'Dr. Sarah Blue', 'Pediatrician', '2223334444'),
(4, 'Dr. Bella Geller', 'Anesthesian','7778884441');

INSERT INTO Appointments (AppointmentID, PatientID, DoctorID, AppointmentDate, Reason)
VALUES
(101, 1, 1, '2023-05-20', 'Routine Check-up'),
(102, 2, 2, '2022-11-10', 'Skin Allergy'),
(103, 3, 3, '2023-06-18', 'Fever and Cough');

INSERT INTO Prescriptions (PrescriptionID, AppointmentID, Medication, Dosage)
VALUES
(1, 101, 'Atorvastatin', '10mg'),
(2, 102, 'Hydrocortisone', '15mg'),
(3, 103, 'Paracetamol', '500mg');


--List of All Appointments for a Specific Doctor
SELECT 
    A.AppointmentID,
    P.Name AS PatientName,
    A.AppointmentDate,
    A.Reason
FROM 
    Appointments A
JOIN 
    Patients P ON A.PatientID = P.PatientID
JOIN 
    Doctors D ON A.DoctorID = D.DoctorID
WHERE 
    D.Name = 'Dr. Emily White';


--Total Number of Appointments for Each Doctor
SELECT 
    D.Name AS DoctorName,
    COUNT(A.AppointmentID) AS TotalAppointments
FROM 
    Doctors D
LEFT JOIN 
    Appointments A ON D.DoctorID = A.DoctorID
GROUP BY 
    D.DoctorID, D.Name;

--All Prescriptions for a Specific Patient
SELECT 
    P.Name AS PatientName,
    Pr.Medication,
    Pr.Dosage
FROM 
    Prescriptions Pr
JOIN 
    Appointments A ON Pr.AppointmentID = A.AppointmentID
JOIN 
    Patients P ON A.PatientID = P.PatientID
WHERE 
    P.Name = 'John Doe';

--Most Common Reason for Appointments
SELECT 
    Reason, 
    COUNT(*) AS Frequency
FROM 
    Appointments
GROUP BY 
    Reason
ORDER BY 
    Frequency DESC
LIMIT 1;

