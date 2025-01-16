using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Address
{
    public class AddressContext : DataContext
    {
        [Function(Name = "[dbo].[Area.GetList]")]
        public DataTable AreaGetList(int UserId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserId);
        }
        [Function(Name = "[dbo].[Address.GetList]")]
        public DataTable AddressGetList(int UserId, int? AreaId, int? ProvinceId, int? DistrictId, int? TownId)
        {
            return ExecuteDatatable((MethodInfo)MethodBase.GetCurrentMethod(), UserId, AreaId, ProvinceId, DistrictId, TownId);
        }
    }
}
