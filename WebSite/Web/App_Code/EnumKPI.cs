using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ECS_Web.App_Code
{
    public enum KPI
    {
        HOTZONE = 1, PNG = 2, POSM = 3, PXN = 4, SURVEYOTHER = 5, CREATESHOP = 6, PROMOTION = 7, INPOSM = 9, COMPE = 8, SO = 10
    }
    public enum STATUS_IMPORT
    {
        ERROR = -1, UNSUCCESS = 0, SUCCESS = 1, EXISTS = 2
    }
    public enum STATUS_EMPLOYEE
    {
        ACTIVE = 1, DEACTIVE = 0
    }
}