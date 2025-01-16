using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Linq.Mapping;

namespace FAuditService.Entities
{

    public class ShopInfo
    {
        [Column(IsPrimaryKey = true)]
        public int shopId;
        [Column]
        public string shopName;
        [Column]
        public string shopCode;
        [Column]
        public string address;
        [Column]
        public string contactName;
        [Column]
        public string phone;
        [Column]
        public double? longitude;
        [Column]
        public double? latitude;
        [Column(CanBeNull = false)]
        public string shopType;
        [Column]
        public string supportAudit;
        [Column]
        public string photo;
        [Column]
        public int workDate;
        [Column]
        public int sFOSA;
        [Column]
        public int? sFSOS;
        [Column]
        public int? sFPROMOTION;
        [Column]
        public int? Status;
        [Column]
        public string WPDescription;
        [Column]
        public string SalesName;
        [Column]
        public string SalesPhone;
        [Column]
        public string FormatName;
    }

}
