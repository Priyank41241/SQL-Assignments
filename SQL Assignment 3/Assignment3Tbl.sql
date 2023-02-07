CREATE DATABASE Office 

USE  Office

CREATE TABLE Department 
(
	dept_id int	PRIMARY KEY, 
	dept_name VARCHAR(30) NOT NULL, 
)

CREATE TABLE Employee 
(
	emp_id int PRIMARY KEY,
	dept_id int REFERENCES Department(dept_id) ON DELETE SET NULL,
	mngr_id int ,
	emp_name VARCHAR(50) NOT NULL,
	salary float NOT NULL,
)

INSERT INTO Department VALUES 
(1001, 'Finance'),
(2001, 'Audit'),
(3001, 'Marketing'),
(4001, 'Production')


INSERT INTO Employee VALUES 
(68319, 1001, NULL, 'Kayling', 6000.00),
(66928, 3001, 68319, 'Blaze', 2750.00),
(67832, 1001, 68319, 'Clare', 2550.00),
(65646, 2001, 68319, 'Jonas', 2975.00),
(64989, 3001, 66928, 'Adelyn', 1700.00),
(65271, 3001, 66928, 'Wade', 1350.00),
(66564, 3001, 66928, 'Madden', 1350.00),
(68454, 3001, 66928, 'Tucker', 1600.00),
(68736, 2001, 67858, 'Adnres', 1200.00),
(69000, 3001, 66928, 'Julius', 1050.00),
(69324, 1001, 67832, 'Marker', 1400.00),
(67858, 2001, 65646, 'Scarlet', 3100.00),
(69062, 2001, 65646, 'Frank', 3100.00),
(63679, 2001, 69062, 'Sandrine', 900.00)

SELECT * FROM Department

SELECT * FROM Employee
