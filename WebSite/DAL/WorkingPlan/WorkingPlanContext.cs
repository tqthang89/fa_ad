using System;
using System.Data;
using System.Data.Linq.Mapping;
using System.Reflection;

namespace DAL.WorkingPlan
{
    public class WorkingPlanContext : DataContext
    {
        [Function(Name = "[dbo].[WorkingPlan.GetShopAvailable]")]
        public DataTable WorkingPlanGetShopAvailable(int LoginId, DateTime FromDate, int SupId, int? AuditorId, string ShopCode)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, SupId, AuditorId, ShopCode);
        }
        [Function(Name = "[dbo].[WorkingPlan.getShop]")]
        public DataTable WorkingPlangetShop(int LoginId, DateTime FromDate, int? AuditorId, string ShopCode)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, AuditorId, ShopCode);
        }
        [Function(Name = "[dbo].[WorkingPlan.Import]")]
        public int WorkingPlanImport(DataTable WorkingPlan)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), WorkingPlan);
        }
        [Function(Name = "[dbo].[WorkingPlan.Delete.Multi]")]
        public int WorkingPlanDeleteMulti(int EmployeeId, string WPId)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, WPId);
        }
        [Function(Name = "[dbo].[WorkingPlan.PIVOT.ExportTemplate]")]
        public DataSet WorkingPlanPIVOTExportTemplate(int Year, int Month, int LoginId)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), Year, Month, LoginId);
        }
        [Function(Name = "[dbo].[WorkingPlan.PIVOT.ExportData]")]
        public DataSet WorkingPlanPIVOTExportData(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? AuditorId, string ShopCode)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate, SupId, AuditorId, ShopCode);
        }

        [Function(Name = "[dbo].[WorkingPlan.GetAllByCycle]")]
        public DataTable WorkingPlanGetAllByCycle(int LoginId, int CycleId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, CycleId);
        }
    }
}
