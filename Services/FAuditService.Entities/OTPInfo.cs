using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class OTPInfo
    {
        [Column]
        public string EmployeeCode { set; get; }
        [Column]
        public string OTP { set; get; }
        [Column]
        public DateTime? BeginActive { set; get; }
        [Column]
        public DateTime? EndActive { set; get; }
    }
}
