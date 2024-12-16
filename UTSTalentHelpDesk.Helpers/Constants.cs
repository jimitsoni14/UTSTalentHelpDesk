﻿namespace UTSTalentHelpDesk.Helpers
{
    public static class Constants
    {
        /// <summary>
        /// ProcConstant
        /// </summary>
        public static class ProcConstant
        {
            #region Ticket
            public static string TS_sproc_GetToken = "TS_sproc_GetToken";
            public static string TS_sproc_SaveTokens = "TS_sproc_SaveTokens";
            public static string TS_sproc_UpdateToken = "TS_sproc_UpdateToken";
            public static string TS_Sproc_SaveAllTicketData = "TS_Sproc_SaveAllTicketData";
            public static string TS_sproc_SaveTicket = "TS_sproc_SaveTicket";
            public static string TS_Sproc_SaveZohoTicket = "TS_Sproc_SaveZohoTicket";
            public static string TS_Sproc_deleteZohoTicket = "TS_Sproc_deleteZohoTicket";
            public static string TS_Sproc_SaveZohoContacts = "TS_Sproc_SaveZohoContacts";
            #endregion

            #region Engagements
            public static string TS_Sproc_GetActive_EngagementList = "TS_Sproc_GetActive_EngagementList";
            public static string TS_Sproc_GetClose_EngagementList = "TS_Sproc_GetClose_EngagementList";
            public static string TS_Sproc_Get_engagement_PRDetails_MonthWise = "TS_Sproc_Get_engagement_PRDetails_MonthWise";
            #endregion

            #region Dashboard
            public static string TS_Sproc_Get_DashBoradCounts = "TS_Sproc_Get_DashBoradCounts";
            #endregion
        }
    }
}
