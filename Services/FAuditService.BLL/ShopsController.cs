using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FAuditService.Data;
using FAuditService.Entities;

namespace FAuditService.BLL
{
    public static class ShopsController
    {


        public static List<ShopInfo> byEmployee(int EmployeeId)
        {
            List<ShopInfo> list = null;
            using (ShopsContext context = new ShopsContext())
            {
                var _list = context.byEmployee(EmployeeId);
                if (_list != null)
                    list = _list.ToList();
            }
            return list;
        }
        public static List<KPIStoreInfo> KPIStoreGetList(string EmployeeCode, DateTime? AuditDate)
        {
            List<KPIStoreInfo> list = null;
            using (ShopsContext context = new ShopsContext())
            {
                var _list = context.KPIStoreGetList(EmployeeCode, AuditDate);
                if (_list != null)
                    list = _list.ToList();
            }
            return list;
        }
       
        public static int StoreInsert(string ShopId,string ShopName,string Address,string Contact,string Phone,string AuditDate,string EmployeeCode)
        {
            int Result = 0;
            using (ShopsContext context = new ShopsContext())
            {
                Result = context.StoreInsert(ShopId, ShopName, Address, Contact, Phone, AuditDate, EmployeeCode);
            }
            return Result;
        }
    }
}
