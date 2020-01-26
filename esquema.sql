CREATE DATABASE Hospital;

CREATE TABLE Patient (
    patientId int,
    firstName nvarchar(20),
    lastName nvarchar(20),
    age int,
    birthDate date,
    gender char,
    bloodType varchar(5),
    PRIMARY KEY (patientId)
);

CREATE TABLE Visits (
    visitId int,
    visitDate date,
    PRIMARY KEY (visitId)
);

CREATE TABLE Doctor (
    doctorId int,
    firstName nvarchar(20),
    lastName nvarchar(20),
    age int,
    PRIMARY KEY (doctorId)
);

CREATE TABLE Medicines (
    medicineId int,
    medicineName nvarchar(20),
    medicinePresentation nvarchar(20),
    PRIMARY KEY (medicineId)
);

CREATE TABLE Diseases (
    diseaseId int,
    diseaseName nvarchar(20),
    PRIMARY KEY (diseaseId)
);

CREATE TABLE Consultation (
    startDate date,
    endDate date,
    instructions varchar(50)
);