USE [TalentConnect]
GO
/****** Object:  StoredProcedure [dbo].[TS_Sproc_Insert_Update_Talent_Leaves]    Script Date: 19-12-2024 19:37:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[TS_Sproc_Insert_Update_Talent_Leaves]        
    @TalentID BIGINT = NULL,
    @LeaveDateStr NVARCHAR(100) = NULL,
    @LeaveDuration NVARCHAR(100) = NULL,
    @LeaveReason NVARCHAR(MAX) = NULL,
	@LeaveID  NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @LeaveDate DATETIME;
	SELECT @LeaveDate = CASE WHEN @LeaveDateStr IS NOT NULL THEN CONVERT(DATETIME, @LeaveDateStr, 105) ELSE NULL END 
	
    BEGIN
        INSERT INTO gen_Talent_LeaveRequests (
            TalentID, 
            LeaveDate, 
            LeaveDuration, 
            LeaveReason,            
            Status, 
            CreatedDate,             
            IsActive,
			LeaveID
        ) 
        VALUES (
            @TalentID, 
            @LeaveDate, 
            @LeaveDuration, 
            @LeaveReason, 
            'Pending',
			GETDATE(),
			1,
			@LeaveID
        );
    END   
END;
