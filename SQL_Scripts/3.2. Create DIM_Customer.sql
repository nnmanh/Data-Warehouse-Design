USE GlobalSuperstore
Go

CREATE TABLE DIM_CUSTOMER (
	C_wk 			int 		IDENTITY,
	CustomerID		nchar(30)	NULL,
	CustomerName	nchar(30)	NULL,
	Segment			nchar(30)	NULL
)

GO

CREATE INDEX IDX_DIM_CUSTOMER ON DIM_CUSTOMER
	(
		CustomerID
	)
Go

ALTER TABLE DIM_CUSTOMER
	ADD PRIMARY KEY (C_wk)
Go