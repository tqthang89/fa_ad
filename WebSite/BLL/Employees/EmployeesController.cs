using DAL.Employees;
using System;
using System.Data;

namespace BLL.Employees
{
    public class EmployeesController
    {
        public DataTable EmployeesGetList(int? EmployeeId, int? ParentId, int? TypeId)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeesGetList(EmployeeId, ParentId, TypeId);
            }
        }
        public DataTable bindEmployeeDropDownGuest(int LoginId, int CycleId, int? EmployeeId, int? ParentId, int? TypeId)
        {
            using (var context = new EmployeesContext())
            {
                return context.bindEmployeeDropDownGuest(LoginId, CycleId, EmployeeId, ParentId, TypeId);
            }
        }
        public DataTable EmployeeStoreGetShopAvailable(int LoginId, DateTime FromDate, DateTime? ToDate, int? AuditorId, string ShopCode)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeeStoreGetShopAvailable(LoginId, FromDate, ToDate, AuditorId, ShopCode);
            }
        }
        public DataTable EmployeeStoregetShop(int LoginId, DateTime FromDate, DateTime? ToDate, int? AuditorId, string ShopCode)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeeStoregetShop(LoginId, FromDate, ToDate, AuditorId, ShopCode);
            }
        }
        public int EmployeeStoreImport(DataTable EmployeeStore)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeeStoreImport(EmployeeStore);
            }
        }
        public int EmployeeStoreDeleteMulti(int EmployeeId, string ShopId)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeeStoreDeleteMulti(EmployeeId, ShopId);
            }
        }
        public DataTable EmployeeStoreExport(int LoginId, DateTime FromDate, DateTime? ToDate, int? SupId, int? AuditorId, string ShopCode)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeeStoreExport(LoginId, FromDate, ToDate, SupId, AuditorId, ShopCode);
            }
        }
        public DataTable EmployeeStoreGetList(int CycleId,int LoginId,int Date)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeeStoreGetList(CycleId, LoginId, Date);
            }
        }
        public DataTable EmployeeGetAll(int LoginId, int? EmployeeId, int? TypeId, int? Status, string Mobile, string Username, string EmployeeCode, string EmployeeName, int PageNumber, int RowPerPage)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeeGetAll(LoginId, EmployeeId, TypeId, Status, Mobile, Username, EmployeeCode, EmployeeName, PageNumber, RowPerPage);
            }
        }
        public DataTable EmployeeTypeGetList()
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeeTypeGetList();
            }
        }
        public int EmployeesImport(int Type, DataTable dt_employee)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeesImport(Type, dt_employee);
            }
        }
    }
}
