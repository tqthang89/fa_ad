using DAL.POSM;
using DAL.Product;
using System.Data;

namespace BLL.Product
{
    public class ProductController
    {
        public int KPIOSAImport(int UserId, int CycleId, DataTable dt_posm)
        {
            using (var context = new ProductContext())
            {
                return context.KPIOSAImport(UserId, CycleId, dt_posm);
            }
        }
        public int KPIOSAImportMTFA(int UserId, int CycleId, DataTable dt_posm)
        {
            using (var context = new ProductContext())
            {
                return context.KPIOSAImportMTFA(UserId, CycleId, dt_posm);
            }
        }
        public DataTable ProductGetList()
        {
            using (var context = new ProductContext())
            {
                return context.ProductGetList();
            }
        }
        public DataTable KPIOSAGetList(int UserId, int CycleId)
        {
            using (var context = new ProductContext())
            {
                return context.KPIOSAGetList(UserId, CycleId);
            }
        }
    }
}
