SELECT 
    CASE 
        WHEN discount <= 0.20 THEN '≤ 20% Discount'
        ELSE '> 20% Discount'
    END AS discount_band,
    AVG(profit) AS avg_profit,
    AVG(profit_margin) AS avg_profit_margin,
    AVG(margin_pct) AS avg_margin_pct,
    COUNT(*) AS num_orders
FROM bpis_data
GROUP BY 
    CASE 
        WHEN discount <= 0.20 THEN '≤ 20% Discount'
        ELSE '> 20% Discount'
    END
ORDER BY discount_band;
