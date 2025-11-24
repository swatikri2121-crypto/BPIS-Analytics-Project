WITH last_date AS (
    SELECT MAX(order_date) AS max_date
    FROM bpis_data
)
SELECT
    p.product_id,
    p.product_name,
    SUM(p.sales) AS total_sales,
    MAX(p.order_date) AS last_sold_date
FROM bpis_data AS p
CROSS JOIN last_date AS ld
GROUP BY 
    p.product_id,
    p.product_name,
    ld.max_date
HAVING 
    MAX(p.order_date) < DATEADD(MONTH, -12, ld.max_date)
ORDER BY 
    last_sold_date;
