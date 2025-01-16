using DAL.WorkingPlan;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.WorkingPlan
{
    public class WorkingPlanController
    {
        public DataTable WorkingPlanGetShopAvailable(int LoginId, DateTime FromDate,int SupId, int? Auditor, string ShopCode)
        {
            using(var context = new WorkingPlanContext())
            {
                return context.WorkingPlanGetShopAvailable(LoginId, FromDate, SupId, Auditor, ShopCode);
            }
        }
        public DataTable WorkingPlangetShop(int LoginId, DateTime FromDate, int? Auditor, string ShopCode)
        {
            using (var context = new WorkingPlanContext())
            {
                return context.WorkingPlangetShop(LoginId, FromDate, Auditor, ShopCode);
            }
        }
        public int WorkingPlanImport(DataTable WorkingPlan)
        {
            using (var context = new WorkingPlanContext())
            {
                return context.WorkingPlanImport(WorkingPlan);
            }
        }
        public int WorkingPlanDeleteMulti(int EmployeeId, string WPId)
        {
            using (var context = new WorkingPlanContext())
            {
                return context.WorkingPlanDeleteMulti(EmployeeId, WPId);
            }
        }
        public DataSet WorkingPlanPIVOTExportTemplate(int Year, int Month, int LoginId)
        {
            using (var context = new WorkingPlanContext())
            {
                return context.WorkingPlanPIVOTExportTemplate(Year, Month, LoginId);
            }
        }
        public DataSet WorkingPlanPIVOTExportData(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? AuditorId, string ShopCode)
        {
            using (var context = new WorkingPlanContext())
            {
                return context.WorkingPlanPIVOTExportData(LoginId, FromDate, ToDate, SupId, AuditorId, ShopCode);
            }
        }
        public DataTable WorkingPlanGetAllByCycle(int LoginId, int CycleId)
        {
            using (var context = new WorkingPlanContext())
            {
                return context.WorkingPlanGetAllByCycle(LoginId, CycleId);
            }
        }
    }
}
