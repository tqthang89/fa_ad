using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Web;

namespace FAuditService.ServiceMessage
{
    public class RequestInfo
    {
        [Column(IsPrimaryKey = true)]
        public long RequestId { set; get; }
        [Column]
        public string RequestTitle { set; get; }
        [Column]
        public string RequestDescription { set; get; }
    }
    public class RequestItem
    {
        [Column(IsPrimaryKey =true)]
        public long ItemId { set; get; }
        [Column]
        public long RequestId { set; get; }
        [Column]
        public string RequestName { set; get; }
        [Column]
        public bool? BooleanField { set; get; }
        [Column]
        public bool? TextField { set; get; }
        [Column]
        public int? ValueField { set; get; }
        [Column]
        public int? ImageField { set; get; }
    }
}