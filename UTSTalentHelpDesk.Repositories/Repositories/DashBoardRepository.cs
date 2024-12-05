﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UTSTalentHelpDesk.Models.Generic;
using UTSTalentHelpDesk.Models.Models;
using UTSTalentHelpDesk.Repositories.Interfaces;

namespace UTSTalentHelpDesk.Repositories.Repositories
{
    public class DashBoardRepository : IDashboard
    {
        #region Variables
        private UTSTalentHelpDeskDBConnection _db;
        private IUnitOfWork _unitOfWork;
        private readonly InMemoryDbContext _dbcontext;

        #endregion

        #region Constructors
        public DashBoardRepository(UTSTalentHelpDeskDBConnection db, IUnitOfWork unitOfWork, InMemoryDbContext dbcontext)
        {
            _db = db;
            _unitOfWork = unitOfWork;
            _dbcontext = dbcontext;
        }

        #endregion
        public void DashBoardCount()
        {
            
        }
    }
}