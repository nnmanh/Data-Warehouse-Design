USE GlobalSuperstore
Go

CREATE TABLE STAGE_ORDERS (
	CustomerID_ST			nchar(30)	NOT NULL,
	Sales_ST				float 		NULL,
	Quantity_ST				int 		NULL,
	Discount_ST				float 		NULL,
	Profit_ST				float 		NULL,
	ShippingCost_ST			float 		NULL,
	Order_Dt_ST				datetime 	NULL,
	Ship_Dt_ST				datetime 	NULL,	
	loc_wk_ST 				int 		NULL,
	city_ST					nchar(30)	NULL,
	state_ST				nchar(30)	NULL,
	country_ST				nchar(30)	NULL,
	ProductID_ST			nchar(30)	NULL,
	OrderID_ST				nchar(30)	NULL,
	Order_Dt_wk_ST			int 		NULL,
	Ship_Dt_wk_ST			int 		NULL,	
	C_wk_ST					int			NULL,
	CustomerName_ST			nchar(30)	NULL,
	Segment_ST				nchar(30)	NULL,
	Prod_wk_ST				int			NULL,
	SubCategory_ST			nchar(30)	NULL, 
	Category_ST				nchar(24)	NULL, 
	ProductName_ST			nchar(255)	NULL,
	Order_wk_ST				int			NULL,
	ShipMode_ST				nchar(30)	NULL,
	OrderPriority_ST		nchar(30)	NULL,
	Response				int			NULL,
	record_C_exists			char(1)		NULL,
	record_Prod_exists		char(1)		NULL,
	record_Order_exists		char(1)		NULL,
	record_Loc_exists		char(1)		NULL,
	record_FactOrder_exists char(1)		NULL
)

CREATE INDEX IDX_STAGE_LOCATION ON STAGE_ORDERS
	(
		city_ST,
		state_ST,
		country_ST
	)

CREATE INDEX IDX_STAGE_CUSTOMER ON STAGE_ORDERS
	(
		CustomerID_ST
	)

CREATE INDEX IDX_STAGE_ORDERS ON STAGE_ORDERS
	(
		OrderID_ST
	)

CREATE INDEX IDX_STAGE_PRODUCT ON STAGE_ORDERS
	(
		ProductID_ST
	)

GO
