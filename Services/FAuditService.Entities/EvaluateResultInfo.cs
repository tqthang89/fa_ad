using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
    public class EvaluateResultInfo
    {
        [Column]
        public int ShopId { get; set; }
        public string EvaluateDate { get; set; }
        public string KpiFormatName { get; set; }
        public string ResultName { get; set; }
        public int ResultStatus { get; set; }
    }
}
