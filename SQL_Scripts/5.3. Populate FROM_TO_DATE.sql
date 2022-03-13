USE GlobalSuperstore
GO

declare @dtStartDate datetime
declare @dtEndDate datetime

SELECT @dtStartDate = '1/1/2011'
SELECT @dtEndDate = '12/31/2011'
INSERT INTO FROM_TO_DATE (StartDate, EndDate) values (@dtStartDate , @dtEndDate)