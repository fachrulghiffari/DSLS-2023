SELECT TOP(5) p.ProductID,  p.ProductName, SUM(od.Quantity) 'TotalQuantity'
FROM [Northwind].[dbo].[Order Details] od
LEFT JOIN [Northwind].[dbo].[Products] p 
	ON od.ProductID = p.ProductID
WHERE OrderID in (
	SELECT OrderID
	FROM [Northwind].[dbo].Orders
	WHERE DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(MONTH, OrderDate) = 1)
GROUP BY p.ProductID,  p.ProductName
ORDER BY TotalQuantity DESC;