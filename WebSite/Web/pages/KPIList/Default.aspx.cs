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
using System.Web.UI.WebControls;
using System.Web;
using BLL.Product;

namespace ECS_Web.pages.KPIList
{
    public partial class Default : PagePermisstion
    {
        private string _title = "Đăng ký KPI theo chu kỳ";
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

            script.RegisterPostBackControl(btnExportOSA);
        }


        protected void btnImport_Click(object sender, EventArgs e)
        {
            Button bt = sender as Button;
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
                    if (dir.GetFiles().Count() > 0)
                    {
                        foreach (System.IO.FileInfo file in dir.GetFiles())
                        {
                            if (bt.CommandArgument.Equals("POSM"))
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
                            else if (bt.CommandArgument.Equals("OSA"))
                            {
                                using (var package = new ExcelPackage(file))
                                {
                                    ExcelWorkbook workBook = package.Workbook;
                                    ExcelWorksheet currentWorksheet = workBook.Worksheets[1];
                                    DataTable dt = new DataTable();
                                    dt.Columns.Add("ShopFormatId", typeof(int));
                                    dt.Columns.Add("ProductId", typeof(int));
                                    dt.Columns.Add("Quantity", typeof(string));

                                    DataTable dataShops = new StoreListController().ShopFormatGetList(Employee.EmployeeId.Value);
                                    DataTable dataPosm = new ProductController().ProductGetList();
                                    for (int i = 2; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 1].Value)) &&
                                        !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)) &&
                                        !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value)); i++)
                                    {
                                        try
                                        {
                                            string ShopFormatId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 1].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 1].Value) : null;
                                            string ProductId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 2].Value) : null;
                                            string Quantity = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 3].Value) : null;

                                            #region Check Exception
                                            if (string.IsNullOrEmpty(ShopFormatId))
                                            {
                                                _ = dt_error.Rows.Add("ShopFormatId không để trống", $"Cell[{i}, 1]");
                                                continue;
                                            }
                                            if (dataShops != null && dataShops.Rows.Count > 0)
                                            {
                                                bool ExistsShopCode = dataShops.AsEnumerable().Any(x => Convert.ToString(x["ShopFormatId"]) == ShopFormatId);
                                                if (!ExistsShopCode)
                                                {
                                                    _ = dt_error.Rows.Add($"ShopFormatId : {ShopFormatId} không tồn tại trên hệ thống.", $"Cell[{i}, 1]");
                                                    continue;
                                                }
                                            }
                                            if (string.IsNullOrEmpty(ProductId))
                                            {
                                                _ = dt_error.Rows.Add("ProductId không để trống", $"Cell[{i}, 2]");
                                                continue;
                                            }
                                            if (dataPosm != null && dataPosm.Rows.Count > 0)
                                            {
                                                bool ExistsPosm = dataPosm.AsEnumerable().Any(x => Convert.ToString(x["ProductId"]) == ProductId);
                                                if (!ExistsPosm)
                                                {
                                                    _ = dt_error.Rows.Add($"ProductId : {ProductId} không tồn tại trên hệ thống.", $"Cell[{i}, 2]");
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
                                                bool CheckDuplicate = dt.AsEnumerable().Any(x => Convert.ToString(x["ShopFormatId"]) == ShopFormatId && Convert.ToString(x["ProductId"]) == ProductId);
                                                if (CheckDuplicate)
                                                {
                                                    _ = dt_error.Rows.Add($"Duplicate ShopFormatId : {ShopFormatId} - ProductId : {ProductId} ", $"Cell[{i}]");
                                                    continue;
                                                }
                                            }
                                            #endregion

                                            _ = dt.Rows.Add(ShopFormatId, ProductId, Quantity);
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
                                            DataTable dt_osa = new DataTable();
                                            dt_osa.Columns.Add("ShopId", typeof(int));
                                            dt_osa.Columns.Add("ProductId", typeof(int));
                                            dt_osa.Columns.Add("Quantity", typeof(string));

                                            foreach (DataRow dr in dt.Rows)
                                            {
                                                dt_osa.Rows.Add(dr["ShopFormatId"], dr["ProductId"], dr["Quantity"]);
                                            }

                                            var return_value = new ProductController().KPIOSAImport(Employee.EmployeeId.Value, CycleId, dt_osa);
                                            switch (return_value)
                                            {
                                                case (int)STATUS_IMPORT.SUCCESS: dt_error.Rows.Add("Cập nhật thông tin KPI OSA thành công"); break;
                                                case (int)STATUS_IMPORT.UNSUCCESS: dt_error.Rows.Add("Cập nhật thông tin KPI OSA KHÔNG thành công."); break;
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
                            else if (bt.CommandArgument.Equals("OSAMTFA"))
                            {
                                using (var package = new ExcelPackage(file))
                                {
                                    ExcelWorkbook workBook = package.Workbook;
                                    ExcelWorksheet currentWorksheet = workBook.Worksheets[1];
                                    DataTable dt = new DataTable();
                                    dt.Columns.Add("ShopFormatId", typeof(int));
                                    dt.Columns.Add("ProductId", typeof(int));
                                    dt.Columns.Add("Quantity", typeof(string));

                                    DataTable dataShops = new StoreListController().ShopFormatGetList(Employee.EmployeeId.Value);
                                    DataTable dataPosm = new ProductController().ProductGetList();
                                    for (int i = 3; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)); i++)
                                    {
                                        try
                                        {
                                            for (int col = 3; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[2, col].Value)); col++)
                                            {
                                                if (!string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[2, col].Value)) && currentWorksheet.Cells[i, col].Value != null && currentWorksheet.Cells[i, col].Value.ToString() == "1")
                                                {
                                                    string ShopFormatId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 2].Value) : null;
                                                    string ProductId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[2, col].Value)) ? Convert.ToString(currentWorksheet.Cells[2, col].Value) : null;
                                                    string Quantity = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, col].Value)) ? Convert.ToString(currentWorksheet.Cells[i, col].Value) : null;

                                                    _ = dt.Rows.Add(ShopFormatId, ProductId, Quantity);
                                                }
                                            }

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
                                            DataTable dt_osa = new DataTable();
                                            dt_osa.Columns.Add("ShopId", typeof(int));
                                            dt_osa.Columns.Add("PosmId", typeof(int));
                                            dt_osa.Columns.Add("Quantity", typeof(string));

                                            foreach (DataRow dr in dt.Rows)
                                            {
                                                dt_osa.Rows.Add(dr["ShopFormatId"], dr["ProductId"], dr["Quantity"]);
                                            }

                                            var return_value = new ProductController().KPIOSAImportMTFA(Employee.EmployeeId.Value, CycleId, dt_osa);
                                            switch (return_value)
                                            {
                                                case (int)STATUS_IMPORT.SUCCESS: dt_error.Rows.Add("Cập nhật thông tin KPI OSA thành công"); break;
                                                case (int)STATUS_IMPORT.UNSUCCESS: dt_error.Rows.Add("Cập nhật thông tin KPI OSA KHÔNG thành công."); break;
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
                    else
                    {
                        Toastr.ErrorToast("Vui lòng chọn file .xlsx để thêm dữ liệu.");
                        return;
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
            Button bt = sender as Button;
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
                if (bt.CommandArgument.Equals("POSM"))
                {
                    DataTable data = new PosmController().KPIPOSMGetList(Employee.EmployeeId.Value, CycleId);
                    if (data != null && data.Rows.Count > 0)
                        Pf.Excel(data, "KPI_POSM_By_Cycle");
                    else
                        Toastr.ErrorToast("Không có dữ liệu");
                }
                else if (bt.CommandArgument.Equals("OSA"))
                {
                    DataTable data = new ProductController().KPIOSAGetList(Employee.EmployeeId.Value, CycleId);
                    if (data != null && data.Rows.Count > 0)
                        Pf.Excel(data, "KPI_OSA_By_Cycle");
                    else
                        Toastr.ErrorToast("Không có dữ liệu");
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi : {ex.Message}");
            }
        }

        protected void btnTemplate_Click(object sender, EventArgs e)
        {
            Button bt = sender as Button;
            try
            {
                if (bt.CommandArgument.Equals("POSM"))
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
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi : {ex}");
                return;
            }
        }


        protected void lbKPI_Click(object sender, EventArgs e)
        {
            LinkButton lk = (LinkButton)sender;

            string CommandName = lk.CommandName;
            error.Visible = false;
            rptError.DataSource = null;
            rptError.DataBind();
            if (CommandName.Equals("OSA"))
            {
                plOSA.Visible = true;
                plPOSM.Visible = false;
                plSF.Visible = false;
                lbOSA.CssClass = "nav-link active";
                lbPOSM.CssClass = "nav-link";
                lbSF.CssClass = "nav-link";
            }
            if (CommandName.Equals("POSM"))
            {
                plOSA.Visible = false;
                plPOSM.Visible = true;
                plSF.Visible = false;
                lbOSA.CssClass = "nav-link";
                lbPOSM.CssClass = "nav-link active";
                lbSF.CssClass = "nav-link";
            }
            if (CommandName.Equals("SF"))
            {
                plOSA.Visible = false;
                plPOSM.Visible = false;
                plSF.Visible = true;
                lbOSA.CssClass = "nav-link";
                lbPOSM.CssClass = "nav-link";
                lbSF.CssClass = "nav-link active";
            }
        }
    }
}