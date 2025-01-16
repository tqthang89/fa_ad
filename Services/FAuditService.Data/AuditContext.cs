using FAuditService.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq.Mapping;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;

namespace FAuditService.Data
{
    public class AuditContext : DAUltility.DataContext
    {

        [Function(Name = "[dbo].[Mobile.KPI.lastEvaluateResult]")]
        public IEnumerable<EvaluateResultInfo> getLastEvaluateResult([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<EvaluateResultInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo].[Mobile.KPI.getCoinCollect]")]
        public IEnumerable<CoinCollectInfo> getCoinCollect([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<CoinCollectInfo>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[MasterData.GetList]")]
        public IEnumerable<MasterInfo> MasterGetList([Parameter(Name = "@EmployeeId", DbType = "INT")]int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<MasterInfo>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.KPI.Survey.GetList]")]
        public IEnumerable<KPISurveyInfo> KPISurveyGetList([Parameter(Name = "@EmployeeId", DbType = "INT")]int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<KPISurveyInfo>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.KPI.SurveyDetail.GetList]")]
		public IEnumerable<KPISurveyDetailInfo> KPISurveyDetailGetList([Parameter(Name = "@EmployeeId", DbType = "INT")]int EmployeeId)
		{
			var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
			return (IEnumerable<KPISurveyDetailInfo>)result.ReturnValue;
		}

        [Function(Name = "[dbo].[Mobile.KPI.SurveyAnswer.GetList]")]
        public IEnumerable<KPISurveyAnswer> KPISurveyAnswerGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<KPISurveyAnswer>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.Attendant.Insert]")]
        public int AuditInsert(string ShopId, string AuditDate, string AuditTime, string EmployeeCode)
        {
            return 0;
        }
		[Function(Name = "[dbo].[Mobile.KPIMTOSA.GetList]")]
		public IEnumerable<KPIMTOSAInfo> KPIMTOSAGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
		{
			var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
			return (IEnumerable<KPIMTOSAInfo>)result.ReturnValue;
		}
		[Function(Name = "[dbo].[Mobile.KPIMTPromotion]")]
		public IEnumerable<KPIMTPromotionInfo> KPIMTProGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
		{
			var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
			return (IEnumerable<KPIMTPromotionInfo>)result.ReturnValue;
		}
		[Function(Name = "[dbo].[Mobile.KPIMTSOS.Getlist]")]
		public IEnumerable<KPIMTSOSInfo> KPIMTSOSGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
		{
			var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
			return (IEnumerable<KPIMTSOSInfo>)result.ReturnValue;
		}
		[Function(Name = "[dbo].[Mobile.KPISOS.Getlist]")]
        public IEnumerable<KPISOSInfo> KPISOSGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<KPISOSInfo>)result.ReturnValue;
        }

        [Function(Name = "[dbo].[Mobile.KPIOOL.Getlist]")]
        public IEnumerable<KPIOOLInfo> KPIOOLGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<KPIOOLInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo].[Mobile.KPIOOL.GetByShop]")]
        public IEnumerable<KPIOOLShopInfo> KPIOLShopGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<KPIOOLShopInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo].[Mobile.KPIOOL.GetBrand]")]
        public IEnumerable<KPIOOLBrandInfo> KPIOLBrandGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<KPIOOLBrandInfo>)result.ReturnValue;
        }
        [Function(Name = "[Mobile.KPIPOSM.Getlist]")]
        public IEnumerable<KPIPosmInfo> KPIPosmGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<KPIPosmInfo>)result.ReturnValue;
        }
        [Function(Name = "[Mobile.KPIPromotion.Getlist]")]
        public IEnumerable<KPIPromotionInfo> KPIPromotionGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<KPIPromotionInfo>)result.ReturnValue;
        }
        [Function(Name = "[Mobile.Address.GetProvince]")]
        public IEnumerable<ProvinceInfo> ProvinceGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<ProvinceInfo>)result.ReturnValue;
        }
        [Function(Name = "[Mobile.Address.GetDistrict]")]
        public IEnumerable<DistrictInfo> District_GetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId, [Parameter(Name = "@ProvinceId", DbType = "INT")] int ProvinceId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, ProvinceId);
            return (IEnumerable<DistrictInfo>)result.ReturnValue;
        }
        [Function(Name = "[Mobile.Address.GetTown]")]
        public IEnumerable<TownInfo> TownGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId, [Parameter(Name = "@DistrictId", DbType = "INT")] int DistrictId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, DistrictId);
            return (IEnumerable<TownInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo].[Mobile.Products.Filter]")]
        public IEnumerable<ProductInfo> ProductsGetList([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<ProductInfo>)result.ReturnValue;
        }
        [Function(Name = "[dbo].[Mobile.EmployeeDownload.SaveOrUpdate]")]
        public int SaveOrUpdateEmployeeDownload(
        [Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId,
        [Parameter(Name = "@IsLoading", DbType = "INT")] int? IsLoading,
         [Parameter(Name = "@Version", DbType = "INT")] int? Version
        )
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId, IsLoading, Version);
            return 1;
        }


        [Function(Name = "[dbo].[Mobile.Support.Pending]")]
        public IEnumerable<MobileSupportInfo> GetSupport([Parameter(Name = "@EmployeeId", DbType = "INT")] int EmployeeId)
        {
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
            return (IEnumerable<MobileSupportInfo>)result.ReturnValue;
        }
    }
}
