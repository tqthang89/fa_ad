using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Caching;

namespace DAUltility
{
    public class IPBlackList : IHttpModule
    {
        private EventHandler onBeginRequest;

        public IPBlackList()
        {
            onBeginRequest = new EventHandler(this.HandleBeginRequest);
        }

        void IHttpModule.Dispose()
        {
        }

        void IHttpModule.Init(HttpApplication context)
        {
            context.BeginRequest += onBeginRequest;
        }

        const string BLOCKEDIPSKEY = "blockedips";
        const string BLOCKEDIPSFILE = "SiteConfig/blockedips.config";

        public static StringDictionary GetBlockedIPs(HttpContext context)
        {
            StringDictionary ips = (StringDictionary)context.Cache[BLOCKEDIPSKEY];
            if (ips == null)
            {
                try
                {
                    ips = GetBlockedIPs(GetBlockedIPsFilePathFromCurrentContext(context));
                    context.Cache.Insert(BLOCKEDIPSKEY, ips, new CacheDependency(GetBlockedIPsFilePathFromCurrentContext(context)));
                }
                catch (Exception)
                {
                    
                }
               
            }
            return ips;
        }

        private static string BlockedIPFileName = null;
        private static object blockedIPFileNameObject = new object();
        public static string GetBlockedIPsFilePathFromCurrentContext(HttpContext context)
        {
            if (BlockedIPFileName != null)
                return BlockedIPFileName;
            lock (blockedIPFileNameObject)
            {
                if (BlockedIPFileName == null)
                {
                    BlockedIPFileName = context.Server.MapPath(BLOCKEDIPSFILE);
                }
            }
            return BlockedIPFileName;
        }

        public static StringDictionary GetBlockedIPs(string configPath)
        {
            StringDictionary retval = new StringDictionary();
            try
            {
                using (StreamReader sr = new StreamReader(configPath))
                {
                    String line;
                    while ((line = sr.ReadLine()) != null)
                    {
                        line = line.Trim();
                        if (line.Length != 0)
                        {
                            retval.Add(line, null);
                        }
                    }
                }
            }
            catch (Exception)
            {

            }

            return retval;
        }

        private void HandleBeginRequest(object sender, EventArgs evargs)
        {
            HttpApplication app = sender as HttpApplication;

            if (app != null)
            {
                string IPAddr = app.Context.Request.ServerVariables["REMOTE_ADDR"];
                if (IPAddr == null || IPAddr.Length == 0)
                {
                    return;
                }

                StringDictionary badIPs = GetBlockedIPs(app.Context);
                if (badIPs != null && badIPs.ContainsKey(IPAddr))
                {
                    app.Context.Response.StatusCode = 404;
                    app.Context.Response.SuppressContent = true;
                    app.Context.Response.End();
                    return;
                }
            }
        }
    }
}
