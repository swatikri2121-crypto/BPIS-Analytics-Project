BULK INSERT bpis_data
FROM 'C:\Users\swati\Desktop\BPIS\BPIS_full_features.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FORMAT = 'CSV',
    TABLOCK
);
GO
