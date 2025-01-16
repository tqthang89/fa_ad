using FAuditService.Entities;
using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Reflection;
using System.Text;

namespace FAuditService.Data
{
    public class AttendantContext : DAUltility.DataContext
    {
        [Function(Name = "[dbo].[Mobile.Attendant.Insert]")]
        public int AddAttendant(
            [Parameter(Name = "@ShopId", DbType = "VARCHAR(32)")]string ShopId,
            [Parameter(Name = "@EmployeeCode", DbType = "VARCHAR(32)")]string EmployeeCode,
            [Parameter(Name = "@AttendantType", DbType = "INT")]int? AttendantType,
            [Parameter(Name = "@AttendantDate", DbType = "DATETIME")]DateTime? AttendantDate,
            [Parameter(Name = "@AttendantPhoto", DbType = "NVARCHAR(500)")]string AttendantPhoto,
            [Parameter(Name = "@Latitude", DbType = "Decimal(18,10)")]double? Latitude,
            [Parameter(Name = "@Longitude", DbType = "Decimal(18,10)")]double? Longitude,
            [Parameter(Name = "@Accuracy", DbType = "Decimal(18,10)")]double? Accuracy,
             [Parameter(Name = "@Status", DbType = "INT")]int? Status
            )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), ShopId, EmployeeCode, AttendantType, AttendantDate, AttendantPhoto, Longitude, Latitude, Accuracy, Status);
            return 1;
        }

        [Function(Name = "[dbo].[Mobile.Attendant.getImage]")]
        public IEnumerable<AttendantInfo> getImage(
          [Parameter(Name = "@ShopId", DbType = "VARCHAR(32)")]string ShopId,
          [Parameter(Name = "@EmployeeCode", DbType = "VARCHAR(32)")]string EmployeeCode,
          [Parameter(Name = "@AttendantDate", DbType = "VARCHAR(10)")]string AttendantDate)
        {
            IEnumerable<AttendantInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), ShopId, EmployeeCode, AttendantDate);
            list = (IEnumerable<AttendantInfo>)result.ReturnValue;
            return list;
        }
    }
}
