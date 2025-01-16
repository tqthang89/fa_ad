using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FAuditService.Entities;
using FAuditService.Data;
using System.Data;

namespace FAuditService.BLL
{
    public class EmployeeController
    {
        public static EmployeeInfo GetEmployee(string EmployeeCode = null, string Username = null, string Email = null, String Mobile = null)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.GetEmployee(EmployeeCode, Username, Email, Mobile).FirstOrDefault();
            }
            return info;
        }
        public static EmployeeInfo byCode(string EmployeeCode)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.byCode(EmployeeCode).FirstOrDefault();
            }
            return info;
        }
        public static EmployeeInfo byUsername(string Username, int EmployeeId)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.byUsername(Username, EmployeeId).FirstOrDefault();
            }
            return info;
        }
        public static EmployeeInfo byCheckChangePass(string username, string oldpass)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.byCheckChangePass(username, oldpass).FirstOrDefault();
            }
            return info;
        }
        public static EmployeeInfo ChangePass(string username, string newpass)
        {
            EmployeeInfo info = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                info = context.Changepass(username, newpass).FirstOrDefault();
            }
            return info;
        }
        public static int OTPCreate(string EmployeeCode, string OTP)
        {
            using (EmployeeContext context = new EmployeeContext())
            {
                return context.OTPCreate(EmployeeCode, OTP);
            }
        }
        public static List<OTPInfo> OTPChecking(string EmployeeCode, string OTP)
        {
            List<OTPInfo> _tmp = null;
            using (EmployeeContext context = new EmployeeContext())
            {
                var tmp = context.OTPChecking(EmployeeCode, OTP);
                if (tmp != null)
                    _tmp = tmp.ToList();
            }
            return _tmp;
        }
        public static int check_emp_mobilesupport(int EmployeeId)
        {
            int value = 0;
            using (EmployeeContext ec = new EmployeeContext())
            {
                int dt_now = Convert.ToInt32(DateTime.Today.ToString("yyyyMMdd"));
                MobileSupportEntity ms = (from p in ec.MobileSupport where p.EmployeeId == EmployeeId && p.WorkDate == dt_now select p).FirstOrDefault();
                if (ms != null)
                    value = 1;
            }
            return value;
        }
        public static int SaveDBMobile(int EmployeeId, string FilePath)
        {
            using (EmployeeContext context = new EmployeeContext())
            {
              return  context.SaveDBMobile(EmployeeId, FilePath);
            }
        }
    }
}