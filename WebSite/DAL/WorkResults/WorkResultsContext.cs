using System;
using System.Data;
using System.Data.Linq.Mapping;
using System.Reflection;

namespace DAL.WorkResults
{
    public class WorkResultsContext : DataContext
    {
        [Function(Name = "[dbo].[WorkResult.GetList]")]
        public DataTable WorkResultGetList(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? Auditor, int? AuditResult, string ShopCode,
             int AreaId, int ProvinceId, int DistrictId, int TownId, int MVOId, int POGId,int QCStatus,string LWorkId,
             string ShopType, int Site,
            int? PageNumber, int? RowNumber)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate, SupId, Auditor, AuditResult, ShopCode, AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, LWorkId, ShopType,Site, PageNumber, RowNumber);
        }

        [Function(Name = "[dbo].[WorkResult.GetList_BCCT]")]
        public DataSet WorkResult_BCCT(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? Auditor, int? AuditResult, string ShopCode,
             int AreaId, int ProvinceId, int DistrictId, int TownId, int MVOId, int POGId, int QCStatus, string LWorkId,
            int? PageNumber, int? RowNumber)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate, SupId, Auditor, AuditResult, ShopCode, AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, LWorkId, PageNumber, RowNumber);
        }
        [Function(Name = "[dbo].[WorkResult.GetList_BCCT_Guest]")]
        public DataSet WorkResult_BCCT_Guest(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? Auditor, int? AuditResult, string ShopCode,
             int AreaId, int ProvinceId, int DistrictId, int TownId, int MVOId, int POGId, int QCStatus, string LWorkId,
            int? PageNumber, int? RowNumber)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate, SupId, Auditor, AuditResult, ShopCode, AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, LWorkId, PageNumber, RowNumber);
        }
        [Function(Name = "[dbo].[WorkResultGuest.GetList]")]
        public DataTable WorkResultGuestGetList(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? Auditor, int? AuditResult, string ShopCode,
            int AreaId, int ProvinceId, int DistrictId, int TownId, int MVOId, int POGId, int QCStatus,
           int? PageNumber, int? RowNumber)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate, SupId, Auditor, AuditResult, ShopCode, AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, PageNumber, RowNumber);
        }
        [Function(Name = "[dbo].[WorkResult.GetTabByWorkId]")]
        public DataTable WorkResultGetTabByWorkId(int WorkId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId);
        }
        [Function(Name = "[dbo].[WorkResult.GetKPISurvey]")]
        public DataTable WorkResultGetKPISurvey(long WorkId, int KPIId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId, KPIId);
        }
        [Function(Name = "[dbo].[WorkResult.GetKPIOSA]")]
        public DataTable WorkResultGetKPIOSA(long WorkId, int ShowAll = 0)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId, ShowAll);
        }
        [Function(Name = "[dbo].[WorkResult.GetKPICalculator]")]
        public DataTable WorkResultGetKPICalculator(long WorkId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId);
        }
        [Function(Name = "[dbo].[WorkResult.GetKPIPOSM]")]
        public DataTable WorkResultGetKPIPOSM(long WorkId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId);
        }
        [Function(Name = "[dbo].[WorkResult.GetKPIPROMOTION]")]
        public DataTable WorkResultGetKPIPROMOTION(long WorkId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId);
        }
        [Function(Name = "[dbo].[WorkResult.GetAudio]")]
        public DataTable WorkResultGetAudio(long WorkId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId);
        }
        [Function(Name = "[dbo].[WorkResult.GetPhotos]")]
        public DataTable WorkResultGetPhotos(long WorkId, int? KPIId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId, KPIId);
        }
        [Function(Name = "[dbo].[WorkResult.GetPhotosAdmin]")]
        public DataTable WorkResultGetPhotosAdmin(long WorkId, int? KPIId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), WorkId, KPIId);
        }
        [Function(Name = "[dbo].[WorkResult.ExportRawData]")]
        public DataTable WorkResultExportRawData(int LoginId, DateTime FromDate, DateTime ToDate, int KPIId, int? SupId, int? Auditor, int? AuditResult, string ShopCode)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate, KPIId, SupId, Auditor, AuditResult, ShopCode);
        }
        [Function(Name = "[dbo].[UpdateDataKPI]")]
        public int UpdateDataKPI(int WorkId, int KPIId, int ItemId, int? value, string _value)
        {
            return ExecuteNonQuery((MethodInfo)MethodBase.GetCurrentMethod(), WorkId, KPIId, ItemId, value, _value);
        }
        [Function(Name = "[dbo].[WorkResult.UpdateQC]")]
        public DataTable WorkResultUpdateQC(int LoginId, int WorkId, int KPIId, int QCStatus, string Comment, int ActionType)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, WorkId, KPIId, QCStatus, Comment, ActionType);
        }
        [Function(Name = "[dbo].[Dashboard.GetData]")]
        public DataSet Dashboard_Data(int LoginId, int CycleId, int AreaId, int ProvinceId, int MDOId, int PNGId)
        {
            return ExecuteDataset((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, CycleId, AreaId, ProvinceId, MDOId, PNGId);
        }
        [Function(Name = "[dbo].[WorkResult.ActionImage]")]
        public DataTable WorkResultActionImage(int LoginId, int WorkId, int ShopId, int AuditDate, int KPIId, int ImageId, string LinkImage, int ItemId, string ImageTime, int ActionType)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, WorkId, ShopId,AuditDate, KPIId, ImageId, LinkImage, ItemId, ImageTime, ActionType);
        }

        [Function(Name = "[dbo].[ToolsIT.Action]")]
        public DataTable ToolsIT(int LoginId, int? ShopId, int? EmployeeId, int? AuditDate, int? TypeIT, int ActionType)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, ShopId, EmployeeId, AuditDate, TypeIT, ActionType);
        }
        [Function(Name = "[dbo].[WorkResult.ExportFile]")]
        public DataTable ExportFile(int LoginId, int FromDate, int ToDate)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), LoginId, FromDate, ToDate);
        }
    }
}
