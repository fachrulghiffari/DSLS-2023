SELECT DISTINCT o.CustomerID, c.CompanyName
FROM [Northwind].[dbo].[Orders] o
JOIN [Northwind].[dbo].[Customers] c 
	ON o.CustomerID = c.CustomerID
JOIN [Northwind].[dbo].[Order Details] od
	ON o.OrderID = od.OrderID
JOIN [Northwind].[dbo].[Products] p
	ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Chai'
	AND DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(MONTH, OrderDate) = 6;