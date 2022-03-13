USE GlobalSuperstore
Go

CREATE TABLE DIM_CALENDAR (
	calendar_wk 	int 		NOT NULL,
	calendar_nk	datetime	NULL,
	full_date 	nvarchar(20)	NULL,
	day_of_week	tinyint		NULL,
	day_of_month	tinyint		NULL,
	day_of_year	smallint	NULL,
	month_num	tinyint		NULL,
	month_ldesc	nvarchar(9)	NULL,
	month_sdesc	nchar(3)	NULL,
	quarter_num	tinyint		NULL,
	quarter_ldesc	nvarchar(10)	NULL,
	quarter_sdesc	nvarchar(10)	NULL,
	year_num	smallint	NULL,
	year_sdesc	nchar(4)	NULL
)

Go

CREATE UNIQUE INDEX IDX_DIM_CALENDAR ON DIM_CALENDAR
	(
		calendar_nk
	)
Go

ALTER TABLE DIM_CALENDAR
	ADD PRIMARY KEY (calendar_wk)
Go