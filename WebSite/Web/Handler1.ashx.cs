using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace ECS_Web
{
    /// <summary>
    /// Summary description for Handler1
    /// </summary>
    public class Handler1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string _Type = context.Request["Type"];
            string _Token = context.Request["Token"];
            if (_Type.Equals("ColumnLine"))
            {
                //needed to generate random numbers
                Random rnd = new Random();

                int[] yRange1_space = Enumerable.Range(0, 0).OrderBy(i => rnd.Next()).Take(6).ToArray();

                //select 12 random numbers between 1 and 50 for column chart
                int[] yRange1 = Enumerable.Range(1, 500).OrderBy(i => rnd.Next()).Take(6).ToArray();
                int[] yRange1_actual = Enumerable.Range(1, 300).OrderBy(i => rnd.Next()).Take(6).ToArray();
                int[] yRange1_actual_ktc = Enumerable.Range(1, 100).OrderBy(i => rnd.Next()).Take(6).ToArray();

                //select 12 random numbers between 1 and 25 for line chart
                int[] yRange2 = Enumerable.Range(0, 100).OrderBy(i => rnd.Next()).Take(6).ToArray();

                //select all the month names for the labels
                string[] xLabels = Enumerable.Range(1, 6).Select(i => DateTimeFormatInfo.CurrentInfo.GetMonthName(i)).ToArray();

                //create the chart
                Chart chart = new Chart();
                chart.Titles.Add("Chart Column Target, Actual, %");
                chart.EnableTheming = true;

                chart.Legends.Add("Target");
                //chart.Legends["Target"].Position.Auto =false;
                //chart.Legends["Target"].Position = new ElementPosition(30, 5, 100, 20);
                chart.Legends["Target"].Docking = Docking.Bottom;
                chart.Legends["Target"].IsDockedInsideChartArea = false;
                chart.Legends["Target"].Alignment = System.Drawing.StringAlignment.Center;


                //add the bar chart series
                Series series = new Series("Target");
                series.LegendText = "Số CH";
                series.ChartType = SeriesChartType.StackedColumn;
                series.IsValueShownAsLabel = true; // hiển thị value trên cột or line
                series.LabelFormat = "{0}-CH"; // format hiển thị value trên cột or line
                series.Legend = "Target";
                series.IsVisibleInLegend = true; /// Hiển thị legend;
                chart.Series.Add(series);


                //add the bar chart series
                Series series_a = new Series("ActualTC");
                series_a.ChartType = SeriesChartType.StackedColumn;
                series_a.IsValueShownAsLabel = true; // hiển thị value trên cột or line
                series_a.LabelFormat = "{0}CH"; // format hiển thị value trên cột or line
                series_a.IsVisibleInLegend = true; /// Hiển thị legend;
                chart.Series.Add(series_a);

                //add the bar chart series ktc
                Series series_a_ktc = new Series("ActualKTC");
                series_a_ktc.ChartType = SeriesChartType.StackedColumn;
                series_a_ktc.IsValueShownAsLabel = true; // hiển thị value trên cột or line
                series_a_ktc.LabelFormat = "{0}CH"; // format hiển thị value trên cột or line
                series_a_ktc.IsVisibleInLegend = true; /// Hiển thị legend;
                chart.Series.Add(series_a_ktc);


                //add the line chart series
                Series series2 = new Series("ChartLine");
                series2.LegendText = "Tỉ lệ %";
                //series2.Label = "Tỉ lệ Audit";
                series2.ChartType = SeriesChartType.Spline;
                series2.Color = System.Drawing.Color.Purple;
                series2.BorderWidth = 1;
                series2.IsValueShownAsLabel = true; // hiển thị value trên cột or line
                series2.LabelFormat = "{0}%"; // format hiển thị value trên cột or line
                series2.IsVisibleInLegend = true; /// Hiển thị legend;
                series2.YAxisType = AxisType.Secondary;
                chart.Series.Add(series2);

                //define the chart area
                ChartArea chartArea = new ChartArea();
                Axis yAxis = new Axis(chartArea, AxisName.Y);
                Axis xAxis = new Axis(chartArea, AxisName.X);
                Axis yAxis2 = new Axis(chartArea, AxisName.Y2);

                //add the data and define color
                chart.Series["Target"].Points.DataBindXY(xLabels, yRange1);
                chart.Series["Target"].Color = System.Drawing.ColorTranslator.FromHtml("#85C1E9");// System.Drawing.Color.Green;
                //chart.Series["Target"]["PointWidth"] = (0.6).ToString();

                //add the data and define color
                chart.Series["ActualTC"].Points.DataBindXY(xLabels, yRange1_actual);
                chart.Series["ActualTC"].Color = System.Drawing.Color.Green;// System.Drawing.Color.Green;

                // add the data and define color
                chart.Series["ActualKTC"].Points.DataBindXY(xLabels, yRange1_actual_ktc);
                chart.Series["ActualKTC"].Color = System.Drawing.Color.Red;// System.Drawing.Color.Green;

                chart.Series["ChartLine"].Points.DataBindXY(xLabels, yRange2);
                chart.Series["ChartLine"].Color = System.Drawing.ColorTranslator.FromHtml("#EC7063");

                chart.Series["Target"].CustomProperties = "StackedGroupName=Group2";
                chart.Series["ActualTC"].CustomProperties = "StackedGroupName=Group1";
                chart.Series["ActualKTC"].CustomProperties = "StackedGroupName=Group1";


                chart.ChartAreas.Add(chartArea);
                chart.ChartAreas[0].AxisX.LabelStyle.Interval = 1;
                chart.ChartAreas[0].AxisX.Interval = 1; // Show all titel dưới của các cột

                chart.ChartAreas[0].AxisX.Title = "Các tháng trong năm";
                chart.ChartAreas[0].AxisY.Title = "Số CH";
                chart.ChartAreas[0].AxisY.LabelStyle.Format = "{0} CH L";
                chart.ChartAreas[0].AxisY.MajorGrid.LineColor = System.Drawing.Color.LightGray;
                chart.ChartAreas[0].AxisX.MajorGrid.LineColor = System.Drawing.Color.LightGray;
                chart.ChartAreas[0].AxisX.MajorGrid.Enabled = false;

                chart.ChartAreas[0].AxisY2.Title = "Tỉ lệ %";
                chart.ChartAreas[0].AxisY2.LabelStyle.Format = "{0}%";
                //chart.ChartAreas[0].AxisY2.TitleFont = new System.Drawing.Font("Arial, Helvetica, sans-serif", 12, System.Drawing.FontStyle.Regular);
                chart.ChartAreas[0].AxisY2.MajorGrid.LineColor = System.Drawing.Color.LightGray;
                chart.ChartAreas[0].AxisY2.MajorGrid.Enabled = false;
                //chart.Series["Target"]["PointWidth"] = "0.6";
                //chart.Series["ActualTC"]["PointWidth"] = "0.6";
                //chart.Series["ActualKTC"]["PointWidth"] = "0.6";
                //chart.Series["Space"]["PointWidth"] = "0.2";

                //chart.Series["Space"].SetCustomProperty("PointWidth", "0.2");

                //chart.Series["Target"].BorderDashStyle = ChartDashStyle.Solid;
                //chart.Series["Target"].BorderColor = System.Drawing.Color.White;
                //chart.Series["Target"].BorderWidth = 2;

                //chart.Series["ActualTC"].BorderDashStyle = ChartDashStyle.Solid;
                //chart.Series["ActualTC"].BorderColor = System.Drawing.Color.White;
                //chart.Series["ActualTC"].BorderWidth = 2;

                //chart.Series["ActualKTC"].BorderDashStyle = ChartDashStyle.Solid;
                //chart.Series["ActualKTC"].BorderColor = System.Drawing.Color.White;
                //chart.Series["ActualKTC"].BorderWidth = 2;

                //set the dimensions of the chart
                //chart.Width = new Unit(2000, UnitType.Pixel);
                //chart.Height = new Unit(1333, UnitType.Pixel);
                chart.Width = new Unit(800, UnitType.Pixel);
                chart.Height = new Unit(533, UnitType.Pixel);

                //create an empty byte array
                byte[] bin = new byte[0];

                //save the chart to the stream instead of a file
                using (MemoryStream stream = new MemoryStream())
                {
                    chart.SaveImage(stream, ChartImageFormat.Png);

                    //write the stream to a byte array
                    bin = stream.ToArray();
                }

                //send the result to the browser
                context.Response.ContentType = "image/png";
                context.Response.AddHeader("content-length", bin.Length.ToString());
                context.Response.AddHeader("content-disposition", "attachment; filename=\"chart.png\"");
                context.Response.OutputStream.Write(bin, 0, bin.Length);
            }
            if (_Type.Equals("3dchart"))
            {
                
            }
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