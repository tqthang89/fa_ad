using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    public class MasterInfo
    {
        [Column]
        public string listCode { set; get; }
        [Column]
        public string code { set; get; }
        [Column]
        public int? id { set; get; }
        [Column]
        public string name { set; get; }
        [Column(Name= "nameVN")]
        public string Name_viVN { set; get; }
        [Column]
        public string description { set; get; }
        [Column]
        public string refCode { set; get; }
        [Column]
        public int? refId { set; get; }
        [Column]
        public int? sortList { set; get; }
    }
}
