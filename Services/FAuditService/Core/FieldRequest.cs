using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FAuditService.Core
{
    /// <summary>
    /// Summary description for FieldRequest
    /// </summary>
    public class FieldRequest : Field
    {
        public FieldRequest(string name)
            : base(name)
        {

        }
        public FieldRequest this[string name]
        {
            get { return new FieldRequest(name); }
        }
        public override string Value
        {
            get
            {
                var s = HttpContext.Current.Request[this.Name];
                if (string.IsNullOrEmpty(s))
                    return base.Value;
                base.Value = s;
                return base.Value;
            }
            set
            {
                base.Value = value;
            }
        }
        
    }
}