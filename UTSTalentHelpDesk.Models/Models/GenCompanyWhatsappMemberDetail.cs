﻿using System;
using System.Collections.Generic;

namespace UTSTalentHelpDesk.Models.Models
{
    public partial class GenCompanyWhatsappMemberDetail
    {
        public long Id { get; set; }
        public long? WhatsappDetailId { get; set; }
        public long? UserId { get; set; }
        public bool? IsAdmin { get; set; }
        public long? CreatedById { get; set; }
        public DateTime? CreatedByDateTime { get; set; }
        public string? MemberName { get; set; }
        public string? WhatsappNumber { get; set; }
        public bool? IsActive { get; set; }
        public bool? IsInvited { get; set; }
    }
}
