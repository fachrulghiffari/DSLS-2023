CREATE PROCEDURE Invoice
(
	@CustomerID VARCHAR(5)
)

AS
BEGIN
	SELECT c.CustomerID, c.CompanyName, o.OrderID, o.OrderDate, o.RequiredDate, o.ShippedDate
	FROM [Northwind].[dbo].[Customers] c
	JOIN [Northwind].[dbo].[Orders] o ON c.CustomerID = o.CustomerID
	WHERE c.CustomerID = @CustomerID
END;