using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
   public class MobileSupportInfo
    {
        [Column]
        public int EmployeeId { set; get; }
        [Column]
        public string QueryString { set; get; }
    }
}
