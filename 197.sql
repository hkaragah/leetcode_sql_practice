# Write your MySQL query statement below
SELECT
    Current.id
FROM
    Weather AS Current
LEFT JOIN
    Weather AS Previous
    ON Previous.recordDate = (
        SELECT MAX(recordDate)
        FROM Weather
        WHERE recordDate < Current.recordDate
        )
WHERE
    Previous.temperature IS NOT NULL
    AND Previous.temperature < Current.temperature
