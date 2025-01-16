using DAL.WorkResults;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.WorkResults
{
    public class WorkResultController
    {
        public DataTable WorkResultGetList(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? Auditor, int? AuditResult, string ShopCode,
            int AreaId, int ProvinceId, int DistrictId, int TownId, int MVOId, int POGId,int QCStatus,string LWorkId,string ShopType, int Site,
            int? PageNumber, int? RowNumber)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetList(LoginId, FromDate, ToDate, SupId, Auditor, AuditResult, ShopCode, AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, LWorkId, ShopType, Site, PageNumber, RowNumber);
            }
        }
        public DataSet WorkResult_BCCT(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? Auditor, int? AuditResult, string ShopCode,
            int AreaId, int ProvinceId, int DistrictId, int TownId, int MVOId, int POGId, int QCStatus, string LWorkId,
            int? PageNumber, int? RowNumber)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResult_BCCT(LoginId, FromDate, ToDate, SupId, Auditor, AuditResult, ShopCode, AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, LWorkId, PageNumber, RowNumber);
            }
        }
        public DataSet WorkResult_BCCT_Guest(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? Auditor, int? AuditResult, string ShopCode,
           int AreaId, int ProvinceId, int DistrictId, int TownId, int MVOId, int POGId, int QCStatus, string LWorkId,
           int? PageNumber, int? RowNumber)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResult_BCCT_Guest(LoginId, FromDate, ToDate, SupId, Auditor, AuditResult, ShopCode, AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, LWorkId, PageNumber, RowNumber);
            }
        }
        public DataTable WorkResultGuestGetList(int LoginId, DateTime FromDate, DateTime ToDate, int? SupId, int? Auditor, int? AuditResult, string ShopCode,
           int AreaId, int ProvinceId, int DistrictId, int TownId, int MVOId, int POGId, int QCStatus,
           int? PageNumber, int? RowNumber)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGuestGetList(LoginId, FromDate, ToDate, SupId, Auditor, AuditResult, ShopCode, AreaId, ProvinceId, DistrictId, TownId, MVOId, POGId, QCStatus, PageNumber, RowNumber);
            }
        }
        public DataTable WorkResultGetTabByWorkId(int WorkId)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetTabByWorkId(WorkId);
            }
        }
        public DataTable WorkResultGetKPISurvey(long WorkId, int KPIId)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetKPISurvey(WorkId, KPIId);
            }
        }
        public DataTable WorkResultGetKPIOSA(long WorkId,int ShowAll = 0)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetKPIOSA(WorkId, ShowAll);
            }
        }
        public DataTable WorkResultGetKPICalculator(long WorkId)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetKPICalculator(WorkId);
            }
        }
        public DataTable WorkResultGetKPIPOSM(long WorkId)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetKPIPOSM(WorkId);
            }
        }
        public DataTable WorkResultGetKPIPROMOTION(long WorkId)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetKPIPROMOTION(WorkId);
            }
        }
        public DataTable WorkResultGetAudio(long WorkId)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetAudio(WorkId);
            }
        }
        public DataTable WorkResultGetPhotos(long WorkId, int? KPIId)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetPhotos(WorkId, KPIId);
            }
        }
        public DataTable WorkResultGetPhotosAdmin(long WorkId, int? KPIId)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultGetPhotosAdmin(WorkId, KPIId);
            }
        }
        public DataTable WorkResultExportRawData(int LoginId, DateTime FromDate, DateTime ToDate, int KPIId, int? SupId, int? Auditor, int? AuditResult, string ShopCode)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultExportRawData(LoginId, FromDate, ToDate, KPIId, SupId, Auditor, AuditResult, ShopCode);
            }
        }
        public int UpdateDataKPI(int WorkId, int KPIId,int ItemId, int? value,string _value)
        {
            using (var context = new WorkResultsContext())
            {
                return context.UpdateDataKPI(WorkId,  KPIId,  ItemId,  value,  _value);
            }
        }
        public DataTable WorkResultUpdateQC(int LoginId, int WorkId, int KPI, int QCStatus, string Comment, int ActionType)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultUpdateQC(LoginId,  WorkId,  KPI,  QCStatus,  Comment,  ActionType);
            }   
        }
        public DataSet Dashboard_Data(int LoginId, int CycleId, int AreaId, int ProvinceId, int MDOId, int PNGId)
        {
            using (var context = new WorkResultsContext())
            {
                return context.Dashboard_Data(LoginId, CycleId,  AreaId,  ProvinceId,  MDOId,  PNGId);
            }
        }
        public DataTable WorkResultActionImage(int LoginId, int WorkId,int ShopId,int AuditDate, int KPI, int ImageId, string LinkImage,int ItemId,string ImageTime, int ActionType)
        {
            using (var context = new WorkResultsContext())
            {
                return context.WorkResultActionImage(LoginId, WorkId, ShopId, AuditDate, KPI, ImageId, LinkImage, ItemId, ImageTime, ActionType);
            }
        }
        public DataTable ToolsIT(int LoginId, int? ShopId, int? EmployeeId, int? AuditDate, int? TypeIT,  int ActionType)
        {
            using (var context = new WorkResultsContext())
            {
                return context.ToolsIT(LoginId, ShopId, EmployeeId, AuditDate, TypeIT, ActionType);
            }
        }
        public DataTable ExportFile(int LoginId, int FromDate, int ToDate)
        {
            using (var context = new WorkResultsContext())
            {
                return context.ExportFile(LoginId, FromDate, ToDate);
            }
        }
    }
}
