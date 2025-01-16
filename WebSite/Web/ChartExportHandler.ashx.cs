using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
public class ChartExportHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string type = context.Request.Form["type"];
        string svg = context.Request.Form["svg"];
        string filename = context.Request.Form["filename"];

        if (string.IsNullOrEmpty(filename)) filename = "chart";

        string tempName = Path.GetRandomFileName();

        string typeString = "", ext = "";

        if (type == "image/png")
        {
            typeString = "-m image/png";
            ext = "png";
        }
        else if (type == "image/jpeg")
        {
            typeString = "-m image/jpeg";
            ext = "jpg";
        }
        else if (type == "application/pdf")
        {
            typeString = "-m application/pdf";
            ext = "pdf";
        }
        else if (type == "image/svg+xml")
        {
            ext = "svg";
        }

        string path = context.Request.PhysicalPath;

        string outfile = string.Format("{0}{1}.{2}", Path.GetTempPath(), tempName, ext);
        string tempSvgPath = string.Format("{0}{1}.svg", Path.GetTempPath(), tempName);

        if (!string.IsNullOrEmpty(typeString))
        {
            string width = "";
            if (context.Request.Form["width"] != null)
            {
                width = "-w " + context.Request.Form["width"];
            }

            try
            {
                File.WriteAllText(tempSvgPath, svg);
            }
            catch
            {
                context.Response.Write("Can't write to file. Check permissions.");
                return;
            }

            string batikPath = context.Server.MapPath(@"~/../SvgConvert/batik/batik-rasterizer.jar");

            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "java";
            psi.Arguments = string.Format("-jar {0} {1} -d {2} {3} {4}", batikPath, typeString, outfile, width, tempSvgPath);
            psi.UseShellExecute = false;

            Process p = Process.Start(psi);
            p.WaitForExit();

            if (!File.Exists(outfile) || (new FileInfo(outfile)).Length < 10)
            {
                context.Response.Write(string.Format("<pre>{0}</pre>Error while converting SVG", p.ExitCode.ToString()));
            }
            else
            {
                context.Response.ContentType = type;
                context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "." + ext);

                FileStream s = File.Open(outfile, FileMode.Open);
                BinaryReader r = new BinaryReader(s);
                Byte[] bytes = r.ReadBytes((int)s.Length);
                r.Close();

                context.Response.BinaryWrite(bytes);
                context.Response.Flush();

                File.Delete(tempSvgPath);
                File.Delete(outfile);
            }
        }
        else if (ext == "svg")
        {
            context.Response.ContentType = type;
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "." + ext);
            context.Response.Write(svg);
        }
        else
        {
            context.Response.Write("Invalid type");
        }

        context.Response.End();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}