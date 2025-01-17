ALTER PROCEDURE [dbo].[TS_Sproc_Insert_Update_Talent_Leaves]        
    @TalentID BIGINT = NULL,
    @LeaveDateStr NVARCHAR(100) = NULL,
    @LeaveDuration NVARCHAR(100) = NULL,
    @LeaveReason NVARCHAR(MAX) = NULL,
	@LeaveID  NVARCHAR(500) = NULL,
	@Flag NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @LeaveDate DATETIME;
	SELECT @LeaveDate = CASE WHEN @LeaveDateStr IS NOT NULL THEN CONVERT(DATETIME, @LeaveDateStr, 105) ELSE NULL END 

	IF(@Flag = 'Update')
	BEGIN
		DELETE FROM gen_Talent_LeaveRequests WHERE LeaveID = @LeaveID
		SET @Flag = 'Add'
	END
	
	IF(@Flag = 'Add')
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
