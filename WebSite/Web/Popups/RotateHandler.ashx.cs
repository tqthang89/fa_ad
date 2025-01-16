using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

namespace ECS_Web.Popups
{
    /// <summary>
    /// Summary description for RotateHandler
    /// </summary>
    public class RotateHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            int angle = Convert.ToInt32(context.Request["angle"]);
            string filename = null;
            context.Response.Clear();
            context.Response.ContentType = "image/jpeg";
            if ((filename = context.Request["path"]) != null)
            {
                try
                {
                    Bitmap bmap = null;

                    WebClient client = new WebClient();
                    var data = client.DownloadData(filename);
                    using (var ms = new MemoryStream(data))
                    {
                        bmap = new Bitmap(ms);
                    }


                    bmap = RotateBitmap(bmap, angle);

                    if (bmap != null)
                    {
                        using (Stream f = context.Response.OutputStream)
                        {
                            f.Flush();
                            bmap.Save(f, System.Drawing.Imaging.ImageFormat.Jpeg);

                            f.Close();
                        }
                    }

                }
                catch (Exception)
                {

                }
            }
        }

        private void GetPointBounds(PointF[] points, out float xmin, out float xmax, out float ymin, out float ymax)
        {
            xmin = points[0].X;
            xmax = xmin;
            ymin = points[0].Y;
            ymax = ymin;
            foreach (PointF point in points)
            {
                if (xmin > point.X) xmin = point.X;
                if (xmax < point.X) xmax = point.X;
                if (ymin > point.Y) ymin = point.Y;
                if (ymax < point.Y) ymax = point.Y;
            }
        }
        private Bitmap RotateBitmap(Bitmap bm, int angle)
        {

            Matrix rotate_at_origin = new Matrix();
            rotate_at_origin.Rotate((float)angle);


            PointF[] points =
            {
                new PointF(0, 0),
                new PointF(bm.Width, 0),
                new PointF(bm.Width, bm.Height),
                new PointF(0, bm.Height),
            };
            rotate_at_origin.TransformPoints(points);
            float xmin, xmax, ymin, ymax;
            GetPointBounds(points, out xmin, out xmax, out ymin, out ymax);

            int wid = (int)Math.Round(xmax - xmin);
            int hgt = (int)Math.Round(ymax - ymin);
            Bitmap result = new Bitmap(wid, hgt);

            Matrix rotate_at_center = new Matrix();
            rotate_at_center.RotateAt(angle,
                new PointF(wid / 2f, hgt / 2f));

            using (Graphics gr = Graphics.FromImage(result))
            {
                gr.InterpolationMode = InterpolationMode.High;

                gr.Clear(bm.GetPixel(0, 0));
                gr.Transform = rotate_at_center;

                int x = (wid - bm.Width) / 2;
                int y = (hgt - bm.Height) / 2;
                gr.DrawImage(bm, x, y);

            }


            return result;
        }
        

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}