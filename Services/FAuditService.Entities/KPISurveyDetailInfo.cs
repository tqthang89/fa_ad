using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
	[Serializable]
	public class KPISurveyDetailInfo
	{
		[Column(IsPrimaryKey = true)]
		public int sdId;
		[Column(IsPrimaryKey = true)]
		public int surveyId;
		[Column]
		public string name;
		[Column]
		public string desc;
		[Column]
		public string type;
		[Column]
		public int? imageMin;
		[Column]
		public int? imageMax;
	}
}
