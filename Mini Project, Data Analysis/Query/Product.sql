WITH CTE AS (
			SELECT CAST(o.OrderDate AS DATE) [Date], c.CategoryName, p.ProductName,
					CAST(SUM(od.UnitPrice*od.Quantity) AS DECIMAL(18,2)) AS [Sales],
					CAST(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) AS DECIMAL(18,2)) AS [Sales After Discount]
			FROM Northwind.dbo.Orders o
			JOIN Northwind.dbo.[Order Details] od
				ON o.OrderID = od.OrderID
			JOIN Northwind.dbo.Products p
				ON od.ProductID = p.ProductID
			JOIN Northwind.dbo.Categories c
				ON p.CategoryID = c.CategoryID
			GROUP BY o.OrderDate, c.CategoryName, p.ProductName),

CTE2 AS (
		SELECT m.my_date [Date],
				a.CategoryName, a.ProductName
		FROM Northwind.dbo.my_table m
		CROSS JOIN (SELECT c.CategoryName, p.ProductName
					FROM Northwind.dbo.Categories c
					JOIN Northwind.dbo.Products p
					ON p.CategoryID = c.CategoryID) a
		)

SELECT c2.[Date], YEAR(c2.[Date]) [Year], MONTH(c2.[Date]) [Month], 
		DAY(c2.[Date]) [Day], c2.CategoryName, c2.ProductName,
		COALESCE(c.Sales, 0) Sales,
		COALESCE(c.[Sales After Discount], 0) [Sales After Discount]
FROM CTE c
RIGHT JOIN CTE2 c2
	ON c.[Date] = c2.[Date] 
		AND c.CategoryName = c2.CategoryName
		AND c.ProductName = c2.ProductName
ORDER BY [Date], CategoryName, ProductName;
