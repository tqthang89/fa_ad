using ECS_Web.App_Code;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web
{
    public partial class DigitalMapAudit : PagePermisstion
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Pf.bindCycleDropDown_Customer(Employee.EmployeeId.Value, DateTime.Now.Year, DateTime.Now.Month, ref ddlCycle);
                txtToDate.Text = txtFromDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                txtFromDate.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("dd/MM/yyyy");
                bindOption();
            }
        }
        void bindOption()
        {
            ddlAuditor.Items.Insert(0, new ListItem("-Tất cả-", "-1"));

            Pf.bindEmployeeDropDown(2, null, null, ref ddlSup);
            if (Employee.TypeId == 2)
            {
                ddlSup.SelectedValue = Employee.EmployeeId.ToString();
                ddlSup.Enabled = false;
            }
            //Pf.bindEmployeeDropDown(4, null, null, ref ddlMDO);
            string value = ddlCycle.SelectedValue;
            string[] arg = value.Split('_');
            Pf.bindEmployeeDropDownGuest(Employee.EmployeeId.Value, Convert.ToInt32(arg[0]), 4, null, null, ref ddlMDO);
            Pf.bindEmployeeDropDown(3, null, Employee.TypeId == 2 ? Employee.EmployeeId : null, ref ddlAuditor);
            //Thread.Sleep(1000);
            Pf.bindMasterDropDown("AUDITRESULT", ref ddlAuditResults);

            Pf.bindAreaDropDown(Employee.EmployeeId.Value, ref ddlArea);
            ddlProvince.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            ddlDistrict.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }

        protected void ddlProvince_SelectedIndexChanged(object sender, EventArgs e)
        {
            int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
            if (ProvinceId < 0)
            {
                ddlDistrict.Items.Clear();
                ddlTown.Items.Clear();
                ddlDistrict.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, null, ProvinceId, null, null, "DistrictId", "DistrictName", ref ddlDistrict);
        }

        protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
        {
            int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
            if (AreaId < 0)
            {
                ddlProvince.Items.Clear();
                ddlDistrict.Items.Clear();
                ddlTown.Items.Clear();
                ddlProvince.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                ddlDistrict.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, AreaId, null, null, null, "ProvinceId", "ProvinceName", ref ddlProvince);
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            int DistrictId = Convert.ToInt32(ddlDistrict.SelectedValue);
            if (DistrictId < 0)
            {
                ddlTown.Items.Clear();
                ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, null, null, DistrictId, null, "TownId", "TownName", ref ddlTown);
        }

        protected void ddlCycle_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtFromDate.Text = txtToDate.Text = "";
            if (ddlCycle.SelectedIndex > 0)
            {
                string value = ddlCycle.SelectedValue;
                string[] arg = value.Split('_');
                txtFromDate.Text = Pf.DateIntToString(Convert.ToInt32(arg[3]), "dd/MM/yyyy");
                txtToDate.Text = Pf.DateIntToString(Convert.ToInt32(arg[4]), "dd/MM/yyyy");
            }
        }
        protected void ddlSup_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlAuditor.Items.Clear();
            string selected = ddlSup.SelectedValue;
            if (!string.IsNullOrEmpty(selected) && selected != "-1")
                Pf.bindEmployeeDropDown(null, null, Convert.ToInt32(selected), ref ddlAuditor);
            else
                ddlAuditor.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }
    }
}