-- CREATE DATABASE

create database HospitalManagement

use HospitalManagement

-- CREATE DEPARTMNET TABLE. PARENT TABLE

CREATE TABLE Departments 
(
Departmentid int IDENTITY(1,1) PRIMARY KEY, 
Name nvarchar(50) NOT NULL
)

-- CREATE DOCTORS TABLE. CHILD TABLE. PARENT TABLE(Appointmnet)

CREATE TABLE Doctors
(
Doctorid int IDENTITY(1,1) PRIMARY KEY,
Name nvarchar(50) NOT NULL,
Specialization nvarchar(100) NOT NULL,
Role nvarchar(50),
Departmentid int,
FOREIGN KEY(Departmentid) REFERENCES Departments(Departmentid)   -- REFERENCIAL INTEGRITY
)

-- CREATE TABLE PATIENTS. PARENT TABLE(Appointmnet)

CREATE TABLE Patients
(
Patientid int IDENTITY(1,1) PRIMARY KEY,
Name nvarchar(50) NOT NULL,
Dateofbirth DATE,
Gender varchar(1) CHECK (Gender in ('m', 'f', 'o')),
Phoneno nvarchar(15),
)

-- CREATE TABLE APPOINTMENT. PARENT TABLE(Prescriptions). PARENT TABLE(Bills). PARENT TABLE(LABREPORT)

CREATE TABLE Appointmnets
(
Appointmnetid int IDENTITY(1,1) PRIMARY KEY,
Patientid int,
Doctorid int,
Appointmenttime DATETIME,
Status varchar(50) NOT NULL 
	CHECK(Status in ('Scheduled', 'Completed', 'Cancelled'))
	FOREIGN KEY(Patientid) REFERENCES Patients(Patientid),
	FOREIGN KEY(Doctorid) REFERENCES Doctors(Doctorid),
)

-- PRESCRIPTIONS TABLE. CHILD TABLE

CREATE TABLE Prescriptions
(
Prescription int IDENTITY(1,1) PRIMARY KEY,
Appointmentid int,
Medication nvarchar(100),
Dosage nvarchar(100),
FOREIGN KEY(Appointmentid) REFERENCES Appointmnets(Appointmnetid)
)

-- BILL TABLE. CHILD TABLE(Appointmnets)

CREATE TABLE Bills
(
Billid INT IDENTITY(1,1) PRIMARY KEY,
Appointmentid INT,
Amount DECIMAL(10,2),
Paid TINYINT,
Billdate DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(Appointmentid) REFERENCES Appointmnets(Appointmnetid)
)

-- LABREPORT TABLE. CHILD TABLE(Appointmnets)

CREATE TABLE Laberport
(
Reportid INT IDENTITY(1,1) PRIMARY KEY,
Appointmentid INT,
Reportdata TEXT,
CREATEDAT DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(Appointmentid) REFERENCES Appointmnets(Appointmnetid)
)

-- INSERTION IN DATA-BASE

select * 
from hospital_data

select hospital_data.Departments_DepartmentID  
from hospital_data

-- INSERTING VALUE INTO DEPARTMENTS.
-- Meta data of your all table.

SELECT CONCAT('select',' ',STRING_AGG(COLUMN_NAME, ', '),' ','from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
	  TABLE_SCHEMA  = 'dbo' AND								--schema name
	  TABLE_CATALOG = 'HospitalManagement' AND              --database base name 
	  TABLE_NAME    = 'hospital_data' AND                   --table name 
	  COLUMN_NAME LIKE 'Departments_%'                      --column name

SET IDENTITY_INSERT Departments ON;
INSERT into Departments(Departmentid, Name)
select Departments_DepartmentID, Departments_Name 
from hospital_data
where Departments_DepartmentID <> '';
SET IDENTITY_INSERT Departments OFF;

SELECT * FROM Departments

-- INSERTING VALUE INTO DOCTORS.

SELECT CONCAT('select',' ',STRING_AGG(COLUMN_NAME, ', '),' ','from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
	  TABLE_SCHEMA  = 'dbo' AND								
	  TABLE_CATALOG = 'HospitalManagement' AND              
	  TABLE_NAME    = 'hospital_data' AND                 
	  COLUMN_NAME LIKE 'Doctors_%' 

SET IDENTITY_INSERT Doctors ON;
INSERT into Doctors(Doctorid, Name, Specialization, Role, Departmentid)
select Doctors_DoctorID, Doctors_Name, Doctors_Specialization, Doctors_Role, Doctors_DepartmentID 
from hospital_data
where Doctors_DepartmentID <> '';
SET IDENTITY_INSERT Doctors OFF;

SELECT * FROM Doctors
	  
-- INSERTING VALUE INTO PATIENTS

SELECT CONCAT('select',' ',STRING_AGG(COLUMN_NAME, ', '),' ','from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
	  TABLE_SCHEMA  = 'dbo' AND								
	  TABLE_CATALOG = 'HospitalManagement' AND              
	  TABLE_NAME    = 'hospital_data' AND                 
	  COLUMN_NAME LIKE 'Patients_%' 

SET IDENTITY_INSERT Patients ON;
INSERT into Patients(Patientid, Name, Dateofbirth, Gender, Phoneno)
select Patients_PatientID, Patients_Name, Patients_DateOfBirth, Patients_Gender, Patients_Phone 
from hospital_data
where Patients_PatientID <> '';
SET IDENTITY_INSERT Patients OFF;

SELECT * FROM Patients

-- INSERTING VALUE INTO APPOINTMENTS

SELECT CONCAT('select',' ',STRING_AGG(COLUMN_NAME, ', '),' ','from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
	  TABLE_SCHEMA  = 'dbo' AND								
	  TABLE_CATALOG = 'HospitalManagement' AND              
	  TABLE_NAME    = 'hospital_data' AND                 
	  COLUMN_NAME LIKE 'Appointments_%' 

SET IDENTITY_INSERT Appointmnets ON;
INSERT into Appointmnets(Appointmnetid, Patientid, Doctorid, Appointmenttime, Status)
select Appointments_AppointmentID, Appointments_PatientID, Appointments_DoctorID, Appointments_AppointmentTime, Appointments_Status 
from hospital_data
where Appointments_AppointmentID <> '';
SET IDENTITY_INSERT Appointmnets OFF;

SELECT * FROM Appointmnets

-- INSERTING VALUE INTO PRESCRIPTIONS

SELECT CONCAT('select',' ',STRING_AGG(COLUMN_NAME, ', '),' ','from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
	  TABLE_SCHEMA  = 'dbo' AND								
	  TABLE_CATALOG = 'HospitalManagement' AND              
	  TABLE_NAME    = 'hospital_data' AND                 
	  COLUMN_NAME LIKE 'Prescriptions_%' 

SET IDENTITY_INSERT Prescriptions ON;
INSERT into Prescriptions(Prescription, Appointmentid, Medication, Dosage)
select Prescriptions_PrescriptionID, Prescriptions_AppointmentID, Prescriptions_Medication, Prescriptions_Dosage 
from hospital_data
where Prescriptions_PrescriptionID <> '';
SET IDENTITY_INSERT Prescriptions OFF;


select * from Prescriptions

-- INSERTING INTO BILLS

SELECT CONCAT('select',' ',STRING_AGG(COLUMN_NAME, ', '),' ','from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
	  TABLE_SCHEMA  = 'dbo' AND								
	  TABLE_CATALOG = 'HospitalManagement' AND              
	  TABLE_NAME    = 'hospital_data' AND                 
	  COLUMN_NAME LIKE 'Bills_%' 

SET IDENTITY_INSERT Bills ON;
INSERT into Bills(Billid, Appointmentid, Amount, Paid, Billdate)
select Bills_BillID, Bills_AppointmentID, Bills_Amount, Bills_Paid, Bills_BillDate 
from hospital_data
where Bills_BillID <> '';
SET IDENTITY_INSERT Bills OFF;


select * from Bills


-- Same Doctor at same time.

CREATE TRIGGER trg_CheckNewAppointment
ON Appointmnets
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON

	-- APPOINTMENT CANNOT BE IN THE PAST

	IF EXISTS(SELECT 1 FROM inserted WHERE Appointmenttime< GETDATE())
	BEGIN
		ROLLBACK TRANSACTION;
		THROW 50001, 'ERROR: APPOINTMENT CANNOT BE IN THE PAST', 1;
	END
	
	-- DOCTOR CANNOT BE DOUBLE BOOKED AT SAME TIME

	IF EXISTS(
	SELECT 1
	FROM inserted AS i
	JOIN
	Appointmnets AS a
		ON a.Doctorid = i.Doctorid

		AND a.Appointmenttime = i.Appointmenttime
		AND  a.Appointmnetid <> i.Appointmnetid
		ANd a.Status = 'Scheduled'
	)
	BEGIN
        ROLLBACK TRANSACTION;
        THROW 50002, 'ERROR: DOCTOR ALREADY HAS AN APPOINTMENT AT THIS TIME', 1;
    END
END;

INSERT INTO Appointmnets (Patientid, Doctorid, Appointmenttime, Status)
VALUES (1, 1, '2026-12-15T10:00:00', 'Scheduled');

-- ERROR: DOCTOR ALREADY HAS AN APPOINTMENT AT THIS TIME
INSERT INTO Appointmnets (Patientid, Doctorid, Appointmenttime, Status)
VALUES (1, 1, '2026-12-15T10:00:00', 'Scheduled');

-- ERROR: APPOINTMENT CANNOT BE IN THE PAST
INSERT INTO Appointmnets (Patientid, Doctorid, Appointmenttime, Status)
VALUES (1, 1, '2026-10-15T10:00:00', 'Scheduled');


-- 
CREATE OR ALTER  PROCEDURE VIEW_DOCTORDATA(
	@INPUT_USERNAME VARCHAR(20),
	@INPUT_PASSWORD VARCHAR(100))

AS
BEGIN
	DECLARE @DOC_ROLE VARCHAR(100)
	DECLARE @DOC_DEPT INT
	DECLARE @DOC_ID INT

	-- check the credential of doctors.

	SELECT @DOC_ID =  doctor_id 
	FROM doctor_credentials
	WHERE user_name = @INPUT_USERNAME AND password = @INPUT_PASSWORD

	if @DOC_ID IS NULL
	BEGIN
		SELECT 'Invalid username and passowrd'  as Message
		return 
	END

	-- get role and department from doctor table

	SELECT  @DOC_ROLE = ROLE,
			@DOC_DEPT = Departmentid

	FROM Doctors
	WHERE Doctorid = @DOC_ID

	-- show appropiate patient data

	if @DOC_ROLE = 'Senior'
	BEGIN
		select d.Doctorid, p.Patientid, p.Name, p.Gender, a.Appointmenttime, pre.Medication, l.Reportdata
		from Patients as p 
		inner join Appointmnets as a on a.Patientid = p.Patientid
		inner join Doctors as d on d.Doctorid = a.Doctorid
		left join Prescriptions as pre on a.Appointmnetid = pre.Appointmentid
		left join LABREPORT as l on a.Appointmnetid = l.Appointmentid
		where
			d.Departmentid = @DOC_DEPT
	END
	else
	BEGIN
		select a.Doctorid, p.Patientid, p.Name, p.Gender, a.Appointmenttime, pre.Medication, l.Reportdata
		from Patients as p 
		inner join Appointmnets as a on a.Patientid = p.Patientid
		left join Prescriptions as pre on a.Appointmnetid = pre.Appointmentid
		left join LABREPORT as l on 
		a.Appointmnetid = l.Appointmentid
		where
			a.Doctorid = @DOC_ID
	END
END

-- Senoir doctor
EXEC VIEW_DOCTORDATA 'doctor4',	'ic0pFSn0';

-- not senior
EXEC VIEW_DOCTORDATA 'doctor1',	'W3jzIANG';
--EXEC VIEW_DOCTORDATA @INPUT_USERNAME  = 'doctor1', @INPUT_PASSWORD =  'W3jzIANG'


select * from Doctors where Doctorid=4

select * from doctor_credentials

SELECT * FROM Appointmnets WHERE Doctorid = 1;

-- POINT 6

CREATE PROCEDURE SP_MONTHLYREVENUE
(
	@YEAR INT, @MONTH INT
)
AS
BEGIN
	SELECT dp.Name as Department, 
	SUM(b.Amount) as [TOTAL REVENUE] FROM Bills AS b
	INNER JOIN Appointmnets AS a ON a.Appointmnetid = b.Appointmentid
	INNER JOIN Doctors as d ON a.Doctorid = d.Doctorid
	INNER JOIN Departments as dp on dp.Departmentid = d.Departmentid
	WHERE MONTH(b.Billdate) = @MONTH AND YEAR(b.Billdate) = @YEAR
	GROUP BY dp.Name
END

EXEC SP_MONTHLYREVENUE 2024, 9

