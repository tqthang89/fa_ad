using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    public  class PriceHistoryInfo
    {
        [Column(IsPrimaryKey =true)]
        public string ShopId { set; get; }
        [Column(IsPrimaryKey = true)]
        public string ProductId { set; get; }
        [Column]
        public decimal? Price { set; get; }
        [Column]
        public decimal? CasePrice { set; get; }
        [Column]
        public string Comment { set; get; }
    }
}
