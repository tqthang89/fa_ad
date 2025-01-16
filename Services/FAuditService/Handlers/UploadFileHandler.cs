using FAuditService.BLL;
using FAuditService.Core;
using FAuditService.Entities;
using FAuditService.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

namespace FAuditService.Handlers
{
    public class UploadFileHandler : AuthorizationHandler
    {

        public override HttpResponseMessage AuthorizationRequest()
        {

            int EmployeeId = Employee.EmployeeId;
            String FUNCTION = new FieldRequest("FUNCTION");
            String UrlServices = System.Configuration.ConfigurationManager.AppSettings["UrlServices"];
            if ("ATTENDANT".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase) || "PHOTO".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    DateTime? ImageTime = new FieldRequest("ImageTime") { Format = "MM/dd/yyyy HH:mm:ss" };
                    int? ShopId = new FieldRequest("ShopId");
                    string ImageName = new FieldRequest("ImageName");
                    string dir = Context.Server.MapPath("~/Upload");

                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, "Images");
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, ImageTime.Value.ToString("yyyyMMdd"));
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);

                    if (Context.Request.Files.Count > 0)
                    {
                        var file = Context.Request.Files[0];
                        ImageName = EmployeeId + "_" + ImageName.Replace(".product", ".jpeg").Replace(".query", ".jpeg");
                        if (file != null)
                        {
                            if (file.ContentLength > 0)
                            {
                                var filename = System.IO.Path.Combine(dir, ImageName);
                                using (FileStream f = new FileStream(filename, FileMode.OpenOrCreate, FileAccess.ReadWrite))
                                {
                                    Bitmap bmap = new Bitmap(file.InputStream);
                                    Graphics graphics = Graphics.FromImage(bmap);
                                    SolidBrush brush = new SolidBrush(Color.Red);
                                    graphics.DrawString("[" + ShopId.Value + "] " + ImageTime.Value.ToString("dd/MM/yyyy HH:mm:ss"), new Font(FontFamily.GenericSansSerif, 16f, FontStyle.Bold), brush, (float)1f, (float)1f);
                                    bmap.Save(f, System.Drawing.Imaging.ImageFormat.Jpeg);
                                    bmap.Dispose();
                                    graphics.Dispose();
                                    f.Flush();
                                    f.Close();
                                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Tải ảnh thành công !");
                                }
                            }
                            else
                            {
                                Logs.w(EmployeeId.ToString(), ShopId + "", ImageName + "' file empty.", 500);
                                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");

                            }
                        }
                        else
                        {
                            Logs.w(EmployeeId.ToString(), ShopId + "", ImageName + "' not found.", 500);
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File not found !");

                        }
                    }
                    else
                    {
                        Logs.w(EmployeeId.ToString(), ShopId + "", ImageName + "' not found.", 590);
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File not found !");
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);

                }

            }
            if ("AUDIO".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    string AudioName = new FieldRequest("AudioName");
                    string dir = Context.Server.MapPath("~/Upload");

                    //if (!System.IO.Directory.Exists(dir))
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, "Audios");
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);

                    if (Context.Request.Files.Count > 0)
                    {
                        AudioName = EmployeeId + "_" + AudioName;
                        var file = Context.Request.Files[0];
                        if (file != null && file.ContentLength > 0)
                        {
                            file.SaveAs(dir + "/" + AudioName);
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Tải file thành công !");
                        }
                        else
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                        }
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }

            }

            if ("PHOTO_SHOP".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    string ImageName = new FieldRequest("ImageName");
                    string dir = Context.Server.MapPath("~/Upload");
                    DateTime? ImageTime = new FieldRequest("ImageTime") { Format = "MM/dd/yyyy HH:mm:ss" };
                    if (!System.IO.Directory.Exists(dir))
                        if (!System.IO.Directory.Exists(dir))
                            System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, "ShopImages");
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);

                    dir = Path.Combine(dir, ImageTime.Value.ToString("yyyyMMdd"));
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);


                    if (Context.Request.Files.Count > 0)
                    {
                        ImageName = EmployeeId + "_" + ImageName;
                        var file = Context.Request.Files[0];
                        if (file != null && file.ContentLength > 0)
                        {
                            file.SaveAs(dir + "/" + ImageName);
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, UrlServices + "/Upload/ShopImages/" + ImageTime.Value.ToString("yyyyMMdd") + "/" + ImageName);
                        }
                        else
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                        }
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }
            }
            if ("PHOTO_APPLE".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    int? AttendanceType = new FieldRequest("AttendanceType");
                    int? ShopId = new FieldRequest("ShopId");

                    double? latitude = new FieldRequest("latitude");
                    double? longitude = new FieldRequest("longitude");
                    string Address = new FieldRequest("Address");

                    string ImageName = DateTime.Now.ToString("yyyyMMddHHmmss") + ".jpeg";
                    string dir = Context.Server.MapPath("~/Upload");
                    DateTime ImageTime = DateTime.Now;
                    if (!System.IO.Directory.Exists(dir))
                        if (!System.IO.Directory.Exists(dir))
                            System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, "ShopImages");
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);

                    dir = Path.Combine(dir, ImageTime.ToString("yyyyMMdd"));
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);


                    if (Context.Request.Files.Count > 0)
                    {
                        ImageName = EmployeeId + "_" + ImageName;
                        var file = Context.Request.Files[0];
                        if (file != null && file.ContentLength > 0)
                        {
                            file.SaveAs(dir + "/" + ImageName);
                            string pto = UrlServices + "/Upload/ShopImages/" + ImageTime.ToString("yyyyMMdd") + "/" + ImageName;
                            using (DataSet ds = WorkController.Attendance_Apple_Action(EmployeeId, ShopId.Value, AttendanceType.Value, latitude, longitude, Address, pto, 1))
                            {

                            }
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, pto);
                        }
                        else
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                        }
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }
            }
            if ("GET_PHOTO_APPLE".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    int? ShopId = new FieldRequest("ShopId");
                    
                    using (DataSet ds = WorkController.Attendance_Apple_Action(EmployeeId, ShopId.Value, 1, null, null, null, null, 2))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, ds.Tables[0]);
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }
            }
            if ("APPLE_EMPLOYEE".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    string Email = new FieldRequest("Email");
                    string PassWord = new FieldRequest("PassWord");
                    string OTP = new FieldRequest("OTP");//1: Create or Save; 2:Send OTP;3:Delete Account
                    int? ActionType = new FieldRequest("ActionType");
                    if (!string.IsNullOrEmpty(PassWord))
                        PassWord = SecurityUtils.Encrypt(PassWord);

                    string[] saAllowedCharacters = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" };
                    string sRandomOTP = GenerateRandomOTP(6, saAllowedCharacters);
                    if (ActionType.Value == 3)
                        OTP = sRandomOTP;

                    using (DataSet ds = WorkController.Employee_Apple_Action(Email, PassWord,OTP,ActionType.Value))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, ds.Tables[0]);
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }
            }
            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "FUNCTION NOT FOUND !");

        }
        private string GenerateRandomOTP(int iOTPLength, string[] saAllowedCharacters)

        {

            string sOTP = String.Empty;

            string sTempChars = String.Empty;

            Random rand = new Random();

            for (int i = 0; i < iOTPLength; i++)

            {

                int p = rand.Next(0, saAllowedCharacters.Length);

                sTempChars = saAllowedCharacters[rand.Next(0, saAllowedCharacters.Length)];

                sOTP += sTempChars;

            }

            return sOTP;

        }
    }
}