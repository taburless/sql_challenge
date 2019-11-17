-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE Departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (
        dept_no
     )
);

DROP TABLE Dept_Manager
CREATE TABLE Dept_Manager (
    dept_no VARCHAR   NOT NULL,
    emp_no INT   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE Employees (
    emp_no INT   NOT NULL,
    birth_date DATE   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    gender VARCHAR   NOT NULL,
    hire_date DATE   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY ( emp_no )
);

DROP TABLE Salaries;
CREATE TABLE Salaries (
    emp_no INT   NOT NULL,
    salary INT   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

DROP TABLE Dept_Emp;
CREATE TABLE Dept_Emp (
    emp_no INT   NOT NULL,
    dept_no VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

DROP TABLE Titles;
CREATE TABLE Titles (
    emp_no INT   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_dept_no FOREIGN KEY(dept_no)
REFERENCES Departments (dept_no);

ALTER TABLE Dept_Manager ADD CONSTRAINT fk_Dept_Manager_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_Emp ADD CONSTRAINT fk_Dept_Emp_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

ALTER TABLE Dept_Emp ADD CONSTRAINT fk_Dept_Emp_dept_no FOREIGN KEY(dept_no)
REFERENCES Dept_Manager (dept_no);

ALTER TABLE Titles ADD CONSTRAINT fk_Titles_emp_no FOREIGN KEY(emp_no)
REFERENCES Employees (emp_no);

--All employees hired in 1986
SELECT * FROM employees
WHERE hire_date >= '1986-01-01' AND hire_date < '1987-01-01'
ORDER BY hire_date ASC;

-- SELECT * FROM employees
--WHERE hire_date LIKE '%1986%';

--Employees name, gender, and salary
SELECT emp.emp_no, emp.first_name, emp.last_name, emp.gender, sal.salary
FROM employees AS emp
INNER JOIN salaries AS sal
ON emp.emp_no = sal.emp_no;

--Employees with first name Hercules and last name beginning with 'B'
SELECT * FROM employees
WHERE first_name LIKE 'Hercules'
AND last_name LIKE 'B%';

--Managers department, department #, employee #, name, and dates of employment
SELECT dept.dept_no, 
dept.dept_name, 
man.emp_no, 
man.from_date, 
man.to_date,
emp.hire_date,
emp.first_name,
emp.last_name
FROM departments AS dept
INNER JOIN dept_manager AS man
ON dept.dept_no = man.dept_no
INNER JOIN employees AS emp
ON emp.emp_no = man.emp_no;

--Employees and their departments
SELECT de.emp_no, emp.last_name, emp.first_name, de.dept_no, dep.dept_name
FROM dept_emp AS de
INNER JOIN employees AS emp
ON emp.emp_no = de.emp_no
INNER JOIN departments AS dep
ON dep.dept_no = de.dept_no

--Sales Employees
SELECT de.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM  employees AS emp
INNER JOIN dept_emp AS de
ON emp.emp_no = de.emp_no
INNER JOIN departments AS dept
ON dept.dept_no = de.dept_no
WHERE dept.dept_name LIKE 'Sales';

--Sales and Development Department
SELECT de.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM  employees AS emp
INNER JOIN dept_emp AS de
ON emp.emp_no = de.emp_no
INNER JOIN departments AS dept
ON dept.dept_no = de.dept_no
WHERE dept.dept_name LIKE 'Sales' 
OR dept.dept_name LIKE 'Development';

SELECT last_name, COUNT(*) AS freq
FROM employees
GROUP BY last_name
ORDER BY freq DESC;


