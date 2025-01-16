using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FAuditService.Data;
using FAuditService.Entities;

namespace FAuditService.BLL
{
    public class AttendantController
    {
        public static int AddAttendants(string ShopId, string EmployeeCode, DateTime? AttendantDate, string AttendantPhoto, int? AttendantType, double? Latitude, double? Longitude, double? Accuracy, int? Status)
        {
            using (var context = new AttendantContext())
            {
                return context.AddAttendant(ShopId, EmployeeCode, AttendantType, AttendantDate, AttendantPhoto, Latitude, Longitude, Accuracy, Status);
            }
        }

        public static List<AttendantInfo> getImageAttendant(string ShopId, string Employeecode, string attendantDate)
        {
            List<AttendantInfo> list = null;
            using (var context = new AttendantContext())
            {
                var _list = context.getImage(ShopId, Employeecode, attendantDate);
                if (_list != null)
                    list = _list.ToList();
            }
            return list;
        }
    }
}
