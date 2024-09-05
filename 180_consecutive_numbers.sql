--Example
Create table If Not Exists Logs (id int, num int)
Truncate table Logs
insert into Logs (id, num) values ('1', '1')
insert into Logs (id, num) values ('2', '1')
insert into Logs (id, num) values ('3', '1')
insert into Logs (id, num) values ('4', '2')
insert into Logs (id, num) values ('5', '1')
insert into Logs (id, num) values ('6', '2')
insert into Logs (id, num) values ('7', '2')



--Solution #1
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs AS l1
JOIN Logs AS l2 ON l1.id = l2.id - 1 AND l1.num = l2.num
JOIN Logs AS l3 ON l2.id = l3.id - 1 AND l2.num = l3.num


--Solution #2
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.id = l2.id - 1
    AND l2.id = l3.id - 1
    AND l1.num= l2.num
    AND l2.num= l3.num


--Solution #3
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT
        id,
        num,
        LAG(num, 1) OVER (ORDER BY id) AS prev_num,
        LEAD(num, 1) OVER (ORDER BY id) AS next_num,
        LAG(id, 1) OVER (ORDER BY id) AS prev_id,
        LEAD(id, 1) OVER (ORDER BY id) AS next_id
    FROM Logs
) AS LeadLagTable
WHERE 
    num = prev_num 
    AND num = next_num
    AND id = prev_id + 1
    AND id = next_id - 1



/*
180. Consecutive Numbers



Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.

*/
