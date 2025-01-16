using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
    [Serializable]
    public class AppStatusInfo
    {
        [Column]
        public int WorkDate { set; get; }
        [Column]
        public string queryLive { set; get; }
    }
}
