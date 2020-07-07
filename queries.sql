-- QUERIES FOR MODULE WORK *Challenge work is included in the bottom

select * from departments;

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')

--Counting Retirees and saving as a new table
drop table retirement_info cascade;

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

drop table retirement_info cascade;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select * from retirement_info;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
    dm.from_date,
    dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- Using Left Join for retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01')

select * from current_emp

-- GROUP and ORDER BY
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Employee Info
SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

drop table emp_info

SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31') AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info;

-- Management
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp as ce
		ON (dm.emp_no = ce.emp_no);
		
--Department Retirees
SELECT ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no);

SELECT * FROM departments

SELECT ce.emp_no, ce.first_name, ce.last_name, d.dept_name
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE (d.dept_name in ('Sales', 'Development'));

-- MODULE CHALLENGE

-- MODULE CHALLENGE: Deliverable 1
-- Query: Creating table with employee number, first name, last name, title, from, date, and salary. The employee must be born between 1952 and 1955.
SELECT * FROM employees;

SELECT e.emp_no, e.first_name, e.last_name, tl.title, tl.from_date, s.salary
FROM employees as e
	INNER JOIN titles as tl
	ON (e.emp_no = tl.emp_no)
	INNER JOIN salaries as s
	ON (e.emp_no = s.salary)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31');

-- Query: Deleting all duplicates
SELECT * FROM numofretiringempwithduplicates;

SELECT emp_no, first_name, last_name, title, from_date, salary 
FROM
  (SELECT emp_no, first_name, last_name, title, from_date, salary, ROW_NUMBER() OVER 
(PARTITION BY (emp_no) ORDER BY from_date DESC) rn
   FROM numofretiringempwithduplicates
  ) tmp WHERE rn = 1
  ORDER BY emp_no;

-- Query: Number of Titles Retiring (Post Duplicate Partitioning) 
SELECT count(title)
FROM numofretiringemp;

-- Query: Number of Retiring Employees with Each Title (Post Duplicate Partitioning)
SELECT COUNT(title), title
FROM numofretiringemp
GROUP BY title;

-- Query: List of current employees born between Jan. 1, 1952 and Dec. 31, 1955 (Post Duplicate Partitioning)
SELECT * FROM numofretiringemp;

-- MODULE CHALLENGE: Deliverable 2
-- Query: Creating table with employee number, first name, last name, title, from date, to date. The employee include has be to born in 1965
SELECT * FROM employees;

SELECT e.emp_no, e.first_name, e.last_name, tl.title, tl.from_date, tl.to_date
FROM employees as e
	INNER JOIN titles as tl
	ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

-- Query: Deleting all duplicates
SELECT * FROM mentorship_prg_w_duplicates;

SELECT emp_no, first_name, last_name, title, from_date, to_date
FROM
  (SELECT emp_no, first_name, last_name, title, from_date, to_date, ROW_NUMBER() OVER 
(PARTITION BY (emp_no) ORDER BY from_date DESC) rn
   FROM mentorship_prg_w_duplicates
  ) tmp WHERE rn = 1
  ORDER BY emp_no;

-- Provides the total amount of unique employees whom qualifies for the program
SELECT COUNT(emp_no) FROM mentorship_prg;

-- Provides the total amount of employees
SELECT COUNT(emp_no) FROM employees