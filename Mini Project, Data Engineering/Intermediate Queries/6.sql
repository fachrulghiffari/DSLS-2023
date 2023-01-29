WITH CTE AS (
	SELECT OrderID, SUM(UnitPrice*Quantity) PurchaseAmount
	FROM [Northwind].[dbo].[Order Details]
	GROUP BY OrderID)

SELECT DISTINCT c.CompanyName
FROM [Northwind].[dbo].[Orders] o
LEFT JOIN [Northwind].[dbo].[Customers] c 
	ON o.CustomerID = c.CustomerID
WHERE o.OrderID in (
	SELECT OrderID
	FROM CTE
	WHERE PurchaseAmount > 500) 
	AND DATEPART(YEAR, OrderDate) = 1997;