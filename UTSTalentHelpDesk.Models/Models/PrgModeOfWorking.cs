﻿using System;
using System.Collections.Generic;

namespace UTSTalentHelpDesk.Models.Models
{
    public partial class PrgModeOfWorking
    {
        public int Id { get; set; }
        public string? ModeOfWorking { get; set; }
        public bool? IsActive { get; set; }
    }
}
