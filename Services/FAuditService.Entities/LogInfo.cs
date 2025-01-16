using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq.Mapping;

namespace FAuditService.Entities
{
    [Serializable]
    [Table(Name = "Logs")]
    public class LogInfo
    {
        [Column(IsDbGenerated = true, IsPrimaryKey = true)]
        public long ID { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string Message { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string Trace { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public DateTime? CreatedDate { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public string EmployeeCode { get; set; }
        [Column(UpdateCheck = UpdateCheck.Never)]
        public int? Type { get; set; }
    }
}
