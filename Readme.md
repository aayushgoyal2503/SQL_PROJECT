# Employee Payroll Management System (SQL)

A mini SQL project developed using MySQL and executed in VS Code.  
It simulates a simple Employee Payroll System for managing departments, employees, salaries, and attendance.

## 🧩 Project Overview
The system consists of three main tables:
- **Department** — stores department names and locations.
- **Employee** — stores employee information with links to departments.
- **Attendance** — tracks employee attendance and leave records.

## ⚙️ Features
- Create and manage database tables.
- Perform joins and aggregations to analyze data.
- Implement salary updates and HR reporting queries.
- Example queries for real-world payroll use cases.

## 🚀 How to Run
1. Install [MySQL](https://dev.mysql.com/downloads/installer/).
2. Install **SQLTools** and **SQLTools MySQL Driver** in VS Code.
3. Connect to MySQL (localhost, user: root).
4. Open `employee_payroll.sql` and run the script.
5. Test queries like:
   ```sql
   SELECT * FROM Employee;
   SELECT e.EmpName, d.DeptName, e.Salary 
   FROM Employee e JOIN Department d ON e.DeptID = d.DeptID;