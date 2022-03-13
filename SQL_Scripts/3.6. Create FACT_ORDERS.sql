USE GlobalSuperstore
Go

CREATE TABLE FACT_ORDERS (
	Orders_wk 		int 		IDENTITY,
	OrdersID		nchar(30) 	NOT NULL,
	ProductID		nchar(30) 	NOT NULL,
	Sales			float 		NOT NULL,
	Quantity		int 		NOT NULL,
	Discount		float 		NOT NULL,
	Profit			float 		NOT NULL,
	ShippingCost	float 		NOT NULL,
	Order_Dt_wk		int 		NOT NULL,
	Ship_Dt_wk		int 		NULL,	
	Loc_wk			int 		NOT NULL,
	C_wk			int			NOT NULL,
	Prod_wk			int			NOT NULL,
	Order_wk		int			NOT NULL,
	Response		int			NULL
)

GO

CREATE INDEX IDX_FACT_ORDERS ON FACT_ORDERS
	(
		OrdersID,
		ProductID
	)
Go

CREATE INDEX IDX_FACT_C_wk ON FACT_ORDERS
	(
		C_wk
	)
Go

CREATE INDEX IDX_FACT_Loc_wk ON FACT_ORDERS
	(
		Loc_wk
	)
Go

CREATE INDEX IDX_FACT_Order_Dt_wk ON FACT_ORDERS
	(
		Order_Dt_wk
	)
Go


CREATE INDEX IDX_FACT_Order_wk ON FACT_ORDERS
	(
		Order_wk
	)
Go

CREATE INDEX IDX_FACT_Prod_wk ON FACT_ORDERS
	(
		Prod_wk
	)
Go


CREATE INDEX IDX_FACT_Ship_Dt_wk ON FACT_ORDERS
	(
		Ship_Dt_wk
	)
Go
