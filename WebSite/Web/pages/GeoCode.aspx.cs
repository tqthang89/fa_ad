using BLL.WorkResults;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Threading;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.pages
{
    public partial class GeoCode : PagePermisstion
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [DataContract]
        public class Address
        {
            [DataMember]
            public string road { get; set; }
            [DataMember]
            public string suburb { get; set; }
            [DataMember]
            public string city { get; set; }
            [DataMember]
            public string state_district { get; set; }
            [DataMember]
            public string state { get; set; }
            [DataMember]
            public string postcode { get; set; }
            [DataMember]
            public string country { get; set; }
            [DataMember]
            public string country_code { get; set; }
        }
        [DataContract]
        public class RootObject
        {
            [DataMember]
            public string place_id { get; set; }
            [DataMember]
            public string licence { get; set; }
            [DataMember]
            public string osm_type { get; set; }
            [DataMember]
            public string osm_id { get; set; }
            [DataMember]
            public string lat { get; set; }
            [DataMember]
            public string lon { get; set; }
            [DataMember]
            public string display_name { get; set; }
            [DataMember]
            public Address address { get; set; }
        }
        public static bool AcceptAllCertifications(object sender, System.Security.Cryptography.X509Certificates.X509Certificate certification, System.Security.Cryptography.X509Certificates.X509Chain chain, System.Net.Security.SslPolicyErrors sslPolicyErrors)
        {
            return true;
        }
        public static RootObject getAddress(string lat, string lon)
        {
            ServicePointManager.Expect100Continue = true;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            ServicePointManager.ServerCertificateValidationCallback = new System.Net.Security.RemoteCertificateValidationCallback(AcceptAllCertifications);
            WebClient webClient = new WebClient();
            webClient.Headers.Add("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");
            webClient.Headers.Add("Referer", "https://www.microsoft.com");
            var jsonData = webClient.DownloadData("https://nominatim.openstreetmap.org/reverse?format=json&lat=" + lat + "&lon=" + lon);
            DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(RootObject));
            RootObject rootObject = (RootObject)ser.ReadObject(new MemoryStream(jsonData));
            return rootObject;
        }

        protected void btnFilterITQuery_Click(object sender, EventArgs e)
        {
            try
            {
                string txt = txtAuditDate.Text;
                string[] lst = txt.Split(new Char[] { '\n', '\r' }, StringSplitOptions.RemoveEmptyEntries);
                if(lst.Count() > 100)
                {
                    Toastr.ErrorToast("Số lượng tọa độ vui lòng không quá 100");
                    return;
                }    

                DataTable dt = new DataTable();
                dt.Columns.Add("RN", typeof(int));
                dt.Columns.Add("Lat", typeof(string));
                dt.Columns.Add("Long", typeof(string));
                dt.Columns.Add("Address", typeof(string));

                int index = 1;
                foreach (string item in lst)
                {
                    string[] location = item.Split(new Char[] { '\t', '\r' }, StringSplitOptions.RemoveEmptyEntries); ;// item.Split(' ');
                    string lat = location[0];
                    string lon = location[1];

                    RootObject rootObject = getAddress(lat, lon);

                    DataRow dr = dt.NewRow();
                    dr["RN"] = index;
                    dr["Lat"] = lat;
                    dr["Long"] = lon;
                    dr["Address"] = rootObject.display_name;// new JavaScriptSerializer().Serialize(rootObject);

                    dt.Rows.Add(dr); index++;
                    Thread.Sleep(500);
                }
                rptITSupport.DataSource = dt;
                rptITSupport.DataBind();

            }
            catch (Exception ex)
            {
                Toastr.SucessToast(ex.Message);
            }

        }

        protected void lbITQuery_Click(object sender, EventArgs e)
        {

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int ShopId = 0;
            if (!string.IsNullOrEmpty(txtShopId.Text))
                ShopId = Convert.ToInt32(txtShopId.Text);
            else
            {
                Toastr.ErrorToast("Vui lòng nhập ShopId");
                return;
            }
            int EmployeeId = 0;
            if (!string.IsNullOrEmpty(txtEmployeeId.Text))
                EmployeeId = Convert.ToInt32(txtEmployeeId.Text);
            else
            {
                Toastr.ErrorToast("Vui lòng nhập EmployeeId");
                return;
            }

            int AuditDate = 0;
            if (!string.IsNullOrEmpty(txtAuditDate.Text))
                AuditDate = Convert.ToInt32(txtAuditDate.Text);
            else
            {
                Toastr.ErrorToast("Vui lòng nhập AuditDate");
                return;
            }
            int TypeId = Convert.ToInt32(ddlTypeITSupport.SelectedValue);

            using (DataTable dt = new WorkResultController().ToolsIT(Employee.EmployeeId.Value, ShopId, EmployeeId, AuditDate, TypeId, 0))
            {
                rptITSupport.DataSource = dt;
                rptITSupport.DataBind();
            }
        }
    }
}