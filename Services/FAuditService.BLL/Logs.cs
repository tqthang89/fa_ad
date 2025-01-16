using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using FAuditService.Data;
using System.Data.SqlClient;
using FAuditService.Entities;

namespace FAuditService.BLL
{
    public class Logs
    {
        public static List<LogInfo> All()
        {
            List<LogInfo> logs = new List<LogInfo>();
            using (LogsContext context = new LogsContext())
            {
                var list = from p in context.Logs select p;
                if (list != null)
                    logs = list.ToList();
            }
            return logs;
        }

        public static void e(String EmployeeCode, Exception ex)
        {
            if (ex != null)
            {
                w(EmployeeCode, ex.Message, ex.ToString(), 1);
            }
        }
        public static void w(String EmployeeCode, String Message, String Trace, int? Type = 0)
        {
            try
            {
                using (LogsContext context = new LogsContext())
                {
                    LogInfo info = new LogInfo();
                    info.CreatedDate = DateTime.Now;
                    info.EmployeeCode = EmployeeCode;
                    info.Message = Message;
                    info.Trace = Trace;
                    info.Type = Type;
                    context.Logs.InsertOnSubmit(info);
                    context.SubmitChanges();
                }
            }
            catch (Exception)
            {

            }
           
        }
        public static void d(String EmployeeCode, String Message, String Trace)
        {
            w(EmployeeCode, Message, Trace, 0);
        }
    }
}
