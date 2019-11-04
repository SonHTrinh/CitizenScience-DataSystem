using CitizenScienceClasses;
using CsvHelper;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
//                while (csvReader.Read())
//                {
//                    Temperature temperature = new Temperature();
//                    temperature.Timestamp = DateTime.Parse(csvReader.GetField(0));
//                    temperature.Celsius = double.Parse(csvReader.GetField(1));
//                    temperature.Fahrenheit = double.Parse(csvReader.GetField(2));
//                    result.Add(temperature);
//                }
                var records = csvReader.GetRecords<Temperature>();
                result = records.ToList();
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

        public static DataSet AuthenticateAdmin(string tu_id)
        {
            string employeeNumber = tu_id;
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "ValidateAdmin";

            // uncomment for live version
            comm.Parameters.AddWithValue("@TU_ID", employeeNumber);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            return dataSet; 
            
        }
    }
}