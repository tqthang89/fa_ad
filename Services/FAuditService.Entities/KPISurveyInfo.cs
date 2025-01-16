using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
	[Serializable]
	public class KPISurveyInfo
	{
		[Column(IsPrimaryKey = true)]
		public int surveyId;
		[Column]
		public int kpiId;
		[Column]
		public string name;
		[Column]
		public string desc;
		[Column]
		public string type;
		[Column]
		public string answer1;
		[Column]
		public string descA1;
		[Column]
		public string type1;
		[Column]
		public int shopFormatId;
		[Column]
		public int? imageMin;
		[Column]
		public int? imageMax;
        [Column]
        public string photo;
        [Column]
        public string groups;
        [Column]
        public int surveyOrder;
		[Column]
		public int? minData;
		[Column]
		public int? maxData;

	}
}

