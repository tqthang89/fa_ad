using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ECS_Web.Cache
{
    public partial class CacheList : System.Web.UI.Page
    {
        public class CacheInfo
        {
            public string CacheKey { get; set; }
            public string LastAcess { get; set; }
            public string Value { get; set; }
            public string CreateDate { get; set; }
            public string HieuLuc { get; set; }
        }
    }
}