# SQL-Hospital-Database-Sample
## Introduction
This GitHub repository contains code samples that demonstrate the features available in Microsoft SQL. Furthermore, the purpose of this GitHub repository is to create a database that meets the privacy and security of the information stored in Wellmeadows Hospital.

## Table of Content
- How to use it
- Business and Data Requirements
- Data Dictionary
- Explanation of the query in Databases Query

## How to use it
In this project, the developer uses Microsoft SQL Server Management Studio 2018 to design and manage the database. Download the query file and open it using SQL Server Management Studio to run it. There are two query files which are **[Databases and Tables]** which consists of the query for the database design and **[Databases Query]** which consists of the query to perform actions mentioned in the Database Auditing Objectives section.

## Business and Data Requirements
Firstly, the data requirement of the Wellmeadows Hospital will be proposed to the developer.

### Wards
The Wellmeadows Hospital has 17 wards including an out-patient clinic with a total of 240 beds available. Each ward is uniquely identified by a number (for example, ward 11) and also a ward name (for example, Orthopaedic), total number of beds (the out-patient clinic has no beds), whether it is for females or males, and telephone extension number (example, Extn 7711).

### Nurse
Every ward has a head nurse and general nurse/trainee nurse. Only one head nurse is assigned for each ward who can update the daily activities (daily medicine dosage and special care) of patients. General nurse/trainee nurse can only view the activities assigned to them and update status along with the date and time.

### Patients
When a patient is first referred to the hospital, he or she is allocated a unique patient number. At this time, additional details of the patient are also recorded including the name (first and last name), address, telephone number, date of birth, gender, marital status, date registered with the hospital, and the details of the patient’s next of kin (name, relationship, telephone number).

### Patient Appointments
When a patient is first referred to Wellmeadows, he or she is given an appointment either through phone or by visiting hospital for an examination by a hospital doctor. Each appointment is given a unique appointment number. The details of each patient’s appointment are recorded by receptionist and include the name and staff number of the doctor undertaking the examination, and the date and time of the appointment. As a result of the examination, the patient is recommended to either attend the out-patient clinic or is assigned to a bed in an appropriate ward. (Assume that there is always such a bed available.)

### Out-patients
The details of out-patients are stored and include the patient number, name (first and last name), address, telephone number, date of birth, gender, and the date, time, and location of the appointment at the out-patient clinic.

### In-patients
The details of patients who are admitted to a ward are recorded. These details include the patient number, name (first and last name), address, telephone number, date of birth, gender, marital status, the details of the patient’s next-of-kin, the ward assigned, the expected duration of stay in days, date stay began, date expected to leave the ward, and the actual date the patient left the ward, when known.

### Doctors
The details of each of the doctors working at Wellmeadows are recorded. They include the doctor’s full name, staff number, the doctor’s specialty or specialties and the doctor’s telephone extension. The appointment schedule is recorded for each doctor including time, date, location, and patient name.

## Business Rules and Assumption
After understanding the business and data requirements, the developer listed down the business rules and assumptions for the implementation and design of the database. In short, this section simplified the business and data requirements proposed to allow the developer has a deeper understanding of the rules and constraints when designing the database.

1. Wellmeadows Hospital contains 17 wards with 240 beds and an out-patient clinic.
2. Each ward must have one head nurse and several general nurses.
3. Each head nurse and general nurse can only be assigned to one ward.
4. Head nurse can update the daily activities, but the general nurse can only view the daily activities assigned to them and update the status with date and time.
5. Each general nurse can conduct many daily activities, and each in-patient can be treated with many daily activities.
6. Each daily activity can only be conducted by one general nurse on one in-patient.
7. Only the receptionist can record the patients’ details and patients’ appointments.
8. Each patient can have many next of kins, whereas each next of kin can only be related to one patient.
9. Each patient can attend many appointments, whereas each appointment can only be attended by one patient.
10. Each doctor can conduct many appointments, whereas each appointment can only be conducted by one doctor.
11. After conducting the appointment, the doctor can update the result of the appointment showing whether the patient is an out-patient or an in-patient.
12. Each in-patient can be assigned to only one ward, whereas one ward can have many in-patients.
13. The database administrators can access all the tables in the database, but they cannot insert, modify, or delete the data of patients, next of kins, out-patients, in-patients, daily activities, and appointments.

## Data Dictionary
Generally speaking, a data dictionary is a centralized repository of metadata. In this section, the developer will demonstrate the name, data type, length, constraint as well as the description for each column of data presented in the database. 
<br >

### Ward Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
WardId | CHAR | 4 | PRIMARY KEY | ID of ward |
WardName | VARCHAR | 50 | NOT NULL | Name of ward |
TotalBeds | INT | - | NOT NULL | Number of beds in the ward |
Gender | CHAR | 1 | CHECK | Gender for the ward |
TelExtNo | VARCHAR | 10 | - | Telephone extension number of the ward |

### Head_Nurse Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
HeadID | CHAR | 4 | PRIMARY KEY | ID of head nurse |
FName | VARCHAR | 50 | NOT NULL | First name of head nurse |
LName | VARCHAR | 50 | NOT NULL | Last name of head nurse |
TelExtNo | VARCHAR | 10 | - | Telephone extension number of head nuse |
Email | VARCHAR | 50 | NOT NULL | Email of head nurse |
Salary | INT | - | NOT NULL | Salary of head nurse |
AssignedWard | CHAR | 4 | NOT NULL | FOREIGN KEY | ID of ward |

### General_Nurse Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
GeneralID | CHAR | 4 | PRIMARY KEY | ID of general nurse |
FName | VARCHAR | 50 | NOT NULL | First name of general nurse |
LName | VARCHAR | 50 | NOT NULL | Last name of general nurse |
TelExtNo | VARCHAR | 10 | - | Telephone extension number of general nurse |
Email | VARCHAR | 50 | NOT NULL | Email of general nurse |
Salary | INT | - | NOT NULL | Salary of general nurse |
AssignedWard | CHAR | 4 | NOT NULL, FOREIGN KEY | ID of ward |

### Patient Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
PatientID | CHAR | 4 | PRIMARY KEY | ID of patient |
FName | VARCHAR | 50 | NOT NULL | First name of patient |
LName | VARCHAR | 50 | NOT NULL | Last name of patient |
HouseNo | VARCHAR | 10 | NOT NULL | House number of address of patient |
Street | VARCHAR | 50 | NOT NULL | Street of address of patient |
Postcode | CHAR | 5 | NOT NULL | Postcode of address of patient |
City | VARCHAR | 50 | NOT NULL | City of address of patient |
State | VARCHAR | 50 | NOT NULL | State of address of patient |
Country | VARCHAR | 20 | NOT NULL | Country of address of patient |
TelNO | VARCHAR | 20 | NOT NULL | Telephone number of patient|
DOB | DATE | - | NOT NULL | Date of birth of patient |
Gender | CHAR | 1 | NOT NULL, CHECK | Gender of patient |
MaritalStatus | VARCHAR | 20 | NOT NULL, CHECK | Marital status of patient |
DateRegistered | DATE | - | NOT NULL | Date registered of patient |

### Next_Of_Kin Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
KinID | CHAR | 4 | PRIMARY KEY | ID of next of kin |
FName | VARCHAR | 50 | NOT NULL | First name of next of kin |
LName | VARCHAR | 50 | NOT NULL | Last name of next of kin |
Relationship | VARCHAR | 20 | NOT NULL, CHECK | Relationship between next of kin and patient |
TelNo | VARCHAR | 10 | NOT NULL | Telephone number of next of kin |
Patient | CHAR | 4 | NOT NULL, FOREIGN KEY | ID of patient |

### Out_Patient Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
OutID | CHAR | 4 | PRIMARY KEY | ID of out-patient |
Location | VARCHAR | 50 | NOT NULL, CHECK | Room number of appointmnt in out-patient clinic |

### In_Patient Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
InID | CHAR | 4 | PRIMARY KEY | ID of in-patient |
DateStay | DATE | - | NOT NULL | Date of stay-in |
ExpectedDateLeave | DATE | - | NOT NULL | Expected date of leaving |
ExpectedDuration | - | - | - | Expected duration of staying (derived) |
ActualDateLeave | Date | - | - | Actual date of leaving |
ActualDuration | - | - | - | Actual duration of staying (derived) |
AssignedWard | CHAR | 4 | NOT NULL | ID of ward |

### Daily_Activity Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
ActivityID | CHAR | 5 | PRIMARY KEY | ID of daily activity |
MedicineDosage | INT | - | NOT NULL | Dosage of medicine |
Status | VARCHAR | 10 | NOT NULL, CHECK | Status of activity |
DateTime | DATETIME | - | DATETIME | Date and time when the activity is done |
Patient | CHAR | 4 | NOT NULL, FOREIGN KEY | ID of in-patient |
Nurse | CHAR | 4 | NOT NULL, FOREIGN KEY | UD of general nurse |

### Receptionist Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
ReceptionistID | CHAR | 4 | PRIMARY KEY | ID of receptionist |
FName | VARCHAR | 50 | NOT NULL | First name of receptionist |
LName | VARCHAR | 50 | NOT NULL | Last name of receptionist |
TelExtNo | VARCHAR | 10 | - | Telephone extension number of receptionist |
Email | VARCHAR | 50 | NOT NULL | Email of receptionist |
Salary | INT | - | NOT NULL | Salary of receptionist |

### Doctor Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
DoctorID | CHAR | 4 | PRIMARY KEY | ID of doctor |
FName | VARCHAR | 50 | NOT NULL | First name of doctor |
LName | VARCHAR | 50 | NOT NULL | Last name of doctor |
Email | VARCHAR | 50 | NOT NULL | Email of doctor |
Specialty1 | VARCHAR | 50 | NOT NULL | Specialty 1 of Doctor |
Specialty2 | VARCHAR | 50 | - | Specialty 2 of Doctor |
Specialty3 | VARCHAR | 50 | - | Specialty 3 of Doctor |
TelExtNo | VARCHAR | 10 | - | Telephone extension number of doctor |
Salary | INT | - | NOT NULL | Salary of doctor |

### Appointment Table
Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
AppointmentID | CHAR | 4 | PRIMARY KEY | ID of appointment |
DateTime | DATETIME | - | NOT NULL | Date and time of appointment |
Patient | CHAR | 4 | NOT NULL, FOREIGN KEY | ID of patient |
Recorded_by | CHAR | 4 | NOT NULL, FOREIGN KEY | ID of receptionist |
Conducted_by | CHAR | 4 | NOT NULL, FOREIGN KEY | ID of doctor |
Out_Patient | CHAR | 4 | FOREIGN KEY | ID of out-patient |
In_Patient | CHAR | 4 | FOREIGN KEY | ID of in-patient |

## Explanation of the query in Databases Query
### User Authentication
Here, the developer implements several stored procedures while creating and performing the Authorization Matrix for the people who exist in Wellmeadows Hospital. The table below describes the people which is the role used to access the Wellmeadows Hospital database. 
<br />

#### Doctor
- The doctors will examine patients based on the appointment assigned to them by the receptionist and update the results stating that the patient will be an out-patient or an in-patient.

#### Database Administrator
- The database administrator is responsible for making sure that all the information stored in the database is available to use and secure from unauthorized access.

#### Receptionist
- The receptionist records the information about the patients and assigns appointments to them as well as the doctor that will be performing the examination.

#### Head Nurse
- Each head nurse is assigned to one ward and is responsible for updating the daily activities of the patients.

#### General Nurse
- The general nurse has the authority to view the activities assigned to them as well as update the status, date, and time of the patient when the task assigned to them is completed.
<br />

Firstly, `sp_addlogin` is used to create new users at the server level. Then, `sp_adduser` is used to add the newly created server level user into the Wellmeadows Hospital database level else the users could not access the Wellmeadows Hospital database. Next, the developer uses `sp_addrole` to create new roles which are mentioned in the table above. Finally, `sp_addrolemember` is implemented to assign the users to their respective roles.
<br />

Each role consists of different privileges. For instant, in terms of receptionists, it can view all the data besides the daily activities and the receptionists. In addition, since the receptionists have to deal with the patient data and their appointments, the receptionist is authorized to insert, modify, and delete the data of the Patient, Next_Of_Kin, Out_Patient, In_Patient, and Appointment tables. However, the receptionist is not authorized to grant access to others for any of the tables such as the Doctor table. 
<br />

When the user accesses the Wellmeadows Hospital database, he or she will be restricted and could only perform the privilege granted towards the role assigned to the user. If the user tries to perform actions aside from the privilege of his or her role, an error message will appear and the respective action will be stopped. 
<br />

### Logon Triggers
In this section, the developer will demonstrate and implement several logon triggers in managing the Wellmeadows Hospital database. The followings are the action that will be performed by the developer:

##### Prevent nurses to access the database after office hours
- When the nurses of the Wellmeadows Hospital access the database before 8.00 am or after 5.00 pm, the logon triggers will be activated and an error message will be displayed

##### Prevent receptionist from having more than 5 sessions at a time
- This logon trigger limits the number of concurrent connections made by the receptionist.

##### Record all logins
- The logic behind this logon trigger is it will record the detail of each attempt and store them in a table that could be referred in the future.
- The data dictionary for the Login_Info table is shown below:
<br >

Column Name | Data Type | Length | Constraint | Description |
------------|-----------|--------|------------|-------------|
Login_Name | VARCHAR | 256 | - | Name of the user who logs in |
Login_Time | DATETIME | - | - | Timestamp of the user log in |
Host_Name | VARCHAR | 128 | - | Location of the server |
SPID | INT | - | - | Server Process ID |

### DML Trigger
The developer will implement a DML trigger in which the modification of the patient data will be tacked and stored respective modification into a table 
<br />

First and foremost, a table with the name of Patient_Audit is created to store the historical changes on the Patient table. These include the action of inserting, deleting and updating the values within the Patient table. After the user has performed the respective action, the modified value will be stored in the Patient_Audit table simultaneously. Moreover, the timestamp, name of the user as well as action will be recorded in the Patient_Audit table.
<br />

The next step is to create the trigger by recording the detail of the action. Other than recording the fundamental attribute values, it will also record the timestamp through `GETDATE()`, the user responsible for the changes through `SYSTEM_USER` as well as the action performed. There is a total of two types of action, either inserting with the label with ‘I’ or deleting with the label of ‘D’.
<br />

The next DML trigger which will be demonstrated is the prevention of deleting the Ward table. The developer constructs a trigger with the name of `Ward_Delete` to perform the action. As the purpose of the Ward_Delete trigger is to prevent the deletion of the Ward table, the INSTEAD OF DELETE is used for purposes. When the user tries to delete the Ward table, the respective command will be ignored and the codes after INSTEAD OF DELETE will be performed. In this case, an error message of ‘Ward cannot be deleted' with the severity level of 16 and a state of 10 will appear on the screen.



