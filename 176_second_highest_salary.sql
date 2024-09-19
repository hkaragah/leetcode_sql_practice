--Example
Create table If Not Exists Employee (id int, salary int)
Truncate table Employee
insert into Employee (id, salary) values ('1', '100')
insert into Employee (id, salary) values ('2', '200')
insert into Employee (id, salary) values ('3', '300')



--My solution
WITH Ranked AS (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS ranking FROM Employee
)
SELECT
    CASE 
        WHEN EXISTS (SELECT 1 FROM Ranked WHERE ranking=2)
        THEN (SELECT salary FROM Ranked WHERE ranking=2 LIMIT 1) 
        ELSE NULL
    END AS SecondHighestSalary



--Other solution 1
SELECT
    COALESCE(
        (SELECT MAX(salary) 
        FROM employee 
        WHERE salary < (SELECT max(salary) FROM employee)), NULL) AS SecondHighestSalary;

--Other solution 2
SELECT 
    COALESCE(
        (SELECT DISTINCT salary 
        FROM employee
        ORDER BY salary DESC 
        LIMIT 1, 1), NULL) AS SecondHighestSalary; --LIMIT offset, count  -> LIMIT 1, 1   -> skips the first row and return the first row after that




/*
176. Second Highest Salary




Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+

*/
