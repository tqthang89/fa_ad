using FAuditService.BLL;
using FAuditService.Core;
using FAuditService.Entities;
using FAuditService.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;

namespace FAuditService.ServiceMessage
{
    /// <summary>
    /// Summary description for MessagerHandler
    /// </summary>
    public class MessagerHandler : AuthorizationHandler
    {
        public class Request
        {
            public List<RequestInfo> INFO { get; set; }
            public List<RequestItem> ITEM { get; set; }
        }

        public override HttpResponseMessage AuthorizationRequest()
        {
            long? NotifyId = new FieldRequest("NotifyId");
            String FUNCTION = new FieldRequest("FUNCTION");
            int? EmployeeId = Employee.EmployeeId;
            //Logs.d("Access Key", Access_Token, null);
            if ("NOTIFY".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                //return NotifyController.NotifyGetList(EmployeeCode, NotifyId);
            }
            else if ("UPDATESTATUS".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                DataTable _tblDataMobile = null;
                string strDataMobile = "";
                //Logs.d(EmployeeCode, FUNCTION, EmployeeCode);
                try
                {
                    if (Context.Request.Files.Count > 0)
                    {
                        var file = Context.Request.Files[0];
                        if (file != null)
                        {
                            using (StreamReader stream = new StreamReader(file.InputStream))
                            {
                                strDataMobile = stream.ReadToEnd();
                            }
                            if (strDataMobile != null && strDataMobile.Length > 2)
                            {
                                List<MobileStatusInfo> json = this.GetObjectFromJSON<List<MobileStatusInfo>>(strDataMobile);
                                _tblDataMobile = Utility.ConvertToTable<MobileStatusInfo>(json, "DataMobile");
                                Logs.w(EmployeeId.ToString(), "AppStatus", strDataMobile, 10);

                                try
                                {

                                    //return AuditController.AppStusted(_tblDataMobile, EmployeeCode);
                                }
                                catch (Exception ex)
                                {
                                    Logs.w(EmployeeId.ToString(), "AppStatus", ex.Message, 9);
                                    throw ex;
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 12);
                }
            }
            return null;
            //else if ("REQUEST".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            //{
            //    String RequestId = new FieldRequest("RequestId");
            //    //DataSet data = ProductsController.GetRequest(Employee.EmployeeId, RequestId);
            //    Request result = new Request();
            //    //if (data != null && data.Tables.Count > 0)
            //    //    result.ITEM = Utility.ToList<RequestItem>(data.Tables[0]);
            //    //if (data != null && data.Tables.Count > 1)
            //    //    result.INFO = Utility.ToList<RequestInfo>(data.Tables[1]);
            //    return result;
            //}
            //else if ("REQUESTDATA".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            //{

            //    DataTable dtRequest = null, dtPhoto = null;
            //    string dataRequest = null, strPhoto = null;
            //    if (Context.Request.Files.Count > 0)
            //    {
            //        var file = Context.Request.Files[0];
            //        if (file != null)
            //        {
            //            using (StreamReader stream = new StreamReader(file.InputStream))
            //            {
            //                dataRequest = stream.ReadToEnd();
            //            }
            //            //Logs.w(EmployeeCode, FUNCTION, dataRequest);
            //            // Logs.d(EmployeeCode, "OrderData", strDataDetail);
            //            if (dataRequest != null && dataRequest.Length > 2)
            //            {
            //                List<AuditUploadInfo.requestdata> json = this.GetObjectFromJSON<List<AuditUploadInfo.requestdata>>(dataRequest);
            //                dtRequest = Utility.ConvertToTable<AuditUploadInfo.requestdata>(json, "RequestData");
            //            }
            //        }
            //    }
            //    if (Context.Request.Files.Count > 1)
            //    {
            //        var file = Context.Request.Files[1];
            //        if (file != null)
            //        {
            //            using (StreamReader stream = new StreamReader(file.InputStream))
            //            {
            //                strPhoto = stream.ReadToEnd();
            //            }
            //            //Logs.w(EmployeeCode, "RQPHOTO", strPhoto);
            //            if (strPhoto != null && strPhoto.Length > 2)
            //            {
            //                List<AuditUploadInfo.requestphoto> json = this.GetObjectFromJSON<List<AuditUploadInfo.requestphoto>>(strPhoto);
            //                dtPhoto = Utility.ConvertToTable<AuditUploadInfo.requestphoto>(json, "RequestPhoto");
            //            }
            //        }
            //    }
            //    //Inset Data
            //    //return NotifyController.RequestData(dtRequest, dtPhoto, EmployeeCode);
            //}
            //return 1;
        }
    }
}