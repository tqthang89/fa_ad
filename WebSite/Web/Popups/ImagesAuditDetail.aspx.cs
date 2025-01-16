using BLL.WorkResults;
using System;
using System.Data;
using System.Linq;
using System.Web.UI;

namespace ECS_Web.Popups
{
    public partial class ImagesAuditDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["rotate"] = 0;
                if (Request.QueryString["WorkId"] != null && Convert.ToString(Request.QueryString["KPIId"]) == "0")
                    bind_image(Request.QueryString["src1"]);
                else
                    bind_image();
            }
        }

        protected void bind_image(string linkimage)
        {
            ViewState["linkimage"] = linkimage; ViewState["rotate"] = 0;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "addlink", "<script> $(function () {$('select').chosen();$('select').chosen({ allow_single_deselect: true }); $('#yourImageID1').attr('src', '" + linkimage + "');});jQuery(function ($) {$('#yourImageID1').smoothZoom({width: 790,height: 591,responsive: false,responsive_maintain_ratio: true,max_WIDTH: '',max_HEIGHT: ''});});</script>", false);
        }
        protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
        {
            if (lbfrom1.Text == "1")
                return;

            lbfrom1.Text = (Convert.ToInt32(lbfrom1.Text) - 1).ToString();
            if (ViewState["dt_src"] != null)
            {
                DataTable dt = (DataTable)ViewState["dt_src"]; ;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (i == (Convert.ToInt32(lbfrom1.Text) - 1))
                    { 
                        bind_image(Convert.ToString(dt.Rows[i]["ImagePath"]));
                        ddlPage.SelectedIndex = i;
                    }
                }
            }
        }
        protected void ImageButton5_Click(object sender, ImageClickEventArgs e)
        {
            if (lbfrom1.Text == lbto1.Text)
                return;
            lbfrom1.Text = (Convert.ToInt32(lbfrom1.Text) + 1).ToString();
            if (ViewState["dt_src"] != null)
            {
                DataTable dt = (DataTable)ViewState["dt_src"];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (i == (Convert.ToInt32(lbfrom1.Text) - 1))
                    {
                        bind_image(Convert.ToString(dt.Rows[i]["ImagePath"]));
                        ddlPage.SelectedIndex = i;
                    }
                }
            }
        }
        private long? _WorkId = null;
        public long WorkId
        {
            get
            {
                if (!string.IsNullOrEmpty(Request.QueryString["WorkId"]) && _WorkId == null)
                    _WorkId = Convert.ToInt64(Request.QueryString["WorkId"]);
                return _WorkId.Value;
            }
            set
            {
                _WorkId = value;
            }
        }


        protected string bind_image()
        {
            string html = null;
            try
            {
                long WorkId = !string.IsNullOrEmpty(Convert.ToString(Request["WorkId"])) ? Convert.ToInt64(Request["WorkId"]) : 0;
                int? KPIId = !string.IsNullOrEmpty(Convert.ToString(Request["KPIId"])) ? Convert.ToInt32(Request["KPIId"]) : 0;
                using (DataTable lst = new WorkResultController().WorkResultGetPhotos(WorkId, KPIId))
                {
                    
                    if (lst.Rows.Count > 0)
                    {
                        ddlPage.DataSource = lst;
                        ddlPage.DataBind();
                        lbto1.Text = lst.Rows.Count.ToString();
                        for (int i = 0; i < lst.Rows.Count; i++)
                        {
                            if (Convert.ToString(lst.Rows[i]["ImagePath"]) == Request.QueryString["src1"])
                            {
                                lbfrom1.Text = (i + 1).ToString();
                                ViewState["linkimage"] = Convert.ToString(lst.Rows[i]["ImagePath"]);
                            }
                        }
                        ViewState["dt_src"] = lst;
                        ddlPage.SelectedValue = Request.QueryString["src1"];
                    }
                    else
                    {
                        ddlPage.DataSource = null;
                        ddlPage.DataBind();
                        html += "<li><img src='/images/noimages.jpg' style=\"width:550px;height:330px;\"  alt='0' /></li>";
                    }
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return html;
        }

        protected void ddlPage_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ViewState["dt_src"] != null)
            {
                DataTable dt = (DataTable)ViewState["dt_src"];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (i == (Convert.ToInt32(ddlPage.SelectedIndex)))
                    {
                        bind_image(Convert.ToString(dt.Rows[i]["ImagePath"]));
                        lbfrom1.Text = (ddlPage.SelectedIndex + 1).ToString();
                    }
                }
            }
        }
        
        protected void img_left_Click(object sender, ImageClickEventArgs e)
        {
            int rotate = (int)ViewState["rotate"];
            if (rotate == 0) rotate = 270;
            else rotate = rotate - 90;
            ViewState["rotate"] = rotate;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "addlink", "<script> $(function () {$('select').chosen();$('select').chosen({ allow_single_deselect: true }); $('#yourImageID1').attr('src', '" + "RotateHandler.ashx?Path=" + ViewState["linkimage"] + "&angle=" + rotate + "');});jQuery(function ($) {$('#yourImageID1').smoothZoom({width: 790,height: 591,responsive: false,responsive_maintain_ratio: true,max_WIDTH: '',max_HEIGHT: ''});});</script>", false);
        }

        protected void img_right_Click(object sender, ImageClickEventArgs e)
        {
            int rotate = (int)ViewState["rotate"];
            if (rotate == 270) rotate = 0;
            else rotate = rotate + 90;
            ViewState["rotate"] = rotate;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "addlink", "<script> $(function () {$('select').chosen();$('select').chosen({ allow_single_deselect: true }); $('#yourImageID1').attr('src', '" + "RotateHandler.ashx?Path=" + ViewState["linkimage"] + "&angle=" + rotate + "');});jQuery(function ($) {$('#yourImageID1').smoothZoom({width: 790,height: 591,responsive: false,responsive_maintain_ratio: true,max_WIDTH: '',max_HEIGHT: ''});});</script>", false);
        }
    }
}