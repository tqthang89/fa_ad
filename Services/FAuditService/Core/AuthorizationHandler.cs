using System;
using System.Web;
using Newtonsoft.Json;
using System.IO;
using FAuditService.BLL;
using FAuditService.Entities;
using FAuditService.Models;
using System.Text.RegularExpressions;
using System.Collections.Generic;
using System.Linq;

namespace FAuditService.Core
{
    public abstract class AuthorizationHandler : BaseHandler
    {
        public string Access_Token { get; set; }
        public EmployeeInfo Employee { get { return Context.Session["LOGIN_EMPLOYEE"] as EmployeeInfo; } private set { Context.Session["LOGIN_EMPLOYEE"] = value; } }
        public override object ProcessRequest()
        {

            Access_Token = Context.Request.Headers["access_token"];
            if (string.IsNullOrWhiteSpace(Access_Token))
                Access_Token = Context.Request["access_token"];
            if (!string.IsNullOrWhiteSpace(Access_Token))
            {

                string password = null;
                int EmployeeId = 0;
                var key = SecurityUtils.Decrypt(Access_Token, "Authorization", "Android");
                string[] data = key.Split(new string[] { ";@;" }, StringSplitOptions.RemoveEmptyEntries);
                EmployeeId = Convert.ToInt32(data[0]);
                password = data[1];

                if (Employee == null || EmployeeId == Employee.EmployeeId)
                    Employee = EmployeeController.byUsername(null, EmployeeId);

                if (Employee != null && Employee.Password.Equals(password))
                    return AuthorizationRequest();
                else
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Access denied");

            }
            else
                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Access denied");

        }
        public abstract HttpResponseMessage AuthorizationRequest();

        public static bool isValidVietNamPhoneNumberV2(string Mobile)
        {
            bool _value = true;
            List<MobileNumberChange> lc = new List<MobileNumberChange>();

            lc.Add(new MobileNumberChange("089", "089"));
            lc.Add(new MobileNumberChange("090", "090"));
            lc.Add(new MobileNumberChange("093", "093"));
            lc.Add(new MobileNumberChange("0120", "070"));
            lc.Add(new MobileNumberChange("0121", "079"));
            lc.Add(new MobileNumberChange("0122", "077"));
            lc.Add(new MobileNumberChange("0126", "076"));
            lc.Add(new MobileNumberChange("0128", "078"));
            lc.Add(new MobileNumberChange("091", "091"));
            lc.Add(new MobileNumberChange("094", "094"));
            lc.Add(new MobileNumberChange("088", "088"));
            lc.Add(new MobileNumberChange("0123", "083"));
            lc.Add(new MobileNumberChange("0124", "084"));
            lc.Add(new MobileNumberChange("0125", "085"));
            lc.Add(new MobileNumberChange("0127", "081"));
            lc.Add(new MobileNumberChange("0129", "082"));
            lc.Add(new MobileNumberChange("098", "098"));
            lc.Add(new MobileNumberChange("097", "097"));
            lc.Add(new MobileNumberChange("096", "096"));
            lc.Add(new MobileNumberChange("086", "086"));
            lc.Add(new MobileNumberChange("0169", "039"));
            lc.Add(new MobileNumberChange("0168", "038"));
            lc.Add(new MobileNumberChange("0167", "037"));
            lc.Add(new MobileNumberChange("0166", "036"));
            lc.Add(new MobileNumberChange("0165", "035"));
            lc.Add(new MobileNumberChange("0164", "034"));
            lc.Add(new MobileNumberChange("0163", "033"));
            lc.Add(new MobileNumberChange("0162", "032"));
            lc.Add(new MobileNumberChange("092", "092"));
            lc.Add(new MobileNumberChange("058", "058"));
            lc.Add(new MobileNumberChange("056", "056"));
            lc.Add(new MobileNumberChange("099", "099"));
            lc.Add(new MobileNumberChange("0199", "059"));
            lc.Add(new MobileNumberChange("052", "052"));
            lc.Add(new MobileNumberChange("087", "087"));
            lc.Add(new MobileNumberChange("087", "087"));

            // Số cố định

            lc.Add(new MobileNumberChange("021", "021"));
            lc.Add(new MobileNumberChange("020", "020"));
            lc.Add(new MobileNumberChange("022", "022"));
            lc.Add(new MobileNumberChange("024", "024"));
            lc.Add(new MobileNumberChange("023", "023"));
            lc.Add(new MobileNumberChange("025", "025"));
            lc.Add(new MobileNumberChange("026", "026"));
            lc.Add(new MobileNumberChange("028", "028"));
            lc.Add(new MobileNumberChange("027", "027"));
            lc.Add(new MobileNumberChange("029", "029"));



            if (!string.IsNullOrEmpty(Mobile))
            {
                string fristnumber = Mobile.Substring(0, 4);
                var checknumber = (from p in lc where p.MobileOld.Equals(fristnumber) select p).FirstOrDefault();
                if (checknumber != null)
                {
                    _value = false;
                    return _value;
                }

                string fristnumber_new = Mobile.Substring(0, 3);
                var checknumber_new = (from p in lc where p.Mobile.Equals(fristnumber_new) select p).FirstOrDefault();
                if (checknumber_new == null)
                {
                    _value = false;
                    return _value;
                }
            }
            else
                _value = false;

            if (Mobile.Length < 10 || Mobile.Length >= 12)
            {
                _value = false;
                return _value;
            }

            if (_value == true)
            {
                string sPhonePattern = @"^[0-9]+$";
                return Regex.IsMatch(Mobile, sPhonePattern);
            }
            return _value;
        }

        public class MobileNumberChange
        {
            public string MobileOld { get; set; }
            public string Mobile { get; set; }


            public MobileNumberChange(string _MobileOld, string _Mobile)
            {
                this.MobileOld = _MobileOld;
                this.Mobile = _Mobile;
            }
        }
    }
}
