using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FAuditService.Models
{
    public class ProductModel
    {
        public string ProductId { get; set; }
        public string ProductName { get; set; }
        public string CategoryCode { get; set; }
        public string Unit { get; set; }
        public int? Status { get; set; }
        public int? Order { get; set; }
        public string Packsize_id { get; set; }
        public string Photo { get; set; }
    }
}