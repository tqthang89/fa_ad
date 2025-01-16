using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ECS_Web.API
{
    public abstract class AuthorizationHandler : BaseHandler
    {
        public EmployeesInfo Employee { get; set; }
        public override object ProcessRequest()
        {
            try
            {
                Employee = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
            }
            catch
            {
            }

            if (Employee != null && Employee.EmployeeId != null && Employee.EmployeeId > 0)
                return AuthorizationRequest();
            else
                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Access denied");
        }
        public abstract HttpResponseMessage AuthorizationRequest();
    }
}