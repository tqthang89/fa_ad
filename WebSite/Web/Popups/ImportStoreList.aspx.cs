using BLL.Address;
using BLL.StoreList;
using ECS_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Data;
using System.IO;
using System.Linq;

namespace ECS_Web.Popups
{
    public partial class ImportStoreList : PagePermisstion
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
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
                            dt.Columns.Add("ShopId", typeof(int));
                            dt.Columns.Add("ShopCode", typeof(string));
                            dt.Columns.Add("ShopName", typeof(string));
                            dt.Columns.Add("AddressLine", typeof(string));
                            dt.Columns.Add("AreaId", typeof(int));
                            dt.Columns.Add("ProvinceId", typeof(int));
                            dt.Columns.Add("DistrictId", typeof(int));
                            dt.Columns.Add("TownId", typeof(int));
                            dt.Columns.Add("Position", typeof(string));
                            dt.Columns.Add("ContactName", typeof(string));
                            dt.Columns.Add("ContactMobile", typeof(string));
                            dt.Columns.Add("ShopType", typeof(string));
                            dt.Columns.Add("Latitude", typeof(decimal));
                            dt.Columns.Add("Longitude", typeof(decimal));
                            dt.Columns.Add("Photo", typeof(string));
                            dt.Columns.Add("SiteId", typeof(int));

                            DataTable data = new StoreListController().StoreListGetList(Employee.EmployeeId.Value, null, null, null, null, null, null, null, 1, 100000);
                            DataTable data_area = new AddressController().AreaGetList(Employee.EmployeeId.Value);
                            DataTable data_address = new AddressController().AddressGetList(Employee.EmployeeId.Value, null, null, null, null);
                            for (int i = 2; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value))
                                 && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 4].Value))
                                  && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 6].Value))
                                 && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 7].Value))
                                 && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 13].Value)); i++)
                            {
                                try
                                {
                                    string ShopId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 2].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 2].Value) : null;
                                    string ShopCode = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 3].Value) : null;
                                    string ShopName = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 4].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 4].Value) : null;
                                    string AddressLine = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 5].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 5].Value) : null;
                                    string AreaId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 6].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 6].Value) : null;
                                    string ProvinceId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 7].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 7].Value) : null;
                                    string DistrictId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 8].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 8].Value) : null;
                                    string TownId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 9].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 9].Value) : null;
                                    string Position = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 10].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 10].Value) : null;
                                    string ContactName = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 11].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 11].Value) : null;
                                    string ContactMobile = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 12].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 12].Value) : null;
                                    string ShopType = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 13].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 13].Value) : null;
                                    string Latitude = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 14].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 14].Value) : null;
                                    string Longitude = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 15].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 15].Value) : null;
                                    string Photo = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 16].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 16].Value) : null;
                                    string SiteId = !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 17].Value)) ? Convert.ToString(currentWorksheet.Cells[i, 17].Value) : null;

                                    #region Check Exxception
                                    string AreaName = "", ProvinceName = "", DistrictName = "", TownName = "";
                                    if (string.IsNullOrEmpty(ShopCode))
                                    {
                                        _ = dt_error.Rows.Add("ShopCode không để trống", $"Cell[{i}, 3]");
                                        continue;
                                    }
                                    if (data != null && data.Rows.Count > 0 && Type == 1)
                                    {
                                        bool ExistsShopCode = data.AsEnumerable().Any(x => Convert.ToString(x["ShopCode"]) == ShopCode);
                                        if (ExistsShopCode)
                                        {
                                            _ = dt_error.Rows.Add($"ShopCode : {ShopCode} đã tồn tại trên hệ thống.", $"Cell[{i}, 3]");
                                            continue;
                                        }
                                    }
                                    if (string.IsNullOrEmpty(ShopName))
                                    {
                                        _ = dt_error.Rows.Add("ShopName không để trống", $"Cell[{i}, 4]");
                                        continue;
                                    }
                                    if (string.IsNullOrEmpty(AddressLine))
                                    {
                                        _ = dt_error.Rows.Add("AddressLine không để trống", $"Cell[{i}, 5]");
                                        continue;
                                    }
                                    if (string.IsNullOrEmpty(AreaId))
                                    {
                                        _ = dt_error.Rows.Add("AreaId không để trống", $"Cell[{i}, 6]");
                                        continue;
                                    }
                                    if (data_area != null && data_area.Rows.Count > 0)
                                    {
                                        var ExistsArea = data_area.AsEnumerable().Where(x => Convert.ToString(x["AreaId"]) == AreaId);
                                        AreaName = ExistsArea.Any() ? Convert.ToString(ExistsArea.FirstOrDefault()["AreaName"] ?? "") : "";
                                        if (!ExistsArea.Any())
                                        {
                                            _ = dt_error.Rows.Add($"AreaId : {AreaId} - {AreaName} không tồn tại trên hệ thống.", $"Cell[{i}, 6]");
                                            continue;
                                        }
                                    }
                                    if (string.IsNullOrEmpty(ProvinceId))
                                    {
                                        _ = dt_error.Rows.Add("ProvinceId không để trống", $"Cell[{i}, 7]");
                                        continue;
                                    }
                                    if (!string.IsNullOrEmpty(ProvinceId))
                                    {
                                        if (data_address != null && data_address.Rows.Count > 0)
                                        {
                                            var ExistsProvince = data_address.AsEnumerable().Where(x => Convert.ToString(x["ProvinceId"]) == ProvinceId);
                                            ProvinceName = ExistsProvince.Any() ? Convert.ToString(ExistsProvince.FirstOrDefault()["ProvinceName"] ?? "") : "";
                                            if (!ExistsProvince.Any())
                                            {
                                                _ = dt_error.Rows.Add($"ProvinceId : {ProvinceId} - {ProvinceName} không tồn tại trên hệ thống.", $"Cell[{i}, 7]");
                                                continue;
                                            }

                                            bool ExistsArea_Province = data_address.AsEnumerable().Any(x => Convert.ToString(x["ProvinceId"]) == ProvinceId && Convert.ToString(x["AreaId"]) == AreaId);
                                            if (!ExistsArea_Province)
                                            {
                                                _ = dt_error.Rows.Add($"ProvinceId : {ProvinceId} - {ProvinceName} không thuộc AreaId : {AreaId} - {AreaName}.", $"Cell[{i}, 7]");
                                                continue;
                                            }
                                        }
                                    }
                                    if (!string.IsNullOrEmpty(DistrictId))
                                    {
                                        if (data_address != null && data_address.Rows.Count > 0)
                                        {
                                            var ExistsDistrictId = data_address.AsEnumerable().Where(x => Convert.ToString(x["DistrictId"]) == DistrictId);
                                            DistrictName = ExistsDistrictId.Any() ? Convert.ToString(ExistsDistrictId.FirstOrDefault()["DistrictName"] ?? "") : "";
                                            if (!ExistsDistrictId.Any())
                                            {
                                                _ = dt_error.Rows.Add($"DistrictId : {DistrictId} - {DistrictName} không tồn tại trên hệ thống.", $"Cell[{i}, 8]");
                                                continue;
                                            }
                                            bool ExistsProvince_District = data_address.AsEnumerable().Any(x => Convert.ToString(x["ProvinceId"]) == ProvinceId && Convert.ToString(x["DistrictId"]) == DistrictId);
                                            if (!ExistsProvince_District)
                                            {
                                                _ = dt_error.Rows.Add($"DistrictId : {DistrictId} - {DistrictName} không thuộc ProvinceId : {ProvinceId} - {ProvinceName}.", $"Cell[{i}, 8]");
                                                continue;
                                            }
                                        }
                                    }
                                    if (!string.IsNullOrEmpty(TownId))
                                    {
                                        if (data_address != null && data_address.Rows.Count > 0)
                                        {
                                            var ExistsTownId = data_address.AsEnumerable().Where(x => Convert.ToString(x["TownId"]) == TownId);
                                            TownName = ExistsTownId.Any() ? Convert.ToString(ExistsTownId.FirstOrDefault()["TownName"] ?? "") : "";
                                            if (!ExistsTownId.Any())
                                            {
                                                _ = dt_error.Rows.Add($"TownId : {TownId} - {TownName} không tồn tại trên hệ thống.", $"Cell[{i}, 9]");
                                                continue;
                                            }
                                        }
                                    }
                                    if (string.IsNullOrEmpty(ShopType))
                                    {
                                        _ = dt_error.Rows.Add("ShopType không để trống", $"Cell[{i}, 7]");
                                        continue;
                                    }
                                    #endregion
                                    _ = dt.Rows.Add(ShopId, ShopCode.Trim(), ShopName, AddressLine, AreaId, ProvinceId, DistrictId, TownId, Position,
                                    ContactName, ContactMobile, ShopType, Latitude, Longitude, Photo,SiteId);
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
                                    var return_value = new StoreListController().StoreListImport(Type, dt);
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
                _ = dt_error.Rows.Add($"Lỗi ghi dữ liệu : {ex.Message}", "");
                Pf.BindGridError(ref error, dt_error, ref rptError);
                Toastr.ErrorToast($"Lỗi : {ex.Message}");
            }
        }

        protected void btnTemplate_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable data = new AddressController().AddressGetList(Employee.EmployeeId.Value, null, null, null, null);
                if (data != null && data.Rows.Count > 0)
                {
                    string fileName = "TempateImport_StoreList_" + string.Format("{0:yyyyMMdd_HHmmss}", DateTime.Now);
                    FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\template_import_store.xlsx"));
                    string path = Server.MapPath($"~\\Upload\\export\\");
                    if (!Directory.Exists(path))
                        Directory.CreateDirectory(path);
                    string fileExport = $"{path}{fileName}.xlsx";
                    FileInfo fileCopy = fileInfo.CopyTo(fileExport);
                    using (var xls = new ExcelPackage(fileCopy))
                    {
                        ExcelWorksheet ws = xls.Workbook.Worksheets["Address"];
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