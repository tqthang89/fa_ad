using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class KPIStoreInfo
    {
        [Column]
        public string KPICode { set; get; }
        [Column]
        public string ShopId { set; get; }
        [Column]
        public int? FromDate { set; get; }
        [Column]
        public int? ToDate { set; get; }
        [Column]
        public string EmployeeCode { set; get; }
    }
}
