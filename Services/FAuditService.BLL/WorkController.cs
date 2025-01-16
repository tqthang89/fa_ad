using FAuditService.Data;
using FAuditService.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.BLL
{
    public static class WorkController
    {
        public static List<WorkPlanInfo> getWorkPlan(string EmployeeCode)
        {
            List<WorkPlanInfo> list = null;
            using (WorkPlanContext context = new WorkPlanContext())
            {
                var _list = context.ListWorkPlan(EmployeeCode);
                if (_list != null)
                    list = _list.ToList();
            }
            return list;
        }

        public static int SaveWorkPlan(string EmployeeCode, string WorkingDate, string WorkingNote, string Reason)
        {
            using (var context = new WorkPlanContext())
            {
                return context.SaveWorkPlan(EmployeeCode, WorkingDate, WorkingNote, Reason);
            }
        }

		public static int WorkResultAction(int EmployeeId,int ShopId,int AuditResult,string ShopType,int WorkDate, string WorkTime,string Comment,int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att)
		{
			using (var context = new WorkPlanContext())
			{
				return context.WorkResultAction(EmployeeId,  ShopId,  AuditResult,  ShopType, WorkDate,  WorkTime,  Comment, ReasonResult, CustomerDisplay,  CustomerComment,  dtosa, dt_sos, dt_sos_compe, dt_pro, dt_pro_compe, dt_posm, dt_survey, dt_surveydetail, dt_audio, dt_photo, dt_att);
			}
		}

        public static int WorkResultActionV2(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att)
        {
            using (var context = new WorkPlanContext())
            {
                return context.WorkResultActionV2(EmployeeId, ShopId, AuditResult, ShopType, WorkDate, WorkTime, Comment, ReasonResult, CustomerDisplay, CustomerComment, dtosa, dt_sos, dt_sos_compe, dt_pro, dt_pro_compe, dt_posm, dt_survey, dt_surveydetail, dt_audio, dt_photo, dt_att);
            }
        }

        public static int WorkResultActionMT(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att,DataTable dt_ool,DataTable dt_ool_detail)
        {
            using (var context = new WorkPlanContext())
            {
                return context.WorkResultActionMT(EmployeeId, ShopId, AuditResult, ShopType, WorkDate, WorkTime, Comment, ReasonResult, CustomerDisplay, CustomerComment, dtosa, dt_sos, dt_sos_compe, dt_pro, dt_pro_compe, dt_posm, dt_survey, dt_surveydetail, dt_audio, dt_photo, dt_att, dt_ool, dt_ool_detail);
            }
        }

        public static int WorkResultActionMTV2(int EmployeeId, int ShopId, int AuditResult, string ShopType, int WorkDate, string WorkTime, string Comment, int? ReasonResult, int CustomerDisplay, string CustomerComment, DataTable dtosa, DataTable dt_sos, DataTable dt_sos_compe, DataTable dt_pro, DataTable dt_pro_compe, DataTable dt_posm, DataTable dt_survey, DataTable dt_surveydetail, DataTable dt_audio, DataTable dt_photo, DataTable dt_att, DataTable dt_ool, DataTable dt_ool_detail)
        {
            using (var context = new WorkPlanContext())
            {
                return context.WorkResultActionMTV2(EmployeeId, ShopId, AuditResult, ShopType, WorkDate, WorkTime, Comment, ReasonResult, CustomerDisplay, CustomerComment, dtosa, dt_sos, dt_sos_compe, dt_pro, dt_pro_compe, dt_posm, dt_survey, dt_surveydetail, dt_audio, dt_photo, dt_att, dt_ool, dt_ool_detail);
            }
        }
        public static DataSet Attendance_Apple_Action(int EmployeeId, int ShopId,int AttendanceType, double? latitude, double? longitude, string Address, string LinkPhoto,int ActionType)
        {
            using (var context = new WorkPlanContext())
            {
                return context.Attendance_Apple_Action(EmployeeId, ShopId, AttendanceType,latitude, longitude, Address, LinkPhoto, ActionType);
            }
        }
        public static DataSet Employee_Apple_Action(string Email, string PassWord, string OTP,int ActionType)
        {
            using (var context = new WorkPlanContext())
            {
                return context.Employee_Apple_Action(Email, PassWord, OTP, ActionType);
            }
        }
    }
}
