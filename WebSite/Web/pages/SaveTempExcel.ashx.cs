using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ECS_Web.pages
{
    /// <summary>
    /// Summary description for SaveTempExcel
    /// </summary>
    public class SaveTempExcel : IHttpHandler
    {
        public EmployeesInfo Employee { get; set; }
        public void ProcessRequest(HttpContext context)
        {
            string result = string.Empty;
            int count = HttpContext.Current.Request.Files.Count;
            string UserName = "Anonymous";
            try
            {
                Employee = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
                if (Employee == null || Employee.EmployeeId == null)
                    HttpContext.Current.Response.Redirect("~/Default.aspx");
                UserName = Employee.LoginName;
                if (string.IsNullOrEmpty(UserName))
                    UserName = "Anonymous";
            }
            catch
            {
                UserName = "Anonymous";
            }
            if (count < 1)
                result = "No file";
            else
            {
                var file = context.Request.Files[0];
                var fileName = System.IO.Path.GetFileName(file.FileName);
                string path = context.Server.MapPath("~/Upload/import/tmpImport/" + UserName + "/");
                if (System.IO.Directory.Exists(path))
                {
                    System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(path);
                    foreach (System.IO.FileInfo f in dir.GetFiles())
                    {
                        f.Delete();
                    }
                }
                else
                {
                    System.IO.Directory.CreateDirectory(path);
                }
                string link = path + fileName;
                file.SaveAs(link);
                result = "success";
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}