using DAL.Address;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Address
{
    public class AddressController
    {
        public DataTable AreaGetList(int UserId)
        {
            using(var context = new AddressContext())
            {
                return context.AreaGetList(UserId);
            }
        }
        public DataTable AddressGetList(int UserId, int? AreaId, int? ProvinceId, int? DistrictId, int? TownId)
        {
            using (var context = new AddressContext())
            {
                return context.AddressGetList(UserId, AreaId, ProvinceId, DistrictId, TownId);
            }
        }
    }
}
