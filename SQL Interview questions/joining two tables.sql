#creating a database and naming personalDetails
CREATE DATABASE personalDetails;
USE personalDetails;
#creating Person table
#PersonId is the primary key column for this table
CREATE TABLE Person(
PersonId INT PRIMARY KEY AUTO_INCREMENT,
FirstName VARCHAR(255) NOT NULL,
LastName VARCHAR(255) NOT NULL
);

#creating Address table
CREATE TABLE Address (
#AddressId is the primary key column for this table.
AddressId INT PRIMARY KEY,
 PersonId INT,
 City VARCHAR(25) NOT NULL,
 State VARCHAR(25) NOT NULL
);

# insert values into Person
INSERT INTO Person (PersonId, FirstName, LastName) VALUES
(1,'James','Lee'),
(2,'Clara','Couto'),
(3,'Seth','Lee');

#selecting from the Person table to view the record
SELECT * FROM Person;


#insert values into Address table
INSERT INTO Address (AddressId, PersonId, City,State) VALUES
(17,23,'Newyork','New Jersey'),
(18,24,'Newyork','New Jersey'),
(19,25,'Newyork','New Jersey');

# combine this two tables
# Write a SQL query for a report that provides the following information for each person in the Person table, regardless if there is an address for each of thosepeople:
#FirstName, LastName, City,, State
select FirstName, LastName, City, State
from Person as p left join Address as a on p.PersonId = a.PersonId;
