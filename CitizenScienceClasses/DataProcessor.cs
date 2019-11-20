using CitizenScienceClasses;
using CsvHelper;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Drawing;
using System.Drawing.Imaging;

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

        private const int exifOrientationID = 0x112; //274
        // Processes image bytes before storing in the database
        public static byte[] ProcessImage(byte[] imageBytes, string contentType)
        {
            byte[] returnResult = imageBytes;
            System.Drawing.Image img = null;

            using (var inStream = new MemoryStream(imageBytes))
            {
                img = System.Drawing.Image.FromStream(inStream);

                if (!img.PropertyIdList.Contains(exifOrientationID))
                    return returnResult;

                var prop = img.GetPropertyItem(exifOrientationID);
                int val = BitConverter.ToUInt16(prop.Value, 0);
                var rot = RotateFlipType.RotateNoneFlipNone;

                if (val == 3 || val == 4)
                    rot = RotateFlipType.Rotate180FlipNone;
                else if (val == 5 || val == 6)
                    rot = RotateFlipType.Rotate90FlipNone;
                else if (val == 7 || val == 8)
                    rot = RotateFlipType.Rotate270FlipNone;

                if (val == 2 || val == 4 || val == 5 || val == 7)
                    rot |= RotateFlipType.RotateNoneFlipX;

                if (rot != RotateFlipType.RotateNoneFlipNone) { 
                    img.RotateFlip(rot);

                    using (var outStream = new MemoryStream())
                    {
                        ImageFormat imageFormat = ImageFormat.MemoryBmp;
                        contentType = contentType.ToLower();

                        if (contentType.Equals("image/jpeg") || contentType.Equals("image/jpg"))
                        {
                            imageFormat = ImageFormat.Jpeg;
                        }
                        else if (contentType.Equals("image/gif"))
                        {
                            imageFormat = ImageFormat.Gif;
                        } 
                        else if (contentType.Equals("image/png"))
                        {
                            imageFormat = ImageFormat.Png;
                        } 
                        else if (contentType.Equals("image/bmp"))
                        {
                            imageFormat = ImageFormat.Bmp;
                        }
                        else if (contentType.Equals("image/tif") || contentType.Equals("image/tiff"))
                        {
                            imageFormat = ImageFormat.Tiff;
                        }

                        img.Save(outStream, imageFormat);
                        returnResult =  outStream.ToArray();
                    }
                }
            }

            return returnResult;
        }
    }
}