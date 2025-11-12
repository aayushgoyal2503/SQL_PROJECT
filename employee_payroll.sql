
CREATE DATABASE EmployeePayrollDB;
USE EmployeePayrollDB;

-- 2️⃣ Create tables
CREATE TABLE Department (
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(50),
    Location VARCHAR(50)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    EmpName VARCHAR(50),
    Gender CHAR(1),
    DeptID INT,
    JoinDate DATE,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Attendance (
    AttID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT,
    WorkDate DATE,
    Status VARCHAR(10),  -- Present/Absent/Leave
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

-- 3️⃣ Insert sample data
INSERT INTO Department (DeptName, Location)
VALUES ('HR', 'Delhi'), ('IT', 'Bangalore'), ('Finance', 'Mumbai');

INSERT INTO Employee (EmpName, Gender, DeptID, JoinDate, Salary)
VALUES 
('Aayush Goyal', 'M', 2, '2023-02-10', 60000),
('Priya Sharma', 'F', 1, '2022-06-15', 50000),
('Rohan Mehta', 'M', 3, '2021-09-20', 70000);

INSERT INTO Attendance (EmpID, WorkDate, Status)
VALUES 
(1, '2025-11-01', 'Present'),
(1, '2025-11-02', 'Absent'),
(2, '2025-11-01', 'Present'),
(3, '2025-11-01', 'Leave');

-- 4️⃣ Example queries

-- a) Display employees with their department names
SELECT e.EmpName, d.DeptName, e.Salary
FROM Employee e
JOIN Department d ON e.DeptID = d.DeptID;

-- b) Calculate average salary per department
SELECT d.DeptName, AVG(e.Salary) AS AvgSalary
FROM Employee e
JOIN Department d ON e.DeptID = d.DeptID
GROUP BY d.DeptName;

-- c) List employees who were absent
SELECT e.EmpName, a.WorkDate
FROM Employee e
JOIN Attendance a ON e.EmpID = a.EmpID
WHERE a.Status = 'Absent';

-- d) Increase IT department salaries by 10%
UPDATE Employee
SET Salary = Salary * 1.10
WHERE DeptID = (SELECT DeptID FROM Department WHERE DeptName = 'IT');
