using CitizenScienceClasses;
using CsvHelper;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace CitizenScienceClasses
{
    public static class DataProcessor
    {
        public static List<Temperature> ReadCsvFile(Stream filestream)
        {
            List<Temperature> result = new List<Temperature>();

            using (StreamReader streamReader = new StreamReader(filestream))
            using (CsvReader csvReader = new CsvReader(streamReader))
            {
                result = csvReader.GetRecords<Temperature>().ToList();
            }

            return result;
        }

        public static byte[] CreateCsvAsBytes(List<Temperature> temperatureList)
        {
            byte[] result = new byte[0];

            using (MemoryStream memoryStream = new MemoryStream())
            {
                using (StreamWriter streamWriter = new StreamWriter(memoryStream))
                using (CsvWriter csvWriter = new CsvWriter(streamWriter))
                {
                    csvWriter.WriteRecords(temperatureList);
                }

                result = memoryStream.ToArray();
            }

            //todo: make more descriptive exception
            if (result.Length.Equals(0)) throw new Exception("Error Creating CSV File");

            return result;
        }

        //public static int AuthenticateAdmin (string tu_id)
        //{

        //}



    }
}