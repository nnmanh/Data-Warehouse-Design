use GlobalSuperstore
Go

declare @dtStartDate datetime
declare @dtEndDate datetime
TRUNCATE TABLE FROM_TO_DATE
SELECT @dtStartDate = '1/1/2013'
SELECT @dtEndDate = '12/31/2013'
INSERT INTO FROM_TO_DATE (StartDate, EndDate) values (@dtStartDate , @dtEndDate)

GO

 
/* Drop Index */

IF EXISTS (SELECT * FROM dbo.sysindexes WHERE NAME = 'IDX_STAGE_LOCATION')
DROP INDEX STAGE_ORDERS.IDX_STAGE_LOCATION
Go

IF EXISTS (SELECT * FROM dbo.sysindexes WHERE NAME = 'IDX_STAGE_CUSTOMER')
DROP INDEX STAGE_ORDERS.IDX_STAGE_CUSTOMER
Go

IF EXISTS (SELECT * FROM dbo.sysindexes WHERE NAME = 'IDX_STAGE_ORDERS')
DROP INDEX STAGE_ORDERS.IDX_STAGE_ORDERS
Go

IF EXISTS (SELECT * FROM dbo.sysindexes WHERE NAME = 'IDX_STAGE_PRODUCT')
DROP INDEX STAGE_ORDERS.IDX_STAGE_PRODUCT
Go



TRUNCATE TABLE STAGE_ORDERS
Go

Use OP
Go



/* Populating Stage_ORDERS */

declare @dtStartDate datetime
declare @dtEndDate datetime

SELECT @dtStartDate = (SELECT StartDate FROM GlobalSuperstore.dbo.FROM_TO_DATE)
SELECT @dtEndDate =  (SELECT EndDate FROM GlobalSuperstore.dbo.FROM_TO_DATE)

Insert into  GlobalSuperstore.dbo.STAGE_ORDERS(CustomerID_ST, Sales_ST, Quantity_ST, Discount_ST, Profit_ST, ShippingCost_ST,
Order_Dt_ST, Ship_Dt_ST, city_ST, state_ST, country_ST, ProductID_ST, OrderID_ST, CustomerName_ST, Segment_ST,
SubCategory_ST, Category_ST, ProductName_ST, ShipMode_ST, OrderPriority_ST ,Response)

SELECT     O.CustomerID, Sales, Quantity, Discount, Profit, ShippingCost, OrderDate, ShipDate, City, State, Country, 
ProductID, OrderID, CustomerName, Segment, SubCategory, Category, ProductName, ShipMode, OrderPriority,
	DATEDIFF(dd, O.OrderDate, O.ShipDate) AS Response

FROM         Orders O 

WHERE (O.OrderDate BETWEEN @dtStartDate AND @dtEndDate)
	OR
	(O.ShipDate BETWEEN @dtStartDate AND @dtEndDate)


GROUP BY
	O.CustomerID, Sales, Quantity, Discount, Profit, ShippingCost, OrderDate, ShipDate, City, State, Country, ProductID, 
	OrderID, CustomerName, Segment, SubCategory, Category, ProductName, ShipMode, OrderPriority



/* Create Index */
Use GlobalSuperstore
Go

CREATE INDEX IDX_STAGE_LOCATION ON dbo.STAGE_ORDERS
	(
		city_ST,
		state_ST,
		country_ST
	)

CREATE INDEX IDX_STAGE_CUSTOMER ON dbo.STAGE_ORDERS
	(
		CustomerID_ST
	)

CREATE INDEX IDX_STAGE_ORDERS ON dbo.STAGE_ORDERS
	(
		OrderID_ST
	)

CREATE INDEX IDX_STAGE_PRODUCT ON dbo.STAGE_ORDERS
	(
		ProductID_ST
	)

GO

use GlobalSuperstore
Go

/* Cleansing and Loading LOCATION */



UPDATE    STAGE_ORDERS
SET              record_Loc_exists = 'Y'
FROM STAGE_ORDERS S, DIM_LOCATION D
WHERE 
ISNULL(S.country_ST, ' ') = ISNULL(D.country, ' ')  AND
ISNULL(S.state_ST, ' ') = ISNULL(D.state, ' ')  AND
ISNULL(S.city_ST, ' ') = ISNULL(D.city, ' ')  


INSERT INTO DIM_LOCATION (country, state, city)
SELECT DISTINCT country_ST, state_ST, city_ST
FROM 
STAGE_ORDERS
WHERE record_Loc_exists IS NULL 

/* Cleansing Customer */

UPDATE
    STAGE_ORDERS
SET
    record_C_exists = 'Y'

FROM STAGE_ORDERS S, DIM_CUSTOMER D

WHERE 

S.CustomerID_ST = D.CustomerID



/* Loading Customer */
INSERT INTO
	DIM_CUSTOMER
	(CustomerID, CustomerName, Segment)
SELECT DISTINCT CustomerID_ST, CustomerName_ST, Segment_ST
FROM
	STAGE_ORDERS
WHERE
	record_C_exists IS NULL
go

UPDATE DIM_CUSTOMER

SET

CustomerID = S.CustomerID_ST,
CustomerName = S.CustomerName_ST,
Segment = S.Segment_ST


FROM

DIM_CUSTOMER D, STAGE_ORDERS S

WHERE D.CustomerID = S.CustomerID_ST AND
	S.record_C_exists = 'Y'
go

/* Cleansing ORDERS */

UPDATE
    STAGE_ORDERS
SET
    record_Order_exists = 'Y'

FROM STAGE_ORDERS S, DIM_ORDERS D

WHERE 

S.OrderID_ST = D.OrderID

/* Loading Shipper */
INSERT INTO
	DIM_ORDERS
	(OrderID, ShipMode, OrderPriority)
SELECT DISTINCT OrderID_ST, ShipMode_ST, OrderPriority_ST
FROM
	STAGE_ORDERS
WHERE
	record_Order_exists IS NULL
go

UPDATE DIM_ORDERS

SET
OrderID = S.OrderID_ST,
ShipMode = S.ShipMode_ST,
OrderPriority = S.OrderPriority_ST

FROM

DIM_ORDERS D, STAGE_ORDERS S

WHERE D.OrderID = S.OrderID_ST AND
	S.record_Order_exists = 'Y'
go

/* Cleansing and Loading Product */

UPDATE
    STAGE_ORDERS
SET
    record_Prod_exists = 'Y'

FROM STAGE_ORDERS S, DIM_PRODUCT D

WHERE 

S.ProductID_ST = D.ProductID


INSERT INTO
	DIM_PRODUCT
		(ProductID, SubCategory, Category, ProductName)
SELECT DISTINCT
	ProductID_ST, SubCategory_ST, Category_ST, ProductName_ST
FROM
	STAGE_ORDERS
WHERE
	record_Prod_exists IS NULL


UPDATE DIM_PRODUCT

SET

ProductID = S.ProductID_ST, 
SubCategory = S.SubCategory_ST, 
Category = S.Category_ST, 
ProductName = S.ProductName_ST

FROM

DIM_PRODUCT D, STAGE_ORDERS S

WHERE D.ProductID = S.ProductID_ST AND
	S.record_Prod_exists = 'Y'

use GlobalSuperstore
Go

/* Cleansing Order_Fact */

UPDATE    STAGE_ORDERS
SET       record_FactOrder_exists = 'Y'
FROM STAGE_ORDERS S, FACT_ORDERS F
WHERE S.OrderID_ST = F.OrdersID AND
	S.ProductID_ST = F.ProductID



UPDATE    STAGE_ORDERS
SET       loc_wk_ST = D.loc_wk
FROM  STAGE_ORDERS S,  DIM_LOCATION D
WHERE 

ISNULL(S.country_ST, ' ') = ISNULL(D.country, ' ')  AND
ISNULL(S.state_ST, ' ') = ISNULL(D.state, ' ')  AND
ISNULL(S.city_ST, ' ') = ISNULL(D.city, ' ') 



UPDATE    STAGE_ORDERS
SET       C_wk_ST = D.C_wk 
FROM  STAGE_ORDERS S,  DIM_CUSTOMER D
WHERE S.CustomerID_ST = D.CustomerID



UPDATE    STAGE_ORDERS
SET       Order_wk_ST = D.Order_wk
FROM  STAGE_ORDERS S,  DIM_ORDERS D
WHERE S.OrderID_ST = D.OrderID



UPDATE    STAGE_ORDERS
SET       Order_Dt_wk_ST = D.calendar_wk 
FROM  STAGE_ORDERS S,  DIM_CALENDAR D
WHERE S.Order_Dt_ST = D.calendar_nk

UPDATE    STAGE_ORDERS
SET       Ship_Dt_wk_ST = D.calendar_wk 
FROM  STAGE_ORDERS S,  DIM_CALENDAR D
WHERE S.Ship_Dt_ST = D.calendar_nk

UPDATE    STAGE_ORDERS
SET       Ship_Dt_wk_ST = 0
WHERE  Ship_Dt_wk_ST IS NULL



UPDATE    STAGE_ORDERS
SET       Prod_wk_ST = D.Prod_wk 
FROM  STAGE_ORDERS S,  DIM_PRODUCT D
WHERE S.ProductID_ST = D.ProductID


/* Loading Order_Fact */

	UPDATE FACT_ORDERS 
	SET Response = S.Response

	 FROM STAGE_ORDERS S, FACT_ORDERS F
	 WHERE S.OrderID_ST = F.OrdersID 
	 AND S.ProductID_ST = F.ProductID
	 AND S.record_FactOrder_exists = 'Y'

	INSERT INTO FACT_ORDERS
	(OrdersID, ProductID, Sales, Quantity, Discount, Profit, ShippingCost, Order_Dt_wk, Ship_Dt_wk, Loc_wk, C_wk, Prod_wk, Order_wk, Response)
	
	SELECT OrderID_ST, ProductID_ST, Sales_ST, Quantity_ST, Discount_ST, Profit_ST, ShippingCost_ST, Order_Dt_wk_ST, Ship_Dt_wk_ST, loc_wk_ST, C_wk_ST, Prod_wk_ST, Order_wk_ST, Response
	FROM STAGE_ORDERS WHERE record_FactOrder_exists IS NULL 
