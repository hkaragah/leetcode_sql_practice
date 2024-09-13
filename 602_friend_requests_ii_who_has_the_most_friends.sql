--Example
Create table If Not Exists RequestAccepted (requester_id int not null, accepter_id int null, accept_date date null)
Truncate table RequestAccepted
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03')
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08')
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08')
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09')



--My Solution
WITH T1 AS (
    SELECT requester_id AS id, COUNT(accepter_id) AS cnt
    FROM RequestAccepted
    GROUP BY requester_id
), T2 AS (
    SELECT accepter_id AS id, COUNT(requester_id) AS cnt
    FROM RequestAccepted
    GROUP BY accepter_id    
), Combined AS (
    SELECT T1.id, (T1.cnt + COALESCE(T2.cnt,0)) AS num
    FROM T1
    LEFT JOIN T2 ON T2.id=T1.id
    UNION
    SELECT T2.id, (T2.cnt + COALESCE(T1.cnt,0)) AS num
    FROM T2
    LEFT JOIN T1 ON T1.id=T2.id
)

SELECT id, num
FROM Combined
GROUP BY id
HAVING num=(SELECT MAX(num) FROM Combined)



--Better Solution (Brute Force Approach)
# Write your MySQL query statement below
SELECT A AS id, COUNT(*) AS num
FROM (
    SELECT requester_id AS A, accepter_id AS B
    FROM RequestAccepted
    UNION
    SELECT accepter_id AS A, requester_id AS B
    FROM RequestAccepted
)s
GROUP BY A ORDER BY num DESC LIMIT 1



/*
602. Friend Requests II: Who Has the Most Friends



Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.

The result format is in the following example.

 

Example 1:

Input: 
RequestAccepted table:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
Output: 
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+
Explanation: 
The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.
 

Follow up: In the real world, multiple people could have the same most number of friends. Could you find all these people in this case?

*/
