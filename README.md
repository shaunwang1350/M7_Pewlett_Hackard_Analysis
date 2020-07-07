# M7_Pewlett_Hackard_Analysis

## Problem

For this analysis, we are asked to determine the total number of employees per title who will be retiring, and identify employees who are eligible to participate in a mentorship program. We have also been asked to create documentation that captures the work that we have been doing. To deliver this documentation, we will need to write about the current assignments. 

These are the deliverables asked:

* Delivering Results: A README.md in the form of a technical report that details your analysis and findings
* Technical Analysis Deliverable 1: Number of Retiring Employees by Title. You will create three new tables, one showing number of titles retiring, one showing number of employees with each title, and one showing a list of current employees born between Jan. 1, 1952 and Dec. 31, 1955. New tables are exported as CSVs. 
* Technical Analysis Deliverable 2: Mentorship Eligibility. A table containing employees who are eligible for the mentorship program You will submit your table and the CSV containing the data (and the CSV containing the data)

## Procedure 

All tables and queries derived are within the queries folder and marked with D1 (Deliverable 1) and D2 (Deliverable 2)

### Deliverable 1

For this analysis, we began by creating a table that contains the number of employees who are about to retire (those born 1952-1955), grouped by job title. Using the ERD as a reference, we created this table with an inner join. The table includes the following information: Employee number, First and last name, Title, from_date, Salary.

Afterwards, we wanted to remove the duplicates within the table that was just created. Therefore, we used the SQL function to partition data. 

### Deliverable 2

For this table, we created a table for employees who are eligible to participate in the mentorship program. Employees will need to have a date of birth that falls between January 1, 1965 and December 31, 1965. The table includes: Employee number, First and last name, Title, from_date and to_date. 

Using the same partitioning method in Deliverable 1, we removed the duplicates that existed in the table.

## Encountered Issues

* One of the three tables that we were asked to deliver asks for one showing number of titles retiring. I am confused if this is asking the total amount of titles, which is count(titles), or is it asking a list of different titles that is retiring.
 * One of the major issues that was encounter was sorting the data by birth_date but not including the variable into the table. This meant that the queries had to reference Employees table and sort the new query using e.birth_date, where e stands from the table. 
* Another issue that was encountered was figuring out the syntax for partitioning. This too a long time and reading through the provided article on blog.theodo.com. 

## Anaylsis 
* From the total of 90398 unique individuals who are about to retire, they are spread across Engieers, Senior Engieers, Managers, Assistant Engineer, Staff, Senior Staff, and Technique Leader. This can bee seen in CSV D1_Num_of_employees_w_e_title and D1_Num_of_titles_retiring. 
* It seems that Senior Engineers, coming in at 29415, and Senior staff, coming at 28255, are the two possibles that have the most amount of employees whom are retiring. This means that the positions that are retiring the most are all senior positions.
* The least amount of retiring employees are managers, at 2, Assistant Engineers, at 1761, and Technique Leaders, at 4502. These three positions are a magnitude lower than the other positions. 
* Examining the Mentorship program excel sheet from D2_mentorship_program CSV, it can be seen that there is a total of 1940 employees who qualify for the mentorship program. More importantly, by adding up all the employees who are retiring from senior positions (29415 + 28255 = 57670) and diving the number of individuals in the mentor program by that total amount of senior employees retiring (1940/57670 + 1 = 3.3%), only 3% of the senior retiring employees qualify for the program.

## Limitations
* One of the major limitations is the small range of the mentorship program. It only allows employees of a 1965 to enter into the program, limiting the program to a small degree of people. Additionally, by only selecting employees into the program by birth date, the program is not based upon experience or merits, but instead on age.
* Another limitation of the dataset is that, it seems that there is 300024 employees at the company, and it seems that 90398 employees are retiring coming up, which means that 1/3 of the company's employees are leaving. Either this is caused by a natural progression of retirement age or some internal issues that so many individuals are leaving is unclear from the data set. In other words, the reason why so many people are leaving is unclear. 