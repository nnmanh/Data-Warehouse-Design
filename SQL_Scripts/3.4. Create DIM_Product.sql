USE GlobalSuperstore
Go

CREATE TABLE DIM_PRODUCT (
	Prod_wk 		int 		IDENTITY,
	ProductID		nchar(30)	NULL,
	SubCategory		nchar(30)	NULL,
	Category		nchar(24)	NULL,
	ProductName		nchar(255)	NULL 
)

GO

CREATE INDEX IDX_DIM_PRODUCT ON DIM_PRODUCT
	(
		ProductID
	)
Go


ALTER TABLE DIM_PRODUCT
	ADD PRIMARY KEY (Prod_wk)
Go
