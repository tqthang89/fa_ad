using System.Data;
using System.Data.Linq.Mapping;
using System.Reflection;

namespace DAL.StoreList
{
    public class StoreListContext : DataContext
    {
        [Function(Name = "[dbo].[StoreList.GetList]")]
        public DataTable StoreListGetList(int UserId, int? ShopId, int? AreaId, int? ProvinceId, int? DistrictId, int? TownId, string ShopType, string ShopCode, int? PageNumber, int? RowNumber)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserId, ShopId, AreaId, ProvinceId, DistrictId, TownId, ShopType, ShopCode, PageNumber, RowNumber);
        }
        [Function(Name = "[dbo].[ShopFormat.GetList]")]
        public DataTable ShopFormatGetList(int UserId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserId);
        }
        [Function(Name = "[dbo].[StoreList.Import]")]
        public int StoreListImport(int Type, DataTable dt_storelist)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), Type, dt_storelist);
        }
        [Function(Name = "[dbo].[StoreListByCyle.Import]")]
        public int StoreListByCyleImport(int UserId, int CycleId, DataTable dt_storelistCycle)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), UserId, CycleId, dt_storelistCycle);
        }
        [Function(Name = "[dbo].[StoreListByCyle.GetList]")]
        public DataTable StoreListByCyleGetList(int UserId, int CycleId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserId, CycleId);
        }
        [Function(Name = "[dbo].[DigitalMap.GetAll]")]
        public DataSet StoreListByMap(int LoginId, int CycleId)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, CycleId);
        }
        [Function(Name = "[dbo].[DigitalMap.GetByShop]")]
        public DataSet StoreListByMapByShopCode(int LoginId, int CycleId,int ShopId)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, CycleId, ShopId);
        }
    }
}
