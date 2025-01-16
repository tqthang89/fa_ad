using FAuditService.BLL;
using FAuditService.Core;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FAuditService.WebMobile
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void txtRegister_Click(object sender, EventArgs e)
        {
            lbError.Text = "";
            if (string.IsNullOrEmpty(txtEmail.Text))
            {
                lbError.Text = "Please type Email!";
                return;
            }
            if (string.IsNullOrEmpty(txtPassWord.Text))
            {
                lbError.Text = "Please type PassWord!";
                return;
            }
            if (string.IsNullOrEmpty(txtRetypePassWord.Text))
            {
                lbError.Text = "Please type Retype PassWord!";
                return;
            }
            if (txtPassWord.Text != txtRetypePassWord.Text)
            {
                lbError.Text = "Passwords do not match!";
                return;
            }
            if(cbAllow.Checked ==false)
            {
                lbError.Text = "Please select agree!";
                return;
            }
            try
            {
                string Password = SecurityUtils.Encrypt(txtPassWord.Text);
                using (DataSet ds = WorkController.Employee_Apple_Action(txtEmail.Text, Password, null, 1))
                {
                    lbError.Text = ds.Tables[0].Rows[0]["Content"].ToString();
                }
            }
            catch (Exception ex)
            {
                lbError.Text = "Lưu lỗi -" + ex.Message;
            }
            
        }
    }
}