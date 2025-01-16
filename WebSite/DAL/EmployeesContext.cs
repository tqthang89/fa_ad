using DAL.Base;
using Model;
using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Data;

namespace DAL
{
    public class EmployeesContext : DataContext
    {
        [Function(Name = "[dbo].[Employee.CheckLogin]")]
        public IEnumerable<EmployeesInfo> EmployeeCheckLogin(string UserName)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), UserName);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }

        [Function(Name = "[dbo].[Attendance.GetLeader]")]
        public IEnumerable<EmployeesInfo> GetLeader(int? EmployeeCode, string Position)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, Position);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[Employees.GetDynamicContent]")]
        public IEnumerable<EmployeesInfo> GetDynamicContent(string EmployeeCode, string Position, string Parent, string EmployeeName, string Mobile, string Division)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, Position, Parent, EmployeeName, Mobile, Division);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[Employees.GetPSLeader]")]
        public IEnumerable<EmployeesInfo> GetPSLeader(int? EmployeeId, int? CategoryId)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, CategoryId);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }

        [Function(Name = "[dbo].[Employees.getPS]")]
        public IEnumerable<EmployeesInfo> getPS(int? LoginID, int? CatId)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), LoginID, CatId);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[Employees.getPSByShop]")]
        public IEnumerable<EmployeesInfo> getPSByShop(int? LoginID, int? CatId,int? ShopId)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), LoginID, CatId,ShopId);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[Employees.getPSLeader.byLoginID]")]
        public IEnumerable<EmployeesInfo> getPSLeaderbyLoginID(int? LoginID)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), LoginID);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[Employee.GetDynamicContent]")]
        public IEnumerable<EmployeesInfo> GetDynamicContent(int? ID, string EmployeeCode, string EmployeeName, int? ParentID, string UserName, string Mobile, string Position, int? Status, int? RowPerPage, int? PageNumber)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), ID, EmployeeCode, EmployeeName, ParentID, UserName, Mobile, Position, Status, RowPerPage, PageNumber);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[users.GetDynamicContents]")]
        public IEnumerable<EmployeesInfo> GetDynamicContent1(int? Id, int? ParentId, string UserName, int? Type, int? Status, int? StartRowIndex, int? MaximumRows)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), Id, ParentId, UserName, Type, Status, StartRowIndex, MaximumRows);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[Employee.getalllistByTree]")]
        public IEnumerable<EmployeesInfo> getalllistByTree(string AccountName, string EmployeeCode, string ParentCode, string LoginName, string Position, int? Status)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), AccountName, EmployeeCode, ParentCode, LoginName, Position, Status);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }

        [Function(Name = "[dbo].[Employees.GetCategory]")]
        public IEnumerable<EmployeesInfo> GetCategory(int? EmployeeId)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }

        [Function(Name = "[dbo].[Employee.getalllistByTreeExport]")]
        public DataSet getalllistByTreeExport(string AccountName, string EmployeeCode, string ParentCode, string LoginName, string Position, int? Status)
        {

            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), AccountName, EmployeeCode, ParentCode, LoginName, Position, Status);
        }

        [Function(Name = "[dbo].[Employee.CheckCode]")]
        public IEnumerable<EmployeesInfo> CheckCode(string EmployeeCode, string Username)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, Username);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[EmployeeStores.GetDynamicContent]")]
        public DataSet EmployeeStoresGetDynamicContent(string employeeCode, string position, string parent, string employeeName, string mobile, string division)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), employeeCode, position, parent, employeeName, mobile, division);
        }
        [Function(Name = "[dbo].[EmployeeStore.InsertDataTable]")]
        public int EmployeeStoresInsertDataTable(DataTable dt)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), dt);
        }


        [Function(Name = "[dbo].[Import_EmployeeEfficiencies]")]
        public int Import_EmployeeEfficiencies(DataTable dt)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), dt);
        }
        [Function(Name = "[dbo].[Import_EmployeeGrading]")]
        public int Import_EmployeeGrading(DataTable dt)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), dt);
        }
        [Function(Name = "[dbo].[Import_EmployeeTraining]")]
        public int Import_EmployeeTraining(DataTable dt)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), dt);
        }

        [Function(Name = "[dbo].[Employee.Action]")]
        public int Employee_Action(string EmployeeCode, string EmployeeName, string Division, string Position, string Region, string Mobile, string Parent, string LoginName, string PassWord, int? Status, int? Sex)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, EmployeeName, Division, Position, Region, Mobile, Parent, LoginName, PassWord, Status, Sex);
        }

        [Function(Name = "[dbo].[Employee.getPosition]")]
        public IEnumerable<EmployeesInfo> getPosition()
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod());
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[Employees.Insert]")]
        public int Insert(int? Id, string EmployeeCode, string EmployeeName, int? ParentId, int? Sex, string Position, DateTime? BirthDay, string Mobile, string Email, string Username, string Password, int? Status, string Address, DateTime? ResignedDate, DateTime? OnboardDate, string Pic)
        {
            int list = 0;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), Id, EmployeeCode, EmployeeName, ParentId, Sex, Position, BirthDay, Mobile, Email, Username, Password, Status, Address, ResignedDate, OnboardDate, Pic);
            list = (Int32)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[EmployeeShared.Action]")]
        public DataSet EmployeeShare(string employeeCode, int? employeeId, int? type)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), employeeCode, employeeId, type);
        }


        [Function(Name = "[dbo].[EmployeeEfficiencies.GetCode]")]
        public IEnumerable<EmployeesInfo> EmployeeEfficiencies_GetCode(string ShopCode, string EmployeeCode)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), ShopCode, EmployeeCode);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }
        [Function(Name = "[dbo].[EmployeeEfficiencies.GetEmployeeId]")]
        public IEnumerable<EmployeesInfo> EmployeeEfficiencies_GetEmployeeId(string EmployeeCode)
        {
            IEnumerable<EmployeesInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode);
            list = (IEnumerable<EmployeesInfo>)result.ReturnValue;
            return list;
        }

        [Function(Name = "[dbo].[Mail.Employee.GetList]")]
        public DataTable MailEmployeeGetList (string LeaderCode)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LeaderCode);
        }
        
        [Function(Name = "[dbo].[Mail.GetListWarning]")]
        public DataTable MailGetListWarning(string LeaderCode, string FromDate, string ToDate, int? EmployeeId, int? CountDate,int? Type, int? RowPerPage, int? PageNumber)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(),  LeaderCode,  FromDate,  ToDate, EmployeeId, CountDate, Type, RowPerPage,  PageNumber);
        }
        [Function(Name = "[dbo].[Mail.ComfirmEmployeeOff]")]
        public int MailComfirmEmployee(int EmployeeId, int LeaderId , string EndDate, string Type, string FromDate, string ToDate = null, string LeaderNote = null)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, LeaderId, EndDate, Type, FromDate, ToDate, LeaderNote);
        }

        [Function(Name = "[dbo].[Employee.PayslipsFeedBack]")]
        public DataSet EmployeePayslipsFeedBack(int ShopId, int EmployeeId, int Year, int Month, int Group)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), ShopId, EmployeeId, Year, Month, Group);
        }

        [Function(Name = "[dbo].[PayslipsFeedBack.insert]")]
        public int EmployeeSalaryUpdate(int Id, int FbId, int EmployeeId, int Year, int Month, string Note)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), Id, FbId, EmployeeId, Year, Month, Note);
        }
        [Function(Name = "[dbo].[Playslips.getEmployee]")]
        public DataTable PlayslipsgetEmployee(int UserLogin, int EmployeeId, int Year, int Month, int FbId, int? Group, int? RowPerPage, int? PageNumber)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserLogin, EmployeeId, Year, Month, FbId, Group, RowPerPage, PageNumber);
        }

        [Function(Name = "[dbo].[Payslips.Import]")]
        public int Payslips_Import(int UserLogin, DataTable tbl, int Month, int Year, int IsDelete, int Group)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), UserLogin, tbl, Month, Year, IsDelete, Group);
        }
        [Function(Name = "[dbo].[Payslips.Export]")]
        public DataSet PayslipsExport( int Year, int Month, int? EmployeeId, int? Group, int LoginId)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), Year, Month, EmployeeId, Group, LoginId);
        }
        [Function(Name = "[dbo].[EmployeesMoreInfo.Update]")]
        public int EmployeesUpdateMoreInfo(int? EmployeeId, int? ProvinceId, int? DistrictId, int? TownId, string AddressDetail,string Comment)
        {
            int list = 0;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, ProvinceId, DistrictId, TownId, AddressDetail, Comment);
            list = (Int32)result.ReturnValue;
            return list;
        }
    }
}
