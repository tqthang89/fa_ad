using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
    [Serializable]
    public class MobileStatusInfo
    {
        [Column(IsPrimaryKey = true)]
        public string ShopId { set; get; }
        [Column(IsPrimaryKey = true)]
        public int WorkDate { set; get; }
    }
}
