-- Create a new database for Wellmeadows Hospital
CREATE DATABASE Wellmeadows_Hospital;
 
-- Use Wellmeadows Hospital database
USE Wellmeadows_Hospital;
 
-- Create Ward table
CREATE TABLE Ward (
WardID CHAR(4) PRIMARY KEY,
WardName VARCHAR(50) NOT NULL,
TotalBeds INT NOT NULL,
Gender CHAR(1) CHECK (Gender = 'M' OR Gender = 'F'),
TelExtNo VARCHAR(10)
);

-- Create Head_Nurse table
CREATE TABLE Head_Nurse (
HeadID CHAR(4) PRIMARY KEY,
FName VARCHAR(50) NOT NULL,
LName VARCHAR(50) NOT NULL,
TelExtNo VARCHAR(10),
Email VARCHAR(50) NOT NULL,
Salary INT NOT NULL,
AssignedWard CHAR(4) NOT NULL,
FOREIGN KEY (AssignedWard) REFERENCES Ward(WardID)
);
 
-- Create General_Nurse table
CREATE TABLE General_Nurse (
GeneralID CHAR(4) PRIMARY KEY,
FName VARCHAR(50) NOT NULL,
LName VARCHAR(50) NOT NULL,
TelExtNo VARCHAR(10),
Email VARCHAR(50) NOT NULL,
Salary INT NOT NULL,
AssignedWard CHAR(4) NOT NULL,
FOREIGN KEY (AssignedWard) REFERENCES Ward(WardID)
);
 
-- Create Patient table
CREATE TABLE Patient (
PatientID CHAR(4) PRIMARY KEY,
FName VARCHAR(50) NOT NULL,
LName VARCHAR(50) NOT NULL,
HouseNo VARCHAR(10) NOT NULL,
Street VARCHAR (50) NOT NULL,
Postcode CHAR(5) NOT NULL,
City VARCHAR (50) NOT NULL,
State VARCHAR(50) NOT NULL,
Country VARCHAR(20) NOT NULL,
TelNo VARCHAR(20) NOT NULL,
DOB DATE NOT NULL,
Gender CHAR(1) NOT NULL CHECK (Gender = 'M' OR Gender = 'F'),
MaritalStatus VARCHAR(20) NOT NULL CHECK (MaritalStatus = 'Married' OR MaritalStatus = 'Widowed'
OR MaritalStatus = 'Separated' OR MaritalStatus = 'Divorced'
OR MaritalStatus = 'Single'),
DateRegistered DATE NOT NULL
);
 
-- Create Next_Of_Kin table
CREATE TABLE Next_Of_Kin (
KinID CHAR(4) PRIMARY KEY,
FName VARCHAR(50) NOT NULL,
LName VARCHAR(50) NOT NULL,
Relationship VARCHAR(20) NOT NULL CHECK (Relationship = 'Parent' OR
Relationship = 'Sibling' OR
Relationship = 'Relative'),
TelNo VARCHAR(10) NOT NULL,
Patient CHAR(4) NOT NULL,
FOREIGN KEY (Patient) REFERENCES Patient(PatientID)
);
 
-- Create Out_Patient table
CREATE TABLE Out_Patient (
OutID CHAR(4) PRIMARY KEY,
Location VARCHAR(50) NOT NULL CHECK (Location = 'room 1' OR
Location = 'room 2' OR
Location = 'room 3')
);
 
-- Create In_Patient table
CREATE TABLE In_Patient (
InID CHAR(4) PRIMARY KEY,
DateStay DATE NOT NULL,
ExpectedDateLeave DATE NOT NULL,
ExpectedDuration AS (DATEDIFF(DAY, DateStay, ExpectedDateLeave)),
ActualDateLeave DATE,
ActualDuration AS (DATEDIFF(DAY, DateStay, ActualDateLeave)),
AssignedWard CHAR(4) NOT NULL,
FOREIGN KEY (AssignedWard) REFERENCES Ward(WardID)
);
 
-- Create Daily_Activity table
CREATE TABLE Daily_Activity (
ActivityID CHAR(5) PRIMARY KEY,
MedicineDosage INT NOT NULL,
Status VARCHAR(10) NOT NULL CHECK (Status = 'done' OR Status = 'not done'),
DateTime DATETIME,
Patient CHAR(4),
FOREIGN KEY (Patient) REFERENCES In_Patient(InID),
Nurse CHAR(4),
FOREIGN KEY (Nurse) REFERENCES General_Nurse(GeneralID)
);
 
-- CREATE Receptionist table
CREATE TABLE Receptionist (
ReceptionistID CHAR(4) PRIMARY KEY,
FName VARCHAR(50) NOT NULL,
LName VARCHAR(50) NOT NULL,
TelExtNo VARCHAR(10),
Email VARCHAR(50) NOT NULL,
Salary INT NOT NULL
);
 
-- Create Doctor table
CREATE TABLE Doctor (
DoctorID CHAR(4) PRIMARY KEY,
FName VARCHAR(50) NOT NULL,
LName VARCHAR(50) NOT NULL, 
Email VARCHAR(50) NOT NULL,
Specialty1 VARCHAR(50) NOT NULL,
Specialty2 VARCHAR(50),
Specialty3 VARCHAR(50),
TelExtNo VARCHAR(10),
Salary INT NOT NULL
);
 
-- Create Appointment table
CREATE TABLE Appointment (
AppointmentID CHAR(4) PRIMARY KEY,
DateTime DATETIME NOT NULL,
Patient CHAR(4) NOT NULL,
FOREIGN KEY (Patient) REFERENCES Patient(PatientID),
Recorded_by CHAR(4) NOT NULL,
FOREIGN KEY (Recorded_by) REFERENCES Receptionist(ReceptionistID),
Conducted_by CHAR(4) NOT NULL,
FOREIGN KEY (Conducted_by) REFERENCES Doctor(DoctorID),
Out_Patient CHAR(4),
FOREIGN KEY (Out_Patient) REFERENCES Out_Patient(OutID),
In_Patient CHAR(4),
FOREIGN KEY (In_Patient) REFERENCES In_Patient(InID)
);

-- Insert data into Ward table
INSERT INTO Ward VALUES ('W001', 'Dermatology', 15, 'M', 'Extn 7701');
INSERT INTO Ward VALUES ('W002', 'Dermatology', 15, 'F', 'Extn 7702');
INSERT INTO Ward VALUES ('W003', 'Cardiology', 15, 'M', 'Extn 7703');
INSERT INTO Ward VALUES ('W004', 'Cardiology', 15, 'F', 'Extn 7704');
INSERT INTO Ward VALUES ('W005', 'Endocrinology', 15, 'M', 'Extn 7705');
INSERT INTO Ward VALUES ('W006', 'Endocrinology', 15, 'F', 'Extn 7706');
INSERT INTO Ward VALUES ('W007', 'Gastroenterology', 15, 'M', 'Extn 7707');
INSERT INTO Ward VALUES ('W008', 'Gastroenterology', 15, 'F', 'Extn 7708');
INSERT INTO Ward VALUES ('W009', 'Nephrology', 15, 'M', 'Extn 7709');
INSERT INTO Ward VALUES ('W010', 'Nephrology', 15, 'F', 'Extn 7710');
INSERT INTO Ward VALUES ('W011', 'Pulmonology', 15, 'M', 'Extn 7711');
INSERT INTO Ward VALUES ('W012', 'Pulmonology', 15, 'F', 'Extn 7712');
INSERT INTO Ward VALUES ('W013', 'Radiology', 15, 'M', 'Extn 7713');
INSERT INTO Ward VALUES ('W014', 'Radiology', 15, 'F', 'Extn 7714');
INSERT INTO Ward VALUES ('W015', 'Orthopaedic', 15, 'M', 'Extn 7715');
INSERT INTO Ward VALUES ('W016', 'Orthopaedic', 15, 'F', 'Extn 7716');
INSERT INTO Ward VALUES ('W017', 'Out-patient Clinic', 0, NULL, 'Extn 7717');

-- Insert data into Head_Nurse table
INSERT INTO Head_Nurse VALUES ('H001','Jessica','Hill','0129547586','jessicahill@gmail.com',3500,'W001');
INSERT INTO Head_Nurse VALUES ('H002','Amanda','Lee','0145678965','amandalee@gmail.com',3200,'W002')
INSERT INTO Head_Nurse VALUES ('H003','Elizabeth','Oliver','0178567488','elizabetholiver@gmail.com',3300,'W003')
INSERT INTO Head_Nurse VALUES ('H004','Sofia','Ramsay','0123267489','sofiaramsay@gmail.com',3350,'W004')
INSERT INTO Head_Nurse VALUES ('H005','Emily','James','0185023867','emilyjames@gmail.com',3140,'W005')
INSERT INTO Head_Nurse VALUES ('H006','Zendaya','Holland','0109507709','zendayaholand@gmail.com',3200,'W006')
INSERT INTO Head_Nurse VALUES ('H007','Olivia','Dobrik','0178995678','oliviadobrik@gmail.com',3100,'W007')
INSERT INTO Head_Nurse VALUES ('H008','Charlotte','Siew','0112234567','charlottesiew@gmail.com',3400,'W008')
INSERT INTO Head_Nurse VALUES ('H009','Sophia','Jennings','0146228769','sophiajennings@gmail.com',3500,'W009')
INSERT INTO Head_Nurse VALUES ('H010','Amelia','Cooper','0199899902','ameliacooper@gmail.com',3370,'W010')
INSERT INTO Head_Nurse VALUES ('H011','Isabella','Davis','0138606589','isabelladavis@gmail.com',3390,'W011')
INSERT INTO Head_Nurse VALUES ('H012','Mia','Penn','0187688900','miapenn@gmail.com',3290,'W012')
INSERT INTO Head_Nurse VALUES ('H013','Evelyn','Walker','0168010879','evelynwalker@gmail.com',3400,'W013')
INSERT INTO Head_Nurse VALUES ('H014','Harper','Avery','0199232546','harperavery@gmail.com',3500,'W014')
INSERT INTO Head_Nurse VALUES ('H015','Camila','Cabello','0123543768','camilacabello@gmail.com',3500,'W015')
INSERT INTO Head_Nurse VALUES ('H016','Abigail','Griffin','0155289467','abigailgriffin@gmail.com',3450,'W016')
INSERT INTO Head_Nurse VALUES ('H017','Luna','Jones','0112308567','lunajones@gmail.com',3430,'W017')

-- Insert data into General_Nurse table
INSERT INTO General_Nurse VALUES ('G001','Tom','Holland','0194563206','tomholland@gmail.com',2800,'W001')
INSERT INTO General_Nurse VALUES ('G002','Tony','Stark','0129547586','tonystark@gmail.com',2850,'W002')
INSERT INTO General_Nurse VALUES ('G003','Thor','Odinson','0145678965','amandalee@gmail.com',2750,'W003')
INSERT INTO General_Nurse VALUES ('G004','Elizabeth','Olsen','0178567488','elizabetholiver@gmail.com',2700,'W004')
INSERT INTO General_Nurse VALUES ('G005','Scarlett','Johanson','0123267489','sofiaramsay@gmail.com',2680,'W005')
INSERT INTO General_Nurse VALUES ('G006','Billy','Eilish','0185023867','emilyjames@gmail.com',2700,'W006')
INSERT INTO General_Nurse VALUES ('G007','Peter','Parker','0109507709','zendayaholand@gmail.com',2830,'W007')
INSERT INTO General_Nurse VALUES ('G008','Olivia','Rodrigo','0129547586','oliviadobrik@gmail.com',2790,'W008')
INSERT INTO General_Nurse VALUES ('G009','Chloe','Siew','0145678965','charlottesiew@gmail.com',2800,'W009')
INSERT INTO General_Nurse VALUES ('G010','Clarissa','Low','0178567488','sophiajennings@gmail.com',2850,'W010')
INSERT INTO General_Nurse VALUES ('G011','Groot','Tree','0123267489','ameliacooper@gmail.com',2830,'W011')
INSERT INTO General_Nurse VALUES ('G012','Mark','Rober','0185023867','isabelladavis@gmail.com',2700,'W012')
INSERT INTO General_Nurse VALUES ('G013','Mannie','Mirza','0109507709','miapenn@gmail.com',2780,'W013')
INSERT INTO General_Nurse VALUES ('G014','Joe','Walker','0168816537','joewalker@gmail.com',2720,'W014')
INSERT INTO General_Nurse VALUES ('G015','Jason','Nash','0178995677','jasonnash@gmail.com',2690,'W015')
INSERT INTO General_Nurse VALUES ('G016','Corinna','Kopf','0178996588','corinnakopf@gmail.com',2780,'W016')
INSERT INTO General_Nurse VALUES ('G017','Natalina','Beck','0123769920','natalinabeck@gmail.com',2800,'W017')

-- Insert data into Patient table
INSERT INTO Patient VALUES ('P001','Adam','Hansar','1','Jalan Chearas','56000','Cheras','Wilayah Persekutuan','Malaysia','0123638635','2000-01-04','M','Single','2020-05-03');
INSERT INTO Patient VALUES ('P002','Mary','Elizabeth','A5','Jalan Kuala Putih','73000','Mukin Repah','Wilayah Persekutuan','Malaysia','0123638635','2010-11-19','F','Single','2021-04-21');
INSERT INTO Patient VALUES ('P003','Liz','Que','94','2/27 Jalan Udang','52000','Kuala Lumpur','Wilayah Persekutuan','Malaysia','0129374852','2000-10-04','M','Single','2020-05-03');
INSERT INTO Patient VALUES ('P004','Hoover','Tan','123','Jalan SS23/15 Taman SEA','47400','Petaling Jaya','Selangor','Malaysia','0129374852','1999-04-02','M','Single','2020-05-03');
INSERT INTO Patient VALUES ('P005','Smith','Brown','57','Jalan Tuanku Abdul Rahman','50100','Kuala Lumpur','Wilayah Persekutuan','Malaysia','0129374852','1998-03-16','M','Single','2020-05-03');
INSERT INTO Patient VALUES ('P006','Joe','Perez','B12','Jalan Sungai Besi Bt 3/4','57100','Kuala Lumpur','Wilayah Persekutuan','Malaysia','0126589452','1990-11-03','M','Married','2021-01-15');
INSERT INTO Patient VALUES ('P007','George','Jim','3','Jalan SS2/53 SS2','47300','Petaling Jaya','Selangor','Malaysia','0121232584','1992-05-08','F','Married','2021-12-04');
INSERT INTO Patient VALUES ('P008','Kan','Kobolt','F9','Jalan Firma 2, Kawasan Perindustrian Tebrau','81100','Johor Bahru','Johor','Malaysia','0124565256','1995-03-19','M','Single','2021-08-04');
INSERT INTO Patient VALUES ('P009','Maxikan','Lee','22A','Jalan 2A/2B Taman Desa Bakti','68100','Kuala Lumpur','Wilayah Persekutuan','Malaysia','0121223512','1997-08-01','M','Married','2022-01-04');
INSERT INTO Patient VALUES ('P010','Apelio','Songo','43','309 Taman Ast','70200','Seremban','Negeri Sembilan','Malaysia','0125546854','1998-02-20','F','Single','2021-06-09');
INSERT INTO Patient VALUES ('P011','Ada','Maria','12','G 66 Jln Penrissen Batu 7 Pekan Batu 7 Kuching','93250','Kuching','Sarawak','Malaysia','0126585425','1990-12-14','F','Divorced','2021-07-12');
INSERT INTO Patient VALUES ('P012','Guerre','Roi','A9','Jalan Subang 7','47500','Petaling Jaya','Selangor','Malaysia','0129891234','1998-07-09','M','Married','2020-09-08');
INSERT INTO Patient VALUES ('P013','Laos','Lopez','A2','Jln Usj 9/5N Taman Seafield Jaya','47620','Petaling Jaya','Selangor','Malaysia','0129372342','1990-01-20','M','Single','2021-01-19');
INSERT INTO Patient VALUES ('P014','Daigo','Ling','93','Jalan Maharajalela','50150','Kuala Lumpur','Wilayah Persekutuan','Malaysia','0129837287','2000-09-01','F','Widowed','2020-10-01');
INSERT INTO Patient VALUES ('P015','Herma','Alfon','12','Jln Gurney 3','54000','Kuala Lumpur','Wilayah Persekutuan','Malaysia','0129384928','1999-01-20','M','Separated','2021-02-01');
INSERT INTO Patient VALUES ('P016','Ernest','Toh','93','Jalan Ros Merah 2/2 Taman Jaya','81100','Johor Bahru','Johor','Malaysia','0129384726','1998-12-09','M','Separated','2020-01-09');
INSERT INTO Patient VALUES ('P017','Quan','Choo','62','Subang Square E 08 3 Jln Ss 15/4E Ss15','47500','Petaling Jaya','Selangor','Malaysia','0122937483','1995-09-01','M','Widowed','2020-09-02');
INSERT INTO Patient VALUES ('P018','Pingi','Leong','A21','Jalan Harimau Tarum, Century Garden','80250','Johor Bahru','Johor','Malaysia','0129384789','2000-10-10','M','Single','2021-12-09');
INSERT INTO Patient VALUES ('P019','Coulin','Neon','B5','Jln Usj10/1B Taman Seafield Jaya','47620','Petaling Jaya','Selangor','Malaysia','0129283742','1995-04-19','M','Single','2022-01-20');
INSERT INTO Patient VALUES ('P020','Kanon','Ramen','92','G Menara Keck Seng 203 Jln Bukit Bintang','55100','Kuala Lumpur','Wilayah Persekutuan','Malaysia','0129384738','1994-09-10','M','Married','2021-07-01');

-- Insert data into Next_Of_Kin table
INSERT INTO Next_Of_Kin VALUES ('K001','Leon','Hansar','Parent','0129374852','P001');
INSERT INTO Next_Of_Kin VALUES ('K002','Edie','Elizabeth','Parent','0128293742','P002');
INSERT INTO Next_Of_Kin VALUES ('K003','Con','Que','Parent','0125648562','P003');
INSERT INTO Next_Of_Kin VALUES ('K004','Kanzen','Tan','Parent','0124581365','P004');
INSERT INTO Next_Of_Kin VALUES ('K005','Chandler','Brown','Relative','0123638635','P005');
INSERT INTO Next_Of_Kin VALUES ('K006','Joey','Perez','Parent','0122569132','P006');
INSERT INTO Next_Of_Kin VALUES ('K007','Oliver ','Jim','Parent','0127854987','P007');
INSERT INTO Next_Of_Kin VALUES ('K008','Kai','Kobolt','Relative','0128456588','P008');
INSERT INTO Next_Of_Kin VALUES ('K009','Cindy','Lee','Parent','0128887312','P009');
INSERT INTO Next_Of_Kin VALUES ('K010','Andrea','Songo','Parent','0128456521','P010');
INSERT INTO Next_Of_Kin VALUES ('K011','Hendikan','Maria','Sibling','0124817293','P011');
INSERT INTO Next_Of_Kin VALUES ('K012','Marry','Roi','Parent','0129983312','P012');
INSERT INTO Next_Of_Kin VALUES ('K013','Ashow','Lopez','Parent','0128192312','P013');
INSERT INTO Next_Of_Kin VALUES ('K014','Esteruf ','Ling','Sibling','0129384112','P014');
INSERT INTO Next_Of_Kin VALUES ('K015','Hermest','Alfon','Sibling','0129384754','P015');
INSERT INTO Next_Of_Kin VALUES ('K016','Monty','Toh','Sibling','0129384671','P016');
INSERT INTO Next_Of_Kin VALUES ('K017','Spade','Choo','Sibling','0129384918','P017');
INSERT INTO Next_Of_Kin VALUES ('K018','Tongol','Leong','Parent','0129384923','P018');
INSERT INTO Next_Of_Kin VALUES ('K019','Moulin','Neon','Relative','0129384925','P019');
INSERT INTO Next_Of_Kin VALUES ('K020','Nike','Ramen','Parent','0129384911','P020');

-- Insert data into Out_Patient table
INSERT INTO Out_Patient VALUES ('O001','room 1');
INSERT INTO Out_Patient VALUES ('O002','room 2');
INSERT INTO Out_Patient VALUES ('O003','room 3');
INSERT INTO Out_Patient VALUES ('O004','room 2');
INSERT INTO Out_Patient VALUES ('O005','room 3');
INSERT INTO Out_Patient VALUES ('O006','room 1');
INSERT INTO Out_Patient VALUES ('O007','room 1');
INSERT INTO Out_Patient VALUES ('O008','room 2');

-- Insert data into In_Patient table
INSERT INTO In_Patient VALUES ('I001','2022-01-01','2022-01-04','2022-01-04','W001');
INSERT INTO In_Patient VALUES ('I002','2022-01-02','2022-01-10','2022-01-14','W001');
INSERT INTO In_Patient VALUES ('I003','2022-01-02','2022-02-02',NULL,'W003');
INSERT INTO In_Patient VALUES ('I004','2022-01-03','2022-01-12','2022-01-15','W003');
INSERT INTO In_Patient VALUES ('I005','2022-01-03','2022-01-20','2022-01-27','W003');
INSERT INTO In_Patient VALUES ('I006','2022-01-03','2022-01-27','2022-01-25','W006');
INSERT INTO In_Patient VALUES ('I007','2022-01-04','2022-02-08',NULL,'W006');
INSERT INTO In_Patient VALUES ('I008','2022-01-04','2022-02-10','2022-02-12','W009');
INSERT INTO In_Patient VALUES ('I009','2022-01-05','2022-01-25','2022-01-20','W009');
INSERT INTO In_Patient VALUES ('I010','2022-01-05','2022-01-25',NULL,'W010');
INSERT INTO In_Patient VALUES ('I011','2022-01-06','2022-01-13',NULL,'W011');
INSERT INTO In_Patient VALUES ('I012','2022-01-06','2022-01-13','2022-01-10','W012');

-- Insert data into Daily_Activity table
INSERT INTO Daily_Activity VALUES ('DA001',200,'done','2022-01-01 13:12','I001','G001');
INSERT INTO Daily_Activity VALUES ('DA002',300,'done','2022-01-02 14:17','I002','G001');
INSERT INTO Daily_Activity VALUES ('DA003',250,'done','2022-01-02 14:22','I003','G003');
INSERT INTO Daily_Activity VALUES ('DA004',200,'done','2022-01-03 13:00','I004','G003');
INSERT INTO Daily_Activity VALUES ('DA005',300,'done','2022-01-03 15:36','I005','G003');
INSERT INTO Daily_Activity VALUES ('DA006',250,'done','2022-01-03 15:32','I006','G006');
INSERT INTO Daily_Activity VALUES ('DA007',230,'done','2022-01-04 12:42','I007','G006');
INSERT INTO Daily_Activity VALUES ('DA008',250,'done','2022-01-04 16:12','I008','G009');
INSERT INTO Daily_Activity VALUES ('DA009',300,'done','2022-01-05 15:32','I009','G009');
INSERT INTO Daily_Activity VALUES ('DA010',400,'done','2022-01-05 15:43','I010','G010');
INSERT INTO Daily_Activity VALUES ('DA011',250,'done','2022-01-06 09:32','I011','G011');
INSERT INTO Daily_Activity VALUES ('DA012',350,'done','2022-01-06 12:19','I012','G012');
INSERT INTO Daily_Activity VALUES ('DA013',200,'done','2022-01-02 13:12','I001','G001');
INSERT INTO Daily_Activity VALUES ('DA014',300,'done','2022-01-03 14:17','I002','G001');
INSERT INTO Daily_Activity VALUES ('DA015',250,'done','2022-01-03 14:22','I003','G003');
INSERT INTO Daily_Activity VALUES ('DA016',200,'done','2022-01-04 13:00','I004','G003');
INSERT INTO Daily_Activity VALUES ('DA017',300,'done','2022-01-04 15:36','I005','G003');
INSERT INTO Daily_Activity VALUES ('DA018',250,'done','2022-01-04 15:32','I006','G006');
INSERT INTO Daily_Activity VALUES ('DA019',230,'done','2022-01-05 12:42','I007','G006');
INSERT INTO Daily_Activity VALUES ('DA020',250,'done','2022-01-05 16:12','I008','G009');
INSERT INTO Daily_Activity VALUES ('DA021',300,'done','2022-01-06 15:32','I009','G009');
INSERT INTO Daily_Activity VALUES ('DA022',400,'done','2022-01-06 15:43','I010','G010');
INSERT INTO Daily_Activity VALUES ('DA023',250,'done','2022-01-07 09:32','I011','G011');
INSERT INTO Daily_Activity VALUES ('DA024',350,'not done',NULL,'I012','G012');
INSERT INTO Daily_Activity VALUES ('DA025',200,'not done',NULL,'I001','G001');
INSERT INTO Daily_Activity VALUES ('DA026',300,'not done',NULL,'I002','G001');
INSERT INTO Daily_Activity VALUES ('DA027',250,'not done',NULL,'I003','G003');
INSERT INTO Daily_Activity VALUES ('DA028',200,'not done',NULL,'I004','G003');
INSERT INTO Daily_Activity VALUES ('DA029',300,'not done',NULL,'I005','G003');
INSERT INTO Daily_Activity VALUES ('DA030',250,'not done',NULL,'I006','G006');
INSERT INTO Daily_Activity VALUES ('DA031',230,'not done',NULL,'I007','G006');
INSERT INTO Daily_Activity VALUES ('DA032',250,'not done',NULL,'I008','G009');
INSERT INTO Daily_Activity VALUES ('DA033',300,'not done',NULL,'I009','G009');
INSERT INTO Daily_Activity VALUES ('DA034',400,'not done',NULL,'I010','G010');
INSERT INTO Daily_Activity VALUES ('DA035',250,'not done',NULL,'I011','G011');
INSERT INTO Daily_Activity VALUES ('DA036',350,'not done',NULL,'I012','G012');

-- Insert data into Receptionist table
INSERT INTO Receptionist VALUES ('R001','James','Bond','Extn 7000','jamesbond@gmail.com',2500);
INSERT INTO Receptionist VALUES ('R002','Queen','Kong','Extn 7001','queenkong@gmail.com',2500);
INSERT INTO Receptionist VALUES ('R003','Ben','Eleven','Extn 7002','beneleven@gmail.com',2500);

-- Insert data into Doctor table
INSERT INTO Doctor VALUES ('D001','Davis','Sneezy','davis@gmail.com','Anesthesiology','Pediatrics',NULL,'Extn 1001',5000);
INSERT INTO Doctor VALUES ('D002','Mason','Nalty','mason@gmail.com','Dermatology','Ophthalmology',NULL,'Extn 1002',6000);
INSERT INTO Doctor VALUES ('D003','Zafar','Yakob','zafar@gmail.com','Radiology','Cardiology',NULL,'Extn 1003',6500);
INSERT INTO Doctor VALUES ('D004','Doc','Bash','doc@gmail.com','Neurology','Ophthalmology','Nephrology','Extn 1004',6300);
INSERT INTO Doctor VALUES ('D005','Klein','Ochoa','klein@gmail.com','Pathology','Clinical Pathology',NULL,'Extn 1005',7000);
INSERT INTO Doctor VALUES ('D006','Valdo','Usman','valdo@gmail.com','Pediatrics','Dermatology',NULL,'Extn 1016',5900);
INSERT INTO Doctor VALUES ('D007','Yakub','Smith','yakub@gmail.com','Psychiatry','Surgery','Cardiology','Extn 1017',6400);
INSERT INTO Doctor VALUES ('D008','Xiang','Ling','xiang@gmail.com','Pulmonology','Surgery','Radiology','Extn 1018',7200);
INSERT INTO Doctor VALUES ('D009','Mufasa','Shenzi','mufasa@gmail.com','Surgery','Ophthalmology','Gastroenterology','Extn 1019',6900);
INSERT INTO Doctor VALUES ('D010','Kovu','Timon','kovu@gmail.com','Endocrinology','Nephrology',NULL,'Extn 1010',5800);
INSERT INTO Doctor VALUES ('D011','Timon','Kiara','timon@gmail.com','Surgery','Gastroenterology',NULL,'Extn 1011',6450);
INSERT INTO Doctor VALUES ('D012','Simba','Kovu','simba@gmail.com','Surgery','Hematology','Nephrology','Extn 1012',7300);
INSERT INTO Doctor VALUES ('D013','Nala','Troff','nala@gmail.com','Endocrinology','Cardiology',NULL,'Extn 1013',7500);
INSERT INTO Doctor VALUES ('D014','White','Reily','white@gmail.com','Surgery','Orthopaedic','Gastroenterology','Extn 1014',6300);
INSERT INTO Doctor VALUES ('D015','Patel','Baker','patel@gmail.com','Surgery','Pediatrics','Pulmonology','Extn 1015',6900);
INSERT INTO Doctor VALUES ('D016','Shenzi','Dokio','shenzi@gmail.com','Surgery','Radiology',NULL,'Extn 1016',7000);
INSERT INTO Doctor VALUES ('D017','Tokyo','Palim','tokyo@gmail.com','Orthopaedic','Surgery',NULL,'Extn 1017',7200);

-- Insert data into Appointment table
INSERT INTO Appointment VALUES ('A001','2022-01-01 08:15','P001','R001','D002',NULL,'I001');
INSERT INTO Appointment VALUES ('A002','2022-01-02 14:39','P002','R002','D006',NULL,'I002');
INSERT INTO Appointment VALUES ('A003','2022-01-02 16:10','P003','R001','D003',NULL,'I003');
INSERT INTO Appointment VALUES ('A004','2022-01-03 20:48','P004','R003','D007',NULL,'I004');
INSERT INTO Appointment VALUES ('A005','2022-01-03 08:15','P005','R003','D013',NULL,'I005');
INSERT INTO Appointment VALUES ('A006','2022-01-03 10:08','P006','R003','D010',NULL,'I006');
INSERT INTO Appointment VALUES ('A007','2022-01-04 11:02','P007','R001','D013',NULL,'I007');
INSERT INTO Appointment VALUES ('A008','2022-01-04 13:18','P008','R001','D012',NULL,'I008');
INSERT INTO Appointment VALUES ('A009','2022-01-05 18:32','P009','R002','D010',NULL,'I009');
INSERT INTO Appointment VALUES ('A010','2022-01-05 09:38','P010','R003','D012',NULL,'I010');
INSERT INTO Appointment VALUES ('A011','2022-01-06 15:14','P011','R002','D008',NULL,'I011');
INSERT INTO Appointment VALUES ('A012','2022-01-06 21:38','P012','R003','D015',NULL,'I012');
INSERT INTO Appointment VALUES ('A013','2022-01-01 21:38','P013','R001','D007','O001', NULL);
INSERT INTO Appointment VALUES ('A014','2022-01-01 09:47','P014','R001','D001','O002', NULL);
INSERT INTO Appointment VALUES ('A015','2022-01-02 11:10','P015','R002','D004','O003', NULL);
INSERT INTO Appointment VALUES ('A016','2022-01-02 12:57','P016','R003','D005','O004', NULL);
INSERT INTO Appointment VALUES ('A017','2022-01-03 17:29','P017','R003','D009','O005', NULL);
INSERT INTO Appointment VALUES ('A018','2022-01-03 10:12','P018','R002','D011','O006', NULL);
INSERT INTO Appointment VALUES ('A019','2022-01-04 13:58','P019','R002','D014','O007', NULL);
INSERT INTO Appointment VALUES ('A020','2022-01-04 15:36','P020','R003','D017','O008', NULL);