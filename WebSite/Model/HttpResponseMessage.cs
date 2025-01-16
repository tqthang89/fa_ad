using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class HttpResponseMessage
    {
        public static HttpResponseMessage CreateResponse(HttpStatusCode httpStatusCode, object content)
        {
            return new HttpResponseMessage(httpStatusCode, content);
        }
        private HttpResponseMessage(HttpStatusCode httpStatusCode, object content)
        {
            this.StatusCode = (int)httpStatusCode;
            this.Content = content;
            this.TotalRaw = 0;
        }
        public static HttpResponseMessage CreateResponse(HttpStatusCode httpStatusCode, object content, int totalRaw)
        {
            return new HttpResponseMessage(httpStatusCode, content, totalRaw);
        }
        private HttpResponseMessage(HttpStatusCode httpStatusCode, object content, int totalRaw)
        {
            this.StatusCode = (int)httpStatusCode;
            this.Content = content;
            this.TotalRaw = totalRaw;
        }
        public int StatusCode { get; set; }
        public object Content { get; set; }
        public int TotalRaw { get; set; }
    }
}
