using System;
using BLL.MasterData;
using BLL.StoreList;
using ECS_Web.App_Code;
using OfficeOpenXml;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.UI;
using BLL.POSM;

namespace ECS_Web.pages.KPIPosm
{
    public partial class Default : PagePermisstion
    {
        private string _title = "Đăng ký KPI POSM theo tháng";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteAuditMaster)Master).SetFormTitle(_title);
                ((SiteAuditMaster)Master)._path = "To";
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
                            dt.Columns.Add("PosmId", typeof(int));
                            dt.Columns.Add("Quantity", typeof(string));

                            DataTable dataShops = new StoreListController().StoreListGetList(Employee.EmployeeId.Value, null, null, null, null, null, null, null, 1, 100000);
                            DataTable dataPosm = new PosmController().PosmGetList();
                            for (int i = 2; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 1].Value)) &&
                                !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)) &&
                                !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value)); i++)
                            {
                                try
                                {
                                    string ShopId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 1].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 1].Value) : null;
                                    string PosmId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 2].Value) : null;
                                    string Quantity = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 3].Value) : null;
                                    
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
                                    if (string.IsNullOrEmpty(PosmId))
                                    {
                                        _ = dt_error.Rows.Add("PosmId không để trống", $"Cell[{i}, 2]");
                                        continue;
                                    }
                                    if (dataPosm != null && dataPosm.Rows.Count > 0)
                                    {
                                        bool ExistsPosm = dataPosm.AsEnumerable().Any(x => Convert.ToString(x["PosmId"]) == PosmId);
                                        if (!ExistsPosm)
                                        {
                                            _ = dt_error.Rows.Add($"PosmId : {PosmId} không tồn tại trên hệ thống.", $"Cell[{i}, 2]");
                                            continue;
                                        }
                                    }
                                    if (string.IsNullOrEmpty(Quantity))
                                    {
                                        _ = dt_error.Rows.Add("Quantity không để trống", $"Cell[{i}, 3]");
                                        continue;
                                    }
                                    if (!int.TryParse(Quantity, System.Globalization.NumberStyles.Number, null, out int _quantity))
                                    {
                                        _ = dt_error.Rows.Add("Quantity phải nhập số", $"Cell[{i}, 3]");
                                        continue;
                                    }
                                    if (_quantity < 0)
                                    {
                                        _ = dt_error.Rows.Add("Quantity phải lớn hơn 0", $"Cell[{i}, 3]");
                                        continue;
                                    }
                                    if (dt != null && dt.Rows.Count > 0)
                                    {
                                        bool CheckDuplicate = dt.AsEnumerable().Any(x => Convert.ToString(x["ShopId"]) == ShopId && Convert.ToString(x["PosmId"]) == PosmId);
                                        if (CheckDuplicate)
                                        {
                                            _ = dt_error.Rows.Add($"Duplicate ShopId : {ShopId} - PosmId : {PosmId} ", $"Cell[{i}]");
                                            continue;
                                        }
                                    }
                                    #endregion

                                    _ = dt.Rows.Add(ShopId, PosmId, Quantity);
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
                                    var return_value = new PosmController().KPIPOSMImport(Employee.EmployeeId.Value, CycleId, dt);
                                    switch (return_value)
                                    {
                                        case (int)STATUS_IMPORT.SUCCESS: dt_error.Rows.Add("Cập nhật thông tin KPI POSM thành công"); break;
                                        case (int)STATUS_IMPORT.UNSUCCESS: dt_error.Rows.Add("Cập nhật thông tin KPI POSM KHÔNG thành công."); break;
                                        case (int)STATUS_IMPORT.ERROR: dt_error.Rows.Add("Cập nhật thông tin KPI POSM KHÔNG thành công. Lỗi ghi dữ liệu"); break;
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
                DataTable data = new PosmController().KPIPOSMGetList(Employee.EmployeeId.Value, CycleId);
                if (data != null && data.Rows.Count > 0)
                    Pf.Excel(data, "KPI_POSM_By_Cycle");
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
                DataTable dataPosm = new PosmController().PosmGetList();

                string fileName = "TempateImport_KPI_Posm_" + string.Format("{0:yyyyMMdd_HHmmss}", DateTime.Now);
                FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\template_kpi_posm.xlsx"));
                string path = Server.MapPath($"~\\Upload\\export\\");
                if (!Directory.Exists(path))
                    Directory.CreateDirectory(path);
                string fileExport = $"{path}{fileName}.xlsx";
                FileInfo fileCopy = fileInfo.CopyTo(fileExport);
                using (var xls = new ExcelPackage(fileCopy))
                {
                    ExcelWorksheet ws = xls.Workbook.Worksheets["PosmList"];
                    ExcelWorksheet ws1 = xls.Workbook.Worksheets["Cycle"];
                    if (dataCycle != null && dataCycle.Rows.Count > 0)
                        ws1.Cells[1, 1].LoadFromDataTable(dataCycle, true);
                    if (dataPosm != null && dataPosm.Rows.Count > 0)
                        ws.Cells[1, 1].LoadFromDataTable(dataPosm, true);

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