using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
	[Serializable]
	public class KPIMTPromotionInfo
	{
		[Column]
		public int ShopFormatId;
		[Column]
		public int PromotionId;
		[Column]
		public String Position;
		[Column]
		public String ProductDescription;
		[Column]
		public String SchemeVN;
		[Column]
		public int FromDate;
		[Column]	
		public int ToDate;
	}
}
