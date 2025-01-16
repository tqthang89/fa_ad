using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using FAuditService.Entities;


namespace FAuditService.Data
{
    public class ShopsContext : DAUltility.DataContext
    {

        [Function(Name = "[dbo].[Mobile.Shops.byEmployee]")]
        public IEnumerable<ShopInfo> byEmployee(
            [Parameter(Name = "@EmployeeId", DbType = "INT")]int EmployeeId
			)
        {
            IEnumerable<ShopInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            list = (IEnumerable<ShopInfo>) result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[Mobile.KPIStore.GetList]")]
        public IEnumerable<KPIStoreInfo> KPIStoreGetList(
            [Parameter(Name = "@EmployeeCode", DbType = "NVARCHAR(256)")]string EmployeeCode,
            [Parameter(Name = "@AuditDate", DbType = "VARCHAR(10)")]DateTime? AuditDate
            )
        {
            IEnumerable<KPIStoreInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, AuditDate);
            list = (IEnumerable<KPIStoreInfo>)result.ReturnValue;
            return list;
        }
        //
       
        [Function(Name = "[dbo].[Mobile.Store.Insert]")]
        public int StoreInsert(
            [Parameter(Name = "@ShopId", DbType = "VARCHAR(50)")]string ShopId,
            [Parameter(Name = "@ShopName", DbType = "NVARCHAR(250)")]string ShopName,
            [Parameter(Name = "@Address", DbType = "NVARCHAR(500)")]string Address,
            [Parameter(Name = "@ContactName", DbType = "NVARCHAR(150)")]string ContactName,
            [Parameter(Name = "@Phone", DbType = "VARCHAR(20)")]string Phone,
            [Parameter(Name = "@AuditDate", DbType = "DATE")]string AuditDate,
            [Parameter(Name = "@EmployeeCode", DbType = "NVARCHAR(50)")]string EmployeeCode
            )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), ShopId, ShopName, Address, ContactName, Phone, AuditDate, EmployeeCode);
            return (int)result.ReturnValue;
        }
    }
}
