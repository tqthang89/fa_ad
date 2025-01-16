using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web
{
    public partial class SiteAuditMaster : MasterPage
    {
        //Visible='<%# Convert.ToBoolean(IsViewDataAdmin == true || Eval("IsLockReport").ToString()=="1") %>'
        public string _path;
        public EmployeesInfo Employee { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            _path = HttpContext.Current.Request.Url.AbsolutePath;
            Employee = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
            if (Employee == null || Employee.EmployeeId == null)
                Response.Redirect("~/Default.aspx");
            else
            {
                spName.InnerText = Employee.EmployeeName + "_"+Employee.TypeId.ToString();
                //Toastr.SucessToast(Employee.TypeId.ToString());
                //limap.Visible = false;
            }
        }
        //protected override void OnInit(EventArgs e)
        //{
        //    try
        //    {
        //        Employee = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
        //        if (Employee == null || Employee.EmployeeId == null)
        //            Response.Redirect("~/Default.aspx");
        //    }
        //    catch (Exception)
        //    {
        //        Response.Redirect("~/Default.aspx");
        //    }

        //}
        public void SetFormTitle(string s)
        {
            Title.Text = s;
        }
        public string path
        {
            get
            {
                return _path;
            }
            set
            {
                this._path = value;
            }
        }
    }
}