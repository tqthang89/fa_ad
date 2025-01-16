using BLL.WorkResults;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace ExportFile
{
    class Program
    {
        public static string bodau(string accented)
        {
            Regex regex = new Regex(@"\p{IsCombiningDiacriticalMarks}+");
            string strFormD = accented.Normalize(System.Text.NormalizationForm.FormD);
            return regex.Replace(strFormD, String.Empty).Replace('\u0111', 'd').Replace('\u0110', 'D');
        }
        static void Main(string[] args)
        {
            string rootPath = WebConfigurationManager.AppSettings["SourceUrl"];

            string fordername = String.Format("Image_Images_{0}{1}", DateTime.Now.Second, DateTime.Now.Millisecond);
            string targetPath = "";

            string shopcode_issue = "";
            using (DataTable dt = new WorkResultController().ExportFile(1,  20221001,20221031 ))
            {

                if (dt != null && dt.Rows.Count > 0)
                {
                    int i = 1;
                    for (int r = 0; r < dt.Rows.Count; r++)
                    {
                        DataRow dr = dt.Rows[r];
                        string _photoonline = dr["PhotoOnline"].ToString();
                        try
                        {
                            string _shoprype = bodau(dr["ShopType"].ToString().Replace("/", "-").Replace(".", "-"));
                            string _area = bodau(dr["Area"].ToString().Replace("/", "-").Replace(".", "-"));
                            string _province = bodau(dr["Province"].ToString().Replace("/", "-").Replace(".", "-"));
                            string _shopcode = dr["ShopCode"].ToString().Replace("/", "-").Replace(".", "-");
                            string _photo = dr["Photo"].ToString();
                            
                            string _phototype = dr["PhotoType"].ToString();
                            if (!System.IO.Directory.Exists(rootPath + "FilesExport/" + fordername + "/" + _shoprype + "/" + _area + "/" + _province + "/" + _shopcode))
                            {
                                System.IO.Directory.CreateDirectory(rootPath + "FilesExport/" + fordername + "/" + _shoprype + "/" + _area + "/" + _province + "/" + _shopcode);
                                i = 1;
                            }
                            targetPath = rootPath + "FilesExport/" + fordername + "/" + _shoprype + "/" + _area + "/" + _province + "/" + _shopcode;
                            shopcode_issue = _shopcode;
                            FileInfo file1 = new FileInfo(_photo);
                            if (file1.Exists)
                            {
                                file1.CopyTo(targetPath + "/" + _phototype + i.ToString() + file1.Extension, true);
                                File.AppendAllText(@"D:\ExportFrancia\file.txt", string.Format("{0}{1}", _photoonline, Environment.NewLine));
                            }
                            else
                            {
                                file1 = new FileInfo(rootPath + "noimages.jpg");
                                if (file1.Exists)
                                    file1.CopyTo(targetPath + "/" + _phototype + i.ToString() + file1.Extension);
                                File.AppendAllText(@"D:\ExportFrancia\file.txt", string.Format("{0}{1}", _photoonline +"_noimage", Environment.NewLine));
                            }
                            i++;
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine(shopcode_issue + "_" + ex.Message.Replace("'", ""));
                            File.AppendAllText(@"D:\ExportFrancia\file.txt", string.Format("{0}{1}", _photoonline + ex.Message, Environment.NewLine));
                        }
                    }

                    Console.WriteLine("Export Successful");
                    Console.ReadLine();
                }
            }
        }
    }
}
