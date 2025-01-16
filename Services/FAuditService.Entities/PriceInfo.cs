using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class PriceInfo
    {
        [Column(IsPrimaryKey =true)]
        public string SiteCode { set; get; }
        [Column(IsPrimaryKey = true)]
        public string ProductId { set; get; }
        [Column]
        public string Competitor { set; get; }
        [Column]
        public decimal? Price { set; get; }
    }
}
