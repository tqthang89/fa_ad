using Model;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;
using static ECS_Web.Cache.CacheList;

public class CacheManager
{

    public static class CacheKeys
    {
        public static string LIST_TO { get { return "LIST_TO"; } }
    }
    public static List<string> ListCache()
    {
        List<string> ls = new List<string>();
        ls.Add(CacheKeys.LIST_TO);
        return ls;
    }

    public static void RemoveCache()
    {
        EmployeesInfo ei = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
        if (ei == null || ei.EmployeeId <= 0)
        {
#pragma warning disable CS0436 // Type conflicts with imported type
            Toastr.ErrorToast("Không có thông tin đăng nhập.");
#pragma warning restore CS0436 // Type conflicts with imported type
        }
        List<string> ls = ListCache();
        foreach (string item in ls)
        {
            HttpContext.Current.Cache.Remove(ei.EmployeeId.ToString() + "_" + item);
        }
    }

    static readonly ConcurrentDictionary<string, CacheInfo> Dictionary_Cache =
            new ConcurrentDictionary<string, CacheInfo>(StringComparer.OrdinalIgnoreCase);

    public static dynamic GetSetCache<T>(string NameCache)
    {
#pragma warning disable CS0436 // Type conflicts with imported type
        EmployeesInfo ei = ICookiesMaster.GetCookie<EmployeesInfo>(ICookiesMaster.EINFO);
#pragma warning restore CS0436 // Type conflicts with imported type
        if (ei == null || ei.EmployeeId <= 0)
        {
#pragma warning disable CS0436 // Type conflicts with imported type
            Toastr.ErrorToast("Không có thông tin đăng nhập.");
            return null;
#pragma warning restore CS0436 // Type conflicts with imported type
        }
        if (!ListCache().Exists(e => e == NameCache))
        {
#pragma warning disable CS0436 // Type conflicts with imported type
            Toastr.ErrorToast("Không có Cache " + NameCache);
            return null;
#pragma warning restore CS0436 // Type conflicts with imported type
        }

        string _key = ei.EmployeeId.ToString() + "_" + NameCache;
        CacheInfo ci = new CacheInfo();
        ci.CacheKey = _key;
        ci.CreateDate = DateTime.Now.ToString("dd/MM/yyyy HH:MM:ss");
        ci.HieuLuc = "15";
        if (HttpContext.Current.Cache[_key] != null)
        {
            Upload_Dictionary_Cache(_key, ci);
            return HttpContext.Current.Cache[_key];
        }
        else
        {
            List<string> lt = new List<string>();
            if (ei.EmployeeId == 1)
            {
                lt.Add("To11");
                lt.Add("To11");
            }
            if (ei.EmployeeId == 2)
            {
                lt.Add("To2");
                lt.Add("To22");
            }
            System.Web.HttpContext.Current.Cache.Insert(_key, lt, null, DateTime.MaxValue, TimeSpan.FromMinutes(15));
            Upload_Dictionary_Cache(_key, ci);
            return lt;
        }
    }

    public static void Upload_Dictionary_Cache(string _key, CacheInfo ci)
    {
        var r = Dictionary_Cache.AddOrUpdate(
                _key,
                ci,
                (key, existingCity) =>
                {
                    // If this delegate is invoked, then the key already exists.
                    // Here we make sure the city really is the same city we already have.
                    if (ci != existingCity)
                    {
                        // throw new ArgumentException($"Duplicate city names are not allowed: {ci.Name}.");
                    }

                    // The only updatable fields are the temperature array and LastQueryDate.
                    existingCity.LastAcess = DateTime.Now.ToString("dd/mm/yyyy HH:MM:ss");
                    return existingCity;
                });
    }

    public static List<CacheInfo> ListCacheActive()
    {
        List<CacheInfo> lc = new List<CacheInfo>();
        foreach (var item in Dictionary_Cache.ToList())
        {
            CacheInfo ci = item.Value as CacheInfo;
            lc.Add(ci);
        }
        return lc;
    }
}
