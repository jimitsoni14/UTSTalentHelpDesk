﻿using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UTSTalentHelpDesk.Helpers;
using UTSTalentHelpDesk.Models.ComplexTypes;
using UTSTalentHelpDesk.Models.Models;
using UTSTalentHelpDesk.Repositories.Interfaces;

namespace UTSTalentHelpDesk.Repositories.Repositories
{
    public class TicketRepository : ITicket
    {
        #region Variables
        private UTSTalentHelpDeskDBConnection db;
        #endregion
        #region Constructor
        public TicketRepository(UTSTalentHelpDeskDBConnection _db)
        {
            this.db = _db;
        }
        #endregion
        public void CreateTicket(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_sproc_SaveTokens, param));
        }

        public async Task<TS_sproc_GetToken_Result> GetTokenList(string strparams)
        {
            return db.Set<TS_sproc_GetToken_Result>().FromSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_sproc_GetToken, strparams)).AsEnumerable().FirstOrDefault();
        }

        public void SaveAllTickets(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_Sproc_SaveAllTicketData, param));
        }
        public void SaveTickets(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_sproc_SaveTicket, param));
        }
        public void UpdateTicket(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_sproc_UpdateToken, param));
        }

        public void SaveZohoTickets(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_Sproc_SaveZohoTicket, param));
        }
        public void deleteZohoTickets(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_Sproc_deleteZohoTicket, param));
        }

        public void saveContacts(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_Sproc_SaveZohoContacts, param));
        }

        public void saveZohoWebHookEvent(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_Sproc_WebHook_History_Manage, param));
        }

        public async Task<long> InsertZohoWebHookLogs(TsGenZohoTicketsWebhookEvent genZohoTicketsWebhookEvent)
        {
            TsGenZohoTicketsWebhookEvent zohoTicketsWebhookEvent = new TsGenZohoTicketsWebhookEvent();

            zohoTicketsWebhookEvent.Payload = genZohoTicketsWebhookEvent.Payload;
             db.TsGenZohoTicketsWebhookEvents.AddAsync(zohoTicketsWebhookEvent);
            db.SaveChanges();

            return zohoTicketsWebhookEvent.Id;
        }

        public void SaveZohoWebHookTickets(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_Sproc_SaveZohoTicket_Webhook, param));
        }
        public void SaveZohoWebHookPrevTickets(string param)
        {
            db.Database.ExecuteSqlRaw(string.Format("{0} {1}", Constants.ProcConstant.TS_Sproc_SaveZohoPrevTicket_Webhook, param));
        }

        public async Task<List<TS_Sproc_Get_Zoho_Tickets_BasedOnUser_Result>> GetZohoTicketsBasedOnUser(string param)
        {
            return await db.Set<TS_Sproc_Get_Zoho_Tickets_BasedOnUser_Result>().FromSqlRaw(String.Format("{0} {1}", Constants.ProcConstant.TS_Sproc_Get_Zoho_Tickets_BasedOnUser, param)).ToListAsync();
        }

        public TsGenTalentTicket SaveUpdateTicketHistory(TsGenTalentTicket talentTicket)
        {
            if (talentTicket != null )
            {
                if (talentTicket.Id == 0)
                {
                    db.TsGenTalentTickets.Add(talentTicket);
                    db.SaveChanges(true);
                }
                else
                {
                    db.TsGenTalentTickets.Update(talentTicket);
                    db.SaveChanges(true);
                }
            }

            return talentTicket;
        }
    }
}
