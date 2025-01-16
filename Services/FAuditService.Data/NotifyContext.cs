using FAuditService.Entities;
using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Reflection;
using System.Text;

namespace FAuditService.Data
{
    public class NotifyContext : DAUltility.DataContext
    {
        [Function(Name = "[dbo].[Mobile.Notify.Getlist]")]
        public IEnumerable<NotifyInfo> NotifyGetList(
            [Parameter(Name = "@EmployeeCode", DbType = "VARCHAR(32)")] string EmployeeCode,
            [Parameter(Name = "@NotifyId", DbType = "BIGINT")] long? NotifyId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, NotifyId);
            return (IEnumerable<NotifyInfo>)result.ReturnValue;
        }
    }
}
