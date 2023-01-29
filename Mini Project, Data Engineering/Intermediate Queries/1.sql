WITH CTE AS (
	SELECT DATEPART(MONTH, OrderDate) A, DATENAME(MONTH, OrderDate) [Month]
	,COUNT(DISTINCT CustomerID) JumlahCustomer
	FROM [Northwind].[dbo].[Orders]
	WHERE DATEPART(YEAR, OrderDate) = 1997
	GROUP BY DATEPART(MONTH, OrderDate), DATENAME(MONTH, OrderDate))

SELECT [MONTH], JumlahCustomer
FROM CTE
ORDER BY A