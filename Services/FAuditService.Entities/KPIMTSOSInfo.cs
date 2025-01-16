using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
	[Serializable]
	public class KPIMTSOSInfo
	{
		[Column(IsPrimaryKey = true)]
		public int SOSId;
		[Column(IsPrimaryKey = true)]
		public int ShopFormatId;
		[Column]
		public string Name;
		[Column]
		public string Brand;
		[Column]
		public string Category;
		[Column]
		public decimal? Width;
		[Column]
		public string Company;
		[Column]
		public string ProductGroup;
		[Column]
		public string Unit;
		[Column]
		public string ProductId;
		[Column]
		public int? SortList;
		[Column]
		public int? ParentId;
	}
}
