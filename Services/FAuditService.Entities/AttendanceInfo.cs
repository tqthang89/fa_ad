using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq.Mapping;

namespace FAuditService.Entities
{
    [Serializable]
    [Table(Name = "dbo.[Attendance]")]
    public class AttendanceInfo
    {
        [Column(IsDbGenerated = true, IsPrimaryKey = true)]
        public long AttendanceID { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string EmployeeCode { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string ShopId { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public DateTime? create_date { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public DateTime? check_date { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string latitude { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string longitude { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string type { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public int? invalid { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public decimal? distance { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string ImagePath { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string address { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public int? image_id { get; set; }
    }
}
