WITH stats AS (
    SELECT 
        AVG(profit) AS avg_profit,
        STDEV(profit) AS sd_profit
    FROM bpis_data
)
SELECT 
    b.*
FROM bpis_data AS b
CROSS JOIN stats AS s
WHERE 
    b.profit > s.avg_profit + 3 * s.sd_profit
    OR b.profit < s.avg_profit - 3 * s.sd_profit
ORDER BY b.profit;
