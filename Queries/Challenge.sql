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