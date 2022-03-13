Use GlobalSuperstore
Go

--  The following adds constraints to the GroupDW database

ALTER TABLE FACT_ORDERS
	ADD PRIMARY KEY (Orders_wk)
Go


ALTER TABLE FACT_ORDERS
	ADD CONSTRAINT [FK_Cwk] FOREIGN KEY 
	(
		[C_wk]
	) REFERENCES [dbo].[DIM_CUSTOMER] (
		[C_wk]
	)
GO


ALTER TABLE FACT_ORDERS
	ADD CONSTRAINT [FK_locwk] FOREIGN KEY 
	(
		[loc_wk]
	) REFERENCES [dbo].[DIM_LOCATION] (
		[loc_wk]
	)
GO


ALTER TABLE FACT_ORDERS
	ADD CONSTRAINT [FK_Prodwk] FOREIGN KEY 
	(
		[Prod_wk]
	) REFERENCES [dbo].[DIM_PRODUCT] (
		[Prod_wk]
	)
GO


ALTER TABLE FACT_ORDERS
	ADD CONSTRAINT [FK_Orderwk] FOREIGN KEY 
	(
		[Order_wk]
	) REFERENCES [dbo].[DIM_ORDERS] (
		[Order_wk]
	)
GO


ALTER TABLE FACT_ORDERS
	ADD CONSTRAINT [FK_Orderdtwk] FOREIGN KEY 
	(
		[Order_dt_wk]
	) REFERENCES [dbo].[DIM_CALENDAR] (
		[calendar_wk]
	)
GO


ALTER TABLE FACT_ORDERS
	ADD CONSTRAINT [FK_Shipdtwk] FOREIGN KEY 
	(
		[Ship_dt_wk]
	) REFERENCES [dbo].[DIM_CALENDAR] (
		[calendar_wk]
	)
GO