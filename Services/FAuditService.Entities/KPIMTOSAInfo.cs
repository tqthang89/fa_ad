using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
	[Serializable]
	public class KPIMTOSAInfo
	{
		[Column(IsPrimaryKey = true)]
		public int productId;
		[Column(IsPrimaryKey = true)]
		public int shopFormatId;
		[Column]
		public int? checkPrice;
		[Column]
		public int? targetOSA;
	}
}
