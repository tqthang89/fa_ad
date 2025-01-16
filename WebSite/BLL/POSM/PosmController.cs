using DAL.POSM;
using System.Data;

namespace BLL.POSM
{
    public class PosmController
    {
        public int KPIPOSMImport(int UserId, int CycleId, DataTable dt_posm)
        {
            using (var context = new PosmContext())
            {
                return context.KPIPOSMImport(UserId, CycleId, dt_posm);
            }
        }
        public DataTable PosmGetList()
        {
            using (var context = new PosmContext())
            {
                return context.PosmGetList();
            }
        }
        public DataTable KPIPOSMGetList(int UserId, int CycleId)
        {
            using (var context = new PosmContext())
            {
                return context.KPIPOSMGetList(UserId, CycleId);
            }
        }
    }
}
