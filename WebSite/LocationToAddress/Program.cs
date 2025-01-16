using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace LocationToAddress
{

    class Program
    {
        static void Main(string[] args)
        {
            RootObject rootObject = getAddress(20.9708883, 105.7755754);
            Console.WriteLine("Full Address " + rootObject.display_name);

        //    string Address_ShortName, Address_country, Address_administrative_area_level_1 = "";
        //    string Address_administrative_area_level_2 = "";
        //    string Address_administrative_area_level_3 = "";
        //    string Address_colloquial_area = "";
        //    string Address_locality = "";
        //    string Address_sublocality = "";
        //    string Address_neighborhood = "";
        //    ReverseGeoLoc("105.7755754","20.9708883", out Address_ShortName, out Address_country, out Address_administrative_area_level_1,
        //        out Address_administrative_area_level_2,
        //        out Address_administrative_area_level_3,
        //out Address_colloquial_area,
        //out Address_locality,
        //out Address_sublocality,
        //out Address_neighborhood);

        //    Console.WriteLine("Address_ShortName: " + Address_ShortName);

        }
        public static RootObject getAddress(double lat, double lon)
        {
            WebClient webClient = new WebClient();
            webClient.Headers.Add("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; .NET CLR 1.0.3705;)");
            webClient.Headers.Add("Referer", "http://www.microsoft.com");
            var jsonData = webClient.DownloadData("http://nominatim.openstreetmap.org/reverse?format=json&lat=" + lat + "&lon=" + lon);
            DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(RootObject));
            RootObject rootObject = (RootObject)ser.ReadObject(new MemoryStream(jsonData));
            return rootObject;
        }
        public static string ReverseGeoLoc(string longitude, string latitude,
        out string Address_ShortName,
        out string Address_country,
        out string Address_administrative_area_level_1,
        out string Address_administrative_area_level_2,
        out string Address_administrative_area_level_3,
        out string Address_colloquial_area,
        out string Address_locality,
        out string Address_sublocality,
        out string Address_neighborhood)
        {

            Address_ShortName = "";
            Address_country = "";
            Address_administrative_area_level_1 = "";
            Address_administrative_area_level_2 = "";
            Address_administrative_area_level_3 = "";
            Address_colloquial_area = "";
            Address_locality = "";
            Address_sublocality = "";
            Address_neighborhood = "";

            XmlDocument doc = new XmlDocument();

            try
            {
                doc.Load("http://maps.googleapis.com/maps/api/geocode/xml?key=AIzaSyDwgPnM_mpRuCDWgP2I8MCJ3EmkLiT9bGE&latlng=" + latitude + "," + longitude + "&sensor=false");
                XmlNode element = doc.SelectSingleNode("//GeocodeResponse/status");
                if (element.InnerText == "ZERO_RESULTS")
                {
                    return ("No data available for the specified location");
                }
                else
                {

                    element = doc.SelectSingleNode("//GeocodeResponse/result/formatted_address");

                    string longname = "";
                    string shortname = "";
                    string typename = "";
                    bool fHit = false;


                    XmlNodeList xnList = doc.SelectNodes("//GeocodeResponse/result/address_component");
                    foreach (XmlNode xn in xnList)
                    {
                        try
                        {
                            longname = xn["long_name"].InnerText;
                            shortname = xn["short_name"].InnerText;
                            typename = xn["type"].InnerText;


                            fHit = true;
                            switch (typename)
                            {
                                //Add whatever you are looking for below
                                case "country":
                                    {
                                        Address_country = longname;
                                        Address_ShortName = shortname;
                                        break;
                                    }

                                case "locality":
                                    {
                                        Address_locality = longname;
                                        //Address_locality = shortname; //Om Longname visar sig innehålla konstigheter kan man använda shortname istället
                                        break;
                                    }

                                case "sublocality":
                                    {
                                        Address_sublocality = longname;
                                        break;
                                    }

                                case "neighborhood":
                                    {
                                        Address_neighborhood = longname;
                                        break;
                                    }

                                case "colloquial_area":
                                    {
                                        Address_colloquial_area = longname;
                                        break;
                                    }

                                case "administrative_area_level_1":
                                    {
                                        Address_administrative_area_level_1 = longname;
                                        break;
                                    }

                                case "administrative_area_level_2":
                                    {
                                        Address_administrative_area_level_2 = longname;
                                        break;
                                    }

                                case "administrative_area_level_3":
                                    {
                                        Address_administrative_area_level_3 = longname;
                                        break;
                                    }

                                default:
                                    fHit = false;
                                    break;
                            }


                            if (fHit)
                            {
                                Console.Write(typename);
                                Console.ForegroundColor = ConsoleColor.Green;
                                Console.Write("\tL: " + longname + "\tS:" + shortname + "\r\n");
                                Console.ForegroundColor = ConsoleColor.Gray;
                            }
                        }

                        catch (Exception e)
                        {
                            //Node missing either, longname, shortname or typename
                            fHit = false;
                            Console.Write(" Invalid data: ");
                            Console.ForegroundColor = ConsoleColor.Red;
                            Console.Write("\tX: " + xn.InnerXml + "\r\n");
                            Console.ForegroundColor = ConsoleColor.Gray;
                        }


                    }

                    //Console.ReadKey();
                    return (element.InnerText);
                }

            }
            catch (Exception ex)
            {
                return ("(Address lookup failed: ) " + ex.Message);
            }
        }
    }

    [DataContract]
    public class Address
    {
        [DataMember]
        public string road { get; set; }
        [DataMember]
        public string suburb { get; set; }
        [DataMember]
        public string city { get; set; }
        [DataMember]
        public string state_district { get; set; }
        [DataMember]
        public string state { get; set; }
        [DataMember]
        public string postcode { get; set; }
        [DataMember]
        public string country { get; set; }
        [DataMember]
        public string country_code { get; set; }
    }
    [DataContract]
    public class RootObject
    {
        [DataMember]
        public string place_id { get; set; }
        [DataMember]
        public string licence { get; set; }
        [DataMember]
        public string osm_type { get; set; }
        [DataMember]
        public string osm_id { get; set; }
        [DataMember]
        public string lat { get; set; }
        [DataMember]
        public string lon { get; set; }
        [DataMember]
        public string display_name { get; set; }
        [DataMember]
        public Address address { get; set; }
    }
}
