USE GlobalSuperstore
Go

CREATE TABLE DIM_LOCATION (
	loc_wk 			int 		IDENTITY,
	city			nchar(30)	NULL,
	state			nchar(30)	NULL,
	country			nchar(30)	NULL,
)

GO

ALTER TABLE DIM_LOCATION
	ADD PRIMARY KEY (loc_wk)
Go

CREATE INDEX IDX_DIM_LOCATION ON DIM_LOCATION
	(
		city,
		state,
		country
	)
Go