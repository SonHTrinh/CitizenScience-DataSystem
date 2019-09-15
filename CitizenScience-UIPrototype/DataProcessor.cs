using CsvHelper;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace CitizenScience_UIPrototype
{
    public static class DataProcessor
    {
        public static List<DataPoint> Read(Stream filestream)
        {
            List<DataPoint> result = new List<DataPoint>();

            using (var reader = new StreamReader(filestream))
            using (var csv = new CsvReader(reader))
            {
                var records = new List<DataPoint>();

                csv.Read();
                csv.ReadHeader();
                while (csv.Read())
                {
                    string date = csv.GetField("Date");
                    string time = csv.GetField("Time");

                    //DateTime timestamp = DateTime.ParseExact($"{date} {time}", "dd-MM-yyyy HH:mm", CultureInfo.InvariantCulture);
                    DateTime timestamp = DateTime.Parse($"{date} {time}");

                    var record = new DataPoint
                    {
                        Timestamp = timestamp,
                        Celsius = csv.GetField<float>("Temperature_C"),
                        Fahrenheit = csv.GetField<float>("Temperature_F")
                    };

                    result.Add(record);
                }

                //records.ForEach(x => result = result + $"{x.Fahrenheit} , ");
            }

            return result;
        }
    }
}