using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
	[Serializable]
	public class AreaInfo
	{
		[Column(IsPrimaryKey = true)]
		public int districtId;
		[Column]
		public int provinceId;
		[Column]
		public string districtName;
	}
	

	[Serializable]
	public class ProvinceInfo
	{
		[Column(IsPrimaryKey = true)]
		public int provinceId;
		[Column]
		public string provinceName;
	}

	[Serializable]
	public class DistrictInfo
	{
		[Column(IsPrimaryKey = true)]
		public int districtId;
		[Column]
		public int provinceId;
		[Column]
		public string districtName;
	}

	[Serializable]
	public class TownInfo
	{
		[Column(IsPrimaryKey = true)]
		public int townId;
		[Column]
		public int districtId;
		[Column]
		public string townName;
	}
}

