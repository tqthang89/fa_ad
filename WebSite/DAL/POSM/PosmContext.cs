using System.Data;
using System.Data.Linq.Mapping;
using System.Reflection;

namespace DAL.POSM
{
    public class PosmContext : DataContext
    {
        [Function(Name = "[dbo].[KPIPOSM.Import]")]
        public int KPIPOSMImport(int UserId, int CycleId, DataTable dt_posm)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), UserId, CycleId, dt_posm);
        }
        [Function(Name = "[dbo].[Posm.GetList]")]
        public DataTable PosmGetList()
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod());
        }
        [Function(Name = "[dbo].[KPI.POSM.GetList]")]
        public DataTable KPIPOSMGetList(int UserId, int CycleId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserId, CycleId);
        }
    }
}
