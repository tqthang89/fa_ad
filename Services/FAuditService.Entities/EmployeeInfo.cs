using System;
using System.Collections.Generic;
using System.Data.Linq.Mapping;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FAuditService.Entities
{
    [Table(Name = "Employee")]
    public class EmployeeInfo
    {
        [Column(IsPrimaryKey=true)]
        public int EmployeeId { get; set; }
        [Column]
        public string EmployeeName { get; set; }
        [Column]
        public bool? Sex { get; set; }
        [Column]
        public string Mobile { get; set; }
        [Column]
        public string Email { get; set; }
        [Column]
        public DateTime? WorkingDay { get; set; }
        [Column]
        public int? TypeId { get; set; }
        [Column]
        public string Address { get; set; }
        [Column]
        public int? RegionId { get; set; }
        [Column]
        public string LoginName { get; set; }
        [Column]
        public string Password { get; set; }
        [Column]
        public int ExpriedDate { get; set; }
        [Column]
        public string ParentCode { get; set; }
        [Column]
        public int? Status { get; set; }
        [Column]
        public int? Order { get; set; }
        [Column]
        public string Pic { get; set; }
        [Column]
        public string Serial { get; set; }
        [Column]
        public int? Active { get; set; }
        [Column]
        public int AlowCamera { get; set; }
        [Column]
        public string Avatar { get; set; }
    }
}
