using System.Data;
using System.Data.Linq.Mapping;
using System.Reflection;

namespace DAL.Attendants
{
    public class AttendantContext : DataContext
    {
        [Function(Name = "[dbo].[Attendant.GetList]")]
        public DataTable AttendantGetList(int EmployeeId, int ShopId, int AttendantDate)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, ShopId, AttendantDate);
        }
        [Function(Name = "[dbo].[CreateShop.GetList]")]
        public DataTable CreateShopGetList(int WorkId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId);
        }
    }
}
