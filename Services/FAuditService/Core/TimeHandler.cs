using System;
using System.Web;
using Newtonsoft.Json;
using FAuditService.Entities;
using FAuditService.BLL;

namespace FAuditService.Core
{
    public class TimeHandler : BaseHandler
    {
        public override object ProcessRequest()
        {
            return DateTime.Now.ToString("yyyyMMddHHmmss");
        }
    }
}
