using BLL.Address;
using BLL.StoreList;
using BLL.WorkResults;
using ECS_Web.App_Code;
using OfficeOpenXml;
using System;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace ECS_Web.Popups
{
    public partial class ImportImageAdmin : PagePermisstion
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["WorkId"]) && !string.IsNullOrEmpty(Request.QueryString["KPIId"]))
                {
                    int WorkId = Convert.ToInt32(Request.QueryString["WorkId"]);
                    txtWorkId.Text = Request.QueryString["WorkId"];
                    int KPIId = Convert.ToInt32(Request.QueryString["KPIId"]);
                    ddlKPI.SelectedValue = Request.QueryString["KPIId"];
                    if (ddlKPI.SelectedValue == "3")
                        divInsert.Visible = true;
                    using (DataTable lst = new WorkResultController().WorkResultGetPhotosAdmin(WorkId, KPIId))
                    {
                        if (lst.Rows.Count > 0)
                        {
                            rpt_list_image.DataSource = lst;
                            rpt_list_image.DataBind();
                        }
                        else
                        {
                            rpt_list_image.DataSource = null;
                            rpt_list_image.DataBind();
                        }
                    }
                }
            }
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtImageId.Text))
            {
                Toastr.ErrorToast("Vui lòng nhập ImageId");
                return;
            }
            string root = WebConfigurationManager.AppSettings["SourceUrl"];
            string UrlServices = WebConfigurationManager.AppSettings["UrlServices"];
            DataTable dt_error = new DataTable();
            dt_error.Columns.Add("Message", typeof(string));
            dt_error.Columns.Add("Cell", typeof(string));

            int WorkId = 0; int KPIId = 0; int ImageId = 0;
            string ImageTime = ""; int AuditDate = 0; int ShopId = 0;
            int Type = 0;// Convert.ToInt32(ddlTypeAction.SelectedValue);
            try
            {
                ImageId = Convert.ToInt32(txtImageId.Text);
                WorkId = Convert.ToInt32(txtWorkId.Text);
                KPIId = Convert.ToInt32(ddlKPI.SelectedValue);
                foreach (RepeaterItem item in rpt_list_image.Items)
                {
                    Label lbImageId = (Label)item.FindControl("lbImageId");
                    Label lbShopId = (Label)item.FindControl("lbShopId");
                    Label lbAuditDate = (Label)item.FindControl("lbAuditDate");
                    Label lbImageTime = (Label)item.FindControl("lbImageTime");
                    if (lbImageId.Text == txtImageId.Text)
                    {
                        ImageTime = lbImageTime.Text;
                        AuditDate = Convert.ToInt32(lbAuditDate.Text);
                        ShopId = Convert.ToInt32(lbShopId.Text);
                    }
                }
                if (AuditDate == 0 || ShopId == 0)
                {
                    Toastr.ErrorToast("Lỗi data");
                    return;
                }

                string ImageName = ShopId + "_" + ImageTime.Replace(" ", "").Replace("/", "").Replace(":", "") + "_" + DateTime.Now.ToString("ddMMyyyhhmmss") + ".jpg";
                string LinkImage = UrlServices + "/Upload/BM_Images/" + AuditDate + "/" + ImageName;
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
                        string fullname_image_admin = root + AuditDate + "/" + ImageName;
                        string dir1 = root + AuditDate;
                        if (!System.IO.Directory.Exists(dir1))
                            System.IO.Directory.CreateDirectory(dir1);

                        using (FileStream f = new FileStream(fullname_image_admin, FileMode.OpenOrCreate, FileAccess.ReadWrite))
                        {
                            Bitmap bmap;
                            using (Stream bmpStream = System.IO.File.Open(file.FullName, System.IO.FileMode.Open))
                            {
                                System.Drawing.Image image = System.Drawing.Image.FromStream(bmpStream);
                                bmap = new Bitmap(image);
                            }
                            Graphics graphics = Graphics.FromImage(bmap);
                            SolidBrush brush = new SolidBrush(Color.Red);
                            graphics.DrawString("[" + ShopId + "] " + ImageTime, new Font(FontFamily.GenericSansSerif, 16f, FontStyle.Bold), brush, (float)1f, (float)1f);
                            bmap.Save(f, System.Drawing.Imaging.ImageFormat.Jpeg);
                            bmap.Dispose();
                            graphics.Dispose();
                            f.Flush();
                            f.Close();
                        }
                        using (DataTable dt = new WorkResultController().WorkResultActionImage(Employee.EmployeeId.Value, WorkId, ShopId, AuditDate, KPIId, ImageId, LinkImage,0,null, Type))
                        {
                            try
                            {
                                Toastr.SucessToast(dt.Rows[0]["RowCount"].ToString() + " data đã thực thi!");
                            }
                            catch (Exception exx)
                            {
                                Toastr.ErrorToast("Lỗi:" + exx.Message);
                            }
                        }
                    }
                }
                bind_data();
            }
            catch (Exception ex)
            {
                _ = dt_error.Rows.Add($"Lỗi ghi dữ liệu : {ex.Message}", "");
                Pf.BindGridError(ref error, dt_error, ref rptError);
                Toastr.ErrorToast($"Lỗi : {ex.Message}");
            }
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            bind_data();
        }

        protected void bind_data()
        {
            DataTable dt_error = new DataTable();
            dt_error.Columns.Add("Message", typeof(string));
            dt_error.Columns.Add("Cell", typeof(string));
            try
            {
                error.Visible = false;
                rptError.DataSource = null;
                rptError.DataBind();
                if (string.IsNullOrEmpty(txtWorkId.Text))
                {
                    Toastr.ErrorToast($"Lỗi : Vui lòng nhập WorkId");
                    return;
                }
                int WorkId = Convert.ToInt32(txtWorkId.Text);
                int KPIId = Convert.ToInt32(ddlKPI.SelectedValue);
                using (DataTable lst = new WorkResultController().WorkResultGetPhotosAdmin(WorkId, KPIId))
                {
                    if (lst.Rows.Count > 0)
                    {
                        rpt_list_image.DataSource = lst;
                        rpt_list_image.DataBind();
                    }
                    else
                    {
                        rpt_list_image.DataSource = null;
                        rpt_list_image.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Toastr.ErrorToast(ex.Message);
                _ = dt_error.Rows.Add($"Lỗi ghi dữ liệu : {ex.Message}", "");
                Pf.BindGridError(ref error, dt_error, ref rptError);
            }
        }

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            bind_data();
            if (ddlKPI.SelectedValue == "3")
                divInsert.Visible = true;
        }

        protected void txtWorkId_TextChanged(object sender, EventArgs e)
        {
            bind_data();
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList dds = (DropDownList)sender;
            RepeaterItem rpt = (RepeaterItem)dds.NamingContainer;
            Label lbImageId = (Label)rpt.FindControl("lbImageId");
            Label lbWorkId = (Label)rpt.FindControl("lbWorkId");
            Label lbShopId = (Label)rpt.FindControl("lbShopId");
            Label lbAuditDate = (Label)rpt.FindControl("lbAuditDate");


            using (DataTable dt = new WorkResultController().WorkResultActionImage(Employee.EmployeeId.Value,
                -1, -1, -1, Convert.ToInt32(ddlKPI.SelectedValue), Convert.ToInt32(lbImageId.Text), null,0,null, 2))
            {
                try
                {
                    Toastr.SucessToast(dt.Rows[0]["RowCount"].ToString() + " data đã thực thi!");
                }
                catch (Exception exx)
                {
                    Toastr.ErrorToast("Lỗi:" + exx.Message);
                }
            }
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtItemId.Text))
            {
                Toastr.ErrorToast("Vui lòng nhập ItemId");
                return;
            }
            if (string.IsNullOrEmpty(txtTime.Text))
            {
                Toastr.ErrorToast("Vui lòng nhập Time");
                return;
            }
            string root = WebConfigurationManager.AppSettings["SourceUrl"];
            string UrlServices = WebConfigurationManager.AppSettings["UrlServices"];
            DataTable dt_error = new DataTable();
            dt_error.Columns.Add("Message", typeof(string));
            dt_error.Columns.Add("Cell", typeof(string));

            int WorkId = 0; int KPIId = 0; int ItemId = 0;
            string ImageTime = ""; int AuditDate = 0; int ShopId = 0;
            int Type = 1;// Convert.ToInt32(ddlTypeAction.SelectedValue);
            try
            {
                DateTime dt = DateTime.Parse(txtTime.Text);
                ItemId = Convert.ToInt32(txtItemId.Text);
                WorkId = Convert.ToInt32(txtWorkId.Text);
                KPIId = Convert.ToInt32(ddlKPI.SelectedValue);
                foreach (RepeaterItem item in rpt_list_image.Items)
                {
                    if (AuditDate > 0)
                        break;
                    Label lbShopId = (Label)item.FindControl("lbShopId");
                    Label lbAuditDate = (Label)item.FindControl("lbAuditDate");
                    AuditDate = Convert.ToInt32(lbAuditDate.Text);
                    ShopId = Convert.ToInt32(lbShopId.Text);
                }
                ImageTime = dt.ToString("dd/MM/yyyy HH:mm:ss");

                if (AuditDate == 0 || ShopId == 0)
                {
                    Toastr.ErrorToast("Lỗi data");
                    return;
                }

                string ImageName = ShopId + "_" + ImageTime.Replace(" ", "").Replace("/", "").Replace(":", "") + "_" + DateTime.Now.ToString("ddMMyyyhhmmss") + ".jpg";
                string LinkImage = UrlServices + "/Upload/BM_Images/" + AuditDate + "/" + ImageName;
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
                        string fullname_image_admin = root + AuditDate + "/" + ImageName;
                        string dir1 = root + AuditDate;
                        if (!System.IO.Directory.Exists(dir1))
                            System.IO.Directory.CreateDirectory(dir1);

                        using (FileStream f = new FileStream(fullname_image_admin, FileMode.OpenOrCreate, FileAccess.ReadWrite))
                        {
                            Bitmap bmap;
                            using (Stream bmpStream = System.IO.File.Open(file.FullName, System.IO.FileMode.Open))
                            {
                                System.Drawing.Image image = System.Drawing.Image.FromStream(bmpStream);
                                bmap = new Bitmap(image);
                            }
                            Graphics graphics = Graphics.FromImage(bmap);
                            SolidBrush brush = new SolidBrush(Color.Red);
                            graphics.DrawString("[" + ShopId + "] " + ImageTime, new Font(FontFamily.GenericSansSerif, 16f, FontStyle.Bold), brush, (float)1f, (float)1f);
                            bmap.Save(f, System.Drawing.Imaging.ImageFormat.Jpeg);
                            bmap.Dispose();
                            graphics.Dispose();
                            f.Flush();
                            f.Close();
                        }
                        using (DataTable dt1 = new WorkResultController().WorkResultActionImage(Employee.EmployeeId.Value, WorkId, ShopId, AuditDate, KPIId, 0, LinkImage, ItemId, dt.ToString("yyyy-MM-dd HH:mm:ss"), Type))
                        {
                            try
                            {
                                Toastr.SucessToast(dt1.Rows[0]["RowCount"].ToString() + " data đã thực thi!");
                            }
                            catch (Exception exx)
                            {
                                Toastr.ErrorToast("Lỗi:" + exx.Message);
                            }
                        }
                    }
                }
                bind_data();
            }
            catch (Exception ex)
            {
                _ = dt_error.Rows.Add($"Lỗi ghi dữ liệu : {ex.Message}", "");
                Pf.BindGridError(ref error, dt_error, ref rptError);
                Toastr.ErrorToast($"Lỗi : {ex.Message}");
            }
        }
    }
}