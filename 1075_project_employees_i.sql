SELECT
    p.project_id,
    ROUND(SUM(e.experience_years) / COUNT(p.employee_id), 2) AS average_years
    -- Alternative: ROUND(AVG(e.experience_years),2) AS average_years
FROM
    Project AS p
LEFT JOIN
    Employee AS e
    ON e.employee_id = p.employee_id
GROUP BY
    p.project_id
