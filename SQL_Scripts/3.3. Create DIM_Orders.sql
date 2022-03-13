USE GlobalSuperstore
Go

CREATE TABLE DIM_ORDERS (
	Order_wk 		int 		IDENTITY,
	OrderID			nchar(30)	NULL,
	ShipMode		nchar(30)	NULL,
	OrderPriority	nchar(30)	NULL
)

GO

CREATE INDEX IDX_DIM_Product ON DIM_ORDERS
	(
		OrderID
	)
Go


ALTER TABLE DIM_ORDERS
	ADD PRIMARY KEY (Order_wk)
Go
