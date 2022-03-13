USE GlobalSuperstore
Go

INSERT INTO DIM_CALENDAR
	(calendar_wk, calendar_nk, full_date, month_ldesc, month_sdesc, quarter_ldesc, quarter_sdesc, year_sdesc)
	VALUES
	(0, NULL, 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A')


declare @dtStartDate datetime
declare @dtEndDate datetime
declare @dtCurrDate datetime

SELECT @dtStartDate = '1/1/2011'
SELECT @dtEndDate = '12/31/2015'

SELECT @dtCurrDate = DATEADD(d,1, MAX(calendar_nk))
FROM DIM_CALENDAR
WHERE calendar_nk IS NOT NULL

SELECT @dtCurrDate = ISNULL(@dtCurrDate, @dtStartDate)

WHILE @dtCurrDate <= @dtEndDate
BEGIN

INSERT INTO DIM_CALENDAR
	(
	calendar_wk, 
	calendar_nk, 
	full_date, 
	day_of_week,
	day_of_month,
	day_of_year,
	month_num,
	month_ldesc, 
	month_sdesc, 
	quarter_num, 
	quarter_ldesc, 
	quarter_sdesc, 
	year_num,
	year_sdesc)
	
VALUES

	(
	CONVERT(int, CONVERT(char(8), @dtCurrDate, 112)),
	@dtCurrDate,
	DATENAME(month, @dtCurrDate) + ' ' + CONVERT(nvarchar(2), DAY(@dtCurrDate)) + ', ' +  CONVERT(char(4), YEAR(@dtCurrDate)),
	DATEPART(dw, @dtCurrDate),
	DATEPART(d, @dtCurrDate),
	DATEPART(dy, @dtCurrDate),
	DATEPART(m, @dtCurrDate),
	SUBSTRING (DATENAME(m, @dtCurrDate),1,3) + ' ' + CONVERT(char(4), YEAR(@dtCurrDate)),
	SUBSTRING (DATENAME(m, @dtCurrDate),1,3),
	DATEPART(qq, @dtCurrDate), 
	'Q' + CONVERT(char(1), DATEPART(qq,@dtCurrDate))+ ' ' + CONVERT(char(4), YEAR(@dtCurrDate)),
	'Q' + CONVERT(char(1), DATEPART(qq,@dtCurrDate)),
	YEAR(@dtCurrDate), 
	CONVERT(char(4), YEAR(@dtCurrDate))
	)

SELECT @dtCurrDate  = DATEADD(d,1,@dtCurrDate)

END
