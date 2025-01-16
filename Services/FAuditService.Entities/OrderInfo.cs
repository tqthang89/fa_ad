using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class OrderInfo
    {
        [Column]
        public string ShopId { set; get; }
        [Column]
        public int? Actual { set; get; }
        [Column]
        public int? Target { set; get; }
        [Column]
        public string UpToDate { set; get; }
    }
}
