using BLL.WorkResults;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.pages
{
    public partial class ToolsIT : PagePermisstion
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnFilterITQuery_Click(object sender, EventArgs e)
        {
            try
            {
                int ShopId = 0;
                if (!string.IsNullOrEmpty(txtShopId.Text))
                    ShopId = Convert.ToInt32(txtShopId.Text);
                int EmployeeId = 0;
                if (!string.IsNullOrEmpty(txtEmployeeId.Text))
                    EmployeeId = Convert.ToInt32(txtEmployeeId.Text);

                
                int AuditDate = 0;
                if (!string.IsNullOrEmpty(txtAuditDate.Text))
                    AuditDate = Convert.ToInt32(txtAuditDate.Text);
                int TypeId = Convert.ToInt32(ddlTypeITSupport.SelectedValue);
                using (DataTable dt = new WorkResultController().ToolsIT(Employee.EmployeeId.Value, ShopId, EmployeeId, AuditDate, TypeId, 1))
                {
                    rptITSupport.DataSource = dt;
                    rptITSupport.DataBind();
                }
            }
            catch (Exception ex)
            {
                Toastr.SucessToast(ex.Message);
            }

        }

        protected void lbITQuery_Click(object sender, EventArgs e)
        {

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int ShopId = 0;
            if (!string.IsNullOrEmpty(txtShopId.Text))
                ShopId = Convert.ToInt32(txtShopId.Text);
            else
            {
                Toastr.ErrorToast("Vui lòng nhập ShopId");
                return;
            }    
            int EmployeeId = 0;
            if (!string.IsNullOrEmpty(txtEmployeeId.Text))
                EmployeeId = Convert.ToInt32(txtEmployeeId.Text);
            else
            {
                Toastr.ErrorToast("Vui lòng nhập EmployeeId");
                return;
            }

            int AuditDate = 0;
            if (!string.IsNullOrEmpty(txtAuditDate.Text))
                AuditDate = Convert.ToInt32(txtAuditDate.Text);
            else
            {
                Toastr.ErrorToast("Vui lòng nhập AuditDate");
                return;
            }
            int TypeId = Convert.ToInt32(ddlTypeITSupport.SelectedValue);

            using (DataTable dt = new WorkResultController().ToolsIT(Employee.EmployeeId.Value, ShopId, EmployeeId, AuditDate, TypeId, 0))
            {
                rptITSupport.DataSource = dt;
                rptITSupport.DataBind();
            }
        }
    }
}