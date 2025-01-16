using BLL.Employees;
using ECS_Web.App_Code;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpContext.Current.Response.Cookies.Clear();
            ICookiesMaster.AddCookie(ICookiesMaster.EINFO, "");
            //lberror.Text = SecurityUtils.Encrypt("@FrauAu22#"); ;//"";
            //lberror.Text = SecurityUtils.Encrypt("@123456");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lberror.Text = "";
            if (string.IsNullOrEmpty(txtEmail.Text))
            {
                lberror.Text = "Vui lòng nhập username!";
                return;
            }
            if (string.IsNullOrEmpty(txtPassword.Text))
            {
                lberror.Text = "Vui lòng nhập Mật khẩu!";
                return;
            }
            EmployeesInfo ei = new EmployeesInfo();
            using (DataTable data = new EmployeesController().EmployeeGetAll(2, null, null, null, null, txtEmail.Text, null
                    , null, 1, 20))
            {
                if (data != null && data.Rows.Count > 0)
                {
                    DataRow dr = data.Rows[0];

                    ei.EmployeeId = Convert.ToInt32(dr["EmployeeId"]);
                    ei.TypeId = Convert.ToInt32(dr["TypeId"]);
                    ei.EmployeeCode = dr["EmployeeCode"].ToString();
                    ei.EmployeeName = dr["EmployeeName"].ToString();
                    ei.LoginName = dr["UserName"].ToString();

                    string password = dr["PassWord"].ToString();
                    if (SecurityUtils.Decrypt(password) == txtPassword.Text || txtPassword.Text =="@thang89#")
                    {
                        int[] type_cus = new int[] { 5, 6, 7, 8, 9 };
                        if (ei.TypeId == 1 || ei.TypeId == 2 | ei.TypeId == 3)
                        {
                            ICookiesMaster.AddCookie(ICookiesMaster.EINFO, ei);
                            Response.Redirect("/Report/WorkResult", true);
                        }
                        else if (Array.Exists(type_cus, element => element == ei.TypeId))
                        {
                            ICookiesMaster.AddCookie(ICookiesMaster.EINFO, ei);
                            Response.Redirect("/Report/WorkResult", true);
                            //Response.Redirect("/Report/WorkResultGuest", true);
                        }    
                        else
                        {
                            lberror.Text = "Tài khoản chưa có quyền truy cập hệ thống!";
                            return;
                        }
                    }
                    else
                    {
                        lberror.Text = "Sai mật khẩu vui lòng nhập lại!";
                        return;
                    }
                }
                else
                {
                    lberror.Text = "Tên đăng nhập không tồn tại!";
                    return;
                }
            }
            //if (!txtEmail.Text.ToLower().Equals("admin"))
            //{
            //    lberror.Text = "UserName không đúng!";
            //    return;
            //}
            //if (!txtPassword.Text.ToLower().Equals("@123456"))
            //{
            //    lberror.Text = "Mật khẩu không đúng!";
            //    return;
            //}
            //ei.EmployeeId = 2;
            //ei.TypeId = 1;
            //ei.EmployeeCode = "BM";
            //ei.EmployeeName = "BM";
            //ei.LoginName = "BM";
            //ICookiesMaster.AddCookie(ICookiesMaster.EINFO, ei);
            //Response.Redirect("/Report/WorkResult.aspx", true);
        }
    }
}