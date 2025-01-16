using DAL.MasterData;
using System.Data;

namespace BLL.MasterData
{
    public class MasterDataController
    {
        public DataTable MasterDataGetList(string ListCode)
        {
            using (var context = new MasterDataContext())
            {
                return context.MasterDataGetList(ListCode);
            }
        }
        public DataTable CycleGetList(int UserId, int Year, int? Month)
        {
            using (var context = new MasterDataContext())
            {
                return context.CycleGetList(UserId, Year, Month);
            }
        }
        public DataTable ShopFormatGetList(int UserId, string KPI, string ShopType)
        {
            using (var context = new MasterDataContext())
            {
                return context.ShopFormatGetList(UserId, KPI, ShopType);
            }
        }
    }
}
