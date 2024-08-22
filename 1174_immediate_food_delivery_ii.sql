-- WITH earliest_orders AS(
--     SELECT
--         customer_id,
--         MIN(order_date) first_order_date
--     FROM
--         Delivery
--     GROUP BY
--         customer_id
-- )

-- SELECT
--     ROUND(
--         AVG(
--             CASE
--                 WHEN d.order_date = d.customer_pref_delivery_date
--                 THEN 1
--                 ELSE 0 END
--         ) * 100 , 2
--     ) AS immediate_percentage
-- FROM
--     Delivery AS d
-- INNER JOIN
--     earliest_orders AS eo
--     ON d.customer_id = eo.customer_id
--     AND d.order_date = eo.first_order_date



Select 
    ROUND(
        AVG(order_date = customer_pref_delivery_date) * 100, 2
    ) AS immediate_percentage
FROM 
    Delivery
WHERE 
    (customer_id, order_date) IN (
        SELECT 
            customer_id, 
            MIN(order_date) 
        FROM 
            Delivery
        GROUP BY 
            customer_id
    );
