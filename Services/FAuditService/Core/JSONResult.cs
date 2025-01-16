using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FAuditService.Core
{
    public class JSONResult<T>
    {
        public JSONResult()
        { }
        public JSONResult(T result)
        {
            this.result = result;
        }
        private T result;
        public T Result { get { return result; } set { result = value; } }
        public string messenger { get; set; }
        public string error { get; set; }
    }
}