USE [TalentConnect]
GO
/****** Object:  StoredProcedure [dbo].[TS_Sproc_Approve_Reject_Revoke_Talent_Leaves]    Script Date: 19-12-2024 19:44:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[TS_Sproc_Approve_Reject_Revoke_Talent_Leaves]
    @LeaveID NVARCHAR(500) = NULL,
	@ActionDoneBy BIGINT = NULL,  
    @IsActionDoneByAM BIT = NULL,  
	@LeaveRejectionRemark NVARCHAR(MAX) = NULL,
	@Flag NVARCHAR(50) = NULL -- Approve, Reject, Revoke
AS
BEGIN
    SET NOCOUNT ON;

    IF (@Flag = 'Approve')
    BEGIN
        UPDATE gen_Talent_LeaveRequests
		SET 			
			Status = 'Approved',			
			ApprovedBy = @ActionDoneBy,
			ApprovalDate = GETDATE(),
			IsApprovedByAM = @IsActionDoneByAM			
		WHERE LeaveID = @LeaveID;
    END
	IF (@Flag = 'Reject')
    BEGIN
        UPDATE gen_Talent_LeaveRequests
		SET 			
			Status = 'Rejected',			
			RejectedBy = @ActionDoneBy,
			RejectedDate = GETDATE(),
			IsRejectedByAM = @IsActionDoneByAM,
			LeaveRejectionRemark = CASE WHEN @LeaveRejectionRemark IS NOT NULL THEN @LeaveRejectionRemark ELSE LeaveRejectionRemark END
		WHERE LeaveID = @LeaveID;
    END
	IF (@Flag = 'Revoke')
    BEGIN
        UPDATE gen_Talent_LeaveRequests
		SET 			
			IsActive = 0		
		WHERE LeaveID = @LeaveID;
    END     
END;
