using BLL.StoreList;
using Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ECS_Web.API
{
    /// <summary>
    /// Summary description for DigitalMap
    /// </summary>
    public class DigitalMap : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        public EmployeesInfo Employee { get; set; }
        public bool IsReusable => throw new NotImplementedException();

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                Employee = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
            }
            catch
            {
            }
            string FUNTION = context.Request["FUNTION"];
            string CYCLEID = context.Request["CYCLEID"];
            string SHOPCODE = context.Request["SHOPCODE"];
            if (FUNTION.Equals("MAP"))
            {
                using (DataSet dt = new StoreListController().StoreListByMap(Employee == null?2: Employee.EmployeeId.Value, Convert.ToInt32(CYCLEID)))
                {
                    ReturnJSON(dt, context);
                }
            }
            if (FUNTION.Equals("SHOPDETAIL"))
            {
                using (DataSet dt = new StoreListController().StoreListByMapByShopCode(2, Convert.ToInt32(CYCLEID), Convert.ToInt32(SHOPCODE)))
                {
                    ReturnJSON(dt, context);
                }
            }
        }
        public void ReturnJSON<T>(T json, HttpContext _Context)
        {
            string strs = "{}";
            if (json != null)
            {
                strs = JsonConvert.SerializeObject(json);
            }
            _Context.Response.Clear();
            _Context.Response.ContentType = "application/json";
            _Context.Response.StatusCode = 200;
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.Write(strs);
        }
    }
}