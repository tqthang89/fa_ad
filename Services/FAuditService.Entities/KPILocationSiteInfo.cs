using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class KPILocationSiteInfo
    {
        //PromotionCode	PromotionName	PromotionDescription	BeginDate	EndDate	SiteCode	LocationCode	LocationName
        [Column]
        public string PromotionCode;
        [Column]
        public string PromotionName;
        [Column]
        public string PromotionDescription;
        [Column]
        public string ItemCode;
        [Column]
        public string ItemName;
        [Column]
        public int? FromDate;
        [Column]
        public int? ToDate;
        [Column]
        public string SiteCode;
        [Column]
        public string LocationCode;
        [Column]
        public string LocationName;
    }
}
