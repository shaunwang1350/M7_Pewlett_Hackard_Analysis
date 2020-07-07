-- SCHEMA FOR MODULE WORK *Challenge work is included in the bottom

-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE titles(
	emp_no INT NOT NULL,
	title varchar not null,
	from_date date not null,
	to_date date not null,
	Foreign key (emp_no) references employees (emp_no),
	primary key (emp_no)
);

CREATE TABLE dept_emp (
	emp_no int not null,
	dept_no varchar(4) not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	primary key (emp_no, dept_no)
);

-- MODULE CHALLENGE

-- MODULE CHALLENGE: Deliverable 1
-- Table Creation: Creating table with employee number, first name, last name, title, from, date, and salary. The employee must be born between 1952 and 1955.
SELECT e.emp_no, e.first_name, e.last_name, tl.title, tl.from_date, s.salary
INTO NumOfRetiringEmpWithDuplicates
FROM employees as e
	INNER JOIN titles as tl
	ON (e.emp_no = tl.emp_no)
	INNER JOIN salaries as s
	ON (e.emp_no = s.salary)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31');

-- Table Creation: Deleting all duplicates
SELECT emp_no, first_name, last_name, title, from_date, salary 
INTO numofretiringemp
FROM
  (SELECT emp_no, first_name, last_name, title, from_date, salary, ROW_NUMBER() OVER 
(PARTITION BY (emp_no) ORDER BY from_date DESC) rn
   FROM numofretiringempwithduplicates
  ) tmp WHERE rn = 1
  ORDER BY emp_no;

-- Table Creation: Number of Titles Retiring (Post Duplicate Partitioning) 
SELECT count(title)
INTO Num_Of_Titles_Retiring
FROM numofretiringemp;

-- Table Creation: Number of Retiring Employees with Each Title (Post Duplicate Partitioning)
SELECT COUNT(title), title
INTO Num_Of_Employees_w_e_title
FROM numofretiringemp
GROUP BY title;

-- MODULE CHALLENGE: Deliverable 2
-- Table Creation: Creating table with employee number, first name, last name, title, from date, to date. The employee include has be to born in 1965
SELECT e.emp_no, e.first_name, e.last_name, tl.title, tl.from_date, tl.to_date
INTO mentorship_prg_w_duplicates
FROM employees as e
	INNER JOIN titles as tl
	ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');

-- Table Creation: Deleting all duplicates
SELECT emp_no, first_name, last_name, title, from_date, to_date
INTO mentorship_prg
FROM
  (SELECT emp_no, first_name, last_name, title, from_date, to_date, ROW_NUMBER() OVER 
(PARTITION BY (emp_no) ORDER BY from_date DESC) rn
   FROM mentorship_prg_w_duplicates
  ) tmp WHERE rn = 1
  ORDER BY emp_no;

