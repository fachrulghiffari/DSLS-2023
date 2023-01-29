SELECT s.CompanyName, o.ShipCountry, COUNT(o.ShipCountry) AS Jumlah
FROM Northwind.dbo.Orders o
JOIN Northwind.dbo.Shippers s
	ON o.ShipVia = s.ShipperID
GROUP BY ShipCountry, s.CompanyName
ORDER BY Jumlah DESC;