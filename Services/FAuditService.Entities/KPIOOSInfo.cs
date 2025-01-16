using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class KPIOOSInfo
    {
        [Column(IsPrimaryKey =true)]
        public string ProductId;
        [Column(IsPrimaryKey = true)]
        public string SiteCode;
        [Column]
        public int? FromDate;
        [Column]
        public int? ToDate;
    }
}
