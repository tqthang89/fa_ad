using BLL.WorkResults;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ECS_Web.API
{
    public class GetDataChartHander : AuthorizationHandler
    {
        [Serializable]
        public class ChartResponseInfo
        {
            public ChartResponseInfo() { }
            public int status_code { set; get; }


            public int process_all_ch { set; get; }
            public int process_all_noaudit_value { set; get; }
            public int process_all_noaudit_percent { set; get; }
            public int process_all_tc_value { set; get; }
            public int process_all_tc_percent { set; get; }
            public int process_all_ktc_value { set; get; }
            public int process_all_ktc_percent { set; get; }


            public string[] process_label { set; get; }
            public int[] process_target { set; get; }
            public int[] process_tc { set; get; }
            public int[] process_ktc { set; get; }
            public int[] process_percent { set; get; }

            public string process_tc_label { set; get; }
            public int process_tc_percent { set; get; }
            public int process_ktc_label { set; get; }
            public int process_ktc_percent { set; get; }


            public string[] passaudit_label { set; get; }
            public int[] passaudit_target { set; get; }
            public int[] passaudit_value { set; get; }
            public int[] passaudit_percent { set; get; }


        }
        public override HttpResponseMessage AuthorizationRequest()
        {
            HttpResponseMessage rp = HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.Accepted, "Đang load dữ liệu");
            try
            {
                string FUNCTION = new FieldRequest("FUNCTION");
                string _CycleId = new FieldRequest("CycleId");
                string[] selected = _CycleId.Split('_');
                int CycleId = Convert.ToInt32(selected[0]);
                int? AreaId = new FieldRequest("AreaId");
                int? ProvinceId = new FieldRequest("ProvinceId");
                int? MDOId = new FieldRequest("MDOId");
                int? PNGId = new FieldRequest("PNGId");

                if (FUNCTION.Equals("PROCESSAUDIT"))
                {
                    ChartResponseInfo crinfo = new ChartResponseInfo();
                    using (DataSet ds = new WorkResultController().Dashboard_Data(Employee.EmployeeId.Value, CycleId, AreaId.Value, ProvinceId.Value, MDOId.Value, PNGId.Value))
                    {
                        // Tien do
                        try
                        {
                            DataTable dt_truycap = ds.Tables[0];

                            crinfo.process_label = (from p in dt_truycap.AsEnumerable() select p.Field<string>("AreaName")).ToArray();
                            crinfo.process_target = (from p in dt_truycap.AsEnumerable() select p.Field<int>("ShopTarget")).ToArray();
                            crinfo.process_tc = (from p in dt_truycap.AsEnumerable() select p.Field<int>("TC")).ToArray();
                            crinfo.process_ktc = (from p in dt_truycap.AsEnumerable() select p.Field<int>("KTC")).ToArray();
                            crinfo.process_percent = (from p in dt_truycap.AsEnumerable() select p.Field<int>("WRPercent")).ToArray();
                        }
                        catch (Exception)
                        {
                        }

                        try
                        {
                            //public int process_all_noaudit_value { set; get; }
                            //public int process_all_noaudit_percent { set; get; }
                            //public int process_all_tc_value { set; get; }
                            //public int process_all_tc_percent { set; get; }
                            //public int process_all_ktc_value { set; get; }
                            //public int process_all_ktc_percent { set; get; }
                            DataTable dt_truycap = ds.Tables[1];
                            crinfo.process_all_ch = Convert.ToInt32(dt_truycap.Rows[0]["TargetAll"]);
                            crinfo.process_all_noaudit_value = Convert.ToInt32(dt_truycap.Rows[0]["NoAudit"]);
                            crinfo.process_all_noaudit_percent = Convert.ToInt32(dt_truycap.Rows[0]["NoAudit_Percent"]);

                            crinfo.process_all_tc_value = Convert.ToInt32(dt_truycap.Rows[0]["WRTC"]);
                            crinfo.process_all_tc_percent = Convert.ToInt32(dt_truycap.Rows[0]["WRTC_Percent"]);

                            crinfo.process_all_ktc_value = Convert.ToInt32(dt_truycap.Rows[0]["WRKTC"]);
                            crinfo.process_all_ktc_percent = Convert.ToInt32(dt_truycap.Rows[0]["WRKTC_Percent"]);

                        }
                        catch (Exception)
                        {

                        }

                        // Ti le auditersult
                        try
                        {
                            DataTable dt_truycap = ds.Tables[2];
                            crinfo.process_tc_percent = Convert.ToInt32(dt_truycap.Rows[0]["WRTC"]);

                            crinfo.process_tc_label = dt_truycap.Rows[0]["WRTC_LABEL"].ToString();

                            crinfo.process_ktc_percent = Convert.ToInt32(dt_truycap.Rows[0]["WRKTC"]);

                            crinfo.process_ktc_label = Convert.ToInt32(dt_truycap.Rows[0]["WRKTC_LABEL"]);
                        }
                        catch (Exception)
                        {
                        }

                        // Ti le dat theo goi TB
                        try
                        {

                            //public string[] passaudit_label { set; get; }
                            //  public int[] passaudit_target { set; get; }
                            //  public int[] passaudit_value { set; get; }
                            DataTable dt_truycap = ds.Tables[3];
                            crinfo.passaudit_label = (from p in dt_truycap.AsEnumerable() select p.Field<string>("FormatName")).ToArray();
                            crinfo.passaudit_target = (from p in dt_truycap.AsEnumerable() select p.Field<int>("D_Target")).ToArray();
                            crinfo.passaudit_value = (from p in dt_truycap.AsEnumerable() select p.Field<int>("Pass")).ToArray();
                            crinfo.passaudit_percent = (from p in dt_truycap.AsEnumerable() select p.Field<int>("DPercent")).ToArray();

                        }
                        catch (Exception)
                        {
                        }
                      
                        rp.StatusCode = (int)System.Net.HttpStatusCode.OK;
                        rp.Content = crinfo;
                    }
                }

                if (FUNCTION.Equals("AUDITRESULT"))
                {

                }

                if (FUNCTION.Equals("PNGAUDIT"))
                {

                }
                if (FUNCTION.Equals("KPIAUDIT"))
                {

                }

            }
            catch (Exception exx)
            {
                rp.StatusCode = (int)System.Net.HttpStatusCode.InternalServerError;
                rp.Content = exx.Message.Replace("'", "");
            }
            return rp;
        }
    }
}