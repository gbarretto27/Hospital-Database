CREATE TABLE Hospital (
  Name         varchar(255) NOT NULL, 
  StreetAddress       varchar(255) NOT NULL, 
  City         varchar(255) NOT NULL,
  AnnualBudget double NOT NULL, 
  PostalCode   varchar(255) NOT NULL, 
  PRIMARY KEY (Name));

CREATE TABLE Department (
  Name         varchar(255) NOT NULL, 
  HospitalName varchar(255) NOT NULL, 
  AnnualBudget double NOT NULL, 
  PRIMARY KEY (Name, 
  HospitalName));

CREATE TABLE Nurses_Department (
  NursesPID              varchar(255) NOT NULL, 
  DepartmentName         varchar(255) NOT NULL, 
  DepartmentHospitalName varchar(255) NOT NULL, 
  PRIMARY KEY (NursesPID, 
  DepartmentName, 
  DepartmentHospitalName));

CREATE TABLE Persons (
  PID        varchar(255) NOT NULL, 
  FirstName  varchar(255) NOT NULL, 
  LastName   varchar(255) NOT NULL, 
  Gender     varchar(255) NOT NULL, 
  DATEOFBIRTH        date NOT NULL, 
  StreetAddress     varchar(255) NOT NULL, 
  City       varchar(255) NOT NULL, 
  Province   varchar(255) NOT NULL, 
  PostalCode varchar(255) NOT NULL, 
  PRIMARY KEY (PID), 
  CONSTRAINT Gender_Check 
    CHECK (Gender IN('male', 'female')));

CREATE TABLE PhoneNumber (
  ContactType integer NOT NULL, 
  Number      char(10) NOT NULL, 
  PersonPID   varchar(255) NOT NULL, 
  PRIMARY KEY (PersonPID), 
  CONSTRAINT number_validation 
    CHECK (Number like REPEAT('[0-9]', 10)), 
  CONSTRAINT ContactType_enum 
    CHECK (ContactType IN('mobile', 'home', 'work')));

CREATE TABLE Patients (
  HealthInsurance varchar(255) NOT NULL, 
  PID             varchar(255) NOT NULL, 
  NursePID        varchar(255) NOT NULL, 
  PhysicianPID    varchar(255) NOT NULL, 
  PRIMARY KEY (PID), 
  CONSTRAINT Insurance_Enum 
    CHECK (HealthInsurance IN('public', 'private', 'self-funded')));

CREATE TABLE Nurses (
  PID           varchar(255) NOT NULL, 
  YearsPractice integer NOT NULL, 
  AnnualSalary  float(10) NOT NULL, 
  PRIMARY KEY (PID));

CREATE TABLE Physicians (
  Specialty              varchar(255) NOT NULL, 
  YearsPractice          integer NOT NULL, 
  AnnualSalary           float(10) NOT NULL, 
  PID                    varchar(255) NOT NULL, 
  DepartmentName         varchar(255) NOT NULL, 
  DepartmentHospitalName varchar(255) NOT NULL, 
  PRIMARY KEY (PID));

CREATE TABLE Admissions (
  PatientsPID  varchar(255) NOT NULL, 
  HospitalName varchar(255) NOT NULL, 
  AdmitDate    date NOT NULL, 
  Priority     varchar(255) NOT NULL, 
  PRIMARY KEY (PatientsPID, 
  HospitalName), 
  CONSTRAINT Admissions_Enum 
    CHECK (Priority IN('immediate', 'urgent', 'standard', 'non-urgent')));

CREATE TABLE MedicalTest (
  Name        varchar(255) NOT NULL, 
  MTID        varchar(255) NOT NULL, 
  Fee         double NOT NULL, 
  TestDate    date NOT NULL, 
  Results     varchar(1000) for bit data NOT NULL, 
  PatientsPID varchar(255) NOT NULL, 
  PRIMARY KEY (MTID));

CREATE TABLE Diagnosis (
  DiagnosisDate date NOT NULL, 
  Disease       varchar(255) NOT NULL, 
  Prognosis     varchar(255) NOT NULL, 
  PatientPID    varchar(255) NOT NULL, 
  PhysiciansPID varchar(255) NOT NULL, 
  PRIMARY KEY (PatientPID, 
  PhysiciansPID), 
  CONSTRAINT Prognosis_Enum 
    CHECK (Prognosis IN('very poor','poor','fair','good','excellent')));

CREATE TABLE Prescription (
  Dosage         varchar(255) NOT NULL, 
  PrescribedDate date NOT NULL, 
  PhysiciansPID  varchar(255) NOT NULL, 
  PatientsPID    varchar(255) NOT NULL, 
  DrugCode       char(8) NOT NULL, 
  PRIMARY KEY (PhysiciansPID, 
  PatientsPID, 
  DrugCode));

CREATE TABLE Drug (
  Code     char(8) NOT NULL, 
  Name     varchar(255) NOT NULL, 
  Category varchar(255) NOT NULL, 
  UnitCost double NOT NULL, 
  PRIMARY KEY (Code), 
  CONSTRAINT DrugCode_Validation 
    CHECK (Code like REPEAT('[0-9]', 8)));







ALTER TABLE Physicians ADD CONSTRAINT PHYSISA FOREIGN KEY (PID) REFERENCES Persons (PID);
ALTER TABLE Physicians ADD CONSTRAINT PHYSBELONGS FOREIGN KEY (DepartmentName, DepartmentHospitalName) REFERENCES Department (Name, HospitalName);

ALTER TABLE Patients ADD CONSTRAINT PATISA FOREIGN KEY (PID) REFERENCES Persons (PID);
ALTER TABLE Patients ADD CONSTRAINT PATDIAGBY FOREIGN KEY (PhysicianPID) REFERENCES Physicians (PID);
ALTER TABLE Patients ADD CONSTRAINT PATCARE FOREIGN KEY (NursePID) REFERENCES Nurses (PID);


ALTER TABLE Nurses_Department ADD CONSTRAINT NURSESDEPTISA FOREIGN KEY (NursesPID) REFERENCES Nurses (PID);
ALTER TABLE Nurses_Department ADD CONSTRAINT NURSESDEPTBELONGS FOREIGN KEY (DepartmentName, DepartmentHospitalName) REFERENCES Department (Name, HospitalName);



ALTER TABLE Diagnosis ADD CONSTRAINT DIAGFOR FOREIGN KEY (PatientPID) REFERENCES Patients (PID);
ALTER TABLE Diagnosis ADD CONSTRAINT DIAGBY FOREIGN KEY (PhysiciansPID) REFERENCES Physicians (PID);

ALTER TABLE Prescription ADD CONSTRAINT PRESCRIPBY FOREIGN KEY (PhysiciansPID) REFERENCES Physicians (PID);
ALTER TABLE Prescription ADD CONSTRAINT PRESBELONGS FOREIGN KEY (PatientsPID) REFERENCES Patients (PID);
ALTER TABLE Prescription ADD CONSTRAINT PRESNEED FOREIGN KEY (DrugCode) REFERENCES Drug (Code);

ALTER TABLE Admissions ADD CONSTRAINT ADMFOR FOREIGN KEY (PatientsPID) REFERENCES Patients (PID);
ALTER TABLE Admissions ADD CONSTRAINT ADMTO FOREIGN KEY (HospitalName) REFERENCES Hospital (Name);

ALTER TABLE MedicalTest ADD CONSTRAINT MEDTESTFOR FOREIGN KEY (PatientsPID) REFERENCES Patients (PID);
ALTER TABLE PhoneNumber ADD CONSTRAINT PHONENUMBELONGS FOREIGN KEY (PersonPID) REFERENCES Persons (PID);
ALTER TABLE Department ADD CONSTRAINT DEPTBELONGS FOREIGN KEY (HospitalName) REFERENCES Hospital (Name);
ALTER TABLE Nurses ADD CONSTRAINT NURSEISA FOREIGN KEY (PID) REFERENCES Persons (PID);


