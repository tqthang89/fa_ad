using System.Data;
using System.Data.Linq.Mapping;
using System.Reflection;

namespace DAL.Product
{
    public class ProductContext : DataContext
    {
        [Function(Name = "[dbo].[KPIOSA.Import]")]
        public int KPIOSAImport(int UserId, int CycleId, DataTable dt_posm)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), UserId, CycleId, dt_posm);
        }
        [Function(Name = "[dbo].[KPIOSA.ImportMTFA]")]
        public int KPIOSAImportMTFA(int UserId, int CycleId, DataTable dt_posm)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), UserId, CycleId, dt_posm);
        }
        [Function(Name = "[dbo].[Product.GetList]")]
        public DataTable ProductGetList()
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod());
        }
        [Function(Name = "[dbo].[KPIOSA.GetList]")]
        public DataTable KPIOSAGetList(int UserId, int CycleId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserId, CycleId);
        }
    }
}
