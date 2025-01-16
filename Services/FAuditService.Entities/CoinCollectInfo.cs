using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
    public class CoinCollectInfo
    {
        public int ShopId { get; set; }
        public string Month { get; set; }
        public int? Coins { get; set; }
        public int Quarter { get; set; }
    }
}
