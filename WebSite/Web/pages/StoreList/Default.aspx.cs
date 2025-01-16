using BLL.StoreList;
using ECS_Web.App_Code;
using System;
using System.Data;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.pages.StoreList
{
    public partial class Default : PagePermisstion
    {
        private string _title = "Quản lý danh sách cửa hàng";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteAuditMaster)Master).SetFormTitle(_title);
                BindOption();
            }
            ScriptManager script = ScriptManager.GetCurrent(Page);
            script.Dispose();
            script.RegisterPostBackControl(btnExport);
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            Filter();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            try
            {
                int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
                int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
                int DistrictId = Convert.ToInt32(ddlDistrict.SelectedValue);
                int TownId = Convert.ToInt32(ddlTown.SelectedValue);
                string ShopType = ddlType.SelectedValue;
                DataTable data = new StoreListController().StoreListGetList(Employee.EmployeeId.Value, null, AreaId, ProvinceId, DistrictId, TownId, ShopType, txtShopCode.Text, 1, 100000);
                if (data != null && data.Rows.Count > 0)
                    Pf.Excel(data, "StoreList");
                else
                    Toastr.ErrorToast("Không có dữ liệu");
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast(ex.Message);
            }
        }
        void BindOption()
        {
            Pf.bindAreaDropDown(Employee.EmployeeId.Value, ref ddlArea);
            ddlProvince.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            ddlDistrict.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }
        void Filter(int PageNumber = 1)
        {
            try
            {
                int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
                int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
                int DistrictId = Convert.ToInt32(ddlDistrict.SelectedValue);
                int TownId = Convert.ToInt32(ddlTown.SelectedValue);
                string ShopType = ddlType.SelectedValue;
                DataTable data = new StoreListController().StoreListGetList(Employee.EmployeeId.Value, null, AreaId, ProvinceId, DistrictId, TownId, ShopType, txtShopCode.Text, PageNumber, 20);
                if (data != null && data.Rows.Count > 0)
                {
                    listemployee.Visible = true;
                    plPaging.Visible = true;
                    rpStoreList.DataSource = data;
                    rpStoreList.DataBind();

                    LoadPaging(data);
                }
                else
                {
                    plPaging.Visible = true;
                    listemployee.Visible = false;
                    rpStoreList.DataSource = new DataTable();
                    rpStoreList.DataBind();
                    Toastr.ErrorToast("Không có dữ liệu");
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast(ex.Message);
            }
        }
        private void LoadPaging(DataTable data, int PageNumber = 1, int RowNumber = 20)
        {
            ViewState["PageNumber"] = PageNumber;
            DataTable data_pag = new DataTable();
            data_pag.Columns.Add("PageNumber", typeof(int));
            data_pag.Columns.Add("Active", typeof(string));

            int TotalRows = Convert.ToInt32(data.Rows[0]["TotalRows"]);
            lblFrom.Text = (((PageNumber - 1) * RowNumber) + 1).ToString();
            lblTo.Text = TotalRows > RowNumber ? (PageNumber * RowNumber).ToString() : (RowNumber - (RowNumber - TotalRows)).ToString();
            lblTotalRows.Text = TotalRows.ToString();

            if (TotalRows > RowNumber)
            {
                int TotalPages = Convert.ToInt32(TotalRows / RowNumber);
                ViewState["TotalPages"] = TotalPages;
                for (int i = 1; i <= TotalPages; i++)
                {
                    if (i == PageNumber)
                        _ = data_pag.Rows.Add(i, "paginate_button page-item active");
                    else
                        data_pag.Rows.Add(i, "paginate_button page-item");
                }
            }
            else
                _ = data_pag.Rows.Add(1, "paginate_button page-item active");

            ViewState["DataPaging"] = data_pag;
            rptPaging.DataSource = data_pag;
            rptPaging.DataBind();

        }

        protected void lnkPage_Click(object sender, EventArgs e)
        {
            LinkButton lnk = sender as LinkButton;
            RepeaterItem item = lnk.NamingContainer as RepeaterItem;
            LinkButton lnkPage = item.FindControl("lnkPage") as LinkButton;

            int PageNumber = Convert.ToInt32(lnkPage.Text.Trim());
            int TotalPages = (int)ViewState["TotalPages"];
            DataTable data_pag = ViewState["DataPaging"] as DataTable;
            ViewState["PageNumber"] = PageNumber;
            lnkPrevious.Enabled = lnkNext.Enabled = true;
            if (PageNumber == 1)
                lnkPrevious.Enabled = !lnkPrevious.Enabled;
            else if (PageNumber == TotalPages)
                lnkNext.Enabled = !lnkNext.Enabled;

            Filter(PageNumber);
            LoadPaging(data_pag, PageNumber);
        }

        protected void lnkPrevious_Click(object sender, EventArgs e)
        {
            int PageNumber = (int)ViewState["PageNumber"];
            int Previous = PageNumber == 1 ? 1 : PageNumber - 1;
            lnkPrevious.Enabled = lnkNext.Enabled = true;
            DataTable data_pag = ViewState["DataPaging"] as DataTable;
            if (PageNumber == 1)
                lnkPrevious.Enabled = false;
            Filter(Previous);
            LoadPaging(data_pag, Previous);
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int TotalPages = (int)ViewState["TotalPages"];
            int PageNumber = (int)ViewState["PageNumber"];
            int Next = PageNumber == TotalPages ? TotalPages : PageNumber + 1;
            lnkPrevious.Enabled = lnkNext.Enabled = true;
            DataTable data_pag = ViewState["DataPaging"] as DataTable;
            if (PageNumber == TotalPages)
                lnkNext.Enabled = false;
            Filter(Next);
            LoadPaging(data_pag, Next);
        }

        protected void ddlProvince_SelectedIndexChanged(object sender, EventArgs e)
        {
            int ProvinceId = Convert.ToInt32(ddlProvince.SelectedValue);
            if (ProvinceId < 0) 
            {
                ddlDistrict.Items.Clear();
                ddlTown.Items.Clear();
                ddlDistrict.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, null, ProvinceId, null, null, "DistrictId", "DistrictName", ref ddlDistrict);
        }

        protected void ddlArea_SelectedIndexChanged(object sender, EventArgs e)
        {
            int AreaId = Convert.ToInt32(ddlArea.SelectedValue);
            if (AreaId < 0)
            {
                ddlProvince.Items.Clear();
                ddlDistrict.Items.Clear();
                ddlTown.Items.Clear();
                ddlProvince.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                ddlDistrict.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, AreaId, null, null, null, "ProvinceId", "ProvinceName", ref ddlProvince);
        }

        protected void ddlDistrict_SelectedIndexChanged(object sender, EventArgs e)
        {
            int DistrictId = Convert.ToInt32(ddlDistrict.SelectedValue);
            if (DistrictId < 0)
            {
                ddlTown.Items.Clear();
                ddlTown.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
            }
            else
                Pf.bindAddressDropDown(Employee.EmployeeId.Value, null, null, DistrictId, null, "TownId", "TownName", ref ddlTown);
        }
    }
}