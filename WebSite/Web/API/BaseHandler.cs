using Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace ECS_Web.API
{
    public abstract class BaseHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private HttpContext _Context = null;

        public HttpContext Context
        {
            get { return _Context; }
            set { _Context = value; }
        }

        #region IHttpHandler Members

        public bool IsReusable
        {
            get { return false; }
        }


        public void ProcessRequest(HttpContext context)
        {
            _Context = context;
            ReturnJSON(ProcessRequest());
        }


        public abstract object ProcessRequest();
        private void ResponseMessage(HttpResponseMessage json)
        {
            string strs = "{}";
            if (json != null)
            {
                strs = JsonConvert.SerializeObject(json);
            }
            _Context.Response.Clear();
            _Context.Response.ContentType = "application/json";
            _Context.Response.StatusCode = json.StatusCode;
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.Write(strs);
        }
        public void ReturnJSON<T>(T json)
        {
            string strs = "{}";
            if (json != null)
            {
                strs = JsonConvert.SerializeObject(json);
            }
            _Context.Response.Clear();
            _Context.Response.ContentType = "application/json";
            _Context.Response.StatusCode = 200;
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.Write(strs);
        }
        public void _ReturnJSON<T>(List<T> json)
        {
            string strs = "[]";
            if (json != null)
            {
                System.Web.Script.Serialization.JavaScriptSerializer convert = new System.Web.Script.Serialization.JavaScriptSerializer();
                strs = convert.Serialize(json);

            }
            _Context.Response.Clear();
            _Context.Response.ContentType = "application/json";
            _Context.Response.StatusCode = 200;
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.Write(strs);
        }
        public void ReturnJSON<T>(T json, Formatting formatting)
        {
            string strs = "{}";
            if (json != null)
            {
                strs = JsonConvert.SerializeObject(json, formatting);
            }
            _Context.Response.Clear();
            _Context.Response.ContentType = "application/json";
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.StatusCode = 200;
            _Context.Response.Write(strs);
        }
        public void ReturnJSON(DataTable json)
        {
            string strs = "{}";
            if (json != null)
            {
                strs = JsonConvert.SerializeObject(json, Formatting.Indented);
            }
            _Context.Response.Clear();
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.ContentType = "application/json";
            _Context.Response.StatusCode = 200;
            _Context.Response.Write(strs);
        }
        public String _GET(string name) { return Context.Request.QueryString[name]; }
        public String _POST(string name) { return Context.Request.Form[name]; }
        public String _HEAD(string name) { return Context.Request.Headers[name]; }
        public void ReturnString(Object value)
        {
            string strs = null;
            if (value != null)
            {
                strs = value.ToString();
            }
            _Context.Response.Clear();
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.ContentType = "text/plain";
            Context.Response.StatusCode = 200;
            if (strs != null)
            {
                _Context.Response.OutputStream.Flush();
                byte[] data = System.Text.Encoding.UTF8.GetBytes(strs);
                _Context.Response.OutputStream.Write(data, 0, data.Length);
            }

        }
        public void ReturnHtml(Object value)
        {
            string strs = null;
            if (value != null)
            {
                strs = value.ToString();
            }
            _Context.Response.Clear();
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.ContentType = "text/html";
            Context.Response.StatusCode = 200;
            if (strs != null)
            {
                _Context.Response.OutputStream.Flush();
                byte[] data = System.Text.Encoding.UTF8.GetBytes(strs);
                _Context.Response.OutputStream.Write(data, 0, data.Length);
            }

        }
        public void ReturnError(Object value)
        {
            string strs = null;
            if (value != null)
            {
                strs = value.ToString();
            }
            _Context.Response.Clear();
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.ContentType = "text/plain";
            Context.Response.StatusCode = 500;
            _Context.Response.Write(strs);
        }
        public T GetObjectFromJSON<T>(string json) where T : new()
        {
            return JsonConvert.DeserializeObject<T>(json);
        }
        #endregion
    }
}