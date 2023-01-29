WITH CTE AS (
	SELECT OrderID, SUM(UnitPrice*Quantity) PurchaseAmount
	FROM [Northwind].[dbo].[Order Details]
	GROUP BY OrderID)

SELECT PurchaseRange, COUNT(*) AS TotalOrder
FROM (SELECT 
	CASE 
		WHEN PurchaseAmount <= 100 THEN '<= 100'
		WHEN PurchaseAmount > 100 AND PurchaseAmount <= 250 THEN '100 < x <=250'
		WHEN PurchaseAmount > 250 AND PurchaseAmount <= 500 THEN '250 < x <=500'
		WHEN PurchaseAmount > 500 THEN '> 500'
		END AS PurchaseRange
	FROM CTE) AS A
GROUP BY PurchaseRange
ORDER BY PurchaseRange;
