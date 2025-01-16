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
    public partial class ReportPhotoPXN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ltrSlider.Text = getPhoto("1");
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
        private string getPhoto(string AuditID)
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
                List<KPIsInfo> lstAtt = new List<KPIsInfo>();// KPIsController().getPhoto(Convert.ToInt64(AuditID), null, ref conn);
                lstAtt.Add(new KPIsInfo("../images/product.jpg", "Chụp ảnh khách hàng đang ký phiếu"));
                lstAtt.Add(new KPIsInfo("../images/product.jpg", "Chụp ảnh PXN có chữ ký KH"));
                if (lstAtt != null && lstAtt.Count > 0)
                {
                    //string objectphoto = JsonConvert.SerializeObject(lstAtt);
                    //Cache.Add(AuditID, lstAtt);
                    fl = true;
                    for (int i = 0; i < lstAtt.Count; i++)
                    {
                        sb.Append("<li><a href=\"" + lstAtt[i].LinkPhoto + "\" ondblclick=\"return openNewImage('" + lstAtt[i].LinkPhoto + "','" + AuditID + "')\"><img src=\"" + lstAtt[i].LinkPhoto + "\" alt=\"" + lstAtt[i].PhotoType + "\" class=\"image" + (i + order).ToString() + "\" height=\"65\" width=\"65\"/></a></li>");

                    }
                    order += lstAtt.Count;
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