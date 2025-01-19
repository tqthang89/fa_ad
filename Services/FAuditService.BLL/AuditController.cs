using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using FAuditService.Data;
using FAuditService.Entities;

namespace FAuditService.BLL
{
    public class AuditController
    {

        public static List<CoinCollectInfo> getCoinCollect(int EmployeeId)
        {
            List<CoinCollectInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.getCoinCollect(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static List<EvaluateResultInfo> getLastEvaluateResult(int EmployeeId)
        {
            List<EvaluateResultInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.getLastEvaluateResult(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

        public static List<MasterInfo> MasterGetList(int EmployeeId)
        {
            List<MasterInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.MasterGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
		#region MT KPI
		public static List<KPIMTSOSInfo> KPIMTSOSGetList(int EmployeeId)
		{
			List<KPIMTSOSInfo> _lst = null;
			using (AuditContext context = new AuditContext())
			{
				var value = context.KPIMTSOSGetList(EmployeeId);
				if (value != null)
					_lst = value.ToList();
			}
			return _lst;
		}
		public static List<KPIMTOSAInfo> KPIMTOSAGetList(int EmployeeId)
		{
			List<KPIMTOSAInfo> _lst = null;
			using (AuditContext context = new AuditContext())
			{
				var value = context.KPIMTOSAGetList(EmployeeId);
				if (value != null)
					_lst = value.ToList();
			}
			return _lst;
		}
        public static List<KPIOOLInfo> KPIOLGetList(int EmployeeId)
        {
            List<KPIOOLInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.KPIOOLGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

        public static List<KPIOOLShopInfo> KPIOLShopGetList(int EmployeeId)
        {
            List<KPIOOLShopInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.KPIOLShopGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

        public static List<KPIOOLBrandInfo> KPIOLBrandGetList(int EmployeeId)
        {
            List<KPIOOLBrandInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.KPIOLBrandGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

        public static List<KPIMTPromotionInfo> KPIMTProGetList(int EmployeeId)
		{
			List<KPIMTPromotionInfo> _lst = null;
			using (AuditContext context = new AuditContext())
			{
				var value = context.KPIMTProGetList(EmployeeId);
				if (value != null)
					_lst = value.ToList();
			}
			return _lst;
		}
        #endregion

        public static int SaveOrUpdateEmployeeDownload(int EmployeeId, int? IsLoading, int? version)
        {
            using (AuditContext context = new AuditContext())
            {
                return context.SaveOrUpdateEmployeeDownload(EmployeeId, IsLoading, version);
            }
        }
        public static List<MobileSupportInfo> GetSupport(int EmployeeId)
        {
            List<MobileSupportInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.GetSupport(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static int InserDevice(int? EmployeeId, string Model, string Release, string IMEI, int? Version, string Platform)
        {
            SqlCommand command = new SqlCommand();
            command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
            command.Parameters.Add(new SqlParameter("@Model", Model));
            command.Parameters.Add(new SqlParameter("@Release", Release));
            command.Parameters.Add(new SqlParameter("@IMEI", IMEI));
            command.Parameters.Add(new SqlParameter("@Version", Version));
            command.Parameters.Add(new SqlParameter("@Platform", Platform));
            command.CommandTimeout = 60;
            return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.Employee.InsertDevice]");
        }
        public static List<KPISurveyInfo> KPISurveyGetList(int EmployeeId)
        {
            List<KPISurveyInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.KPISurveyGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

		public static List<KPISurveyDetailInfo> KPISurveyDetailGetList(int EmployeeId)
		{
			List<KPISurveyDetailInfo> _lst = null;
			using (AuditContext context = new AuditContext())
			{
				var value = context.KPISurveyDetailGetList(EmployeeId);
				if (value != null)
					_lst = value.ToList();
			}
			return _lst;
		}

        public static List<KPISurveyAnswer> KPISurveyAnswerGetList(int EmployeeId)
        {
            List<KPISurveyAnswer> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.KPISurveyAnswerGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

        public static List<KPIPosmInfo> KPIPosmGetList(int EmployeeId)
        {
            List<KPIPosmInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.KPIPosmGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static List<KPIPromotionInfo> KPIPromotionGetList(int EmployeeId)
        {
            List<KPIPromotionInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.KPIPromotionGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static List<ProductInfo> ProductsGetList(int EmployeeId)
        {
            List<ProductInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.ProductsGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

        public static List<ProvinceInfo> ProvinceGetList(int EmployeeId)
        {
            List<ProvinceInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.ProvinceGetList(EmployeeId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static List<DistrictInfo> DistrictGetList(int EmployeeId,int ProvinceId)
        {
            List<DistrictInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.District_GetList(EmployeeId, ProvinceId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }
        public static List<TownInfo> TownGetList(int EmployeeId, int DistrictId)
        {
            List<TownInfo> _lst = null;
            using (AuditContext context = new AuditContext())
            {
                var value = context.TownGetList(EmployeeId, DistrictId);
                if (value != null)
                    _lst = value.ToList();
            }
            return _lst;
        }

        public static int InsertData(int? ShopId,int? WorkDate,string WorkTime,int EmployeeId,int? ShopFormatId,int? AuditResult,string ShopType,string Comment, string platform,string version, DataTable _tbAttendant , DataTable _tbPhoto , DataTable _tbAudio , DataTable _tbOSA , DataTable _tbPosm , DataTable _tbSurveyResult , DataTable _tbSurveyDetailResult,DataTable _tbPromotion)
        {
           
            try
            {
               
                SqlCommand command = new SqlCommand();
                command.Parameters.Add(new SqlParameter("@ShopId", ShopId));
                command.Parameters.Add(new SqlParameter("@WorkDate", WorkDate));
                command.Parameters.Add(new SqlParameter("@WorkTime", WorkTime));
                command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));
                command.Parameters.Add(new SqlParameter("@ShopFormatId", ShopFormatId));
                command.Parameters.Add(new SqlParameter("@AuditResult", AuditResult));
                command.Parameters.Add(new SqlParameter("@ShopType", ShopType));
                command.Parameters.Add(new SqlParameter("@Comment", Comment));
                command.Parameters.Add(new SqlParameter("@platform", platform));
                command.Parameters.Add(new SqlParameter("@version", version));
                //New add
                command.Parameters.Add(new SqlParameter("@TableAttendant", _tbAttendant));
                command.Parameters.Add(new SqlParameter("@TablePhoto", _tbPhoto));
                command.Parameters.Add(new SqlParameter("@TableAudio", _tbAudio));
                command.Parameters.Add(new SqlParameter("@TableOSA", _tbOSA));
                command.Parameters.Add(new SqlParameter("@TablePosm", _tbPosm));
                command.Parameters.Add(new SqlParameter("@TableSurveyResult", _tbSurveyResult));
                command.Parameters.Add(new SqlParameter("@TableSurveyDetailResult", _tbSurveyDetailResult));
                command.Parameters.Add(new SqlParameter("@TablePromotion", _tbPromotion));
                command.CommandTimeout = 60;
                return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.Worked.Insert]");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static int InsertData_CreateShop(string merchantName,string phoneNumber,int? provinceId,int? districtId,int? townId,string addressline,
            int? areaDisplay,string itemDisplay,string typeDisplay,string revenue,string photo,double? latitude,double? longitude,int EmployeeId,
            string platform, string version)
        {

            try
            {

                SqlCommand command = new SqlCommand();
                command.Parameters.Add(new SqlParameter("@merchantName", merchantName));
                command.Parameters.Add(new SqlParameter("@phoneNumber", phoneNumber));
                command.Parameters.Add(new SqlParameter("@provinceId", provinceId));
                command.Parameters.Add(new SqlParameter("@districtId", districtId));
                command.Parameters.Add(new SqlParameter("@townId", townId));
                command.Parameters.Add(new SqlParameter("@addressline", addressline));

                command.Parameters.Add(new SqlParameter("@areaDisplay", areaDisplay));
                command.Parameters.Add(new SqlParameter("@itemDisplay", itemDisplay));
                command.Parameters.Add(new SqlParameter("@typeDisplay", typeDisplay));
                command.Parameters.Add(new SqlParameter("@revenue", revenue));
                //New add
                command.Parameters.Add(new SqlParameter("@photo", photo));
                command.Parameters.Add(new SqlParameter("@latitude", latitude));
                command.Parameters.Add(new SqlParameter("@longitude", longitude));
                command.Parameters.Add(new SqlParameter("@EmployeeId", EmployeeId));

                command.Parameters.Add(new SqlParameter("@platform", platform));
                command.Parameters.Add(new SqlParameter("@version", version));

                command.CommandTimeout = 60;
                return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.Worked.Insert_CreateShop]");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
