SELECT 
    product_id,
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(profit) / NULLIF(SUM(sales), 0) AS margin_ratio
FROM bpis_data
GROUP BY product_id, product_name
HAVING 
    SUM(sales) > 5000      -- threshold
    AND SUM(profit) < 0
ORDER BY total_sales DESC;
