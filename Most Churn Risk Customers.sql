WITH cust AS (
    SELECT 
        customer_id,
        customer_name,
        MAX(recency_days) AS recency_days,
        MAX(frequency) AS frequency,
        MAX(monetary) AS monetary,
        AVG(CLTV_pred) AS CLTV_pred
    FROM bpis_data
    GROUP BY customer_id, customer_name
)
SELECT TOP 20 *
FROM cust
ORDER BY recency_days DESC;
