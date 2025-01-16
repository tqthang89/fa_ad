using DAL.StoreList;
using System.Data;

namespace BLL.StoreList
{
    public class StoreListController
    {
        public DataTable StoreListGetList(int UserId, int? ShopId, int? AreaId, int? ProvinceId, int? DistrictId, int? TownId, string ShopType, string ShopCode, int? PageNumber, int? RowNumber)
        {
            using (var context = new StoreListContext())
            {
                return context.StoreListGetList(UserId, ShopId, AreaId, ProvinceId, DistrictId, TownId, ShopType, ShopCode, PageNumber, RowNumber);
            }
        }
        public DataTable ShopFormatGetList(int UserId)
        {
            using (var context = new StoreListContext())
            {
                return context.ShopFormatGetList(UserId);
            }
        }
        public int StoreListImport(int Type, DataTable dt_storelist)
        {
            using (var context = new StoreListContext())
            {
                return context.StoreListImport(Type, dt_storelist);
            }
        }
        public int StoreListByCyleImport(int UserId, int CycleId, DataTable dt_storelistCycle)
        {
            using (var context = new StoreListContext())
            {
                return context.StoreListByCyleImport(UserId, CycleId, dt_storelistCycle);
            }
        }
        public DataTable StoreListByCyleGetList(int UserId, int CycleId)
        {
            using (var context = new StoreListContext())
            {
                return context.StoreListByCyleGetList(UserId, CycleId);
            }
        }
        public DataSet StoreListByMap(int LoginId, int CycleId)
        {
            using (var context = new StoreListContext())
            {
                return context.StoreListByMap(LoginId, CycleId);
            }
        }
        public DataSet StoreListByMapByShopCode(int LoginId, int CycleId, int ShopId)
        {
            using (var context = new StoreListContext())
            {
                return context.StoreListByMapByShopCode(LoginId, CycleId, ShopId);
            }
        }
    }
}
