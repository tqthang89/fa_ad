using BLL.MasterData;
using BLL.StoreList;
using ECS_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.UI;

namespace ECS_Web.pages.ShopByCycle
{
    public partial class Default : PagePermisstion
    {
        private string _title = "Đăng ký thông tin cửa hàng theo tháng";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteAuditMaster)Master).SetFormTitle(_title);
                Pf.bindCycleDropDown(Employee.EmployeeId.Value, DateTime.Now.Year, null, ref ddlCycle);
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
            script.RegisterPostBackControl(btnExport);
            script.RegisterPostBackControl(btnTemplate);
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            DataTable dt_error = new DataTable();
            dt_error.Columns.Add("Message", typeof(string));
            dt_error.Columns.Add("Cell", typeof(string));
            if (ddlCycle.SelectedIndex == 0)
            {
                Toastr.ErrorToast("Vui lòng chọn chu kỳ.");
                return;
            }
            string[] selected = ddlCycle.SelectedValue.Split('_');
            int CycleId = Convert.ToInt32(selected[0]);
            int Month = Convert.ToInt32(selected[1]);

            if (Month < DateTime.Now.Month)
            {
                Toastr.ErrorToast("Vui lòng nhập liệu tháng quá khứ.");
                return;
            }
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
                            dt.Columns.Add("ShopId", typeof(int));
                            dt.Columns.Add("ShopName", typeof(string));
                            dt.Columns.Add("ShopAddress", typeof(string));
                            dt.Columns.Add("Position", typeof(string));
                            dt.Columns.Add("Frequency", typeof(int));
                            dt.Columns.Add("AuditTimeMorning", typeof(int));
                            dt.Columns.Add("AuditTimeAfternoon", typeof(int));
                            dt.Columns.Add("SalesContact", typeof(string));
                            dt.Columns.Add("SalesName", typeof(string));
                            dt.Columns.Add("SFOSA", typeof(int));
                            dt.Columns.Add("SFSOS", typeof(int));
                            dt.Columns.Add("SFPROMOTION", typeof(int));
                            dt.Columns.Add("SFOOS", typeof(int));
                            dt.Columns.Add("SFNPI", typeof(int));
                            dt.Columns.Add("NPP", typeof(int));
                            dt.Columns.Add("ASMId", typeof(int));
                            dt.Columns.Add("SaleId", typeof(int));
                            dt.Columns.Add("SupId", typeof(int));

                            DataTable dataShops = new StoreListController().StoreListGetList(Employee.EmployeeId.Value, null, null, null, null, null, null, null, 1, 100000);
                            for (int i = 2; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 1].Value)) &&
                                !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)) &&
                                !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value)); i++)
                            {
                                try
                                {
                                    string ShopId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 1].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 1].Value) : null;
                                    string ShopName = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 2].Value) : null;
                                    string ShopAddress = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 3].Value) : null;
                                    string Position = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 4].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 4].Value) : null;
                                    string Frequency = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 5].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 5].Value) : null;
                                    string AuditTimeMorning = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 6].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 6].Value) : null;
                                    string AuditTimeAfternoon = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 7].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 7].Value) : null;
                                    string SalesContact = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 8].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 8].Value) : null;
                                    string SalesName = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 9].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 9].Value) : null;
                                    string SFOSA = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 10].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 10].Value) : null;
                                    string SFSOS = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 11].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 11].Value) : null;
                                    string SFPROMOTION = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 12].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 12].Value) : null;
                                    string SFOOS = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 13].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 13].Value) : null;
                                    string SFNPI = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 14].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 14].Value) : null;
                                    string NPP = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 15].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 15].Value) : null;
                                    string ASMId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 16].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 16].Value) : null;
                                    string SaleId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 17].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 17].Value) : null;
                                    string SupId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 18].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 18].Value) : null;

                                    #region Check Exception
                                    if (string.IsNullOrEmpty(ShopId))
                                    {
                                        _ = dt_error.Rows.Add("ShopId không để trống", $"Cell[{i}, 1]");
                                        continue;
                                    }
                                    if (dataShops != null && dataShops.Rows.Count > 0)
                                    {
                                        bool ExistsShopCode = dataShops.AsEnumerable().Any(x => Convert.ToString(x["ShopId"]) == ShopId);
                                        if (!ExistsShopCode)
                                        {
                                            _ = dt_error.Rows.Add($"ShopId : {ShopId} không tồn tại trên hệ thống.", $"Cell[{i}, 1]");
                                            continue;
                                        }
                                    }
                                    if (string.IsNullOrEmpty(ShopName))
                                    {
                                        _ = dt_error.Rows.Add("ShopName không để trống", $"Cell[{i}, 2]");
                                        continue;
                                    }
                                    if (string.IsNullOrEmpty(ShopAddress))
                                    {
                                        _ = dt_error.Rows.Add("ShopAddress không để trống", $"Cell[{i}, 3]");
                                        continue;
                                    }
                                    if (dt != null && dt.Rows.Count > 0)
                                    {
                                        bool CheckDuplicate = dt.AsEnumerable().Any(x => Convert.ToString(x["ShopId"]) == ShopId);
                                        if (CheckDuplicate)
                                        {
                                            _ = dt_error.Rows.Add($"Duplicate ShopId : {ShopId} ", $"Cell[{i}]");
                                            continue;
                                        }
                                    }
                                    #endregion

                                    _ = dt.Rows.Add(ShopId, ShopName, ShopAddress, Position, Frequency, AuditTimeMorning, AuditTimeAfternoon, SalesContact, SalesName, SFOSA, SFSOS,
                                        SFPROMOTION, SFOOS, SFNPI, NPP, ASMId, SaleId, SupId);
                                }
                                catch (Exception ex)
                                {
                                    _ = dt_error.Rows.Add($"Lỗi ghi dữ liệu : {ex.Message}", $"Cell[{i}]");
                                    continue;
                                }
                            }
                            if (dt_error.Rows.Count == 0)
                            {
                                if (dt != null && dt.Rows.Count > 0)
                                {
                                    var return_value = new StoreListController().StoreListByCyleImport(Employee.EmployeeId.Value, CycleId, dt);
                                    switch (return_value)
                                    {
                                        case (int)STATUS_IMPORT.SUCCESS: dt_error.Rows.Add("Cập nhật thông tin cửa hàng thành công"); break;
                                        case (int)STATUS_IMPORT.UNSUCCESS: dt_error.Rows.Add("Cập nhật thông tin cửa hàng KHÔNG thành công."); break;
                                        case (int)STATUS_IMPORT.ERROR: dt_error.Rows.Add("Cập nhật thông tin cửa hàng KHÔNG thành công. Lỗi ghi dữ liệu"); break;
                                        default:
                                            break;
                                    }
                                    Pf.BindGridError(ref error, dt_error, ref rptError);
                                }
                                else
                                {
                                    dt_error.Rows.Add("Không có dữ liệu import", "");
                                    Pf.BindGridError(ref error, dt_error, ref rptError);
                                    Toastr.ErrorToast("Không có dữ liệu import");
                                }
                            }
                            else
                            {
                                Pf.BindGridError(ref error, dt_error, ref rptError);
                                Toastr.ErrorToast("Lỗi dữ liệu import");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                _ = dt_error.Rows.Add($"Lỗi ghi dữ liệu : {ex.Message}", "");
                Pf.BindGridError(ref error, dt_error, ref rptError);
                Toastr.ErrorToast($"Lỗi : {ex.Message}");
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            if (ddlCycle.SelectedIndex == 0)
            {
                Toastr.ErrorToast("Vui lòng chọn chu kỳ.");
                return;
            }
            try
            {
                string[] selected = ddlCycle.SelectedValue.Split('_');
                int CycleId = Convert.ToInt32(selected[0]);
                int Month = Convert.ToInt32(selected[1]);
                DataTable data = new StoreListController().StoreListByCyleGetList(Employee.EmployeeId.Value, CycleId);
                if (data != null && data.Rows.Count > 0)
                    Pf.Excel(data, "ShopByCyle");
                else
                    Toastr.ErrorToast("Không có dữ liệu");
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi : {ex.Message}");
            }
        }

        protected void btnTemplate_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dataCycle = new MasterDataController().CycleGetList(Employee.EmployeeId.Value, DateTime.Now.Year, null);
                DataTable dataShopFormat = new MasterDataController().ShopFormatGetList(Employee.EmployeeId.Value, null, null);

                string fileName = "TempateImport_ShopByCyle_" + string.Format("{0:yyyyMMdd_HHmmss}", DateTime.Now);
                FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\templete_shopbycycle.xlsx"));
                string path = Server.MapPath($"~\\Upload\\export\\");
                if (!Directory.Exists(path))
                    Directory.CreateDirectory(path);
                string fileExport = $"{path}{fileName}.xlsx";
                FileInfo fileCopy = fileInfo.CopyTo(fileExport);
                using (var xls = new ExcelPackage(fileCopy))
                {
                    ExcelWorksheet ws = xls.Workbook.Worksheets["ShopFormat"];
                    ExcelWorksheet ws1 = xls.Workbook.Worksheets["Cycle"];
                    if (dataCycle != null && dataCycle.Rows.Count > 0)
                        ws1.Cells[1, 1].LoadFromDataTable(dataCycle, true);
                    if (dataShopFormat != null && dataShopFormat.Rows.Count > 0)
                        ws.Cells[1, 1].LoadFromDataTable(dataShopFormat, true);

                    Pf.ExcelByExcelPackage(xls, fileName);
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