using UTSTalentHelpDesk.Models.Generic;
using UTSTalentHelpDesk.Models.Models;
namespace UTSTalentHelpDesk.Repositories.Infrastructure.Repositories
{
public class GenTalentSelectedNextRoundInterviewDetailRepository : GenericRepository<GenTalentSelectedNextRoundInterviewDetail>, IGenTalentSelectedNextRoundInterviewDetailRepository
{
public GenTalentSelectedNextRoundInterviewDetailRepository(UTSTalentHelpDeskDBConnection dbContext) : base(dbContext){}
}
}
