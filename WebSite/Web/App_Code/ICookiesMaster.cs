using ECS_Web.App_Code;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class ICookiesMaster
{
    public static string EINFO = "EINFO";
    public static List<string> ListCookie()
    {
        List<string> ls = new List<string>();
        ls.Add("EINFO");
        return ls;
    }
    public static void RemoveCookie()
    {
        List<string> ls = ListCookie();
        foreach (string item in ls)
        {
            HttpContext.Current.Response.Cookies.Remove(item);
        }
    }
    public static void AddCookie(string NameCookie, object objectvalue)
    {
        if (!ListCookie().Exists(e => e == NameCookie))
        {
#pragma warning disable CS0436 // Type conflicts with imported type
            Toastr.ErrorToast("Không có cookie " + NameCookie);
#pragma warning restore CS0436 // Type conflicts with imported type
            return;
        }
        HttpCookie authcookie = new HttpCookie(NameCookie);
#pragma warning disable CS0436 // Type conflicts with imported type
        authcookie.Value = SecurityUtils.Encrypt(JsonConvert.SerializeObject(objectvalue));
#pragma warning restore CS0436 // Type conflicts with imported type
        authcookie.Expires = DateTime.Now.AddDays(1);
        HttpContext.Current.Response.Cookies.Add(authcookie);
    }

    public static T GetCookie<T>(string NameCookie)
    {
        if (!ListCookie().Exists(e => e == NameCookie))
        {
#pragma warning disable CS0436 // Type conflicts with imported type
            Toastr.ErrorToast("Không có cookie " + NameCookie);
#pragma warning restore CS0436 // Type conflicts with imported type
        }
        HttpCookie cookie = HttpContext.Current.Request.Cookies[NameCookie];
        if (cookie != null)
        {
#pragma warning disable CS0436 // Type conflicts with imported type
            string json = SecurityUtils.Decrypt(cookie.Value);
#pragma warning restore CS0436 // Type conflicts with imported type
            return JsonConvert.DeserializeObject<T>(json);
        }
        else
            return default(T);
    }



}
