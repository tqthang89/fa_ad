using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
    [Serializable]
    public class KPISurveyAnswer
    {
		[Column]
		public int id;
		[Column]
		public int surveyId;
		[Column]
		public string name;		
		[Column]
		public int kpiId;
		[Column]
		public int? notCheck;
	}
}
