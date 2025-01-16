using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    public class OOLHistoryInfo
    {
        [Column(IsPrimaryKey =true)]
        public string ShopId { set; get; }
        [Column(IsPrimaryKey = true)]
        public string LocationCode { set; get; }
        [Column]
        public string Competitor { set; get; }
        [Column]
        public int Target { set; get; }
        [Column]
        public decimal? OOLValue { set; get; }
    }
}
