using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class SkipProductInfo
    {
        [Column]
        public string ShopId { set; get; }
        [Column]
        public string ProductId { set; get; }
        [Column]
        public int AuditDate { set; get; }
    }
}
