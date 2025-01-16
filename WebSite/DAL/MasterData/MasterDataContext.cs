using System.Data;
using System.Data.Linq.Mapping;
using System.Reflection;

namespace DAL.MasterData
{
    public class MasterDataContext : DataContext
    {
        [Function(Name = "[dbo].[MasterData.GetList]")]
        public DataTable MasterDataGetList(string ListCode)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), ListCode);
        }
        [Function(Name = "[dbo].[Cycle.GetList]")]
        public DataTable CycleGetList(int UserId, int Year, int? Month)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserId, Year, Month);
        }
        [Function(Name = "[dbo].[ShopFormatGetList]")]
        public DataTable ShopFormatGetList(int UserId, string KPI, string ShopType)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserId, KPI, ShopType);
        }
    }
}
