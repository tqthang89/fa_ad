using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    [Serializable]
    public class NPDInfo
    {
        [Column(IsPrimaryKey =true)]
        public string ProductId { set; get; }
        [Column(IsPrimaryKey = true)]
        public string SiteCode { set; get; }
        [Column(CanBeNull =false)]
        public int EffectiveDate { set; get; }
        [Column]
        public string Description { set; get; }
    }
}
