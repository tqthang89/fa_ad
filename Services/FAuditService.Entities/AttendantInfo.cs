using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
    [Serializable]
    public class AttendantInfo
    {
        [Column]
        public long AttendantId;
        [Column]
        public string ShopId;
        [Column]
        public string EmployeeCode;
        [Column]
        public int AttendantType;
        [Column]
        public string AttendantDate;  
        [Column]
        public long AttendentTime;
        [Column]
        public string AttendantPhoto;
        [Column]
        public double Longitude;
        [Column]
        public double Latitude;
        [Column]
        public double Accuracy;
    }
}
