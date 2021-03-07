SELECT *
FROM ddw1DW.DimCustomer;
GO

SELECT *
FROM ddw1DW.DimProduct;
GO

-- TRUNCATE TABLE ddw1DW.FactSales;

SELECT *
FROM ddw1DW.FactSales;
GO

SELECT count(1)
FROM ddw1DW.DimTime;
GO

-- SELECT *
-- FROM ddw1DW.DimTime;
-- GO

SELECT *
FROM ddw1DW.DimTime
WHERE TimeKey = 367;
GO

SELECT CustomerID, ProductID, SUM(TotalAmount) AS Total
FROM ddw1DW.FactSales
-- WHERE TimeKey = 369
GROUP BY CustomerID, ProductID
ORDER BY CustomerID

