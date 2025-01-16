using BLL.Employees;
using BLL.StoreList;
using ECS_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.Popups
{
    public partial class ImportEmployeeStore : PagePermisstion
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }

        protected void btnImport_Click(object sender, EventArgs e)
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
                        dt.Columns.Add("ShopId", typeof(int));
                        dt.Columns.Add("EmployeeId", typeof(int));
                        dt.Columns.Add("FromDate", typeof(DateTime));
                        dt.Columns.Add("ToDate", typeof(DateTime));

                        DataTable dt_error = new DataTable();
                        dt_error.Columns.Add("Message", typeof(string));
                        dt_error.Columns.Add("Cell", typeof(string));

                        DataTable data_emp = new EmployeesController().EmployeesGetList(null, null, null);
                        DataTable data_shops = new StoreListController().StoreListGetList(Employee.EmployeeId.Value, null, null, null, null, null, null, null, null, null);
                        for (int i = 3; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i,2].Value)) && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 4].Value))
                             && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 6].Value)); i++)
                        {
                            try
                            {
                                int EmployeeId = Convert.ToInt32(currentWorksheet.Cells[i, 2].Value);
                                int ShopId = Convert.ToInt32(currentWorksheet.Cells[i, 4].Value);
                                if(!DateTime.TryParseExact(Convert.ToString(currentWorksheet.Cells[i, 6].Value), "yyyy-MM-dd", null, System.Globalization.DateTimeStyles.None, out DateTime FromDate))
                                {
                                    dt_error.Rows.Add("Sai định dạng FromDate (yyyy-MM-dd)", $"Cell[{i}, 6]");
                                    continue;
                                }

                                if (!string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 7].Value)))
                                {
                                    if (!DateTime.TryParseExact(Convert.ToString(currentWorksheet.Cells[i, 7].Value), "yyyy-MM-dd", null, System.Globalization.DateTimeStyles.None, out DateTime ToDate))
                                    {
                                        dt_error.Rows.Add("Sai định dạng ToDate (yyyy-MM-dd)", $"Cell[{i}, 7]");
                                        continue;
                                    }
                                }
                                bool check_shop = data_shops.AsEnumerable().Any(x => Convert.ToInt32(x["ShopId"]) == ShopId);
                                if (!check_shop)
                                {
                                    dt_error.Rows.Add("Không tồn tại mã cửa hàng", $"Cell[{i}, 4]");
                                    continue;
                                }
                                bool check_emp = data_emp.AsEnumerable().Any(x => Convert.ToInt32(x["EmployeeId"]) == EmployeeId);
                                if (!check_shop)
                                {
                                    dt_error.Rows.Add("Không tồn tại mã nhân viên", $"Cell[{i}, 4]");
                                    continue;
                                }
                                if (dt != null && dt.Rows.Count > 0)
                                {
                                    bool check_dupplicate = dt.AsEnumerable().Any(x => Convert.ToInt32(x["EmployeeId"]) == EmployeeId && Convert.ToInt32(x["ShopId"]) == ShopId);
                                    if (check_dupplicate)
                                    {
                                        dt_error.Rows.Add($"Duplicate Employee : {EmployeeId}, Shop : {ShopId}", $"Cell[{i}]");
                                        continue;
                                    }
                                }

                                DataRow dr = dt.NewRow();
                                dr["ShopId"] = ShopId;
                                dr["EmployeeId"] = EmployeeId;
                                dr["FromDate"] = FromDate.Date;
                                if (DateTime.TryParseExact(Convert.ToString(currentWorksheet.Cells[i, 7].Value), "yyyy-MM-dd", null, System.Globalization.DateTimeStyles.None, out DateTime _ToDate))
                                    dr["ToDate"] = _ToDate;
                                else dr["ToDate"] = DBNull.Value;
                                dt.Rows.Add(dr);
                            }
                            catch
                            {
                                continue;
                            }
                        }
                        if (dt_error != null && dt_error.Rows.Count > 0)
                        {
                            Pf.BindGridError(ref error, dt_error, ref rptError);
                            Toastr.ErrorToast("Lỗi dữ liệu");
                            return;
                        }
                        else
                        {
                            var return_value = new EmployeesController().EmployeeStoreImport(dt);
                            switch (return_value)
                            {
                                case (int)STATUS_IMPORT.SUCCESS: dt_error.Rows.Add("Phân quyền cửa hàng thành công.", "OK"); break;
                                case (int)STATUS_IMPORT.UNSUCCESS: dt_error.Rows.Add("Phân quyền cửa hàng KHÔNG thành công.", "Unsuccess"); break;
                                case (int)STATUS_IMPORT.ERROR: dt_error.Rows.Add("Phân quyền cửa hàng KHÔNG thành công. Lỗi ghi dữ liệu", "Unsuccess"); break;
                                default:
                                    break;
                            }
                            Pf.BindGridError(ref error, dt_error, ref rptError);
                        }
                    }
                }
            }
        }
    }
}