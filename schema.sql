/* diasble foreign key checks for schema.sql to create tables*/

CREATE TABLE Department (
    DeptID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    DeptName VARCHAR(255) NOT NULL,
    Faculty VARCHAR(255) NOT NULL,
    HODName VARCHAR(255) NOT NULL UNIQUE,
    Address VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY(DeptID),
    INDEX(DeptID));
    
CREATE TABLE Enrolment (
    EID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    StudentID BIGINT NOT NULL,
    ModuleID BIGINT NOT NULL,
    Score INT NOT NULL,
    Semester VARCHAR(255) NOT NULL,
    Year BIGINT NOT NULL,
    PRIMARY KEY(EID),
    INDEX(EID),
    INDEX(StudentID),
    INDEX(ModuleID),
    INDEX(Semester),
    INDEX(Year),
    FOREIGN KEY(StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY(ModuleID) REFERENCES Module(ModuleID));
    
CREATE TABLE Student (
    StudentID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    StudentName VARCHAR(255) NOT NULL,
    DoB DATE NOT NULL,
    Address VARCHAR(255) NOT NULL,
    StudyType VARCHAR(255) NOT NULL,
    Date_of_Start DATE NOT NULL,
    PRIMARY KEY(StudentID),
    INDEX(StudentID));
    
CREATE TABLE Module (
    ModuleID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    ModuleName VARCHAR(255) NOT NULL,
    DeptID BIGINT NOT NULL,
    Programme VARCHAR(255),
    TMode VARCHAR(255),
    Date_of_Firstoffer DATE,
    PRIMARY KEY(ModuleID),
    INDEX(ModuleID),
    INDEX(ModuleName),
    FOREIGN KEY(DeptID) REFERENCES Department(DeptID));
	
CREATE TABLE Teach (
    TID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    ModuleID BIGINT NOT NULL,
    StaffID BIGINT NOT NULL,
    SpaID BIGINT NOT NULL,
    Semester VARCHAR(255) NOT NULL,
    Year BIGINT NOT NULL,
    PRIMARY KEY(TID),
    INDEX(TID),
    INDEX(ModuleID),
    INDEX(StaffID),
    INDEX(Semester),
    INDEX(Year),
    FOREIGN KEY(ModuleID) REFERENCES Module(ModuleID),
    FOREIGN KEY(StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY(SpaID) REFERENCES SpaceAssign(SpaID));
	
CREATE TABLE Staff (
    StaffID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    Title VARCHAR(32),
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    DeptID BIGINT,
    CaID INT NOT NULL,
    Joined DATE,
    LeftD DATE,
    Current BOOLEAN NOT NULL,
    Salary BIGINT NOT NULL,
    ContractType VARCHAR(32) NOT NULL,
    SupervisorID BIGINT,
    PRIMARY KEY(StaffID),
    INDEX(StaffID),
    INDEX(FirstName),
    INDEX(LastName),
    INDEX(DeptID),
    INDEX(Current),
    INDEX(SupervisorID),
    FOREIGN KEY(CaID) REFERENCES Campus(CaID),
    FOREIGN KEY(SupervisorID) REFERENCES Staff(StaffID));
	
CREATE TABLE Allocation (
    StaffID BIGINT NOT NULL,
    AcID BIGINT NOT NULL,
    INDEX(StaffID),
    INDEX(AcID),
    FOREIGN KEY(StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY(AcID) REFERENCES Activity(AcID));
	
CREATE TABLE Activity (
    AcID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    Title VARCHAR(255) NOT NULL,
    CaID INT,
    BuID BIGINT,
    Status VARCHAR(255) NOT NULL,
    Started DATE NOT NULL,
    Ended DATE,
    Internal BOOLEAN NOT NULL,
    PRIMARY KEY(AcID),
    INDEX(AcID),
    INDEX(Title),
    FOREIGN KEY(CaID) REFERENCES Campus(CaID),
    FOREIGN KEY(BuID) REFERENCES Budget(BuID));

CREATE TABLE Campus(
    CaID INT AUTO_INCREMENT NOT NULL UNIQUE,
    Address VARCHAR(255),
    GmName VARCHAR(255),
    Country VARCHAR(255),
    Status VARCHAR(255) NOT NULL,
    PRIMARY KEY(CaID),
	INDEX(CaID));
    
CREATE TABLE Budget(
    BuID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    Amount BIGINT,
    Approver VARCHAR(255),
    Payee VARCHAR(255),
    Status VARCHAR(255) NOT NULL,
    PRIMARY KEY(BuID),
    INDEX(BuID));
    
CREATE TABLE Classroom(
    RmID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    Capacity BIGINT,
    CaID INT,
    Location VARCHAR(255),
    Type VARCHAR(255) NOT NULL,
    Status VARCHAR(255) NOT NULL,
    PRIMARY KEY(RmID),
    INDEX(RmID),
    FOREIGN KEY(CaID) REFERENCES Campus(CaID));
    
CREATE TABLE SpaceAssign(
    SpaID BIGINT AUTO_INCREMENT NOT NULL UNIQUE,
    RmID BIGINT NOT NULL,
    TID BIGINT NOT NULL,
    Manager VARCHAR(255) NOT NULL,
    Approved VARCHAR(255) NOT NULL,
    PRIMARY KEY(SpaID),
    INDEX(RmID),
    INDEX(TID),
    FOREIGN KEY(RmID) REFERENCES Classroom(RmID),
    FOREIGN KEY(TID) REFERENCES Teach(TID));
    
