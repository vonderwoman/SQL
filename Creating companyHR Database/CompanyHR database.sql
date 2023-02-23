#creating a database and naming companyHR
CREATE DATABASE companyHR;
USE companyHR;
#creating co_employees table
CREATE TABLE co_employees (
id INT PRIMARY KEY AUTO_INCREMENT,
em_name VARCHAR(255) NOT NULL,
gender CHAR(1) NOT NULL,
contact_number VARCHAR(255),
age INT NOT NULL,
date_created TIMESTAMP NOT NULL DEFAULT NOW()
);
#creating mentorship table
CREATE TABLE mentorships (
mentor_id INT NOT NULL,
mentee_id INT NOT NULL,
status VARCHAR(255) NOT NULL,
project VARCHAR(255) NOT NULL,
PRIMARY KEY (mentor_id, mentee_id, project),
CONSTRAINT fk1 FOREIGN KEY(mentor_id) REFERENCES
co_employees(id) ON DELETE CASCADE ON UPDATE RESTRICT,
CONSTRAINT fk2 FOREIGN KEY(mentee_id) REFERENCES
co_employees(id) ON DELETE CASCADE ON UPDATE RESTRICT,
CONSTRAINT mm_constraint UNIQUE(mentor_id, mentee_id)
);
#altering tables
#first we can modify co_employee table and rename to employees
RENAME TABLE co_employees TO employees;

ALTER TABLE employees
DROP COLUMN age,
ADD COLUMN salary FLOAT NOT NULL AFTER contact_number,
ADD COLUMN years_in_company INT NOT NULL AFTER salary;
#to describe employee table we write this basic syntax
DESCRIBE employees;

#altering mentorship table
ALTER TABLE mentorships
DROP FOREIGN KEY fk2;

ALTER TABLE mentorships
ADD CONSTRAINT fk2 FOREIGN KEY(mentee_id) REFERENCES
employees(id) ON DELETE CASCADE ON UPDATE CASCADE,
DROP INDEX mm_constraint;

#viewing the mentorship table
DESCRIBE mentorships;

#inserting data into our tables
INSERT INTO employees (em_name, gender, contact_number, salary,
years_in_company) VALUES
('James Lee', 'M', '516-514-6568', 3500, 11),
('Peter Pasternak', 'M', '845-644-7919', 6010, 10),
('Clara Couto', 'F', '845-641-5236', 3900, 8),
('Walker Welch', 'M', NULL, 2500, 4),
('Li Xiao Ting', 'F', '646-218-7733', 5600, 4),
('Joyce Jones', 'F', '523-172-2191', 8000, 3),
('Jason Cerrone', 'M', '725-441-7172', 7980, 2),
('Prudence Phelps', 'F', '546-312-5112', 11000, 2),
('Larry Zucker', 'M', '817-267-9799', 3500, 1),
('Serena Parker', 'F', '621-211-7342', 12000, 1);

#inserting into the mentorship table
INSERT INTO mentorships (mentor_id, mentee_id, status, project)
VALUES
(1, 2, 'Ongoing', 'SQF Limited'),
(1, 3, 'Past', 'Wayne Fibre'),
(2, 3, 'Ongoing', 'SQF Limited'),
(3, 4, 'Ongoing', 'SQF Limited'),
(6, 5, 'Past', 'Flynn Tech');

#updating data
UPDATE employees
SET contact_number = '516-514-1729'
WHERE id = 1;
#we can use other columns like years_in_company

UPDATE employees
SET contact_number = '516-514-1729'
WHERE years_in_copmany = 11;

#Deleting data
DELETE FROM employees
WHERE id = 5;

UPDATE employees
SET id = 11
WHERE id = 4;
#selecting data
SELECT * FROM employees;
SELECT * FROM mentorships
#filtering records

SELECT em_name AS "Employee Name", gender AS Gender FROM
employees;

#using limit
SELECT em_name AS 'Employee Name', gender AS Gender FROM
employees LIMIT 3;

#using distinct used to remove duplicates
SELECT DISTINCT(gender) FROM employees;
#using where clause
UPDATE employees
SET contact_number = '516-514-1729'
WHERE id = 1;
#We can do a comparison between two values using the following operators
#Not Equal (!=), Greater than (>), Greater than or equal to (>=), Smaller than
#(<), Smaller than or equal to (<=)
SELECT * FROM employees WHERE id != 1;
SELECT * FROM employees WHERE id > 1;
SELECT * FROM employees WHERE id >= 1;
SELECT * FROM employees WHERE id <= 1;

#using Between clause
SELECT * FROM employees WHERE id BETWEEN 1 AND 3;

#using lIKE clause
#If we want to select employees whose names end with ‘er’, we can do it as follows:
SELECT * FROM employees WHERE em_name LIKE '%er';
SELECT * FROM employees WHERE em_name LIKE '%ne';
#If we want to select employees whose names have 'er' anywhere within (not
#necessarily at the back), we can use the following statement:
SELECT * FROM employees WHERE em_name LIKE '%er%';
#Suppose we want to select the rows of all employees that have ‘e’ as the fifth
#letter in their names, we write:
SELECT * FROM employees WHERE em_name LIKE '____e%';
#Here, we use FOUR _ symbols to indicate that there are four characters before ‘e’. 

##using the IN clause
SELECT * FROM employees WHERE id IN (6, 7, 9);

## using Not in
#if we want to select rows that do not have id 7 or 8, we use the NOT IN keywords:
SELECT * FROM employees WHERE id NOT IN (7, 8);

#using and or
##The AND keyword gives us rows that satisfy ALL the conditions listed while
#the OR keyword selects rows that satisfy at least one of the conditions.
SELECT * FROM employees WHERE (years_in_company > 5 OR salary >
5000) AND gender = 'F';
##For instance, if we want to select all female employees who have worked
#more than 5 years in the company or have salaries above 5000, we can write:


###.........................................
#writing subqueries
#Subqueries are commonly used to filter the results of one table based on the results of a query on another table.
#For instance, in our example, suppose we want to select the names of all
#employees that are mentors of the 'SQF Limited' project.
SELECT em_name from employees WHERE id IN
(SELECT mentor_id FROM mentorships WHERE project = 'SQF
Limited');

##sorting rows
SELECT * FROM employees ORDER BY gender, em_name;
SELECT * FROM employees ORDER BY gender DESC, em_name;

/*************MySQL Functions**************/

#The first is the CONCAT() function.It allows us to combine two or more strings into a single string
#SUBSTRING  a portion of a longer string
#NOW() gives us the current date and time
#CURDATE() function gives us the current date
#CURTIME() also gives us current time

/************Aggregate functions*****************/
#COUNT() function returns the number of rows in the table

SELECT COUNT(*) FROM employees;
SELECT COUNT(contact_number) FROM employees;
SELECT COUNT(gender) FROM employees;
SELECT COUNT(DISTINCT gender) FROM employees;

#AVG() function returns the average of a set of values
SELECT AVG(salary) FROM employees;
SELECT AVG(id) FROM employees;
#if we want to round off the result of the AVG() function to 2 decimal places, we write
SELECT ROUND(AVG(salary), 2) FROM employees;

#MAX() function
SELECT MAX(salary) FROM employees;
#MIN() function
SELECT MIN(salary) FROM employees;
#SUM() The SUM() function returns the sum of a set of values.
SELECT SUM(salary) FROM employees;

/**********GROUP BY****************/
#GROUP BY allows us to group data and  perform calculations
#What if we are interested in the maximum salary of males vs females?
SELECT gender, MAX(salary) FROM employees GROUP BY gender;
#Having 
#we can also filter the results of the grouped data. We do that using the HAVING clause.
SELECT gender, MAX(salary) FROM employees GROUP BY gender HAVING
MAX(salary) > 10000;

###########################################################################

/*************JOINS********************/

SELECT employees.id, mentorships.mentor_id, employees.em_name AS
'Mentor', mentorships.project AS 'Project Name'
FROM
mentorships
JOIN
employees
ON
employees.id = mentorships.mentor_id;

#if you do not want the id and mentor_id columns to show, you can use the code below:

SELECT employees.em_name AS 'Mentor', mentorships.project AS
'Project Name'
FROM
mentorships
JOIN
employees
ON
employees.id = mentorships.mentor_id;


/*************UNIONS**********************/
#The UNION keyword is used to combine the results of two or more SELECT statements.

SELECT em_name, salary FROM employees WHERE gender = 'M'
UNION
SELECT em_name, years_in_company FROM employees WHERE gender =
'F';

SELECT mentor_id FROM mentorships
UNION ALL
SELECT id FROM employees WHERE gender = 'F';

################################################################################
/***************VIEWS****************************/

CREATE VIEW myView AS
SELECT employees.id, mentorships.mentor_id, employees.em_name AS
'Mentor', mentorships.project AS 'Project Name'
FROM
mentorships
JOIN
employees
ON
employees.id = mentorships.mentor_id;


SELECT * FROM myView;

#If we only want the mentor_id and Project Name columns, we can write

SELECT mentor_id, `Project Name` FROM myView;

/******ALTERING A VIEW*********/

ALTER VIEW myView AS
SELECT employees.id, mentorships.mentor_id, employees.em_name AS
'Mentor', mentorships.project AS 'Project'
FROM
mentorships
JOIN
employees
ON
employees.id = mentorships.mentor_id;

SELECT * FROM myView;


/*******Deleting a View***********/

DROP VIEW IF EXISTS myView;

###########################################################################
/**************TRIGGERS********************/
CREATE TABLE ex_employees (
em_id INT PRIMARY KEY,
em_name VARCHAR(255) NOT NULL,
gender CHAR(1) NOT NULL,
date_left TIMESTAMP DEFAULT NOW()
);























