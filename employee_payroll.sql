DROP DATABASE IF EXISTS EmployeePayrollDB;
CREATE DATABASE EmployeePayrollDB;
USE EmployeePayrollDB;

CREATE TABLE Department (
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    EmpName VARCHAR(50) NOT NULL,
    Gender CHAR(1),
    DeptID INT,
    JoinDate DATE,
    Salary DECIMAL(10,2),
    Bonus DECIMAL(10,2),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

CREATE TABLE Attendance (
    AttID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT,
    WorkDate DATE,
    Status ENUM('Present','Absent','Leave'),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);

CREATE TABLE Payroll (
    PayrollID INT PRIMARY KEY AUTO_INCREMENT,
    EmpID INT,
    Month VARCHAR(20),
    BaseSalary DECIMAL(10,2),
    Bonus DECIMAL(10,2),
    Deductions DECIMAL(10,2),
    NetSalary DECIMAL(10,2),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID)
);


INSERT INTO Department (DeptName, Location)
VALUES ('HR', 'Delhi'),
       ('IT', 'Bangalore'),
       ('Finance', 'Mumbai'),
       ('Operations', 'Hyderabad');

INSERT INTO Employee (EmpName, Gender, DeptID, JoinDate, Salary, Bonus)
VALUES 
('Aayush Goyal', 'M', 2, '2023-02-10', 60000, 5000),
('Priya Sharma', 'F', 1, '2022-06-15', 50000, 3000),
('Rohan Mehta', 'M', 3, '2021-09-20', 70000, 7000),
('Sneha Verma', 'F', 4, '2020-01-10', 80000, 8000);

INSERT INTO Attendance (EmpID, WorkDate, Status)
VALUES 
(1, '2025-11-01', 'Present'),
(1, '2025-11-02', 'Absent'),
(2, '2025-11-01', 'Present'),
(3, '2025-11-01', 'Leave'),
(4, '2025-11-01', 'Present');

INSERT INTO Payroll (EmpID, Month, BaseSalary, Bonus, Deductions, NetSalary)
VALUES
(1, 'November', 60000, 5000, 1000, 64000),
(2, 'November', 50000, 3000, 500, 52500),
(3, 'November', 70000, 7000, 2000, 75000),
(4, 'November', 80000, 8000, 1000, 87000);

SELECT e.EmpName, e.Gender, d.DeptName, d.Location, e.Salary, e.Bonus
FROM Employee e
INNER JOIN Department d ON e.DeptID = d.DeptID;

SELECT d.DeptName, ROUND(AVG(e.Salary),2) AS AvgSalary
FROM Employee e
JOIN Department d ON e.DeptID = d.DeptID
GROUP BY d.DeptName
ORDER BY AvgSalary DESC;

SELECT e.EmpName, a.WorkDate, a.Status
FROM Employee e
JOIN Attendance a ON e.EmpID = a.EmpID
WHERE a.Status = 'Absent';

SELECT d.DeptName, SUM(p.NetSalary) AS TotalDeptSalary
FROM Payroll p
JOIN Employee e ON p.EmpID = e.EmpID
JOIN Department d ON e.DeptID = d.DeptID
GROUP BY d.DeptName
ORDER BY TotalDeptSalary DESC;

SELECT EmpName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

SELECT EmpName, Salary, Bonus
FROM Employee
ORDER BY Salary + Bonus DESC
LIMIT 2;

SELECT DeptName, COUNT(*) AS EmployeeCount
FROM Department d
JOIN Employee e ON d.DeptID = e.DeptID
GROUP BY DeptName
ORDER BY EmployeeCount DESC
LIMIT 1;

CREATE OR REPLACE VIEW DepartmentSummary AS
SELECT d.DeptName,
       COUNT(e.EmpID) AS TotalEmployees,
       ROUND(AVG(e.Salary),2) AS AvgSalary,
       SUM(p.NetSalary) AS TotalMonthlyCost
FROM Department d
JOIN Employee e ON d.DeptID = e.DeptID
JOIN Payroll p ON e.EmpID = p.EmpID
GROUP BY d.DeptName;

SELECT * FROM DepartmentSummary;

UPDATE Employee
SET Salary = Salary * 1.05
WHERE DeptID IN (SELECT DeptID FROM Department WHERE DeptName = 'IT');

SELECT EmpName, DeptID, Salary FROM Employee WHERE DeptID = 2;
