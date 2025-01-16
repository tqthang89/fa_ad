using ECS_Web.App_Code;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class PagePermisstion : System.Web.UI.Page
{
    public EmployeesInfo Employee { get; set; }
    public bool IsViewDataAuditer { get; set; }
    public bool IsViewDataAdmin { get; set; }
    public bool IsEditDataAdmin { get; set; }
    public bool IsEditDataQC { get; set; }
    public bool IsViewDataQC { get; set; }
    protected override void OnInit(EventArgs e)
    {
        IsViewDataAuditer = IsViewDataAdmin = IsEditDataAdmin = IsEditDataQC = IsViewDataQC = false;
        try
        {
            Employee = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
            if (Employee == null || Employee.EmployeeId == null)
                Response.Redirect("~/Default.aspx");

            //BM
            if (Employee.TypeId == 1)
            {
                IsViewDataAuditer = true;
                IsViewDataAdmin = false;
                IsEditDataAdmin = true;
                IsEditDataQC = true;
                IsViewDataQC = false;
            }
            // Sup, Auditer
            if (Employee.TypeId == 2 || Employee.TypeId == 3)
            {
                IsViewDataAuditer = true;
                IsViewDataAdmin = true;
                IsEditDataAdmin = false;
                IsEditDataQC = false;
                IsViewDataQC = true;
            }
        }
        catch (Exception)
        {
            Response.Redirect("~/Default.aspx");
        }

    }

    public string CheckStatusEmployee(int Status)
    {
        string StatusName = "";
        switch (Status)
        {
            case (int)STATUS_EMPLOYEE.ACTIVE: StatusName = "Đang hoạt đồng"; break;
            case (int)STATUS_EMPLOYEE.DEACTIVE: StatusName = "Không hoạt đồng"; break;
            default:
                break;
        }
        return StatusName;
    }
}
