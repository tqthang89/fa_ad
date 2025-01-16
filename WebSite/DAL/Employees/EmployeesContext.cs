using System;
using System.Data;
using System.Data.Linq.Mapping;
using System.Reflection;

namespace DAL.Employees
{
    public class EmployeesContext : DataContext
    {
        [Function(Name = "[dbo].[Employees.GetList]")]
        public DataTable EmployeesGetList(int? EmployeeId, int? ParentId, int? TypeId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, ParentId, TypeId);
        }
        [Function(Name = "[dbo].[Employees.GetList.Guest]")]
        public DataTable bindEmployeeDropDownGuest(int LoginId, int CycleId, int? EmployeeId, int? ParentId, int? TypeId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, CycleId, EmployeeId, ParentId, TypeId);
        }
        [Function(Name = "[dbo].[EmployeeStore.GetShopAvailable]")]
        public DataTable EmployeeStoreGetShopAvailable(int LoginId, DateTime FromDate, DateTime? ToDate, int? AuditorId, string ShopCode)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate, AuditorId, ShopCode);
        }
        [Function(Name = "[dbo].[EmployeeStore.getShop]")]
        public DataTable EmployeeStoregetShop(int LoginId, DateTime FromDate, DateTime? ToDate, int? AuditorId, string ShopCode)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate, AuditorId, ShopCode);
        }
        [Function(Name = "[dbo].[EmployeeStore.Import]")]
        public int EmployeeStoreImport(DataTable EmployeeStore)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), EmployeeStore);
        }
        [Function(Name = "[dbo].[EmployeeStore.Delete.Multi]")]
        public int EmployeeStoreDeleteMulti(int EmployeeId, string ShopId)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, ShopId);
        }
        [Function(Name = "[dbo].[EmployeeStore.Export]")]
        public DataTable EmployeeStoreExport(int LoginId, DateTime FromDate, DateTime? ToDate, int? SupId, int? AuditorId, string ShopCode)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate, SupId, AuditorId, ShopCode);
        }
        [Function(Name = "[dbo].[EmployeeShops.GetList]")]
        public DataTable EmployeeStoreGetList(int CycleId, int LoginId,int Date)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), CycleId,LoginId, Date);
        }
        [Function(Name = "[dbo].[Employee.GetAll]")]
        public DataTable EmployeeGetAll(int LoginId, int? EmployeeId, int? TypeId, int? Status, string Mobile, string Username, string EmployeeCode, string EmployeeName, int PageNumber, int RowPerPage)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, EmployeeId, TypeId, Status, Mobile, Username, EmployeeCode, EmployeeName, PageNumber, RowPerPage);
        }
        [Function(Name = "[dbo].[EmployeeType.getList]")]
        public DataTable EmployeeTypeGetList()
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod());
        }
        [Function(Name = "[dbo].[Employees.Import]")]
        public int EmployeesImport(int Type, DataTable dt_employee)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), Type, dt_employee);
        }
        
    }
}
