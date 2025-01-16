using BLL.Address;
using BLL.Employees;
using BLL.MasterData;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ECS_Web.App_Code
{
    public class Pf
    {
        public static void bindEmployeeDropDown(int? TypeId, int? EmployeeId, int? ParentId, ref DropDownList ddl)
        {
            DataTable data = new EmployeesController().EmployeesGetList(EmployeeId, ParentId, TypeId);
            if (data != null && data.Rows.Count > 0)
            {
                ddl.DataTextField = "EmployeeName";
                ddl.DataValueField = "EmployeeId";
                ddl.DataSource = data;
                ddl.DataBind();
            }
            ddl.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }
        public static void bindEmployeeDropDownGuest(int LoginId, int CycleId, int? TypeId, int? EmployeeId, int? ParentId, ref DropDownList ddl)
        {
            DataTable data = new EmployeesController().bindEmployeeDropDownGuest(LoginId, CycleId, EmployeeId, ParentId, TypeId);
            if (data != null && data.Rows.Count > 0)
            {
                ddl.DataTextField = "EmployeeName";
                ddl.DataValueField = "EmployeeId";
                ddl.DataSource = data;
                ddl.DataBind();
            }
            ddl.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }
        public static void bindEmployeeTypeDropDown(ref DropDownList ddl)
        {
            DataTable data = new EmployeesController().EmployeeTypeGetList();
            if (data != null && data.Rows.Count > 0)
            {
                ddl.DataTextField = "TypeName";
                ddl.DataValueField = "EmployeeTypeId";
                ddl.DataSource = data;
                ddl.DataBind();
            }
            ddl.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }
        public static void bindAreaDropDown(int UserId, ref DropDownList ddl)
        {
            DataTable data = new AddressController().AreaGetList(UserId);
            if (data != null && data.Rows.Count > 0)
            {
                ddl.DataTextField = "AreaName";
                ddl.DataValueField = "AreaId";
                ddl.DataSource = data;
                ddl.DataBind();
            }
            ddl.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }
        public static void bindCycleDropDown(int UserId, int Year, int? Month, ref DropDownList ddl)
        {
            using (DataTable data = new MasterDataController().CycleGetList(UserId, Year, Month))
            {
                string value_select = null;
                if (data != null && data.Rows.Count > 0)
                {

                    var _data = data.AsEnumerable().Select(x => new
                    {
                        Value = $"{x["CycleId"]}_{x["Month"]}_{x["Year"]}_{x["FromDate"]}_{x["ToDate"]}",
                        Text = $"{x["Name"]} -> ({x["FromDate"]} - {x["ToDate"]})"
                    }).ToList();

                    ddl.DataTextField = "Text";
                    ddl.DataValueField = "Value";
                    ddl.DataSource = _data;
                    ddl.DataBind();
                    if (Month != null)
                    {
                        value_select = (from myRow in data.AsEnumerable()
                                        where myRow.Field<int>("Year") == Year && myRow.Field<int>("Month") == Month
                                        select new { values = $"{myRow["CycleId"]}_{myRow["Month"]}_{myRow["Year"]}_{myRow["FromDate"]}_{myRow["ToDate"]}" }).FirstOrDefault().values;
                    }

                }
                ddl.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                if (!string.IsNullOrEmpty(value_select))
                    ddl.SelectedValue = value_select;

            }
        }
        public static void bindCycleDropDown_Customer(int UserId, int Year, int? Month, ref DropDownList ddl)
        {
            using (DataTable data = new MasterDataController().CycleGetList(UserId, Year, Month))
            {
                string value_select = null;
                if (data != null && data.Rows.Count > 0)
                {

                    var _data = data.AsEnumerable().Select(x => new
                    {
                        Value = $"{x["CycleId"]}_{x["Month"]}_{x["Year"]}_{x["FromDate"]}_{x["ToDate"]}",
                        Text = $"{x["Name"]}/{x["Year"]}"
                    }).ToList();

                    ddl.DataTextField = "Text";
                    ddl.DataValueField = "Value";
                    ddl.DataSource = _data;
                    ddl.DataBind();
                    if (Month != null)
                    {
                        value_select = (from myRow in data.AsEnumerable()
                                        where myRow.Field<int>("Year") == Year && myRow.Field<int>("Month") == Month
                                        select new { values = $"{myRow["CycleId"]}_{myRow["Month"]}_{myRow["Year"]}_{myRow["FromDate"]}_{myRow["ToDate"]}" }).FirstOrDefault().values;
                    }

                }
                ddl.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
                if (!string.IsNullOrEmpty(value_select))
                    ddl.SelectedValue = value_select;

            }
        }
        public static void bindAddressDropDown(int UserId, int? AreaId, int? ProvinceId, int? DistrictId, int? TownId, string Value, string Text, ref DropDownList ddl)
        {
            DataTable data = new AddressController().AddressGetList(UserId, AreaId, ProvinceId, DistrictId, TownId);
            var data_tmp = data.AsEnumerable().Select(x => new { Value = x[Value], Text = x[Text] }).Distinct().ToList();
            if (data != null && data.Rows.Count > 0)
            {
                ddl.DataTextField = "Text";
                ddl.DataValueField = "Value";
                ddl.DataSource = data_tmp;
                ddl.DataBind();
            }
            ddl.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }
        public static void bindMasterDropDown(string ListCode, ref DropDownList ddl)
        {
            DataTable data = new MasterDataController().MasterDataGetList(ListCode);
            if (data != null && data.Rows.Count > 0)
            {
                if (ListCode.ToUpper() == "AUDITRESULT")
                    data.Rows.RemoveAt(0);
                ddl.DataTextField = "Name.vi-VN";
                ddl.DataValueField = "Id";
                ddl.DataSource = data;
                ddl.DataBind();
            }

            ddl.Items.Insert(0, new ListItem("-Tất cả-", "-1"));
        }
        public static int DateStringToInt(string date)
        {
            int _value = 0;
            try
            {
                _value = Convert.ToInt32(date.Replace("-", ""));
            }
            catch (Exception)
            {
            }
            return _value;
        }
        public static string DateIntToString(int date, string format)
        {
            string _value = "";
            try
            {
                _value = DateTime.ParseExact(date + "", "yyyyMMdd", null).ToString(format);
            }
            catch (Exception)
            {
            }
            return _value;
        }
        public static DateTime DateIntToDate(int date)
        {
            DateTime _value = new DateTime();
            try
            {
                _value = DateTime.ParseExact(date + "", "yyyyMMdd", null);
            }
            catch (Exception)
            {
            }
            return _value;
        }
        public static string GetIPAddress()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                string[] addresses = ipAddress.Split(',');
                if (addresses.Length != 0)
                {
                    return addresses[0];
                }
            }

            return context.Request.ServerVariables["REMOTE_ADDR"];
        }
        public static void Excel(DataTable dt, string name)
        {
            if (dt != null && dt.Rows.Count > 0)
            {
                string path = HttpContext.Current.Request.Url.AbsolutePath;

                HttpContext.Current.Session.RemoveAll();
                string UUID = Guid.NewGuid().ToString();
                HttpContext.Current.Session[UUID] = dt;

                HttpContext.Current.Response.Write("<script>");
                HttpContext.Current.Response.Write(string.Format("window.open('/ExcelExport/Default.aspx?name={0}&path={1}&UUID={2}','_blank')", name, path, UUID));
                HttpContext.Current.Response.Write("</script>");
            }
        }
        public static void Excel(DataTable dt, string name, bool result)
        {
            if (dt != null && dt.Rows.Count > 0)
            {
                //var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
                //var stringChars = new char[8];
                //var random = new Random();
                //for (int i = 0; i < stringChars.Length; i++)
                //{
                //    stringChars[i] = chars[random.Next(chars.Length)];
                //}
                //var finalString = new String(stringChars);
                string time = DateTime.Now.ToString("yyyyMMddHHmmss");
                //name = name.Replace(" ", "_");
                string fileName = string.Format("{0} ({1})", name, time);// name + "_" + finalString;

                using (ExcelPackage xp = new ExcelPackage())
                {
                    ExcelWorksheet ws = xp.Workbook.Worksheets.Add("Sheet1");

                    int rowstart = 1;
                    int colstart = 1;
                    int rowend = rowstart;
                    int colend = colstart + dt.Columns.Count - 1;

                    //ws.Cells[rowstart, colstart, rowend, colend].Merge = true;
                    //ws.Cells[rowstart, colstart, rowend, colend].Value = name;
                    ws.Cells[rowstart, colstart, rowend, colend].Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                    ws.Cells[rowstart, colstart, rowend, colend].Style.Font.Bold = true;
                    ws.Cells[rowstart, colstart, rowend, colend].Style.Fill.PatternType = OfficeOpenXml.Style.ExcelFillStyle.Solid;
                    ws.Cells[rowstart, colstart, rowend, colend].Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.White);

                    //rowstart += 1;
                    rowend = rowstart + dt.Rows.Count;
                    ws.Cells[rowstart, colstart].LoadFromDataTable(dt, true);

                    int i = 1;
                    foreach (DataColumn dc in dt.Columns)
                    {
                        i++;
                        if (dc.DataType == typeof(decimal))
                            ws.Column(i).Style.Numberformat.Format = "#,##0.00;(#,##0.00)";
                    }
                    ws.Cells[ws.Dimension.Address].AutoFitColumns();

                    ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Top.Style =
                       ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Bottom.Style =
                       ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Left.Style =
                       ws.Cells[rowstart, colstart, rowend, colend].Style.Border.Right.Style = OfficeOpenXml.Style.ExcelBorderStyle.Thin;

                    HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xlsx");
                    HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    HttpContext.Current.Response.BinaryWrite(xp.GetAsByteArray());
                    HttpContext.Current.Response.End();
                }
            }
        }
        public static void ExcelByExcelPackage(ExcelPackage excelPackage, string name)
        {
            if (excelPackage != null)
            {
                string path = HttpContext.Current.Request.Url.AbsolutePath;
                string UUID = Guid.NewGuid().ToString();
                HttpContext.Current.Session[UUID] = excelPackage.GetAsByteArray();

                HttpContext.Current.Response.Write("<script>");
                HttpContext.Current.Response.Write(string.Format("window.open('/ExcelExport/Default.aspx?type=ExcelPackage&name={0}&path={1}&UUID={2}','_blank')", name, path, UUID));
                HttpContext.Current.Response.Write("</script>");
            }
        }
        public static void AddHeaderAutoDownloadFileExel(string Filepath, ExcelPackage excelPackage)
        {
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + Filepath + ".xlsx");
            HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            HttpContext.Current.Response.BinaryWrite(excelPackage.GetAsByteArray());
            HttpContext.Current.Response.End();
        }
        public static void border(ExcelWorksheet sheet, int rowstart, int rowsend, int colstart, int colend, string BackgroundColor, string FontColor)
        {
            try
            {
                ExcelRange ex = sheet.Cells[rowstart, colstart, rowsend, colend];
                ex.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                ex.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                ex.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                ex.Style.Border.Top.Style = ExcelBorderStyle.Thin;

                if (!string.IsNullOrEmpty(BackgroundColor))
                {
                    ex.Style.Fill.PatternType = ExcelFillStyle.Solid;
                    ex.Style.Fill.BackgroundColor.SetColor(ColorTranslator.FromHtml(BackgroundColor));
                }
                if (!string.IsNullOrEmpty(FontColor))
                    ex.Style.Font.Color.SetColor(ColorTranslator.FromHtml(FontColor));

            }
            catch
            { }
        }
        public static void merge(ExcelWorksheet sheet, int rowstart, int rowsend, int colstart, int colend)
        {
            try
            {
                ExcelRange ex = sheet.Cells[rowstart, colstart, rowsend, colend];
                ex.Style.Fill.PatternType = ExcelFillStyle.Solid;
                ex.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                ex.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                ex.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                ex.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                ex.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                ex.Style.Fill.BackgroundColor.SetColor(Color.White);
                ex.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                ex.Style.Font.Color.SetColor(Color.Black);
                ex.Style.Font.Bold = true;

                ex.Merge = true;
            }
            catch
            { }
        }
        public static void merge(ExcelWorksheet sheet, int rowstart, int rowsend, int colstart, int colend, string BackgroundColor, string FontColor)
        {
            try
            {
                ExcelRange ex = sheet.Cells[rowstart, colstart, rowsend, colend];
                ex.Style.Fill.PatternType = ExcelFillStyle.Solid;
                ex.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                ex.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                ex.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                ex.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                ex.Style.HorizontalAlignment = ExcelHorizontalAlignment.Center;

                ex.Style.Fill.BackgroundColor.SetColor(ColorTranslator.FromHtml(BackgroundColor));
                ex.Style.VerticalAlignment = ExcelVerticalAlignment.Center;
                ex.Style.Font.Color.SetColor(ColorTranslator.FromHtml(FontColor));
                ex.Style.Font.Bold = true;

                ex.Merge = true;
            }
            catch
            { }
        }
        public static bool IsValidMail(string emailaddress)
        {
            try
            {
                MailAddress m = new MailAddress(emailaddress);
                return true;
            }
            catch (FormatException)
            {
                return false;
            }
        }
        public static bool ValidateEmail(string email)
        {
            Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            Match match = regex.Match(email);
            bool result = false;
            if (match.Success)
                result = !result;
            return result;
        }
        public static void BindGridError(ref HtmlGenericControl pnl, DataTable data, ref Repeater rptError)
        {
            pnl.Visible = true;
            rptError.DataSource = data;
            rptError.DataBind();
        }
        public static int ConvertPercent(int Target, int Actual)
        {
            int result = 0;
            try
            {
                result = (int)Math.Round((double)(100 * (double)Actual) / (double)Target);
            }
            catch (Exception)
            {
            }
            return result;
        }
    }
}