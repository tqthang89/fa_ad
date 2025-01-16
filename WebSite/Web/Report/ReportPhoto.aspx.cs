using BLL.WorkResults;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.Report
{
    public partial class ReportPhoto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                long WorkId = !string.IsNullOrEmpty(Convert.ToString(Request.QueryString["WorkId"])) ? Convert.ToInt64(Request.QueryString["WorkId"]) : 0;
                int KPIId = !string.IsNullOrEmpty(Convert.ToString(Request.QueryString["KPIId"])) ? Convert.ToInt32(Request.QueryString["KPIId"]) : 0;
                ltrSlider.Text = getPhoto(WorkId, KPIId);
            }
        }
        public class KPIsInfo
        {
            public string LinkPhoto { get; set; }
            public string PhotoType { get; set; }
            public KPIsInfo(string _LinkPhoto, string _PhotoType)
            {
                this.LinkPhoto = _LinkPhoto;
                this.PhotoType = _PhotoType;
            }
        }
        private string getPhoto(long WorkId, int KPIId)
        {
            IDbConnection conn = null;
            StringBuilder sb = new StringBuilder();
            try
            {
                int order = 0;
                bool? fl = false;
                // photo display
                sb.Append("<div id=\"gallery\" class=\"ad-gallery\">");
                sb.Append("<div class=\"ad-image-wrapper\">");
                sb.Append("</div>");
                sb.Append("<div class=\"ad-controls\">");
                sb.Append("</div>");
                sb.Append("<div class=\"ad-nav\">");
                sb.Append("<div class=\"ad-thumbs\">");
                sb.Append("<ul class=\"ad-thumb-list\">");

                // photo attendace
                DataTable lstAtt = new WorkResultController().WorkResultGetPhotos(WorkId, KPIId);

                if (lstAtt != null && lstAtt.Rows.Count > 0)
                {
                    //string objectphoto = JsonConvert.SerializeObject(lstAtt);
                    //Cache.Add(AuditID, lstAtt);
                    fl = true;
                    for (int i = 0; i < lstAtt.Rows.Count; i++)
                    {
                        sb.Append($"<li><a href=\"{Convert.ToString(lstAtt.Rows[i]["ImagePath"])}\"" +
                            $"ondblclick=\"return openNewImage('{Convert.ToString(lstAtt.Rows[i]["ImagePath"])}','{WorkId }', '{KPIId}')\"><img src=\"" + 
                            Convert.ToString(lstAtt.Rows[i]["ImagePath"]) + "\" alt=\"" + Convert.ToString(lstAtt.Rows[i]["Desc"]) + "\" " +
                            $"class=\"image{i + order}\" height=\"65\" width=\"65\"/></a></li>"
                            );

                    }
                    order += lstAtt.Rows.Count;
                }

                if (fl == false)
                {
                    sb.Append("<li><a href=\"../Images/noimages.jpg\"><img src='../Images/noimage_slider.jpg' height=\"65\" width=\"65\"/></a></li>");
                }

                sb.Append("</ul>");
                sb.Append("</div>");
                sb.Append("</div>");
                sb.Append("</div>");
                sb.Append("<div id=\"descriptions\">");
                sb.Append("</div>");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                    conn.Dispose();
                }
            }

            return sb.ToString();
        }
    }
}