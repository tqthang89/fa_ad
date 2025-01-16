using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using System.Reflection;
using System.Data;
using System.Data.SqlClient;
using FAuditService.Entities;

namespace FAuditService.Data
{
    public class EmployeeContext : DAUltility.DataContext
    {
        public Table<MobileSupportEntity> MobileSupport { get { return GetTable<MobileSupportEntity>(); } }
        [Function(Name = "[dbo].[Mobile.Employee.byCode]")]
        public IEnumerable<EmployeeInfo> byCode(
            [Parameter(Name = "@EmployeeCode", DbType = "NVARCHAR(100)")] String EmployeeCode)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo].[Mobile.Employee.byUsername]")]
        public IEnumerable<EmployeeInfo> byUsername(
            [Parameter(Name = "@Username", DbType = "NVARCHAR(100)")] String Username,
            [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId
            )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), Username, EmployeeId);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo]. [Mobile.CheckChangePass]")]
        public IEnumerable<EmployeeInfo> byCheckChangePass(
            [Parameter(Name = "@username", DbType = "NVARCHAR(32)")] String username,
            [Parameter(Name = "@oldpass", DbType = "NVARCHAR(32)")] String oldpass)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), username, oldpass);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo]. [Mobile.Employee.ChangePass]")]
        public IEnumerable<EmployeeInfo> Changepass(
            [Parameter(Name = "@username", DbType = "NVARCHAR(32)")] String username,
            [Parameter(Name = "@newpass", DbType = "NVARCHAR(32)")] String newpass)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), username, newpass);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }


        [Function(Name = "[dbo].[Mobile.Employee.GetEmployee]")]
        public IEnumerable<EmployeeInfo> GetEmployee(
            [Parameter(Name = "@EmployeeCode", DbType = "NVARCHAR(100)")] String EmployeeCode = null,
            [Parameter(Name = "@Username", DbType = "NVARCHAR(100)")] String Username = null,
            [Parameter(Name = "@Email", DbType = "NVARCHAR(100)")] String Email = null,
            [Parameter(Name = "@Mobile", DbType = "NVARCHAR(50)")] String Mobile = null)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, Username, Email, Mobile);
            return (IEnumerable<EmployeeInfo>)result.ReturnValue;
        }


        #region "OTP TOOL"

        [Function(Name = "[dbo].[Mobile.CreateOTP]")]
        public int OTPCreate(
            [Parameter(Name = "@EmployeeCode", DbType = "VARCHAR(50)")] String EmployeeCode,
            [Parameter(Name = "@OTP", DbType = "VARCHAR(6)")] String OTP)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, OTP);
            return (int)result.ReturnValue;
        }
        [Function(Name = "[dbo].[Mobile.CheckingOTP]")]
        public IEnumerable<OTPInfo> OTPChecking(
            [Parameter(Name = "@EmployeeCode", DbType = "VARCHAR(50)")] string EmployeeCode,
            [Parameter(Name = "@OTP", DbType = "VARCHAR(6)")] string OTP)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, OTP);
            return (IEnumerable<OTPInfo>)result.ReturnValue;
        }
        #endregion
        [Function(Name = "[dbo].[Mobile.DBSqlite.Save]")]
        public int SaveDBMobile(
           [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId,
           [Parameter(Name = "@FilePath", DbType = "VARCHAR(512)")] string FilePath)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, FilePath);
            return (int)result.ReturnValue;
        }

    }
}
