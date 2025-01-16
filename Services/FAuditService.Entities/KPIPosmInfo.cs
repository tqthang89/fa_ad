using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
	[Serializable]
	public class KPIPosmInfo
	{
		[Column(IsPrimaryKey = true)]
		public int shopId;
		[Column(IsPrimaryKey = true)]
		public int posmId;
		[Column]
		public string posmName;
        [Column]
        public string photo;
        [Column]
        public int? quantity;
	}
}
