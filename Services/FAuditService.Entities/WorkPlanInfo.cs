using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
    public class WorkPlanInfo
    {
        [Column]
        public String EmployeeCode { get; set; }
        [Column]
        public String WorkingDate { get; set; }
        [Column]
        public String WorkingNote { get; set; }
        [Column]
        public String Reason { get; set; }

    }
}
