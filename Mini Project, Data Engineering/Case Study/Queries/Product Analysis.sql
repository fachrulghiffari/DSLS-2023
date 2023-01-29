WITH CTE AS (
			SELECT YEAR(o.OrderDate) [Year], DATENAME(MONTH, o.OrderDate) [Month],
			c.CategoryName, p.ProductName,
			CAST(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) AS DECIMAL(18,2)) AS Sales
			FROM Northwind.dbo.Orders o
			JOIN Northwind.dbo.[Order Details] od
				ON o.OrderID = od.OrderID
			JOIN Northwind.dbo.Products p
				ON od.ProductID = p.ProductID
			JOIN Northwind.dbo.Categories c
				ON p.CategoryID = c.CategoryID
			GROUP BY YEAR(o.OrderDate), DATENAME(MONTH, o.OrderDate),
					DATEPART(MONTH, o.OrderDate), c.CategoryName, p.ProductName),

CTE2 AS (
		SELECT DISTINCT YEAR(o.OrderDate) [Year], DATENAME(MONTH, o.OrderDate) [Month],
						DATEPART(MONTH, o.OrderDate) MonthNo, a.CategoryName, a.ProductName
		FROM Northwind.dbo.Orders o
		CROSS JOIN (SELECT c.CategoryName, p.ProductName
		FROM Northwind.dbo.Categories c
		JOIN Northwind.dbo.Products p
			ON p.CategoryID = c.CategoryID) a
		)

SELECT c2.Year, c2.Month, c2.CategoryName, c2.ProductName, 
		COALESCE(c.Sales, 0) Sales
FROM CTE c
RIGHT JOIN CTE2 c2
	ON c.Year = c2.Year 
		AND c.Month = c2.Month
		AND c.CategoryName = c2.CategoryName
		AND c.ProductName = c2.ProductName
ORDER BY c2.Year, c2.MonthNo, c2.CategoryName, c2.ProductName;