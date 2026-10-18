SELECT @@VERSION AS SQLServerVersion; -- To check the MS SQL Version that is currently being used.

CREATE DATABASE Employees; -- Created a database as Employees to execute our MS SQL Server queries.


USE Employees;


SELECT DB_NAME() AS Current_Database; -- To check which database we are currently using.


-- Creating Department Table

CREATE TABLE Departments 
(
	DeptID INT PRIMARY KEY,
	DeptName VARCHAR(20)
);

-- Inserting values into Department Table

INSERT INTO Departments (DeptID, DeptName) VALUES

	(10,'IT'),
	(20,'HR'),
	(30,'Finance'),
	(40,'Sales');

SELECT * FROM Departments; -- Retriving the data stored in department table.

-- Creating Employees Table.

CREATE TABLE Employees 
(
	EmpID INT PRIMARY KEY,
	EmpName VARCHAR(20),
	DeptID INT,
	Salary DECIMAL(20,0),
	ManagerID INT NULL,
	FOREIGN KEY (DeptID) REFERENCES Departments(DeptID),
	FOREIGN KEY (ManagerID) REFERENCES Employees(EmpID)
);

--DROP TABLE Employees;

-- Inserting values in the employees table.

INSERT INTO Employees (EmpID,EmpName,DeptID,Salary,ManagerID)
VALUES

	(101,'Amit',10,45000,104),
	(102,'Neha',20,38000,104),
	(103,'Ravi',10,52000,101),
	(104,'Priya',30,60000,NULL),
	(105,'Sara',20,42000,102),
	(106,'John',10,45000,101);

select * from employees; -- To retrieve to data from the employees table.

-- PART - A : Microsoft SQL Server Queries:

-- Task 1: Basic Queries

-- 1. Display employees earning more than 40,000.

select * from employees
where Salary > 40000;

-- 2. Display employees whose names start with S.

select * from employees
where EmpName LIKE 'S%';

-- 3. Display employees in descending order of salary.

select * from employees
order by salary desc;


-- Task 2: Aggregate Functions

-- 1. Calculate the average salary of all employees.

select avg(Salary) AS Average_Salary from employees;

-- 2. Find the maximum and minimum salaries.

select max(Salary) as Max_Salary from employees;

select min(Salary) as Min_Salary from employees;

-- 3. Count employees in each department.

select DeptID, count(EmpID) AS E_P_D  from employees
group by DeptID;

-- Task 3: GROUP BY and HAVING

-- 1. Display departments having more than one employee, along with their employee count.

select DeptID, count(EmpID) AS E_P_D from employees
group by DeptID 
having count(EmpID) > 1;

-- Task 4: JOIN

-- 1. Display employee names with their department names.

select d.DeptID, d.DeptName, e.EmpName 
from Departments as d
INNER JOIN Employees as e
ON d.DeptID = e.DeptID;

-- 2. Display all departments, including departments that have no employees.

select d.DeptID, d.DeptName, e.EmpID, e.EmpName 
from Departments as d
LEFT JOIN Employees as e
ON d.DeptID = e.DeptID;

-- Task 5: Subquery

-- 1. Display employees whose salary is greater than the overall average salary.


select * from employees
where Salary > (select avg(Salary) from employees);

-- Task 6: Second-Highest Salary

-- 1. Find the second-highest distinct salary without using TOP.
 
select max(Salary) AS Second_Highest_Salary from employees
where Salary < ( select max(Salary) from employees);

-- Task 7: Window Functions

-- 1. Display each employee's name, department ID, salary and department-wise salary rank using DENSE_RANK().

select EmpName, DeptID, Salary,
DENSE_RANK() OVER(PARTITION BY DeptID ORDER BY Salary DESC) AS Salary_Rank FROM employees;

-- Task 8: CASE Expression

-- 1. Display each employee's name and salary category: High (salary >= 50000), Medium (salary from 40000 to less than
--50000), Low (salary below 40000).

select EmpName, Salary,
CASE
	WHEN Salary >= 50000 THEN 'High Salary'
	WHEN Salary >= 40000 AND Salary < 50000 THEN 'Medium Salary'
	ELSE 'Low Salary'
END AS Salary_Category
FROM Employees;
