﻿using System;
using System.Collections.Generic;

namespace UTSTalentHelpDesk.Models.Models
{
    public partial class PrgSkillCategory
    {
        public int Id { get; set; }
        public string? SkillCategory { get; set; }
        public bool? IsActive { get; set; }
    }
}
