using BLL.Employees;
using ECS_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace ECS_Web.Popups
{
    public partial class ImportEmployees : PagePermisstion
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
            script.RegisterPostBackControl(btnImport);
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            DataTable dt_error = new DataTable();
            dt_error.Columns.Add("Message", typeof(string));
            dt_error.Columns.Add("Cell", typeof(string));

            int Type = Convert.ToInt32(ddlType.SelectedValue);
            try
            {
                error.Visible = false;
                string UserCode = Employee.LoginName;
                if (string.IsNullOrEmpty(UserCode))
                    UserCode = "Anonymous";
                string path = Server.MapPath("~/Upload/import/tmpImport/" + UserCode + "/");

                if (System.IO.Directory.Exists(path))
                {
                    System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(path);
                    foreach (System.IO.FileInfo file in dir.GetFiles())
                    {
                        using (var package = new ExcelPackage(file))
                        {
                            ExcelWorkbook workBook = package.Workbook;
                            ExcelWorksheet currentWorksheet = workBook.Worksheets[1];
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

                            string Password = SecurityUtils.Encrypt("audit@2022");
                            for (int i = 2; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value))
                                 && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 4].Value))
                                  && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 5].Value))
                                 && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 11].Value))
                                 && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 12].Value)); i++)
                            {
                                try
                                {
                                    string EmployeeId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 2].Value) : null;
                                    string ParentId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 3].Value) : null;
                                    string EmployeeCode = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 4].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 4].Value) : null;
                                    string EmployeeName = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 5].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 5].Value) : null;
                                    string DateOfBirth = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 6].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 6].Value) : null;
                                    string Photo = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 7].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 7].Value) : null;
                                    string PhoneHome = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 8].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 8].Value) : null;
                                    string EmailAddress = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 9].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 9].Value) : null;
                                    string AddressLine = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 10].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 10].Value) : null;
                                    string TypeId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 11].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 11].Value) : null;
                                    string Username = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 12].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 12].Value) : null;
                                    string Avatar = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 13].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 13].Value) : null;
                                    string IdentityCard = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 14].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 14].Value) : null;
                                    string Status = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 15].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 15].Value) : null;
                                    string Sex = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 16].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 16].Value) : null;

                                    if (string.IsNullOrEmpty(ParentId))
                                    {
                                        dt_error.Rows.Add("ParentId không để trống", $"Cell[{i}, 3]");
                                        continue;
                                    }
                                    if (string.IsNullOrEmpty(EmployeeCode))
                                    {
                                        dt_error.Rows.Add("EmployeeCode không để trống", $"Cell[{i}, 4]");
                                        continue;
                                    }
                                    if (string.IsNullOrEmpty(EmployeeName))
                                    {
                                        dt_error.Rows.Add("EmployeeName không để trống", $"Cell[{i}, 5]");
                                        continue;
                                    }

                                    if (!DateTime.TryParseExact(DateOfBirth, "yyyyMMdd", null, System.Globalization.DateTimeStyles.None, out DateTime _date))
                                    {
                                        dt_error.Rows.Add("Sai định dạng ToDate (yyyyMMdd)", $"Cell[{i}, 6]");
                                        continue;
                                    }
                                    if (string.IsNullOrEmpty(TypeId))
                                    {
                                        dt_error.Rows.Add("TypeId không để trống", $"Cell[{i}, 11]");
                                        continue;
                                    }
                                    if (string.IsNullOrEmpty(Username))
                                    {
                                        dt_error.Rows.Add("Username không để trống", $"Cell[{i}, 12]");
                                        continue;
                                    }
                                    if (!string.IsNullOrEmpty(IdentityCard))
                                    {
                                        if (IdentityCard.Length > 12 || IdentityCard.Length < 9)
                                        {
                                            dt_error.Rows.Add("IdentityCard phải từ 9 đến 12 ký tự", $"Cell[{i}, 14]");
                                            continue;
                                        }
                                    }
                                    if (!string.IsNullOrEmpty(EmailAddress))
                                    {
                                        if (!Pf.ValidateEmail(EmailAddress))
                                        {
                                            dt_error.Rows.Add("EmailAddress không đúng định dạng hoặc sai địa chỉ email.", $"Cell[{i}, 9]");
                                            continue;
                                        }
                                    }
                                    if (!string.IsNullOrEmpty(Sex) && !string.IsNullOrEmpty(Sex.Trim()))
                                    {
                                        int _sex = Convert.ToInt32(Sex);
                                        if (_sex < -1 || _sex > 1)
                                        {
                                            dt_error.Rows.Add("Giới tính không đúng định dạng (1-Nam, 0-Nữ).", $"Cell[{i}, 16]");
                                            continue;
                                        }
                                    }

                                    dt.Rows.Add(EmployeeId, ParentId, EmployeeCode.Trim(), EmployeeName, DateOfBirth, Photo, PhoneHome, EmailAddress, AddressLine,
                                    TypeId, Username, Password, Status, Avatar, IdentityCard, Sex);
                                }
                                catch (Exception ex)
                                {
                                    dt_error.Rows.Add($"Lỗi ghi dữ liệu : {ex.Message}", $"Cell[{i}]");
                                    continue;
                                }
                            }
                            if (dt_error.Rows.Count == 0)
                            {
                                if (dt != null && dt.Rows.Count > 0)
                                {
                                    var return_value = new EmployeesController().EmployeesImport(Type, dt);
                                    switch (return_value)
                                    {
                                        case (int)STATUS_IMPORT.SUCCESS: dt_error.Rows.Add("Cập nhật thông tin nhân viên thành công"); break;
                                        case (int)STATUS_IMPORT.UNSUCCESS: dt_error.Rows.Add("Cập nhật thông tin nhân viên KHÔNG thành công."); break;
                                        case (int)STATUS_IMPORT.ERROR: dt_error.Rows.Add("Cập nhật thông tin nhân viên KHÔNG thành công. Lỗi ghi dữ liệu"); break;
                                        case (int)STATUS_IMPORT.EXISTS: dt_error.Rows.Add("Tồn tại nhân viên trên hệ thống. Lỗi ghi dữ liệu"); break;
                                        default:
                                            break;
                                    }
                                    Pf.BindGridError(ref error, dt_error, ref rptError);
                                }
                                else
                                {
                                    dt_error.Rows.Add("Không có dữ liệu import", "");
                                    Pf.BindGridError(ref error, dt_error, ref rptError);
                                }
                            }
                            else
                                Pf.BindGridError(ref error, dt_error, ref rptError);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                dt_error.Rows.Add($"Lỗi ghi dữ liệu : {ex.Message}", "");
                Pf.BindGridError(ref error, dt_error, ref rptError);
                Toastr.ErrorToast($"Lỗi : {ex.Message}");
            }
        }
       
        protected void btnTemplate_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable data = new EmployeesController().EmployeeTypeGetList();
                if (data != null && data.Rows.Count > 0)
                {
                    string fileName = "TempateImport_employees_" + string.Format("{0:yyyyMMdd_HHmmss}", DateTime.Now);
                    FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\template_imort_employees.xlsx"));
                    string path = Server.MapPath($"~\\Upload\\export\\");
                    if (!Directory.Exists(path))
                        Directory.CreateDirectory(path);
                    string fileExport = $"{path}{fileName}.xlsx";
                    FileInfo fileCopy = fileInfo.CopyTo(fileExport);
                    using (var xls = new ExcelPackage(fileCopy))
                    {
                        ExcelWorksheet ws = xls.Workbook.Worksheets["EmployeeType"];
                        ws.Cells[1, 1].LoadFromDataTable(data, true);
                        Pf.ExcelByExcelPackage(xls, fileName);
                    }
                }
                else
                {
                    Toastr.ErrorToast("Không có dữ liệu");
                    return;
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