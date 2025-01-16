using BLL.WorkResults;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;

namespace ECS_Web.API
{
    public class UpdateDataKPIHander : AuthorizationHandler
    {
        public override HttpResponseMessage AuthorizationRequest()
        {
            HttpResponseMessage hm = HttpResponseMessage.CreateResponse(HttpStatusCode.Created, "Start");
            if (Employee.TypeId != 1)
            {
                hm.Content = "Tài khoản không có quyền chỉnh sửa";
                return hm;
            }
            try
            {
                int? WorkId = new FieldRequest("WorkId");
                int? KPIId = new FieldRequest("KPIId");
                int? ItemId = new FieldRequest("ItemId");
                string Value = new FieldRequest("Value");
                int _value = 0;
                if (string.IsNullOrEmpty(Value))
                    _value = -100;
                else if (Value == "0")
                    _value = 0;
                else
                {
                    int.TryParse(Value, out _value);
                    if (_value <= 0 && KPIId.Value != 5)
                    {
                        hm.Content = "Nhập liệu không phải kiểu số";
                        return hm;
                    }
                }

                // POG- OSA
                if (KPIId.Value == 2)
                {
                    if (_value > 100)
                    {
                        hm.Content = "Nhập số < 100";
                        return hm;
                    }

                    if (ItemId.Value == 1 || ItemId.Value == 2 || ItemId.Value == 3 || ItemId.Value == 4 || ItemId.Value == 5)
                    {
                        if (_value > 1)
                        {
                            hm.Content = "Chỉ được nhập 1 or 0";
                            return hm;
                        }
                    }
                }
                // POSM
                else if (KPIId.Value == 3)
                {
                    if (_value > 50)
                    {
                        hm.Content = "Nhập số <= 50";
                        return hm;
                    }
                }
                // Hotzone -- PXN
                else if (KPIId.Value ==1 || KPIId.Value == 4)
                {
                    if (_value > 1)
                    {
                        hm.Content = "Nhập số <= 1";
                        return hm;
                    }
                }

                int value = new WorkResultController().UpdateDataKPI(WorkId.Value, KPIId.Value, ItemId.Value, _value, Value);
                if (value == 1)
                {
                    hm.StatusCode = (int)HttpStatusCode.OK;
                    hm.Content = "Lưu thành công (item:" + ItemId + ")";
                    return hm;
                }
                if (value == 2)
                {
                    hm.Content = "Dữ liệu bị double, vui lòng kiểm tra lại";
                    return hm;
                }
                if (value == 0)
                {
                    hm.Content = "Không có dữ liệu được update";
                    return hm;
                }
                if (value == -1)
                {
                    hm.Content = "Update lỗi";
                    return hm;
                }
                if (value == -2)
                {
                    hm.Content = "Báo cáo đã khóa";
                    return hm;
                }
            }
            catch (Exception ex)
            {
                hm.StatusCode = (int)HttpStatusCode.InternalServerError;
                hm.Content = "Lỗi:" + ex.Message;
            }
            return hm;
        }
    }
}