using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FAuditService.Models
{
    public class LoginModel
    {
        public int EmployeeId { get; set; }
        public string EmployeeName { get; set; }
        public string LoginName { get; set; }
        public int ExpriedDate { get; set; }
        public string client_time { get; set; }
        public string server_time { get; set; }
        public string access_token { get; set; }

        public string Avatar;
        public int TypeId { get; set; }
    }
}