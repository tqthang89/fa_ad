using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class KPIOOLInfo
    {
        [Column(IsPrimaryKey = true)]
        public int OLId;
        [Column]
        public string OLName;
        [Column]
        public string DataType;
        [Column]
        public string Desc;
        [Column]
        public int HasTotal;
        [Column]
        public int HasCompetitor;
        [Column]
        public int? HasFree;
        [Column]
        public string FreeDataType;
        [Column]
        public int? FreeHasTotal;
        [Column]
        public string FreeDesc;
        [Column]
        public int? IsRental;
    }

    [Serializable]
    public class KPIOOLShopInfo
    {
        [Column]
        public int ShopId;
        [Column]
        public int OLBId;
        [Column]
        public string OLBName;
        [Column]
        public string Customer;
        [Column]
        public int OLId;
        [Column]
        public string OLName;
        [Column]
        public string DataType;
        [Column]
        public string Desc;
        [Column]
        public int? HasTotal;
        [Column]
        public int? OLType;
        [Column]
        public string FreeDataType;
        [Column]
        public int? FreeHasTotal;
        [Column]
        public string FreeDesc;
        [Column]
        public int? HasPallet;
        [Column]
        public int? HasFree;
        [Column]
        public string LayerDesc;
        [Column]
        public int? HasCompetitor;
        [Column]
        public int? Orders;
        [Column]
        public string DescTotal;
        [Column]
        public string DescPallet;
        [Column]
        public int? FreeHasPallet;
        [Column]
        public string FreeDescTotal;
        [Column]
        public string FreeDescPallet;
        [Column]
        public int? Target;
    }

    [Serializable]
    public class KPIOOLBrandInfo
    {
        [Column]
        public int OLBId;
        [Column]
        public string OLBName;
        [Column]
        public string Customer;
    }
}
