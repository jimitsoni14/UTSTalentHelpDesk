USE [TalentConnect]
GO
/****** Object:  StoredProcedure [dbo].[TS_Sproc_Get_Talent_Leaves_Monthly_Calendar]    Script Date: 19-12-2024 20:15:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[TS_Sproc_Get_Talent_Leaves_Monthly_Calendar]  

	@TalentID BIGINT = NULL,
	@MonthNumber INT = NULL,
	@Year INT = NULL
AS
BEGIN 

	DECLARE @DaysOfTheMonthWithLeaveInfo TABLE
	(
		ActualDate NVARCHAR(500),
		DayOfWeeks NVARCHAR(100),
		IsLeave	 BIT,
		LeaveType Nvarchar(200),
		ColorCode NVARCHAR(20)
	)

	DECLARE @StartDate DATE = (SELECT DATEFROMPARTS(@Year, @MonthNumber, 1));
	DECLARE @EndDate DATE = EOMONTH(@StartDate);

	WITH DaysOfMonth AS (
		SELECT @StartDate AS DateValue
		UNION ALL
		SELECT DATEADD(DAY, 1, DateValue)
		FROM DaysOfMonth
		WHERE DATEADD(DAY, 1, DateValue) <= @EndDate
	)

	INSERT INTO @DaysOfTheMonthWithLeaveInfo
	SELECT DateValue, 
	DATENAME(WEEKDAY, DateValue) AS DayOfWeek,
	0, '',''	
	FROM DaysOfMonth
	OPTION (MAXRECURSION 0);

	UPDATE T1
	SET T1.IsLeave = 1,
	T1.LeaveType = LR.LeaveDuration,
	ColorCode = '#FF0000'
	FROM @DaysOfTheMonthWithLeaveInfo T1
	JOIN gen_Talent_LeaveRequests LR
		ON CAST(LR.LeaveDate AS DATE) = CAST(T1.ActualDate AS DATE)
	WHERE LR.TalentID = @TalentID AND LR.Status = 'Approved'

	UPDATE @DaysOfTheMonthWithLeaveInfo SET IsLeave = 1, ColorCode = '#FF0000' WHERE DayOfWeeks IN ('Sunday', 'Saturday')

	SELECT * FROM @DaysOfTheMonthWithLeaveInfo

END