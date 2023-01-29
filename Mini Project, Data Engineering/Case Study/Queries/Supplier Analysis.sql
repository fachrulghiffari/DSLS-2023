SELECT s.CompanyName, p.ProductName, c.CategoryName, 
		CAST(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) AS DECIMAL(18,2)) AS Sales
FROM Northwind.dbo.Orders o
JOIN Northwind.dbo.[Order Details] od
	ON o.OrderID = od.OrderID
JOIN Northwind.dbo.Products p
	ON od.ProductID = p.ProductID
JOIN Northwind.dbo.Suppliers s
	ON p.SupplierID = s.SupplierID
JOIN Northwind.dbo.Categories c
	ON p.CategoryID = c.CategoryID
GROUP BY s.CompanyName, p.ProductName,  c.CategoryName
ORDER BY CompanyName;