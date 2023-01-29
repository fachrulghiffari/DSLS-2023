CREATE VIEW OrderDetails
AS
SELECT OrderID, od.ProductID, ProductName, od.UnitPrice, Quantity, Discount,
		(od.UnitPrice*Quantity*(1-Discount)) AS TotalPayment 
FROM [Northwind].[dbo].[Order Details] od
JOIN [Northwind].[dbo].[Products] p ON p.ProductID = od.ProductID;