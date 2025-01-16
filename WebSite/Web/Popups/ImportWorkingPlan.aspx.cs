using BLL.Employees;
using BLL.StoreList;
using BLL.WorkingPlan;
using ECS_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ECS_Web.Popups
{
    public partial class ImportWorkingPlan : PagePermisstion
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindYear_Month();
                Pf.bindCycleDropDown(Employee.EmployeeId.Value, DateTime.Now.Year, null, ref ddlCycle);
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
            script.RegisterPostBackControl(btnExportTemplate);
            script.RegisterPostBackControl(btnImport);
        }

        protected void btnExportTemplate_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlYear.SelectedIndex == 0)
                {
                    Toastr.ErrorToast("Chọn năm");
                    return;
                }
                if (ddlMonth.SelectedIndex == 0)
                {
                    Toastr.ErrorToast("Chọn tháng");
                    return;
                }
                int Year = Convert.ToInt32(ddlYear.SelectedValue);
                int Month = Convert.ToInt32(ddlMonth.SelectedValue);
                using (DataSet ds = new WorkingPlanController().WorkingPlanPIVOTExportTemplate(Year, Month, Employee.EmployeeId.Value))
                {
                    if (ds != null)
                    {
                        string fileName = "RoutingPlan_" + string.Format("{0:yyyyMMdd_HHmmss}", DateTime.Now);
                        FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\template_routingplan.xlsx"));
                        string path = Server.MapPath($"~\\Upload\\export\\");
                        if (!Directory.Exists(path))
                            Directory.CreateDirectory(path);
                        string fileExport =$"{path}{fileName}.xlsx";
                        FileInfo fileCopy = fileInfo.CopyTo(fileExport);
                        using (var xls = new ExcelPackage(fileCopy))
                        {
                            ExcelWorksheet ws = xls.Workbook.Worksheets[1];
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                                {
                                    ws.Cells[4 + i, j + 1].Value = ds.Tables[0].Rows[i][j].ToString();

                                }
                            }
                            Pf.border(ws, 4, ds.Tables[0].Rows.Count + 3, 1, ds.Tables[0].Columns.Count + 1, "#FFF", "#000000");
                            int from = 9, to = 0, num = 1;
                            string week = "";
                            for (int k = 0; k < ds.Tables[1].Rows.Count; k++)
                            {
                                string week2 = "";
                                week2 = "Week " + ds.Tables[1].Rows[k]["TheISOWeek"] + " (" + ds.Tables[1].Rows[k]["TheYear"] + "-" + ds.Tables[1].Rows[k]["TheMonth"] + ")";
                                ws.Cells[1, k + 9].Value = week2;
                                Pf.border(ws, 1, 1, k + 9, k + 9, "#FFF", "#000000");
                                ws.Cells[2, k + 9].Value = ds.Tables[1].Rows[k]["TheDayName"].ToString() == "1" ? "CN" : "Thứ " + ds.Tables[1].Rows[k]["TheDayOfWeek"];
                                Pf.border(ws, 2, 2, k + 9, k + 9, "#FFF", "#000000");
                                ws.Cells[3, k + 9].Value = ds.Tables[1].Rows[k]["TheDateInt"];
                                Pf.border(ws, 3, 3, k + 9, k + 9, "#FFF", "#000000");
                                if (k != 0)
                                {
                                    if (week2 != week)
                                    {
                                        to = to + 1;
                                        if ((to - from) > 1 && num > 1)
                                        {
                                            Pf.merge(ws, 1, 1, from, to - 1);
                                        }
                                        from = to;
                                        num = 1;
                                    }
                                    else
                                    {
                                        to = to + 1;
                                        num++;
                                    }
                                }
                                else
                                    to = from;
                                if (k == ds.Tables[1].Rows.Count - 1)
                                {
                                    if (Convert.ToString(ws.Cells[1, 9 + k].Value) == week)
                                    {
                                        to = to + 1;
                                        if ((to - from) > 1 && num > 1)
                                        {
                                            Pf.merge(ws, 1, 1, from, to - 1);
                                        }
                                    }
                                }
                                week = week2;
                            }
                            Pf.ExcelByExcelPackage(xls, fileName);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi : {ex.Message}");
            }
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            if (ddlCycle.SelectedIndex == 0)
            {
                Toastr.ErrorToast("Chọn chu kỳ");
                return;
            }
            //int CycleId = Convert.ToInt32(ddlCycle.SelectedValue);
            string[] selected = ddlCycle.SelectedValue.Split('_');
            int CycleId = Convert.ToInt32(selected[0]);
            DataTable dt_error = new DataTable();
            dt_error.Columns.Add("Message", typeof(string));
            dt_error.Columns.Add("Cell", typeof(string));

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
                            dt.Columns.Add("EmployeeId", typeof(int));
                            dt.Columns.Add("AuditDate", typeof(DateTime));
                           
                            //DataTable data_shops = new StoreListController().StoreListGetList(Employee.EmployeeId.Value, null, null, null, null, null, null, null, null, null);
                            DataTable data_empshop = new EmployeesController().EmployeeStoreGetList(CycleId,Employee.EmployeeId.Value, Pf.DateStringToInt(DateTime.Now.ToString("yyyy-MM-dd")));
                            DataTable ds_wp = new WorkingPlanController().WorkingPlanGetAllByCycle( Employee.EmployeeId.Value, CycleId);
                            for (int i = 4; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 3].Value)) && !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[i, 7].Value)); i++)
                            {
                                try
                                {
                                    string ShopId = currentWorksheet.Cells[i, 3].Value != null ? currentWorksheet.Cells[i, 3].Value.ToString() : string.Empty;
                                    string EmployeeId = currentWorksheet.Cells[i, 7].Value != null ? currentWorksheet.Cells[i, 7].Value.ToString() : string.Empty;
                                    if (string.IsNullOrEmpty(ShopId.Trim())) continue;
                                    if (string.IsNullOrEmpty(EmployeeId.Trim())) continue;
                                    bool empshops = data_empshop.AsEnumerable().Any(es => Convert.ToInt32(es["ShopId"]) == Convert.ToInt32(ShopId) 
                                    //&& Convert.ToInt32(es["EmployeeId"]) == Convert.ToInt32(EmployeeId)
                                    );
                                    if (!empshops)
                                    {
                                        dt_error.Rows.Add($"Bạn chưa phân quyền Shop: {ShopId} trong chu kỳ.", $"Cell[{i}]");
                                        continue;
                                    }

                                    if(ds_wp != null && ds_wp.Rows.Count>0)
                                    {
                                        bool ex_wp = ds_wp.AsEnumerable().Any(es => Convert.ToInt32(es["ShopId"]) == Convert.ToInt32(ShopId));
                                        if (!ex_wp)
                                        {
                                            dt_error.Rows.Add($"ShopId: {ShopId} đã có lịch làm việc trong chu kỳ.", $"Cell[{i}]");
                                            continue;
                                        }
                                    }    

                                    for (int j = 9; !string.IsNullOrEmpty(Convert.ToString(currentWorksheet.Cells[3, j].Value)); j++)
                                    {
                                        string x_off = Convert.ToString(currentWorksheet.Cells[i, j].Value);
                                        try
                                        {
                                            string PlanDate = Convert.ToString(currentWorksheet.Cells[3, j].Value);
                                            DateTime date;
                                            if (!DateTime.TryParseExact(PlanDate, "yyyyMMdd", null, System.Globalization.DateTimeStyles.None, out date))
                                            {
                                                dt_error.Rows.Add($"Sai định dạng (YYYYMMDD) ngày làm việc", $"Cell[3, {j}");
                                                return;
                                            }
                                            if (!string.IsNullOrEmpty(x_off.Trim()) && x_off.ToUpper() == "X")
                                            {
                                                if (!string.IsNullOrEmpty(PlanDate.Trim()))
                                                {
                                                    if (dt != null && dt.Rows.Count > 0)
                                                    {
                                                        bool check_dupplicate = dt.AsEnumerable().Any(x => Convert.ToInt32(x["EmployeeId"]) == Convert.ToInt32(EmployeeId) 
                                                        && Convert.ToInt32(x["ShopId"]) == Convert.ToInt32(ShopId) && Convert.ToDateTime(x["AuditDate"]).Date == date.Date);
                                                        if (check_dupplicate)
                                                        {
                                                            dt_error.Rows.Add($"Duplicate Employee : {EmployeeId}, Shop : {ShopId}", $"Cell[{i}, {j}]");
                                                            continue;
                                                        }
                                                    }

                                                    dt.Rows.Add(ShopId, EmployeeId, date.Date);

                                                    //if (dt.Rows.Count == 1000)
                                                    //{
                                                    //    var return_value = new WorkingPlanController().WorkingPlanImport(dt);
                                                    //    dt = new DataTable();
                                                    //    dt.Columns.Add("ShopId", typeof(int));
                                                    //    dt.Columns.Add("EmployeeId", typeof(int));
                                                    //    dt.Columns.Add("AuditDate", typeof(DateTime));
                                                    //}
                                                }
                                                else
                                                {
                                                    dt_error.Rows.Add($"WorkingDate trống", $"Cell[{i}, {j}]");
                                                    continue;
                                                }
                                            }
                                            else
                                                continue;
                                        }
                                        catch { continue; }
                                    }
                                }
                                catch (Exception ex)
                                {
                                    dt_error.Rows.Add($"Lỗi ghi dữ liệu : {ex.Message}", "");
                                    continue;
                                }
                            }
                            if (dt_error.Rows.Count == 0)
                            {
                                if (dt != null && dt.Rows.Count > 0)
                                {
                                    var return_value = new WorkingPlanController().WorkingPlanImport(dt);
                                    switch (return_value)
                                    {
                                        case (int)STATUS_IMPORT.SUCCESS: dt_error.Rows.Add("Phân quyền LLV thành công."); break;
                                        case (int)STATUS_IMPORT.UNSUCCESS: dt_error.Rows.Add("Phân quyền LLV KHÔNG thành công."); break;
                                        case (int)STATUS_IMPORT.ERROR: dt_error.Rows.Add("Phân quyền LLV KHÔNG thành công. Lỗi ghi dữ liệu"); break;
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
        private void BindYear_Month()
        {
            int index = 1;
            ddlYear.Items.Insert(0, new ListItem("- Năm -", "0"));
            for (int i = 2022; i <= DateTime.Now.Year + 1; i++)
            {
                ddlYear.Items.Insert(index++, new ListItem(i.ToString(), i.ToString()));
            }
            ddlYear.SelectedValue = DateTime.Now.Year.ToString();

            ddlMonth.Items.Insert(0, new ListItem("- Tháng -", "0"));
            for (int i = 1; i <= 12; i++)
            {
                ddlMonth.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
            }
            ddlMonth.SelectedValue = DateTime.Now.Month.ToString();
        }
    }
}