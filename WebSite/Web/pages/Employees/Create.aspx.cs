using BLL.Employees;
using ECS_Web.App_Code;
using System;
using System.Data;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.pages.Employees
{
    public partial class Create : PagePermisstion
    {
        private string _title = "Thông tin nhân viên";
        public int _EmployeeId { get; set; }
        public string _Password;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteAuditMaster)Master).SetFormTitle(_title);
                BindOption();
                if (Request.QueryString["EmployeeId"] != null)
                    BindEmployee(Convert.ToInt32(Request.QueryString["EmployeeId"]));
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
        }
        void BindOption()
        {
            Pf.bindEmployeeDropDown(2, null, null, ref ddlSup);

            DataTable data = new EmployeesController().EmployeesGetList(null, null, 2);
            if (data != null && data.Rows.Count > 0)
            {
                ddlSup.DataTextField = "EmployeeName";
                ddlSup.DataValueField = "EmployeeId";
                ddlSup.DataSource = data;
                ddlSup.DataBind();
            }

            ddlSup.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            ddlSup.Items.Insert(1, new ListItem("BM", "2"));
            ddlSup.Items.Insert(2, new ListItem("Hồ Công Trường", "202"));

            Thread.Sleep(500);
            Pf.bindEmployeeTypeDropDown(ref ddlType);
        }
        void BindEmployee(int EmployeeId)
        {
            DataTable data = new EmployeesController().EmployeeGetAll(Employee.EmployeeId.Value, EmployeeId, null, null, null, null, null, null, 1, 1);
            if (data != null && data.Rows.Count > 0)
            {
                ViewState["Employees"] = data;
                txtEmployeeCode.Enabled = false;
                txtEmployeeCode.Text = Convert.ToString(data.Rows[0]["EmployeeCode"]);
                txtEmployeeName.Text = Convert.ToString(data.Rows[0]["EmployeeName"]);
                ddlSup.SelectedValue = !string.IsNullOrEmpty(Convert.ToString(data.Rows[0]["SupId"])) ? Convert.ToString(data.Rows[0]["SupId"]) : "-1";
                txtDateOfBirth.Text = !string.IsNullOrEmpty(Convert.ToString(data.Rows[0]["DateOfBirth"])) ? Pf.DateIntToString(Convert.ToInt32(data.Rows[0]["DateOfBirth"]), "dd/MM/yyyy") : null;
                txtPhone.Text = Convert.ToString(data.Rows[0]["PhoneHome"]);
                txtIdentityCard.Text = Convert.ToString(data.Rows[0]["IdentityCard"]);
                txtEmail.Text = Convert.ToString(data.Rows[0]["EmailAddress"]);
                ddlSex.SelectedValue = !string.IsNullOrEmpty(Convert.ToString(data.Rows[0]["Sex"])) ? Convert.ToString(data.Rows[0]["Sex"]) : "-1";
                ddlType.SelectedValue = !string.IsNullOrEmpty(Convert.ToString(data.Rows[0]["TypeId"])) ? Convert.ToString(data.Rows[0]["TypeId"]) : "-1";
                txtAddress.Text = Convert.ToString(data.Rows[0]["AddressLine"]);
                ddlStatus.SelectedValue = Convert.ToString(data.Rows[0]["Status"]);
                txtUsername.Text = Convert.ToString(data.Rows[0]["UserName"]);
               
            }
            else
            {
                Toastr.ErrorToast("Không tồn tại thông tin nhân viên");
                return;
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            DataTable data =  (DataTable)ViewState["Employees"];
            if (data == null || data.Rows.Count == 0)
                data = new EmployeesController().EmployeeGetAll(Employee.EmployeeId.Value, Convert.ToInt32(Request.QueryString["EmployeeId"]), null, null, null, null, null, null, 1, 1);
            if (data != null && data.Rows.Count > 0)
            {
                _Password = Convert.ToString(data.Rows[0]["PassWord"]);
                _EmployeeId = Convert.ToInt32(data.Rows[0]["EmployeeId"]);
            }
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("EmployeeId", typeof(int));
                dt.Columns.Add("ParentId", typeof(int));
                dt.Columns.Add("EmployeeCode", typeof(string));
                dt.Columns.Add("EmployeeName", typeof(string));
                dt.Columns.Add("DateOfBirth", typeof(int));
                dt.Columns.Add("Photo", typeof(string));
                dt.Columns.Add("PhoneHome", typeof(string));
                dt.Columns.Add("EmailAddress", typeof(string));
                dt.Columns.Add("AddressLine", typeof(string));
                dt.Columns.Add("TypeId", typeof(int));
                dt.Columns.Add("UserName", typeof(string));
                dt.Columns.Add("PassWord", typeof(string));
                dt.Columns.Add("Status", typeof(int));
                dt.Columns.Add("Avatar", typeof(string));
                dt.Columns.Add("IdentityCard", typeof(string));
                dt.Columns.Add("Sex", typeof(string));


                if (ddlSup.SelectedIndex == 0)
                {
                    Toastr.ErrorToast("Chưa chọn quản lý");
                    return;
                }
                if (string.IsNullOrEmpty(txtEmployeeCode.Text.Trim()))
                {
                    Toastr.ErrorToast("EmployeeCode không để trống");
                    return;
                }
                if (string.IsNullOrEmpty(txtEmployeeName.Text.Trim()))
                {
                    Toastr.ErrorToast("EmployeeName không để trống");
                    return;
                }

                if (!string.IsNullOrEmpty(txtDateOfBirth.Text))
                {
                    if (!DateTime.TryParseExact(txtDateOfBirth.Text, "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime _date))
                    {
                        Toastr.ErrorToast("Sai định dạng ToDate (dd/MM/yyyy)");
                        return;
                    }
                }
                if (ddlType.SelectedIndex == 0)
                {
                    Toastr.ErrorToast("Chưa chọn loại nhân viên");
                    return;
                }
                if (string.IsNullOrEmpty(txtUsername.Text))
                {
                    Toastr.ErrorToast("Username không để trống");
                    return;
                }
               
                if (string.IsNullOrEmpty(Convert.ToString(_Password)))
                {
                    if (string.IsNullOrEmpty(txtPass.Text.Trim()) || string.IsNullOrEmpty(txtRePass.Text.Trim()))
                    {
                        Toastr.ErrorToast("Mật khẩu không để trống");
                        return;
                    }
                    if (txtPass.Text.Trim() != txtRePass.Text.Trim())
                    {
                        Toastr.ErrorToast("Nhập lại mật khẩu không trùng khớp");
                        return;
                    }
                }

                if(!string.IsNullOrEmpty(Request.QueryString["EmployeeId"]))
                {
                    if (!string.IsNullOrEmpty(txtPass.Text.Trim()) && !string.IsNullOrEmpty(txtRePass.Text.Trim()))
                        _Password = SecurityUtils.Encrypt(txtPass.Text.Trim());
                }    

                if (!string.IsNullOrEmpty(txtIdentityCard.Text.Trim()))
                {
                    if (txtIdentityCard.Text.Length > 12 || txtIdentityCard.Text.Length < 9)
                    {
                        Toastr.ErrorToast("CMND/CCCD phải từ 9 đến 12 ký tự");
                        return;
                    }
                }
                if (!string.IsNullOrEmpty(txtEmail.Text.Trim()))
                {
                    if (!Pf.ValidateEmail(txtEmail.Text.Trim()))
                    {
                        Toastr.ErrorToast("Địa chỉ không đúng định dạng hoặc sai địa chỉ email");
                        return;
                    }
                }

                string EmployeeId = !string.IsNullOrEmpty(Convert.ToString(_EmployeeId)) ? Convert.ToString(_EmployeeId) : null;
                string ParentId = ddlSup.SelectedValue;
                string EmployeeCode = txtEmployeeCode.Text.Trim();
                string EmployeeName = txtEmployeeName.Text.Trim();
                string DateOfBirth = Pf.DateStringToInt(txtDateOfBirth.Text.Trim()).ToString();
                string Photo = null;
                string PhoneHome = txtPhone.Text.Trim();
                string EmailAddress = txtEmail.Text.Trim();
                string AddressLine = txtAddress.Text;
                string TypeId = ddlType.SelectedValue;
                string Username = txtUsername.Text;
                string Avatar = null;
                string IdentityCard = txtIdentityCard.Text;
                string Status = ddlStatus.SelectedValue;
                string Password = !string.IsNullOrEmpty(Convert.ToString(_Password)) ? _Password : SecurityUtils.Encrypt(txtPass.Text.Trim());
                string Sex = ddlSex.SelectedValue;

                dt.Rows.Add(EmployeeId, ParentId, EmployeeCode.Trim(), EmployeeName, DateOfBirth, Photo, PhoneHome, EmailAddress, AddressLine,
                TypeId, Username, Password, Status, Avatar, IdentityCard, Sex);
                int Type = 1;
                if (_EmployeeId > 0)
                    Type = 2;
                var return_value = new EmployeesController().EmployeesImport(Type, dt);
                switch (return_value)
                {
                    case (int)STATUS_IMPORT.SUCCESS: Toastr.SucessToast("Cập nhật thông tin nhân viên thành công"); break;
                    case (int)STATUS_IMPORT.UNSUCCESS: Toastr.ErrorToast("Cập nhật thông tin nhân viên KHÔNG thành công."); break;
                    case (int)STATUS_IMPORT.ERROR: Toastr.ErrorToast("Cập nhật thông tin nhân viên KHÔNG thành công. Lỗi ghi dữ liệu"); break;
                    case (int)STATUS_IMPORT.EXISTS: Toastr.ErrorToast("Tồn tại nhân viên trên hệ thống. Lỗi ghi dữ liệu"); break;
                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi : {ex}");
                return;
            }
        }
    }
}