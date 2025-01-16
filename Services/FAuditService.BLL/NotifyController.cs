using FAuditService.Data;
using FAuditService.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace FAuditService.BLL
{
    public class NotifyController
    {
        public static List<NotifyInfo> NotifyGetList(string EmployeeCode, long? NotifyId)
        {
            List<NotifyInfo> _tmp = null;
            using (NotifyContext context = new NotifyContext())
            {
                var tmp = context.NotifyGetList(EmployeeCode, NotifyId);
                if (tmp != null)
                    _tmp = tmp.ToList();
                if (context != null && context.Connection.State != ConnectionState.Closed)
                    context.Connection.Close();
            }
            return _tmp;
        }
        public static int RequestData(DataTable dtData, DataTable dtPhoto, string EmployeeCode)
        {

            try
            {
                SqlCommand command = new SqlCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@RequestData", dtData));
                command.Parameters.Add(new SqlParameter("@RequestPhoto", dtPhoto));
                command.Parameters.Add(new SqlParameter("@EmployeeCode", EmployeeCode));
                return DAUltility.Helpers.SqlHelper.excuteSqlCommnd(command, "[dbo].[Mobile.Request.Insert]");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
