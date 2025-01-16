using BLL.Employees;
using BLL.WorkingPlan;
using ECS_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Collections;
using System.Data;
using System.IO;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.pages.WorkingPlan
{
    public partial class Default : PagePermisstion
    {
        private string _title = "Phân quyền lịch làm việc";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteAuditMaster)Master).SetFormTitle(_title);
                txtWPDate.Text =  txtToDate.Text = txtFromDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                bindOption();
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
            script.RegisterPostBackControl(btnExport);
            ScriptManager.RegisterStartupScript(Page, GetType(), Guid.NewGuid().ToString(), "<script> $(function () {  $('#reservationdatewp').datetimepicker({ format: 'DD/MM/YYYY' }); }); </script>", false);
        }
        void bindOption()
        {
            ddlAuditor.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            
            if (Employee.TypeId == 2)
                Pf.bindEmployeeDropDown(2, Employee.EmployeeId, null, ref ddlSup);
            else
                Pf.bindEmployeeDropDown(2, null, null, ref ddlSup);

            //Pf.bindEmployeeDropDown(3, null, Employee.TypeId == 2 ? Employee.EmployeeId : null, ref ddlAuditor);
        }
        protected void btnFilter_Click(object sender, EventArgs e)
        {
            if (!DateTime.TryParseExact(txtWPDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime WPDate))
            {
                Toastr.ErrorToast("Ngày LV không đúng định dạng dd/MM/yyyy");
                return;
            }
            //DateTime? ToDate = null;
            //if (!string.IsNullOrEmpty(Convert.ToString(txtToDate.Text).Trim()))
            //    ToDate = Convert.ToDateTime(txtToDate.Text);
            if (ddlAuditor.SelectedIndex == 0)
            {
                Toastr.WarningToast("Vui lòng chọn nhân viên !");
                return;
            }
            int SupId = Convert.ToInt32(ddlSup.SelectedValue);
            int AuditorId = Convert.ToInt32(ddlAuditor.SelectedValue);
            BindShopAvailable(WPDate, SupId, AuditorId, txtShopCode.Text);
            Thread.Sleep(1000);
            BindShopChoosen(WPDate, AuditorId, txtShopCode.Text);
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                if (!DateTime.TryParseExact(txtFromDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime FromDate))
                {
                    Toastr.ErrorToast("FromDate không đúng định dạng dd/MM/yyyy");
                    return;
                }
                if (!DateTime.TryParseExact(txtToDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime ToDate))
                {
                    Toastr.ErrorToast("FromDate không đúng định dạng dd/MM/yyyy");
                    return;
                }
                int? SupId = Convert.ToInt32(ddlSup.SelectedValue);
                int AuditorId = Convert.ToInt32(ddlAuditor.SelectedValue);

                using (DataSet ds = new WorkingPlanController().WorkingPlanPIVOTExportData(Employee.EmployeeId.Value, FromDate, ToDate, SupId, AuditorId, txtShopCode.Text))
                {
                    if (ds != null)
                    {
                        string fileName = "RoutingPlan_" + string.Format("{0:yyyyMMdd_HHmmss}", DateTime.Now);
                        FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\template_routingplan.xlsx"));
                        string path = Server.MapPath($"~\\Upload\\export\\");
                        if (!Directory.Exists(path))
                            Directory.CreateDirectory(path);
                        string fileExport = Server.MapPath($"~\\Upload\\export\\{fileName}.xlsx");
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
                Toastr.ErrorToast($"Lỗi : {ex}");
            }
        }
        protected void ddlSup_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlAuditor.Items.Clear();
            string selected = ddlSup.SelectedValue;
            if (!string.IsNullOrEmpty(selected) && selected != "-1")
                Pf.bindEmployeeDropDown(null, null, Convert.ToInt32(selected), ref ddlAuditor);
            else
                ddlAuditor.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }
        #region ListBox
        ArrayList _lbAvailable = new ArrayList();
        ArrayList _lbChoosen = new ArrayList();
        protected void btnAdd_Click(object sender, ImageClickEventArgs e)
        {
            AddData();
        }

        protected void btnAddAll_Click(object sender, ImageClickEventArgs e)
        {
            AddData(true);
        }

        protected void btnRemove_Click(object sender, ImageClickEventArgs e)
        {
            RemoveData();
        }

        protected void btnRemoveAll_Click(object sender, ImageClickEventArgs e)
        {
            RemoveData(true);
        }
        private void BindShopAvailable(DateTime FromDate,int SupId, int? AuditorId, string ShopCode)
        {
            try
            {
                DataTable data = new WorkingPlanController().WorkingPlanGetShopAvailable(Employee.EmployeeId.Value, FromDate, SupId,  AuditorId, txtShopCode.Text);
                if (data != null && data.Rows.Count > 0)
                {
                    lbAvailable.DataSource = data;
                    lbAvailable.DataBind();
                }
                else
                {
                    lbAvailable.DataSource = new DataTable();
                    lbAvailable.DataBind();
                }
                ltrAvailable.Text = "Total " + lbAvailable.Items.Count + " shop";
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi tải dữ liệu Cửa hàng : {ex.Message}");
            }
        }

        private void BindShopChoosen(DateTime FromDate, int? AuditorId, string ShopCode)
        {
            try
            {
                DataTable data = new WorkingPlanController().WorkingPlangetShop(Employee.EmployeeId.Value, FromDate, AuditorId, txtShopCode.Text);
                if (data != null && data.Rows.Count > 0)
                {
                    lbChoosen.DataSource = data;
                    lbChoosen.DataBind();
                }
                else
                {
                    lbChoosen.DataSource = new DataTable();
                    lbChoosen.DataBind();
                }
                ltrChoosen.Text = "Total " + lbChoosen.Items.Count + " shop";
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi tải dữ liệu Cửa hàng : {ex.Message}");
            }
        }
        private void AddData(bool IsAll = false)
        {
            if (!DateTime.TryParseExact(txtWPDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime WPDate))
            {
                Toastr.ErrorToast("Ngày LV không đúng định dạng dd/MM/yyyy");
                return;
            }
            if (ddlAuditor.SelectedIndex == 0)
            {
                Toastr.WarningToast("Vui lòng chọn nhân viên !");
                return;
            }
            int AuditorId = Convert.ToInt32(ddlAuditor.SelectedValue);
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ShopId", typeof(int));
                dt.Columns.Add("EmployeeId", typeof(int));
                dt.Columns.Add("AuditDate", typeof(DateTime));
                if (lbAvailable.SelectedIndex >= 0 || IsAll)
                {
                    for (int i = 0; i < lbAvailable.Items.Count; i++)
                    {
                        if (lbAvailable.Items[i].Selected || IsAll)
                        {
                            if (lbAvailable.Items[i].Text.Trim() != "")
                            {
                                try
                                {
                                    if (!_lbAvailable.Contains(lbAvailable.Items[i]))
                                        _lbAvailable.Add(lbAvailable.Items[i]);
                                }
                                catch
                                {
                                    continue;
                                }
                            }
                        }
                    }
                    if (_lbAvailable.Count > 0)
                    {
                        for (int j = 0; j < _lbAvailable.Count; j++)
                        {
                            if (!lbChoosen.Items.Contains(((ListItem)_lbAvailable[j])))
                            {
                                lbChoosen.Items.Add(((ListItem)_lbAvailable[j]));
                                DataRow dr = dt.NewRow();
                                dr["ShopId"] = ((ListItem)_lbAvailable[j]).Value;
                                dr["EmployeeId"] = AuditorId.ToString();
                                dr["AuditDate"] = WPDate;
                                dt.Rows.Add(dr);
                            }
                            lbAvailable.Items.Remove(((ListItem)_lbAvailable[j]));
                        }
                    }
                    ltrAvailable.Text = "Total: " + lbAvailable.Items.Count.ToString();
                    ltrChoosen.Text = "Total: " + lbChoosen.Items.Count.ToString();
                    var return_value = new WorkingPlanController().WorkingPlanImport(dt);
                    switch (return_value)
                    {
                        case (int)STATUS_IMPORT.SUCCESS: Toastr.SucessToast("Phân quyền LLV thành công."); break;
                        case (int)STATUS_IMPORT.UNSUCCESS: Toastr.SucessToast("Phân quyền LLV KHÔNG thành công."); break;
                        case (int)STATUS_IMPORT.ERROR: Toastr.SucessToast("Phân quyền LLV KHÔNG thành công. Lỗi ghi dữ liệu"); break;
                        default:
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi ghi dữ liệu : {ex.Message}");
            }
        }
        private void RemoveData(bool IsAll = false)
        {
            if (!DateTime.TryParseExact(txtWPDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime WPDate))
            {
                Toastr.ErrorToast("Ngày LV không đúng định dạng dd/MM/yyyy");
                return;
            }
            if (ddlAuditor.SelectedIndex == 0)
            {
                Toastr.WarningToast("Vui lòng chọn nhân viên !");
                return;
            }
            int AuditorId = Convert.ToInt32(ddlAuditor.SelectedValue);
            try
            {
                if (lbChoosen.SelectedIndex >= 0 || IsAll)
                {
                    string WPId = "";
                    for (int i = 0; i < lbChoosen.Items.Count; i++)
                    {
                        if (lbChoosen.Items[i].Selected || IsAll)
                        {
                            if (!_lbChoosen.Contains(lbChoosen.Items[i]))
                            {
                                _lbChoosen.Add(lbChoosen.Items[i]);
                            }
                        }
                    }
                    if (_lbChoosen.Count > 0)
                    {
                        for (int i = 0; i < _lbChoosen.Count; i++)
                        {
                            if (!lbAvailable.Items.Contains(((ListItem)_lbChoosen[i])))
                            {
                                lbAvailable.Items.Add(((ListItem)_lbChoosen[i]));
                                WPId += ((ListItem)_lbChoosen[i]).Value + ",";
                            }
                            lbChoosen.Items.Remove(((ListItem)_lbChoosen[i]));
                        }
                    }
                    ltrAvailable.Text = "Total: " + lbAvailable.Items.Count.ToString();
                    ltrChoosen.Text = "Total: " + lbChoosen.Items.Count.ToString();
                    int return_value = new WorkingPlanController().WorkingPlanDeleteMulti(AuditorId, WPId.Trim().TrimEnd(','));
                    switch (return_value)
                    {
                        case (int)STATUS_IMPORT.SUCCESS: Toastr.SucessToast("Xoá phân quyền LLV thành công."); break;
                        case (int)STATUS_IMPORT.UNSUCCESS: Toastr.SucessToast("Xoá phân quyền LLV KHÔNG thành công."); break;
                        case (int)STATUS_IMPORT.ERROR: Toastr.SucessToast("Xoá phân quyền LLV KHÔNG thành công. Lỗi ghi dữ liệu"); break;
                        default:
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi ghi dữ liệu : {ex.Message}");
                return;
            }
        }
        #endregion

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlType.SelectedValue =="1")
            {
                btnExport.Visible = false;
                div_export1.Visible = false;
                div_export2.Visible = false;

                btnFilter.Visible = true;
                btnImport.Visible = true;
                div_create1.Visible = true;
                workresult.Visible = true;
            }   
            else
            {
                btnExport.Visible = true;
                div_export1.Visible = true;
                div_export2.Visible = true;

                btnFilter.Visible = false;
                btnImport.Visible = false;
                div_create1.Visible = false;
                workresult.Visible = false;
            }
        }
    }
}