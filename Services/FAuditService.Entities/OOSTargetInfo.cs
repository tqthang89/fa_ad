using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class OOSTargetInfo
    {
        [Column(IsPrimaryKey =true)]
        public string ShopId { set; get; }
        [Column(IsPrimaryKey = true)]
        public string ProductId { set; get; }
        [Column]
        public int? Target { set; get; }
    }
}
