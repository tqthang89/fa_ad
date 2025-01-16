using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FAuditService.Models
{
    public class StoreListModel
    {
        public string ShopId { get; set; }
        public string SupplierCode { get; set; }
        public string ShopName { get; set; }
        public string ShopAddress { get; set; }
        public string ContactName { get; set; }
        public string ImageUrl { get; set; }
        public string ShopFormat { get; set; }
        public string Area { get; set; }
        public string Phone { get; set; }
        public string Position { get; set; }
        public string Grade { get; set; }
        public int? RegionID { get; set; }
        public int? Status { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string SiteCode { get; set; }
    }
}