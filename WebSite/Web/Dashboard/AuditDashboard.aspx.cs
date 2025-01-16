using ECS_Web.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.Dashboard
{
    public partial class AuditDashboard : PagePermisstion
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                bindOption();
            }    
        }
        void bindOption()
        {
            //Pf.bindEmployeeDropDown(4, null, null, ref ddlMDO);
            Pf.bindCycleDropDown_Customer(Employee.EmployeeId.Value, DateTime.Now.Year, DateTime.Now.Month, ref ddlCycle);

            string value = ddlCycle.SelectedValue;
            string[] arg = value.Split('_');
            Pf.bindEmployeeDropDownGuest(Employee.EmployeeId.Value, Convert.ToInt32(arg[0]), 4, null, null, ref ddlMDO);
            Thread.Sleep(1000);
            Pf.bindAreaDropDown(Employee.EmployeeId.Value, ref ddlArea);
            Pf.bindAddressDropDown(Employee.EmployeeId.Value, -1, null, null, null, "ProvinceId", "ProvinceName", ref ddlProvince);
        }
        protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
        {
            int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
            if (AreaId < 0)
            {
                ddlProvince.Items.Clear();
                ddlProvince.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, AreaId, null, null, null, "ProvinceId", "ProvinceName", ref ddlProvince);
        }
    }
}