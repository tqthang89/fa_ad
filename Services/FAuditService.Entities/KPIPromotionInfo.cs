using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
	[Serializable]
	public class KPIPromotionInfo
	{
		[Column(IsPrimaryKey = true)]
		public int shopId;
		[Column(IsPrimaryKey = true)]
		public int promotionId;
		[Column]
		public string scheme;
        [Column]
        public int fromdate;
		[Column]
		public int todate;
		[Column]
        public int? productid;
		[Column]
		public string productdescription;
	}
}
