using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FAuditService.Entities
{
    public class AuditUploadInfo
    {
        public class jsonAttendant
        {

            public int ShopId { set; get; }
            public string ImageName { set; get; }
            public int AttendantDate { set; get; }
            public int AttendantType { set; get; }
            public string AttendantTime { set; get; }
            public double? Latitude { set; get; }
            public double? Longitude { set; get; }
            public double? Accuracy { set; get; }
            public string AttendantServer { set; get; }
        }
        public class jsonPhoto
        {

            public int ShopId { set; get; }
            public string PhotoName { set; get; }
            public string PhotoType { set; get; }
            public string PhotoTime { set; get; }
            public int? KpiId { set; get; }
            public int? ItemId { set; get; }
            public int? WorkDate { set; get; }
            public string PhotoServer { set; get; }
        }
        public class jsonAudio
        {
            public string AudioName { set; get; }
            public string AudioServer { set; get; }
        }
        public class jsonOsa
        {
            public int ProductId { set; get; }
            public int? OsaValue { set; get; }
            public int? LayerValue { set; get; }
            public int? FootValue { set; get; }
            public string Comment { set; get; }
        }
        public class jsonSurveyResult
        {
            public int SurveyId { set; get; }
            public int? Value { set; get; }
            public string Comment { set; get; }
            public string TextValue { get; set; }
        }
        public class jsonSurveyDetailResult
        {
            public int SurveyId { set; get; }
            public int? SdId { set; get; }
            public int? Value { set; get; }
        }
        public class jsonPosm
        {
            public int? PosmId { set; get; }
            public int? Target { set; get; }
            public string Comment { set; get; }
            public int? Value { set; get; }
            public int? Status { set; get; }
            public int? Quantity { set; get; }
        }
        public class jsonPromotion
        {
            public int? PromotionId { set; get; }
            public string Comment { set; get; }
            public int Value { set; get; }
            public int? Value1 { set; get; }
        }
    }
}
