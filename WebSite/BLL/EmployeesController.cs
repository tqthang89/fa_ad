using DAL;
using DAL.Base;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Linq.Mapping;

namespace BLL
{
    public class EmployeesController
    {
        public static List<EmployeesInfo> EmployeeCheckLogin(string LoginName)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.EmployeeCheckLogin(LoginName);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        public static List<EmployeesInfo> GetPSLeader(int? EmployeeId, int? CategoryId)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.GetPSLeader(EmployeeId, CategoryId);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        public static List<EmployeesInfo> GetDynamicContent(string EmployeeCode, string Position, string Parent, string EmployeeName, string Mobile, string Division)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.GetDynamicContent(EmployeeCode, Position, Parent, EmployeeName, Mobile, Division);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        public static List<EmployeesInfo> getPS(int? LoginID, int? CatId)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.getPS(LoginID, CatId);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        public static List<EmployeesInfo> getPSByShop(int? LoginID, int? CatId, int? ShopId)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.getPSByShop(LoginID, CatId, ShopId);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        public static List<EmployeesInfo> getPSLeaderbyLoginID(int? LoginID )
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.getPSLeaderbyLoginID(LoginID);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        public static List<EmployeesInfo> GetDynamicContent(int? ID, string EmployeeCode, string EmployeeName, int? ParentID, string UserName, string Mobile, string Position, int? Status, int? RowPerPage, int? PageNumber)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.GetDynamicContent(ID, EmployeeCode, EmployeeName, ParentID, UserName, Mobile, Position, Status, RowPerPage, PageNumber);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        //[dbo].[Employee.GetDynamicContent]
        public static DataTable GetDynamicContentnew(int? ID, string EmployeeCode, string EmployeeName, int? ParentID, string UserName, string Mobile, string Position, int? Status, int? RowPerPage, int? PageNumber)
        {
            return DAL.Base.BaseDataContext.ExecuteDataset("[dbo].[Employee.GetDynamicContent]", new object[] { ID, EmployeeCode, EmployeeName, ParentID, UserName, Mobile, Position, Status, RowPerPage, PageNumber }).Tables[0];
        }
        public static DataTable Calendargetlist(int Year)
        {
            return DAL.Base.BaseDataContext.ExecuteDataset("[dbo].[Calendar.getlist]", new object[] { Year }).Tables[0];
        }

        

        public static List<EmployeesInfo> GetDynamicContent1(int? Id, int? ParentId, string UserName, int? Type, int? Status, int? StartRowIndex, int? MaximumRows)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.GetDynamicContent1(Id, ParentId, UserName, Type, Status, StartRowIndex, MaximumRows);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        public static List<EmployeesInfo> getalllistByTree(string AccountName, string EmployeeCode, string ParentCode, string LoginName, string Position, int? Status)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.getalllistByTree(AccountName, EmployeeCode, ParentCode, LoginName, Position, Status);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        
        public static DataSet getalllistByTreeExport(string AccountName, string EmployeeCode, string ParentCode, string LoginName, string Position, int? Status)
        {
            using (EmployeesContext context = new EmployeesContext())
            {
                return context.getalllistByTreeExport( AccountName, EmployeeCode, ParentCode, LoginName, Position, Status );
            }
        }
        public static DataSet EmployeeStoresGetDynamicContent(string EmployeeCode, string Position, string Parent, string EmployeeName, string Mobile, string Division)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                return context.EmployeeStoresGetDynamicContent( EmployeeCode, Position, Parent, EmployeeName, Mobile, Division );
            }
        }
        public static int EmployeeStoresInsertDataTable(DataTable dt)
        {
            using (EmployeesContext context = new EmployeesContext())
            {
                return context.EmployeeStoresInsertDataTable(dt );
            }
        }
        public static int Import_EmployeeEfficiencies(DataTable dt)
        {
            using (EmployeesContext context = new EmployeesContext())
            {
                return context.Import_EmployeeEfficiencies(dt);
            }
        }
        public static int Import_EmployeeGrading(DataTable dt)
        {
            using (EmployeesContext context = new EmployeesContext())
            {
                return context.Import_EmployeeGrading(dt);
            }
        }
        public static int Import_EmployeeTraining(DataTable dt)
        {
            using (EmployeesContext context = new EmployeesContext())
            {
                return context.Import_EmployeeTraining(dt);
            }
        }

        public static int Employee_Action(string EmployeeCode, string EmployeeName, string Division, string Position, string Region, string Mobile, string Parent, string LoginName, string PassWord, int? Status, int? Sex)
        {
            using (EmployeesContext context = new EmployeesContext())
            {
                return context.Employee_Action(EmployeeCode, EmployeeName, Division, Position, Region, Mobile, Parent, LoginName, PassWord, Status, Sex);
            }
        }
        public static int EmployeeStore_Action(string EmployeeCode, string ShopCode)
        {
            int _lst = 0;
            _lst = BaseDataContext.ExecuteNonQuery("[dbo].[EmployeeStore.InsertXML]", EmployeeCode, ShopCode);
            return _lst;
        }

        public static DataTable GetCategorylist(int? EmployeeId)
        {
            return BaseDataContext.ExecuteDataset("[dbo].[Employees.GetCategory]", new object[] { EmployeeId }).Tables[0];
        }
        public static DataSet EmployeeOffGetList(int? EmployeeId,int Year, int Month)
        {
            return BaseDataContext.ExecuteDataset("[dbo].[EmployeeOff.GetList]", new object[] { EmployeeId, Year, Month });
        }//
        public static DataSet EmployeeOTGetList(int? EmployeeId, int Year, int Month)
        {
            return BaseDataContext.ExecuteDataset("[dbo].[EmployeeOT.GetList]", new object[] { EmployeeId, Year, Month });
        }
        public static DataTable EmployeeOffCheck(int? EmployeeId, string WorkingDate)
        {
            return BaseDataContext.ExecuteDataset("[dbo].[EmployeeOff.Check]", new object[] { EmployeeId, WorkingDate }).Tables[0];
        }
        public static DataTable EmployeeOTCheck(int? EmployeeId, string WorkingDate)
        {
            return BaseDataContext.ExecuteDataset("[dbo].[EmployeeOT.Check]", new object[] { EmployeeId, WorkingDate }).Tables[0];
        }
        public static DataTable EmployeeOffCheckLeader(int? EmployeeId)
        {
            return BaseDataContext.ExecuteDataset("[dbo].[EmployeeOff.CheckLeader]", new object[] { EmployeeId }).Tables[0];
        }
        public static DataTable EmployeeOffListType()
        {
            return BaseDataContext.ExecuteDataset("[dbo].[EmployeeOff.ListType]").Tables[0];
        }
        public static int EmployeeOffCreated(int? EmployeeId, string WorkingDate, int OffType, string EmployeeNote, int? UserLogin)
        {
            int _lst = 0;
            _lst = BaseDataContext.ExecuteNonQuery("[dbo].[EmployeeOff.Created]", EmployeeId, WorkingDate, OffType, EmployeeNote, UserLogin);
            return _lst;
        }
        public static int EmployeeOTCreated(int? EmployeeId, string WorkingDate,string FromTime, string ToTime, decimal TotalHour, string EmployeeNote, int? UserLogin)
        {
            int _lst = 0;
            _lst = BaseDataContext.ExecuteNonQuery("[dbo].[EmployeeOT.Created]", EmployeeId, WorkingDate, FromTime, ToTime, TotalHour, EmployeeNote, UserLogin);
            return _lst;
        }
        //
        public static int EmployeeOffComfirm(int? UserLogin, int ComfirmType, string ComfirmNote, int? EmployeeId, string WorkingDate)
        {
            int _lst = 0;
            _lst = BaseDataContext.ExecuteNonQuery("[dbo].[EmployeeOff.Comfirm]", UserLogin, ComfirmType, ComfirmNote, EmployeeId, WorkingDate);
            return _lst;
        }
        public static int EmployeeOTComfirm(int? UserLogin, int ComfirmType, string ComfirmNote, int? EmployeeId, string WorkingDate)
        {
            int _lst = 0;
            _lst = BaseDataContext.ExecuteNonQuery("[dbo].[EmployeeOT.Comfirm]", UserLogin, ComfirmType, ComfirmNote, EmployeeId, WorkingDate);
            return _lst;
        }
        public static DataTable GetLeaderlist(int? EmployeeId, string Position)
        {
            return BaseDataContext.ExecuteDataset("[dbo].[Attendance.GetLeader]", new object[] {  EmployeeId,  Position }).Tables[0];
        }

        // 

        public static List<EmployeesInfo> GetLeader(int? EmployeeCode, string Position)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.GetLeader(EmployeeCode, Position);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }

        public static List<EmployeesInfo> GetCategory(int? EmployeeId)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.GetCategory(EmployeeId);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }

        public static List<EmployeesInfo> CheckCode(string EmployeeCode, string Username)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.CheckCode(EmployeeCode, Username);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        public static List<EmployeesInfo> getPosition()
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.getPosition();
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        
        public static DataSet EmployeeShare(string EmployeeCode, int? EmployeeId, int? Type)
        {
            using (EmployeesContext context = new EmployeesContext())
            {
                return context.EmployeeShare(EmployeeCode, EmployeeId, Type);
            }
        }
        public static DataSet EmployeePassword(string EmployeeCode, string Password)
        {
            return BaseDataContext.ExecuteDataset("[dbo].[EmployeePassword.Action]", new object[] { EmployeeCode, Password });
        }
        public static List<EmployeesInfo> EmployeeEfficiencies_GetCode(string ShopCode, string EmployeeCode)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.EmployeeEfficiencies_GetCode(ShopCode, EmployeeCode);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }
        public static List<EmployeesInfo> EmployeeEfficiencies_GetEmployeeId(string EmployeeCode)
        {
            List<EmployeesInfo> _lst = new List<EmployeesInfo>();
            using (EmployeesContext context = new EmployeesContext())
            {
                var tmp = context.EmployeeEfficiencies_GetEmployeeId(EmployeeCode);
                if (tmp != null)
                {
                    _lst = tmp.ToList();
                }
                return _lst;
            }
        }

        public static DataTable MailEmployeeGetList(string LeaderCode)
        {
            using (var context = new EmployeesContext())
            {
                return context.MailEmployeeGetList(LeaderCode);
            }
        }
        public static DataTable MailGetListWarning(string LeaderCode, string FromDate, string ToDate, int? EmployeeId, int? CountDate,int? Type, int? RowPerPage, int? PageNumber)
        {
            using (var context = new EmployeesContext())
            {
                return context.MailGetListWarning(LeaderCode, FromDate, ToDate, EmployeeId, CountDate, Type, RowPerPage, PageNumber);
            }
        }
        public static int MailComfirmEmployee(int EmployeeId, int LeaderId, string EndDate, string Type, string FromDate, string ToDate = null, string LeaderNote = null)
        {
            using (var context = new EmployeesContext())
            {
                return context.MailComfirmEmployee(EmployeeId, LeaderId, EndDate, Type, FromDate, ToDate, LeaderNote);
            }
        }
        public static DataSet EmployeePayslipsFeedBack(int ShopId, int EmployeeId, int Year, int Month, int Group)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeePayslipsFeedBack(ShopId, EmployeeId, Year, Month, Group);
            }
        }
        public static int EmployeeSalaryUpdate(int Id, int FbId, int EmployeeId, int Year, int Month, string Note)
        {
            using (var context = new EmployeesContext())
            {
                return context.EmployeeSalaryUpdate(Id, FbId, EmployeeId, Year, Month, Note);
            }
        }
        public static DataTable PlayslipsgetEmployee(int UserLogin, int EmployeeId, int Year, int Month, int FbId, int? Group, int? RowPerPage, int? PageNumber)
        {
            using (var context = new EmployeesContext())
            {
                return context.PlayslipsgetEmployee(UserLogin, EmployeeId, Year, Month, FbId, Group, RowPerPage, PageNumber);
            }
        }

        public static int Payslips_Import(int UserLogin, DataTable tbl, int Month, int Year, int IsDelete, int Group)
        {
            using (var context = new EmployeesContext())
            {
                return context.Payslips_Import(UserLogin, tbl, Month, Year, IsDelete, Group);
            }
        }

        public static DataSet PayslipsExport(int Year, int Month, int? EmployeeId, int? Group, int LoginId)
        {
            using (var context = new EmployeesContext())
            {
                return context.PayslipsExport(Year, Month, EmployeeId, Group, LoginId);
            }
        }

        public static int EmployeesUpdateMoreInfo(int? EmployeeId, int? ProvinceId, int? DistrictId, int? TownId, string AddressDetail, string Comment)
        {
            int _lst = 0;
            using (EmployeesContext context = new EmployeesContext())
            {
                _lst = context.EmployeesUpdateMoreInfo(EmployeeId, ProvinceId, DistrictId, TownId, AddressDetail, Comment);
                return _lst;
            }
        }
    }
}