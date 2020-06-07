--Creating tables for PH-EmployeeDB
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL, 
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

CREATE TABLE  employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL, 
	from_date DATE NOT NULL, 
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no), 
	PRIMARY KEY (emp_no,dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no)REFERENCES employees (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no)REFERENCES employees (emp_no)

DROP TABLE dept_emp;

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no)REFERENCES employees (emp_no)
);

DROP TABLE dept_emp;
	
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no)REFERENCES employees (emp_no)
);
	
SELECT *FROM dept_emp
SELECT * FROM dept_emp
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM employees;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO count_emp
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no,
	first_name,
last_name,
	gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE emp_info
	
SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
     AND (de.to_date = '9999-01-01');
	
SELECT * FROM emp_info;
	
--List managers by department
SELECT dm.dept_no,
		d.dept_name,
		dm.emp_no,
		ce.last_name,
		dm.from_date,
		dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
	ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
	ON (dm.emp_no = ce.emp_no);

SELECT * FROM manager_info;

SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

--Sales team retirement list
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
INTO retirement_sales
FROM retirement_info AS ri
INNER JOIN dept_emp AS de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_no = 'd007');

--Sales and Development retirement list 
	
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
INTO retirementanddev_sales
FROM retirement_info AS ri
INNER JOIN dept_emp AS de
ON (ri.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_no = 'd007') OR (d.dept_no = 'd005');

SELECT emp_no, birth_date, first_name, last_name, genger, hire_date
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- CHALLENGE
	
-- Challenge Part 1  - Number of employees retiring by title

SELECT ce.emp_no AS Employee_number,ce.first_name, ce.last_name, 
    t.title AS Title, t.from_date, s.salary AS Salary
INTO challenge_emp_info
FROM current_emp AS ce
INNER JOIN titles AS t ON ce.emp_no = t.emp_no
INNER JOIN salaries AS s ON ce.emp_no = s.emp_no;

-- For each employee ONLY display the most recent title:

SELECT employee_number, first_name, last_name, title, from_date, salary
INTO current_title_info
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY (cei.employee_number, cei.first_name, cei.last_name)
                ORDER BY cei.from_date DESC) AS emp_row_number
      FROM challenge_emp_info AS cei) AS unique_employee	  
WHERE emp_row_number =1;

-- Get frequency count of employee titles 
SELECT *, count(ct.Employee_number) 
		OVER (PARTITION BY ct.title ORDER BY ct.from_date DESC) AS emp_count
INTO challenge_title_info
FROM current_title_info AS ct;
-- get total count per title group
SELECT COUNT(employee_number), title
FROM challenge_title_info
GROUP BY title;

-- Part 2: Employee eligible for the mentorship program
	
SELECT em.emp_no,em.first_name, em.last_name, 
    t.title AS Title, t.from_date, t.to_date
INTO challenge_mentor_info
FROM Employees AS em
INNER JOIN titles AS t ON em.emp_no = t.emp_no
INNER JOIN dept_emp AS d ON em.emp_no = d.emp_no
WHERE (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (d.to_date = '9999-01-01');
	