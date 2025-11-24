WITH cust AS (
    SELECT 
        customer_id,
        customer_name,
        MAX(recency_days) AS recency_days,
        MAX(frequency) AS frequency,
        MAX(monetary) AS monetary,
        MAX(RFM_Score) AS RFM_Score,
        AVG(CLTV_pred) AS CLTV_pred
    FROM bpis_data
    GROUP BY customer_id, customer_name
)
SELECT 
    CASE 
        WHEN recency_days <= 30 THEN 'Active (≤ 30 days)'
        WHEN recency_days <= 90 THEN 'Warm (31–90 days)'
        WHEN recency_days <= 180 THEN 'At Risk (91–180 days)'
        ELSE 'Churned (> 180 days)'
    END AS churn_segment,
    COUNT(*) AS num_customers,
    AVG(recency_days) AS avg_recency,
    AVG(frequency) AS avg_frequency,
    AVG(monetary) AS avg_monetary,
    AVG(CLTV_pred) AS avg_cltv
FROM cust
GROUP BY 
    CASE 
        WHEN recency_days <= 30 THEN 'Active (≤ 30 days)'
        WHEN recency_days <= 90 THEN 'Warm (31–90 days)'
        WHEN recency_days <= 180 THEN 'At Risk (91–180 days)'
        ELSE 'Churned (> 180 days)'
    END
ORDER BY churn_segment;
