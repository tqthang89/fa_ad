using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
	[Table(Name = "MobileSupport")]
	public class MobileSupportEntity
	{
        [Column(IsPrimaryKey = true, IsDbGenerated = true)]
        public int Id { get; set; }

        [Column]
        public int EmployeeId { get; set; }
        [Column]
        public int WorkDate { get; set; }
        [Column]
        public DateTime? CreatedDate { get; set; }
    }
}
