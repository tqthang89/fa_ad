using DAL.Attendants;
using System.Data;

namespace BLL.Attendants
{
    public class AttendantController
    {
        public DataTable AttendantGetList(int EmployeeId, int ShopId, int AttendantDate)
        {
            using (var context = new AttendantContext())
            {
                return context.AttendantGetList(EmployeeId, ShopId, AttendantDate);
            }
        }
        public DataTable CreateShopGetList(int WorkId)
        {
            using (var context = new AttendantContext())
            {
                return context.CreateShopGetList(WorkId);
            }
        }
    }
}
