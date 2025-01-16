using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq.Mapping;

namespace FAuditService.Entities
{
    [Serializable]
    [Table(Name = "[dbo].[Products]")]
    public class ProductInfo
    {
        [Column(IsPrimaryKey = true)]
        public int productId { get; set; }
        [Column]
        public string productName { get; set; }
        [Column]
        public string package { get; set; }
        [Column]
        public int? catId { get; set; }
        [Column]
        public int? rate { get; set; }
        [Column]
        public string segment2 { get; set; }
        [Column]
        public string segment { get; set; }
        [Column]
        public string segment4 { get; set; }
        [Column]
        public int? sortlist { get; set; }
        [Column]
        public string photo { get; set; }
        [Column]
        public string keyBrand { get; set; }
    }
}
