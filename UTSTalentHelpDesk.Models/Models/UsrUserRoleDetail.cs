﻿using System;
using System.Collections.Generic;

namespace UTSTalentHelpDesk.Models.Models
{
    public partial class UsrUserRoleDetail
    {
        public long Id { get; set; }
        public int? UserId { get; set; }
        public int? UserRoleId { get; set; }
    }
}
