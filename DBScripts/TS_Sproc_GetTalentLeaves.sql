ALTER PROCEDURE [dbo].[TS_Sproc_GetTalentLeaves]  

	@TalentID BIGINT = NULL
AS
BEGIN    
	

	WITH LeaveDates AS (
    SELECT 
        TL.LeaveID,    
		TL.TalentID            ,		
		TL.LeaveDuration		,
		TL.LeaveReason			,
		TL.LeaveRejectionRemark,
		TL.Status			,
		CAST(TL.CreatedDate AS DATE) AS CreatedDate		,
		TL.ApprovedBy			,
		TL.ApprovalDate		,
		TL.IsApprovedByAM		,
		TL.RejectedBy			,
		TL.RejectedDate		,
		TL.IsRejectedByAM		,
		TL.IsActive,
		TA.FirstName + ' ' + TA.LastName AS TalentName,	
		ISNULL(T.FullName, T1.FullName) AS ApprovedByName,	
		ISNULL(TR.FullName, TR1.FullName) AS RejectedByName,
        ROW_NUMBER() OVER (PARTITION BY LeaveID ORDER BY LeaveDate DESC) AS RowDesc,
		ROW_NUMBER() OVER (PARTITION BY LeaveID ORDER BY LeaveDate ASC) AS RowAsc,
        CAST(CONVERT(varchar, LeaveDate, 107) AS NVARCHAR(MAX)) AS LeaveDate
    FROM gen_Talent_LeaveRequests TL WITH(NOLOCK) 
	INNER JOIN gen_Talent TA WITH(NOLOCK) ON TA.ID = TL.TalentID
	LEFT JOIN  usr_user T WITH(NOLOCK) ON TL.ApprovedBy = T.ID AND TL.IsApprovedByAM = 1 AND TL.Status = 'Approved'
	LEFT JOIN gen_Contact T1 WITH(NOLOCK) ON TL.ApprovedBy = T1.ID AND ISNULL(TL.IsApprovedByAM,0) = 0 AND TL.Status = 'Approved'
	LEFT JOIN  usr_user TR WITH(NOLOCK) ON TL.RejectedBy = TR.ID AND TL.IsRejectedByAM = 1 AND TL.Status = 'Rejected'
	LEFT JOIN gen_Contact TR1 WITH(NOLOCK) ON TL.RejectedBy = TR1.ID AND ISNULL(TL.IsRejectedByAM,0) = 0 AND TL.Status = 'Rejected'
    WHERE TalentID = @TalentID AND TL.IsActive = 1
	)
	
	SELECT DISTINCT
		LeaveID,
		TalentID            ,		
		LeaveDuration		,
		LeaveReason			,
		LeaveRejectionRemark,
		Status			,
		CreatedDate			,
		ApprovedBy			,
		ApprovalDate		,
		IsApprovedByAM		,
		RejectedBy			,
		RejectedDate		,
		IsRejectedByAM		,
		IsActive,
		TalentName,	
		ApprovedByName,	
		RejectedByName,
		STUFF((
			SELECT ' - ' + LeaveDate
			FROM LeaveDates AS ld
			WHERE ld.LeaveID = l1.LeaveID
			  AND (ld.RowAsc = 1 OR ld.RowDesc = 1)
			FOR XML PATH('')
		), 1, 2, '') AS LeaveDate
	FROM LeaveDates AS l1
	--GROUP BY LeaveID;	
END