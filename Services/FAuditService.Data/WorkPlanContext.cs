using FAuditService.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq.Mapping;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Data
{
    public class WorkPlanContext : DAUltility.DataContext
    {
        [Function(Name = "[dbo].[Mobile.WorkingPlan.GetList]")]
        public IEnumerable<WorkPlanInfo> ListWorkPlan(
            [Parameter(Name = "@EmployeeCode", DbType = "NVARCHAR(100)")]String EmployeeCode)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode);
            return (IEnumerable<WorkPlanInfo>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.WorkingPlan.Save]")]
        public int SaveWorkPlan(
           [Parameter(Name = "@EmployeeCode", DbType = "VARCHAR(100)")]string EmployeeCode,
           [Parameter(Name = "@WorkingDate", DbType = "VARCHAR(50)")]string WorkingDate,
           [Parameter(Name = "@WorkingNote", DbType = "VARCHAR(MAX)")]string WorkingNote,
           [Parameter(Name = "@Reason", DbType = "NVARcHAR(256)")]string Reason
           )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeCode, WorkingDate, WorkingNote, Reason);
            return 1;
        }

        public int WorkResultAction(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            command.Parameters.Add(new SqlParameter("@AuditResult", AuditResult));
            command.Parameters.Add(new SqlParameter("@ShopType", ShopType));
            command.Parameters.Add(new SqlParameter("@WorkDate", WorkDate));
            command.Parameters.Add(new SqlParameter("@WorkTime", WorkTime));
            command.Parameters.Add(new SqlParameter("@Comment", Comment));
            //int? ReasonResult, int CustomerDisplay, string CustomerComment
            command.Parameters.Add(new SqlParameter("@ReasonResult", ReasonResult));
            command.Parameters.Add(new SqlParameter("@CustomerDisplay", CustomerDisplay));
            command.Parameters.Add(new SqlParameter("@CustomerComment", CustomerComment));
            command.Parameters.Add(new SqlParameter("@dtosa", dtosa));
            command.Parameters.Add(new SqlParameter("@dtsos", dt_sos));
            command.Parameters.Add(new SqlParameter("@dtsoscompe", dt_sos_compe));
            command.Parameters.Add(new SqlParameter("@dtpro", dt_pro));
            command.Parameters.Add(new SqlParameter("@dtprocompe", dt_pro_compe));
            command.Parameters.Add(new SqlParameter("@dtposm", dt_posm));
            command.Parameters.Add(new SqlParameter("@dtsurvey", dt_survey));
            command.Parameters.Add(new SqlParameter("@dtsurveydetail", dt_surveydetail));
            command.Parameters.Add(new SqlParameter("@dtaudio", dt_audio));
            command.Parameters.Add(new SqlParameter("@dtphoto", dt_photo));
            command.Parameters.Add(new SqlParameter("@dtatt", dt_att));
            return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.WorkResultAction]");
            //return 1
        }

        public int WorkResultActionV2(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            command.Parameters.Add(new SqlParameter("@AuditResult", AuditResult));
            command.Parameters.Add(new SqlParameter("@ShopType", ShopType));
            command.Parameters.Add(new SqlParameter("@WorkDate", WorkDate));
            command.Parameters.Add(new SqlParameter("@WorkTime", WorkTime));
            command.Parameters.Add(new SqlParameter("@Comment", Comment));
            //int? ReasonResult, int CustomerDisplay, string CustomerComment
            command.Parameters.Add(new SqlParameter("@ReasonResult", ReasonResult));
            command.Parameters.Add(new SqlParameter("@CustomerDisplay", CustomerDisplay));
            command.Parameters.Add(new SqlParameter("@CustomerComment", CustomerComment));
            command.Parameters.Add(new SqlParameter("@dtosa", dtosa));
            command.Parameters.Add(new SqlParameter("@dtsos", dt_sos));
            command.Parameters.Add(new SqlParameter("@dtsoscompe", dt_sos_compe));
            command.Parameters.Add(new SqlParameter("@dtpro", dt_pro));
            command.Parameters.Add(new SqlParameter("@dtprocompe", dt_pro_compe));
            command.Parameters.Add(new SqlParameter("@dtposm", dt_posm));
            command.Parameters.Add(new SqlParameter("@dtsurvey", dt_survey));
            command.Parameters.Add(new SqlParameter("@dtsurveydetail", dt_surveydetail));
            command.Parameters.Add(new SqlParameter("@dtaudio", dt_audio));
            command.Parameters.Add(new SqlParameter("@dtphoto", dt_photo));
            command.Parameters.Add(new SqlParameter("@dtatt", dt_att));
            return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.WorkResultActionV2]");
            //return 1
        }

        public int WorkResultActionMT(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att, DataTable dt_ool, DataTable dt_ool_detail)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            command.Parameters.Add(new SqlParameter("@AuditResult", AuditResult));
            command.Parameters.Add(new SqlParameter("@ShopType", ShopType));
            command.Parameters.Add(new SqlParameter("@WorkDate", WorkDate));
            command.Parameters.Add(new SqlParameter("@WorkTime", WorkTime));
            command.Parameters.Add(new SqlParameter("@Comment", Comment));
            //int? ReasonResult, int CustomerDisplay, string CustomerComment
            command.Parameters.Add(new SqlParameter("@ReasonResult", ReasonResult));
            command.Parameters.Add(new SqlParameter("@CustomerDisplay", CustomerDisplay));
            command.Parameters.Add(new SqlParameter("@CustomerComment", CustomerComment));
            command.Parameters.Add(new SqlParameter("@dtosa", dtosa));
            command.Parameters.Add(new SqlParameter("@dtsos", dt_sos));
            command.Parameters.Add(new SqlParameter("@dtsoscompe", dt_sos_compe));
            command.Parameters.Add(new SqlParameter("@dtpro", dt_pro));
            command.Parameters.Add(new SqlParameter("@dtprocompe", dt_pro_compe));
            command.Parameters.Add(new SqlParameter("@dtposm", dt_posm));
            command.Parameters.Add(new SqlParameter("@dtsurvey", dt_survey));
            command.Parameters.Add(new SqlParameter("@dtsurveydetail", dt_surveydetail));
            command.Parameters.Add(new SqlParameter("@dtaudio", dt_audio));
            command.Parameters.Add(new SqlParameter("@dtphoto", dt_photo));
            command.Parameters.Add(new SqlParameter("@dtatt", dt_att));//dt_ool
            command.Parameters.Add(new SqlParameter("@dt_ool", dt_ool));
            command.Parameters.Add(new SqlParameter("@dt_ool_detail", dt_ool_detail));
            return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.WorkResultActionMT]");
            //return 1
        }

        public int WorkResultActionMTV2(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att, DataTable dt_ool, DataTable dt_ool_detail)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            command.Parameters.Add(new SqlParameter("@AuditResult", AuditResult));
            command.Parameters.Add(new SqlParameter("@ShopType", ShopType));
            command.Parameters.Add(new SqlParameter("@WorkDate", WorkDate));
            command.Parameters.Add(new SqlParameter("@WorkTime", WorkTime));
            command.Parameters.Add(new SqlParameter("@Comment", Comment));
            //int? ReasonResult, int CustomerDisplay, string CustomerComment
            command.Parameters.Add(new SqlParameter("@ReasonResult", ReasonResult));
            command.Parameters.Add(new SqlParameter("@CustomerDisplay", CustomerDisplay));
            command.Parameters.Add(new SqlParameter("@CustomerComment", CustomerComment));
            command.Parameters.Add(new SqlParameter("@dtosa", dtosa));
            command.Parameters.Add(new SqlParameter("@dtsos", dt_sos));
            command.Parameters.Add(new SqlParameter("@dtsoscompe", dt_sos_compe));
            command.Parameters.Add(new SqlParameter("@dtpro", dt_pro));
            command.Parameters.Add(new SqlParameter("@dtprocompe", dt_pro_compe));
            command.Parameters.Add(new SqlParameter("@dtposm", dt_posm));
            command.Parameters.Add(new SqlParameter("@dtsurvey", dt_survey));
            command.Parameters.Add(new SqlParameter("@dtsurveydetail", dt_surveydetail));
            command.Parameters.Add(new SqlParameter("@dtaudio", dt_audio));
            command.Parameters.Add(new SqlParameter("@dtphoto", dt_photo));
            command.Parameters.Add(new SqlParameter("@dtatt", dt_att));//dt_ool
            command.Parameters.Add(new SqlParameter("@dt_ool", dt_ool));
            command.Parameters.Add(new SqlParameter("@dt_ool_detail", dt_ool_detail));
            return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.WorkResultActionMTV2]");
            //return 1
        }

        public DataSet Attendance_Apple_Action(int EmployeeId, int ShopId,int AttendanceType, double? latitude, double? longitude, string Address, string LinkPhoto,int ActionType)
        {
            //SqlCommand command = new SqlCommand();
            //command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            //command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
            //command.Parameters.Add(new SqlParameter("@AttendanceType", AttendanceType));
            //command.Parameters.Add(new SqlParameter("@latitude", latitude));
            //command.Parameters.Add(new SqlParameter("@longitude", longitude));
            //command.Parameters.Add(new SqlParameter("@Address", Address));
            //command.Parameters.Add(new SqlParameter("@LinkPhoto", LinkPhoto));
            //command.Parameters.Add(new SqlParameter("@ActionType", ActionType));
            //return DAUltility.Helpers.SqlHelper.ExecuteDataset(command, "[dbo].[Apple.AtendanceAction]");
            //return 1
            return DAUltility.Helpers.SqlHelper.ExecuteDataset("[dbo].[Apple.AtendanceAction]", EmployeeId, ShopId, AttendanceType, latitude, longitude, Address, LinkPhoto, ActionType);
        }
        public DataSet Employee_Apple_Action(string Email, string PassWord, string OTP, int ActionType)
        {
            //SqlCommand command = new SqlCommand();
            //command.Parameters.Add(new SqlParameter("@Email", Email));
            //command.Parameters.Add(new SqlParameter("@PassWord", PassWord));
            //command.Parameters.Add(new SqlParameter("@OTP", OTP));
            //command.Parameters.Add(new SqlParameter("@ActionType", ActionType));
            //return DAUltility.Helpers.SqlHelper.ExecuteDataset(command, "[dbo].[Apple.EmployeeAction]");
            //return 1
            return DAUltility.Helpers.SqlHelper.ExecuteDataset("[dbo].[Apple.EmployeeAction]", Email, PassWord, OTP, ActionType);
        }
    }
}
