using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ECS_Web.Report
{
    public partial class Attendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            //DataTable dt = new DataTable();
            //dt.Columns.Add("STT", typeof(int));
            //dt.Columns.Add("EmployeeName", typeof(string));
            //dt.Columns.Add("ShopName", typeof(string));
            //dt.Columns.Add("ShopAddress", typeof(string));
            //dt.Columns.Add("SellDate", typeof(string));
            //dt.Columns.Add("ManagerName", typeof(string));
            //dt.Columns.Add("VisitResult", typeof(string));
            //dt.Columns.Add("TiepCanTC", typeof(int));
            //dt.Columns.Add("VisitType", typeof(string));

            //for (int i = 1; i <= 10; i++)
            //{
            //    DataRow dr = dt.NewRow();
            //    dr["STT"] = i;
            //    dr["EmployeeName"] = "Nhân viên " + i.ToString();
            //    dr["ShopName"] = "ShopName	 " + i.ToString();
            //    dr["ShopAddress"] = "175 Hòa Bình, Phường Hiệp Tân, Quận tân Phú, TP.HCM	 " + i.ToString();
            //    dr["SellDate"] = "16/12/2022";
            //    dr["ManagerName"] = "Quản lý " + i.ToString();
            //    dr["VisitResult"] = i == 3 ? "KTC - Đóng cửa do Covid" : "Thành công";
            //    dr["TiepCanTC"] = "4";
            //    dr["VisitType"] = i == 1 ? "Mở mới cửa hàng" : "Chăm sóc cửa hàng";
            //    dt.Rows.Add(dr);
            //}
            //gvSellOut.DataSource = dt;
            //gvSellOut.DataBind();

            //gvSellOut.Rows[0].FindControl("imgNew").Visible = true;

            //Toastr.SucessToast("Thành công");
        }

        protected void btnExport1111_Click(object sender, EventArgs e)
        {

        }
    }
}