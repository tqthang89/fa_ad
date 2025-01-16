using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq.Mapping;

namespace FAuditService.Entities
{
    [Serializable]
    public class CategoryInfo
    {
        [Column(IsPrimaryKey = true)]
        public int CategoryCode { get; set; }
        [Column]
        public string Division_id { get; set; }
        [Column]
        public string Division { get; set; }
        [Column]
        public string Category_id { get; set; }
        [Column]
        public string Category { get; set; }
        [Column]
        public string Market_id { get; set; }
        [Column]
        public string Market { get; set; }
        [Column]
        public string Sector_id { get; set; }
        [Column]
        public string Sector { get; set; }
        [Column]
        public string Variant_id { get; set; }
        [Column]
        public string Variant { get; set; }
        [Column]
        public string Brand_id { get; set; }
        [Column]
        public string Brand { get; set; }
        [Column]
        public int? ListOrder { get; set; }
    }
}
