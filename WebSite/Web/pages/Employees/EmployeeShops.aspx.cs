using BLL.Employees;
using ECS_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Collections;
using System.Data;
using System.IO;
using System.Threading;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.pages.Employees
{
    public partial class EmployeeShops : PagePermisstion
    {
        private string _title = "Phân quyền nhân viên";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteAuditMaster)Master).SetFormTitle(_title);
                txtFromDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
                BindOption();
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
            script.RegisterPostBackControl(btnExport);
        }
        void BindOption()
        {
            //ddlAuditor.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            Pf.bindEmployeeDropDown(2, null, null, ref ddlSup);
        }
        protected void btnFilter_Click(object sender, EventArgs e)
        {
            if (!DateTime.TryParseExact(txtFromDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime FromDate))
            {
                Toastr.ErrorToast("FromDate không đúng định dạng dd/MM/yyyy");
                return;
            }
            DateTime? _ToDate = null;
            if (!string.IsNullOrEmpty(Convert.ToString(txtToDate.Text).Trim()))
            {
                if (!DateTime.TryParseExact(txtToDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime ToDate))
                {
                    Toastr.ErrorToast("ToDate không đúng định dạng dd/MM/yyyy");
                    return;
                }
                _ToDate = ToDate;
            }
            if (ddlSup.SelectedIndex == 0)
            {
                Toastr.WarningToast("Vui lòng chọn nhân viên !");
                return;
            }

            int AuditorId = Convert.ToInt32(ddlSup.SelectedValue);
            BindShopAvailable(FromDate, _ToDate, AuditorId, txtShopCode.Text);
            Thread.Sleep(1000);
            BindShopChoosen(FromDate, _ToDate, AuditorId, txtShopCode.Text);
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
                DateTime? _ToDate = null;
                if (!string.IsNullOrEmpty(Convert.ToString(txtToDate.Text).Trim()))
                {
                    if (!DateTime.TryParseExact(txtToDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime ToDate))
                    {
                        Toastr.ErrorToast("ToDate không đúng định dạng dd/MM/yyyy");
                        return;
                    }
                    _ToDate = ToDate;
                }
                int? SupId =  Convert.ToInt32(ddlSup.SelectedValue);
                int AuditorId = -1;// Convert.ToInt32(ddlAuditor.SelectedValue);

                string fileName = "EmployeStore_" + string.Format("{0:yyyyMMddHHmmss}", DateTime.Now);
                FileInfo fileInfo = new FileInfo(Server.MapPath("~\\Template\\template_employeeStore.xlsx"));
                string fileExport = Server.MapPath("~\\Template\\Upload\\export\\" + fileName);
                FileInfo fileCopy = fileInfo.CopyTo(fileExport);
                using (var xls = new ExcelPackage(fileCopy))
                {
                    ExcelWorksheet ws = xls.Workbook.Worksheets[1];
                    DataTable data = new EmployeesController().EmployeeStoreExport(Employee.EmployeeId.Value, FromDate, _ToDate, SupId, AuditorId, txtShopCode.Text);
                    if (data != null && data.Rows.Count > 0)
                    {
                        ws.Cells[3, 1].LoadFromDataTable(data, false);
                        Pf.ExcelByExcelPackage(xls, fileName);
                    }
                    else
                        Toastr.WarningToast("Không có dữ liêu !");

                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast($"Lỗi : {ex}");
            }
        }
        protected void ddlSup_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ddlAuditor.Items.Clear();
            //string selected = ddlSup.SelectedValue;
            //if (!string.IsNullOrEmpty(selected) && selected != "-1")
            //    Pf.bindEmployeeDropDown(null, null, Convert.ToInt32(selected), ref ddlAuditor);
            //else
            //    ddlAuditor.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
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
        private void BindShopAvailable(DateTime FromDate, DateTime? ToDate, int? AuditorId, string ShopCode)
        {
            try
            {
                DataTable data = new EmployeesController().EmployeeStoreGetShopAvailable(Employee.EmployeeId.Value, FromDate, ToDate, AuditorId, txtShopCode.Text);
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

        private void BindShopChoosen(DateTime FromDate, DateTime? ToDate, int? AuditorId, string ShopCode)
        {
            try
            {
                DataTable data = new EmployeesController().EmployeeStoregetShop(Employee.EmployeeId.Value, FromDate, ToDate, AuditorId, txtShopCode.Text);
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
            if (!DateTime.TryParseExact(txtFromDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime FromDate))
            {
                Toastr.ErrorToast("FromDate không đúng định dạng dd/MM/yyyy");
                return;
            }
            DateTime? _ToDate = null;
            if (!string.IsNullOrEmpty(Convert.ToString(txtToDate.Text).Trim()))
            {
                if (!DateTime.TryParseExact(txtToDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime ToDate))
                {
                    Toastr.ErrorToast("ToDate không đúng định dạng dd/MM/yyyy");
                    return;
                }
                _ToDate = ToDate;
            }
            if (ddlSup.SelectedIndex == 0)
            {
                Toastr.WarningToast("Vui lòng chọn nhân viên !");
                return;
            }
            int AuditorId = Convert.ToInt32(ddlSup.SelectedValue);
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ShopId", typeof(int));
                dt.Columns.Add("EmployeeId", typeof(int));
                dt.Columns.Add("FromDate", typeof(DateTime));
                dt.Columns.Add("ToDate", typeof(DateTime));
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
                                dr["FromDate"] = FromDate;
                                if (!string.IsNullOrEmpty(txtToDate.Text.Trim()))
                                    dr["ToDate"] = _ToDate;
                                else dr["ToDate"] = DBNull.Value;
                                dt.Rows.Add(dr);
                            }
                            lbAvailable.Items.Remove(((ListItem)_lbAvailable[j]));
                        }
                    }
                    ltrAvailable.Text = "Total: " + lbAvailable.Items.Count.ToString();
                    ltrChoosen.Text = "Total: " + lbChoosen.Items.Count.ToString();
                    var return_value = new EmployeesController().EmployeeStoreImport(dt);
                    switch (return_value)
                    {
                        case (int)STATUS_IMPORT.SUCCESS: Toastr.SucessToast("Phân quyền cửa hàng thành công."); break;
                        case (int)STATUS_IMPORT.UNSUCCESS: Toastr.SucessToast("Phân quyền cửa hàng KHÔNG thành công."); break;
                        case (int)STATUS_IMPORT.ERROR: Toastr.SucessToast("Phân quyền cửa hàng KHÔNG thành công. Lỗi ghi dữ liệu"); break;
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
            if (!DateTime.TryParseExact(txtFromDate.Text.Trim(), "dd/MM/yyyy", null, System.Globalization.DateTimeStyles.None, out DateTime FromDate))
            {
                Toastr.ErrorToast("FromDate không đúng định dạng dd/MM/yyyy");
                return;
            }
            if (ddlSup.SelectedIndex == 0)
            {
                Toastr.WarningToast("Vui lòng chọn nhân viên !");
                return;
            }
            int AuditorId = Convert.ToInt32(ddlSup.SelectedValue);
            try
            {
                if (lbChoosen.SelectedIndex >= 0 || IsAll)
                {
                    string ShopId = "";
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
                                ShopId += ((ListItem)_lbChoosen[i]).Value + ",";
                            }
                            lbChoosen.Items.Remove(((ListItem)_lbChoosen[i]));
                        }
                    }
                    ltrAvailable.Text = "Total: " + lbAvailable.Items.Count.ToString();
                    ltrChoosen.Text = "Total: " + lbChoosen.Items.Count.ToString();
                    int return_value = new EmployeesController().EmployeeStoreDeleteMulti(AuditorId, ShopId.Trim().TrimEnd(','));
                    switch (return_value)
                    {
                        case (int)STATUS_IMPORT.SUCCESS: Toastr.SucessToast("Xoá phân quyền cửa hàng thành công."); break;
                        case (int)STATUS_IMPORT.UNSUCCESS: Toastr.SucessToast("Xoá phân quyền cửa hàng KHÔNG thành công."); break;
                        case (int)STATUS_IMPORT.ERROR: Toastr.SucessToast("Xoá phân quyền cửa hàng KHÔNG thành công. Lỗi ghi dữ liệu"); break;
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
        #endregion
    }
}