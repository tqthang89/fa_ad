using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Linq.Mapping;
using System.Text;


namespace Model
{
    [Serializable]
    public class EmployeesInfo
    {
        public EmployeesInfo() { }
        [Column]
        public int? EmployeeId { set; get; }
        [Column]
        public string EmployeeCode { set; get; }
        [Column]
        public string AliasCode { get; set; }
        [Column]
        public string EmployeeName { set; get; }
        [Column]
        public string Division { set; get; }
        [Column]
        public string Position { set; get; }
        [Column]
        public string Region { set; get; }
        [Column]
        public string Mobile { set; get; }
        [Column]
        public string Parent { set; get; }
        [Column]
        public string LoginName { set; get; }
        [Column]
        public string PassWord { set; get; }
        [Column]
        public int? Status { set; get; }
        [Column]
        public string Trangthai { set; get; }
        [Column]
        public string Pic { set; get; }
        [Column]
        public int? Sex { set; get; }
        [Column]
        public int? Level { set; get; }
        [Column]
        public string Category { set; get; }
        [Column]
        public string CategoryValue { set; get; }
        [Column]
        public int TypeId { set; get; }
    }
}
