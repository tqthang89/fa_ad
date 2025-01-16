using ECS_Web.App_Code;
using System;
using System.Data;
using System.Web;

namespace ECS_Web.ExcelExport
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string name = Request.QueryString["name"] != null ? Request.QueryString["name"].ToString() : "-";
                string UUID = Request.QueryString["UUID"] != null ? Request.QueryString["UUID"].ToString() : "-";
                string type = Request.QueryString["type"] != null ? Request.QueryString["type"].ToString() : null;
                if (Session[UUID] != null && string.IsNullOrEmpty(type))
                {
                    DataTable dt = (DataTable)Session[UUID];
                    Session.Remove(UUID);
                    //string path = Request.QueryString["path"] != null ? Request.QueryString["path"].ToString() : "-";
                    Pf.Excel(dt, name, true);

                    Session[UUID] = null;
                }
                if (Session[UUID] != null && Convert.ToString(type) == "ExcelPackage")
                {
                    try
                    {
                        byte[] ExcelPackageGetAsByteArray = (byte[])HttpContext.Current.Session[UUID];

                        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + name + ".xlsx");
                        HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        HttpContext.Current.Response.BinaryWrite(ExcelPackageGetAsByteArray);
                        HttpContext.Current.Response.End();

                        Session[UUID] = null;
                    }
                    catch
                    {

                        Session[UUID] = null;
                    }
                }
            }
        }
    }
}