WITH CTE AS (SELECT DATENAME(MONTH, o.OrderDate) [Month], 
				p.ProductName, SUM(od.Quantity) TotalQuantity,
				ROW_NUMBER() OVER(PARTITION BY DATEPART(MONTH, o.OrderDate) ORDER BY SUM(od.Quantity) DESC) AS QR
FROM [Northwind].[dbo].[Order Details] od
JOIN [Northwind].[dbo].[Orders] o ON o.OrderID = od.OrderID
JOIN [Northwind].[dbo].[Products] P ON od.ProductID = p.ProductID
WHERE DATEPART(YEAR, o.OrderDate) = 1997
GROUP BY DATEPART(MONTH, o.OrderDate), DATENAME(month, o.OrderDate), p.ProductName)

SELECT [Month], ProductName, TotalQuantity
FROM CTE
WHERE QR <= 5;