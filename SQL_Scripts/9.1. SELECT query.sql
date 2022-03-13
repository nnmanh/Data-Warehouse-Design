USE GlobalSuperstore
GO

SELECT COUNT (DISTINCT OrderID)
FROM DIM_ORDERS

/*Output: 25036 */