using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Data.Linq;
using System.Data.Linq.Mapping;
using FAuditService.Entities;


namespace FAuditService.Data
{
    public class ProductsContext : DAUltility.DataContext
    {

        [Function(Name = "[dbo].[Mobile.Products.Filter]")]
        public IEnumerable<ProductInfo> Filter()
        {
            IEnumerable<ProductInfo> list = null;
            var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod());
            list = (IEnumerable<ProductInfo>)result.ReturnValue;
            return list;
        }

		[Function(Name = "[dbo].[Mobile.KPIPOSM.Getlist]")]
		public IEnumerable<KPIPosmInfo> PostGetList(int EmployeeId)
		{
			IEnumerable<KPIPosmInfo> list = null;
			var result = this.ExecuteMethodCall(this, (MethodInfo)MethodBase.GetCurrentMethod(), EmployeeId);
			list = (IEnumerable<KPIPosmInfo>)result.ReturnValue;
			return list;
		}

	}
}
