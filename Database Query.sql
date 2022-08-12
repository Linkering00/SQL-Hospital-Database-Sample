-- User Authentication
-- Creating new users in server level
EXECUTE sp_addlogin @loginame = 'Yong', @passwd = 'Yong@123'
EXECUTE sp_addlogin @loginame = 'Chester', @passwd = 'Chester@123'
EXECUTE sp_addlogin @loginame = 'James', @passwd = 'j@mes123'
EXECUTE sp_addlogin @loginame = 'Saw', @passwd = 'Saw@123'
EXECUTE sp_addlogin @loginame = 'Chong', @passwd = 'Chong@123'

-- Adding users into database level
USE Wellmeadows_Hospital;
EXECUTE sp_adduser @loginame = 'Yong', @name_in_db = 'Yong'
EXECUTE sp_adduser @loginame = 'Chester', @name_in_db = 'Chester'
EXECUTE sp_adduser @loginame = 'James', @name_in_db = 'James' 
EXECUTE sp_adduser @loginame = 'Saw', @name_in_db = 'Saw'
EXECUTE sp_adduser @loginame = 'Chong', @name_in_db = 'Chong'

-- Creating roles
EXECUTE sp_addrole @rolename = 'Doctor'
EXECUTE sp_addrole @rolename = 'DatabaseAdministrator'
EXECUTE sp_addrole @rolename = 'Receptionist'
EXECUTE sp_addrole @rolename = 'Head_Nurse'
EXECUTE sp_addrole @rolename = 'General_Nurse'

-- Assign users to roles
EXECUTE sp_addrolemember @rolename = 'Doctor', @membername = 'Yong'
EXECUTE sp_addrolemember @rolename = 'DatabaseAdministrator', @membername = 'Chester'
EXECUTE sp_addrolemember @rolename = 'Receptionist' , @membername = 'James'
EXECUTE sp_addrolemember @rolename = 'Head_Nurse', @membername = 'Saw'
EXECUTE sp_addrolemember @rolename = 'General_Nurse', @membername = 'Chong'

-- Permission of Doctor
GRANT SELECT
ON Ward
TO Doctor

GRANT SELECT
ON Head_Nurse
TO Doctor

GRANT SELECT
ON General_Nurse
TO Doctor

GRANT SELECT
ON Patient
TO Doctor

GRANT SELECT
ON Next_Of_Kin
TO Doctor

GRANT SELECT
ON Out_Patient
TO Doctor

GRANT SELECT, UPDATE
ON In_Patient
TO Doctor

GRANT SELECT
ON Daily_Activity
TO Doctor

GRANT SELECT
ON Appointment
TO Doctor

-- Permission of Database Administrator
GRANT SELECT, INSERT, UPDATE, DELETE
ON Ward
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT, INSERT, UPDATE, DELETE
ON Head_Nurse
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT, INSERT, UPDATE, DELETE
ON General_Nurse
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT
ON Patient
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT
ON Next_Of_Kin
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT
ON Out_Patient
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT
ON In_Patient
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT
ON Daily_Activity
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT, INSERT, UPDATE, DELETE
ON Receptionist
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT, INSERT, UPDATE, DELETE
ON Doctor
TO DatabaseAdministrator
WITH GRANT OPTION

GRANT SELECT
ON Appointment
TO DatabaseAdministrator
WITH GRANT OPTION

-- Permission of Receptionist
GRANT SELECT
ON Ward
TO Receptionist

GRANT SELECT
ON Head_Nurse
TO Receptionist

GRANT SELECT
ON General_Nurse
TO Receptionist

GRANT SELECT, INSERT, UPDATE, DELETE
ON Patient
TO Receptionist

GRANT SELECT, INSERT, UPDATE, DELETE
ON Next_Of_Kin
TO Receptionist

GRANT SELECT, INSERT, UPDATE, DELETE
ON Out_Patient
TO Receptionist

GRANT SELECT, INSERT, UPDATE, DELETE
ON In_Patient
TO Receptionist

GRANT SELECT
ON Doctor
TO Receptionist

GRANT SELECT, INSERT, UPDATE, DELETE
ON Appointment
TO Receptionist

-- Permission of Head Nurse
GRANT SELECT
ON Ward
TO Head_Nurse

GRANT SELECT
ON General_Nurse
TO Head_Nurse

GRANT SELECT
ON Patient
TO Head_Nurse

GRANT SELECT
ON Next_Of_Kin
TO Head_Nurse

GRANT SELECT
ON Out_Patient
TO Head_Nurse

GRANT SELECT
ON In_Patient
TO Head_Nurse

GRANT SELECT, INSERT, UPDATE, DELETE
ON Daily_Activity
TO Head_Nurse

-- Permission of General Nurse
GRANT SELECT
ON Ward
TO General_Nurse

GRANT SELECT
ON Patient
TO General_Nurse

GRANT SELECT
ON Next_Of_Kin
TO General_Nurse

GRANT SELECT
ON Out_Patient
TO General_Nurse

GRANT SELECT
ON In_Patient
TO General_Nurse

GRANT SELECT, UPDATE(Status, DateTime)
ON Daily_Activity
TO General_Nurse

-- Logon Triggers
-- Prevent nurses to access the database after office hours
CREATE TRIGGER pre_acc_off
ON ALL SERVER
FOR LOGON
AS
BEGIN
	IF ((ORIGINAL_LOGIN() = 'Saw' OR ORIGINAL_LOGIN() = 'Chong') AND
		(DATEPART(HOUR, GETDATE()) < 8 OR DATEPART(HOUR, GETDATE()) >= 17))
	BEGIN
		ROLLBACK
	END
END

-- Prevent receptionist from having more than 5 sessions at a time
Create TRIGGER LimitMultipleConcurrentConnections
ON ALL SERVER 
FOR LOGON
AS
BEGIN
 IF ORIGINAL_LOGIN() = 'James' AND
  (SELECT COUNT(*) FROM   sys.dm_exec_sessions
   WHERE  Is_User_Process = 1 
    AND Original_Login_Name = 'James') > 5
 BEGIN
  PRINT 'You are not authorized to login, as you already have 5 active user sessions'
  ROLLBACK
 END
END

SELECT login_name ,COUNT(session_id) AS session_count   
FROM sys.dm_exec_sessions   
GROUP BY login_name;  

-- Record all logins
USE Wellmeadows_Hospital;
CREATE TABLE Login_Info (
Login_Name VARCHAR(256),
Login_Time DATETIME,
Host_Name VARCHAR(128),
SPID INT
);

GO
CREATE TRIGGER Login_Audit
ON ALL SERVER
FOR LOGON
AS
	BEGIN
		INSERT INTO Wellmeadows_Hospital.dbo.Login_Info
		SELECT ORIGINAL_LOGIN(), 
		GETDATE(), 
		EVENTDATA().value('(/EVENT_INSTANCE/ClientHost)[1]','VARCHAR(128)'), 
		@@SPID
	END;

GO
USE Master
GRANT CONTROL SERVER TO Yong
GRANT CONTROL SERVER TO Chester

SELECT *
FROM Wellmeadows_Hospital.dbo.Login_Info

-- DML Trigger
-- Track modification of patient data
-- Create Patient Audit Table
USE Wellmeadows_Hospital;
CREATE TABLE Patient_Audit (
PatientID CHAR(4),
FName VARCHAR(50),
LName VARCHAR(50),
HouseNo VARCHAR(10),
Street VARCHAR (50),
Postcode CHAR(5),
City VARCHAR (50),
State VARCHAR(50),
Country VARCHAR(20),
TelNo VARCHAR(20),
DOB DATE,
Gender CHAR(1),
MaritalStatus VARCHAR(20),
DateRegistered DATE,
ChangedDateTime DATETIME,
ChangedUser VARCHAR (256),
ChangedType CHAR(1)
);

-- Create Patient Audit trigger
GO
CREATE TRIGGER Patient_Audit_Trigger
ON Patient
AFTER INSERT, DELETE, UPDATE
AS

INSERT INTO Patient_Audit
SELECT PatientID, FName, LName, HouseNo,Street, Postcode,
City, State, Country, TelNo, DOB, Gender, MaritalStatus,
DateRegistered, GETDATE(), SYSTEM_USER, 'I'
FROM inserted

INSERT INTO Patient_Audit
SELECT PatientID, FName, LName, HouseNo,Street, Postcode,
City, State, Country, TelNo, DOB, Gender, MaritalStatus,
DateRegistered, GETDATE(), SYSTEM_USER, 'D'
FROM deleted

-- Insert Testing
INSERT INTO Patient 
VALUES ('P021','Adam','Hansar','1','Jalan Chearas','56000','Cheras','Wilayah Persekutuan',
'Malaysia','0123638635','2000-01-04','M','Single','2020-05-03');

SELECT * FROM Patient
SELECT * FROM Patient_Audit

SELECT PatientID, ChangedDateTime, ChangedUser, ChangedType
FROM Patient_Audit

-- Delete Testing
DELETE FROM Patient
WHERE PatientID = 'P021'
 
SELECT * FROM Patient
SELECT PatientID, ChangedDateTime, ChangedUser, ChangedType
FROM Patient_Audit

-- Update Testing
UPDATE Patient
SET FName = 'Khai'
WHERE PatientID = 'P021'

SELECT * FROM Patient
SELECT PatientID, ChangedDateTime, ChangedUser, ChangedType
FROM Patient_Audit

-- Precent deletion of Ward table
GO
CREATE TRIGGER Ward_Delete
ON Ward
INSTEAD OF DELETE
AS
BEGIN
	select * from deleted
	RAISERROR('Ward cannot be deleted', 16,10);
END

DELETE FROM Ward
WHERE WardID = 'W001'

SELECT * FROM Ward
GO

-- Prevent the deletion of Ward table
GO
CREATE TRIGGER Ward_Delete
ON Ward
INSTEAD OF DELETE
AS
BEGIN
	select * from deleted
	RAISERROR('Ward cannot be deleted', 16,10);
END

-- Testing
DELETE FROM Ward
WHERE WardID = 'W001'

SELECT * FROM Ward
GO