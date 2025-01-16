using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    public class SOSHistoryInfo
    {
        [Column(IsPrimaryKey =true)]
        public string ShopId { get; set; }
        [Column(IsPrimaryKey = true)]
        public long SOSId { get; set; }
        [Column]
        public decimal? SOSValue { get; set; }
        [Column]
        public int? TargetValue { get; set; }
        [Column]
        public int? Facing { get; set; }
        [Column]
        public string ProductId { get; set; }
    }
}
