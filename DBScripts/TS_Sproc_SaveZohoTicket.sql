ALTER PROCEDURE [dbo].[TS_Sproc_SaveZohoTicket]  

	@ZohoTicketId			NVARCHAR(50) = null,
    @TicketNumber			NVARCHAR(50) = null,
    @Subject				NVARCHAR(MAX)= null,
    @Description			NVARCHAR(MAX)= null,
    @Status					NVARCHAR(50)= null,
    @StatusType				NVARCHAR(50)= null,
    @Priority				NVARCHAR(50)= null,
    @Category				NVARCHAR(100)= null,
    @SubCategory			NVARCHAR(100)= null,
	@CreatedTimeStr			NVARCHAR(50)= null,   
	@DueDateStr				NVARCHAR(50) = NULL,
    @ClosedTimeStr				NVARCHAR(50) = NULL,
    @CustomerResponseTimeStr   NVARCHAR(50) = NULL,
	@Email					NVARCHAR(500) = null,
	@Phone					NVARCHAR(100) = null,
	@ContactId				NVARCHAR(500) = NULL,
	@AssigneeId				NVARCHAR(500) = NULL,
	@DepartmentId			NVARCHAR(500) = NULL,	
	@Channel				NVARCHAR(50)= null,
	@WebUrl					NVARCHAR(MAX) = NULL,	
	@IsSpam					BIT = NULL,
	@IsArchieved			BIT = NULL
AS
BEGIN    


		DECLARE @UTSTalentID BIGINT = 0, @UserID BIGINT = 0, @ContactEmail NVARCHAR(500) = NULL,
		@CreatedTime			DATETIME = NULL,
		@DueDate				DATETIME = NULL,
		@ClosedTime				DATETIME = NULL,
		@CustomerResponseTime   DATETIME = NULL;

		SELECT @CreatedTimeStr, @DueDateStr, @ClosedTimeStr, @CustomerResponseTimeStr

		SELECT @CreatedTime	 = CASE WHEN @CreatedTimeStr IS NOT NULL THEN CONVERT(DATETIME, @CreatedTimeStr, 105) ELSE NULL END 
		SELECT @DueDate = CASE WHEN @DueDateStr IS NOT NULL THEN CONVERT(DATETIME, @DueDateStr, 105) ELSE NULL END
		SELECT @ClosedTime	 = CASE WHEN @ClosedTimeStr IS NOT NULL THEN  CONVERT(DATETIME, @ClosedTimeStr, 105) ELSE NULL END
		SELECT @CustomerResponseTime = CASE WHEN @CustomerResponseTimeStr IS NOT NULL THEN CONVERT(DATETIME, @CustomerResponseTimeStr, 105) ELSE NULL END


		SELECT @CreatedTime, @DueDate, @ClosedTime, @CustomerResponseTime
		

		SELECT TOP 1 @ContactEmail = Email_ID FROM TS_Gen_Zoho_Contacts WITH(NOLOCK) WHERE Zoho_ContactID = @ContactId

		IF(ISNULL(@ContactEmail,'') <> '')
		BEGIN
			SELECT TOP 1 @UserID = ID FROM Usr_User WITH(NOLOCK) WHERE EmailID = @ContactEmail

			SELECT TOP 1 @UTSTalentID = ID FROM gen_Talent WITH(NOLOCK) WHERE EmailID = @ContactEmail
		END

        -- Insert or Update Ticket
        IF EXISTS (SELECT 1 FROM TS_Gen_Zoho_Tickets WiTH(NOLOCK) WHERE ZohoTicketId = @ZohoTicketId)
			BEGIN
				UPDATE  TS_Gen_Zoho_Tickets SET 
							ZohoTicketId = ISNULL(@ZohoTicketId, ZohoTicketId),
							TicketNumber = ISNULL(@TicketNumber, TicketNumber),
							Subject = ISNULL(@Subject,Subject),
							Description = ISNULL(@Description,Description),
							Status = ISNULL(@Status, Status),
							StatusType = ISNULL(@StatusType,StatusType),
							Priority = ISNULL(@Priority,Priority),
							Category = ISNULL(@Category,Category),
							SubCategory = ISNULL(@SubCategory,SubCategory),
							Channel = @Channel,	
							CreatedTime = @CreatedTime,
							ModifiedTime = GETDATE(),
							DueDate = ISNULL(@DueDate,DueDate),
							ClosedTime = ISNULL(@ClosedTime, ClosedTime),
							CustomerResponseTime = ISNULL(@CustomerResponseTime, CustomerResponseTime),
							Email = ISNULL(@Email, Email),
							Phone = ISNULL(@Phone, Phone)
					WHERE   ZohoTicketId = @ZohoTicketId
			END
        ELSE
			BEGIN
				INSERT INTO TS_Gen_Zoho_Tickets (					
					ZohoTicketId,
					TicketNumber,
					Subject,
					Description,
					Status,
					StatusType,
					Priority,
					Category,
					SubCategory,
					CreatedTime,				
					DueDate,
					ClosedTime,
					CustomerResponseTime,
					Email,
					Phone,
					ContactId,
					AssigneeId,
					DepartmentId,					
					Channel,
					WebUrl,					
					IsSpam,
					IsArchieved,
					Talent_ID,
					UTS_User_ID
				) 
				VALUES 
				(					
					@ZohoTicketId,
					@TicketNumber,
					@Subject,
					@Description,
					@Status,
					@StatusType,
					@Priority,
					@Category,
					@SubCategory,
					@CreatedTime,					
					@DueDate,
					@ClosedTime,
					@CustomerResponseTime,
					@Email,
					@Phone,
					@ContactId,
					@AssigneeId,
					@DepartmentId,				
					@Channel,
					@WebUrl,					
					@IsSpam,
					@IsArchieved,
					@UTSTalentID,
					@UserID
				);
				
			END		
    
END