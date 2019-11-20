using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace CitizenScienceClasses
{
    public static class ClassFunctions
    {
        /////////////////////////////////   BULKUPLOAD FUNCTIONS    
        public static DataSet GetBulkUploads()
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllBulkUploads";
            return conn.GetDataSetUsingCmdObj(comm);
        }



        /////////////////////////////////   LOCATION FUNCTIONS
        public static DataSet GetLocations()
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllLocations";
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static DataSet GetLocationsByWatershed(int watershedID)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetLocationsByWatershed";
            comm.Parameters.AddWithValue("@watershedID", watershedID);
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static Location CreateLocation(int watershedId, string name, double latitude, double longitude, int imageid)
        {
            Location result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "CreateLocation";
            comm.Parameters.AddWithValue("@watershedid", watershedId);
            comm.Parameters.AddWithValue("@name", name);
            comm.Parameters.AddWithValue("@latitude", latitude);
            comm.Parameters.AddWithValue("@longitude", longitude);
            comm.Parameters.AddWithValue("@imageid", imageid);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Location
                {
                    LocationID = Convert.ToInt32(dataRow["LocationID"]),
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    SensorName = Convert.ToString(dataRow["SensorName"]),
                    Latitude = Convert.ToDouble(dataRow["Latitude"]),
                    Longitude = Convert.ToDouble(dataRow["Longitude"]),
                    AlbumId = Convert.ToInt32(dataRow["AlbumId"])
                };
            }

            return result;
        }
        public static Location ReadLocation(int id)
        {
            Location result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "ReadLocation";
            comm.Parameters.AddWithValue("@id", id);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Location
                {
                    LocationID = Convert.ToInt32(dataRow["LocationID"]),
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    SensorName = Convert.ToString(dataRow["SensorName"]),
                    Latitude = Convert.ToDouble(dataRow["Latitude"]),
                    Longitude = Convert.ToDouble(dataRow["Longitude"]),
                };
            }

            return result;
        }
        public static List<Location> ReadAllLocation()
        {
            List<Location> result = new List<Location>();

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllLocations";

            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            for (int i = 0; i < dataSet.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[i];

                Location location = new Location
                {
                    LocationID = Convert.ToInt32(dataRow["LocationID"]),
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    SensorName = Convert.ToString(dataRow["SensorName"]),
                    Latitude = Convert.ToDouble(dataRow["Latitude"]),
                    Longitude = Convert.ToDouble(dataRow["Longitude"])
                };

                result.Add(location);
            }

            return result;
        }
        public static Location UpdateLocation(int id, int watershedId, string name, double latitude, double longitude)
        {
            Location result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "UpdateLocation";
            comm.Parameters.AddWithValue("@id", id);
            comm.Parameters.AddWithValue("@watershedid", watershedId);
            comm.Parameters.AddWithValue("@name", name);
            comm.Parameters.AddWithValue("@latitude", latitude);
            comm.Parameters.AddWithValue("@longitude", longitude);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Location
                {
                    LocationID = Convert.ToInt32(dataRow["LocationID"]),
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    SensorName = Convert.ToString(dataRow["SensorName"]),
                    Latitude = Convert.ToDouble(dataRow["Latitude"]),
                    Longitude = Convert.ToDouble(dataRow["Longitude"])
                };
            }

            return result;
        }
        public static bool DeleteLocation(int id)
        {
            bool result = false;

            //TODO: handle deletion/archiving

            return result;
        }



        /////////////////////////////////   TEMPERATURE FUNCTIONS
        public static DataSet GetAllTemperatures()
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllTemperatures";
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static DataSet GetSelectedTemperatures(List<int> selectedLocations)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static DataSet GetAllTemperaturesByLocationId(int locationId)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllTemperaturesByLocationId";
            comm.Parameters.AddWithValue("@locationID", locationId);
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static DataSet GetAllTemperaturesByMultipleLocationIds(List<int> locationIdList)
        {
            string commaList = string.Join(", ", locationIdList.Select(id => id));

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllTemperaturesByMultipleLocationIds";
            comm.Parameters.AddWithValue("@listOfLocationID", commaList);
            return conn.GetDataSetUsingCmdObj(comm);
        }  


        public static DataSet GetTemperaturesByLocationIdStartNoEnd(int locationID, DateTime startDate)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetTemperaturesByLocationIdStartNoEnd";
            comm.Parameters.AddWithValue("@locationID", locationID);
            comm.Parameters.AddWithValue("@startDate", startDate);
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static DataSet GetTemperaturesByLocationIdNoStartEnd(int locationID, DateTime endDate)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetTemperaturesByLocationIdNoStartEnd";
            comm.Parameters.AddWithValue("@locationID", locationID);
            comm.Parameters.AddWithValue("@endDate", endDate);
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static DataSet GetTemperaturesByLocationIdStartEnd(int locationID, DateTime startDate, DateTime endDate)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetTemperaturesByLocationIdStartEnd";
            comm.Parameters.AddWithValue("@locationID", locationID);
            comm.Parameters.AddWithValue("@startDate", startDate);
            comm.Parameters.AddWithValue("@endDate", endDate);
            return conn.GetDataSetUsingCmdObj(comm);
        }


        public static int AddTempsToDatabase(List<Temperature> temperatureList, int locationid)
        {
            int k = 0;
            DBConnect objDb = new DBConnect();
            foreach (Temperature t in temperatureList)
            {
                SqlCommand comm = new SqlCommand();
                comm.CommandType = CommandType.StoredProcedure;
                comm.CommandText = "AddTemperatures";
                comm.Parameters.AddWithValue("@locationid", locationid);
                comm.Parameters.AddWithValue("@ts", t.Timestamp);
                comm.Parameters.AddWithValue("@temp_c", t.Celsius);
                comm.Parameters.AddWithValue("@temp_f", t.Fahrenheit);

                k = objDb.DoUpdateUsingCmdObj(comm);
            }
            return k;
        }
        public static int BulkTemperatureDataInsert(List<Temperature> temperatureList, int locationid)
        {
            int result = 0;

            DataTable dataTable = new DataTable();

            dataTable.Columns.Add(new DataColumn("LocationID", typeof(string)));
            dataTable.Columns.Add(new DataColumn("Timestamp", typeof(DateTime)));
            dataTable.Columns.Add(new DataColumn("TempC", typeof(double)));
            dataTable.Columns.Add(new DataColumn("TempF", typeof(double)));

            foreach(Temperature temperature in temperatureList)
            {
                dataTable.Rows.Add(locationid, temperature.Timestamp, temperature.Celsius, temperature.Fahrenheit);
            }

            DBConnect objDb = new DBConnect();

            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "BulkTemperatureDataInsert";
            comm.Parameters.AddWithValue("@temperaturetable", dataTable);

            result = objDb.DoUpdateUsingCmdObj(comm);

            return result;
        }

        public static List<Temperature> GetLocationTemperaturesByDateRange(int locationId, DateTime startDate, DateTime endDate)
        {
            List<Temperature> result = new List<Temperature>();

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetLocationTemperaturesByDateRange";
            comm.Parameters.AddWithValue("@locationid", locationId);
            comm.Parameters.AddWithValue("@startdate", startDate);
            comm.Parameters.AddWithValue("@enddate", endDate);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            foreach(DataRow dataRow in dataSet.Tables[0].Rows)
            {
                result.Add(new Temperature
                {
                    Id = Convert.ToInt32(dataRow["TempID"]),
                    Timestamp = Convert.ToDateTime(dataRow["Timestamp"]),
                    Celsius = Convert.ToDouble(dataRow["TempC"]),
                    Fahrenheit = Convert.ToDouble(dataRow["TempF"])
                });
            }

            return result;
        }

        public static Temperature GetLatestLocationTemperature(int locationId)
        {
            Temperature result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetLatestLocationTemperature";
            comm.Parameters.AddWithValue("@locationid", locationId);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            foreach (DataRow dataRow in dataSet.Tables[0].Rows)
            {
                result = new Temperature
                {
                    Id = Convert.ToInt32(dataRow["TempID"]),
                    Timestamp = Convert.ToDateTime(dataRow["Timestamp"]),
                    Celsius = Convert.ToDouble(dataRow["TempC"]),
                    Fahrenheit = Convert.ToDouble(dataRow["TempF"])
                };
            }

            return result;
        }


        /////////////////////////////////   WATERSHED FUNCTIONS
        public static DataSet GetWatersheds()
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllWatersheds";
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static Watershed CreateWatershed(string name)
        {
            Watershed watershed = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "CreateWatershed";
            comm.Parameters.AddWithValue("@name", name);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if(dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                watershed = new Watershed
                {
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    WatershedName = Convert.ToString(dataRow["WatershedName"])
                };
            }

            return watershed;
        }
        public static Watershed ReadWatershed(int id)
        {
            Watershed watershed = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "ReadWatershed";
            comm.Parameters.AddWithValue("@id", id);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                watershed = new Watershed
                {
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    WatershedName = Convert.ToString(dataRow["WatershedName"])
                };
            }
            
            return watershed;
        }
        public static Watershed UpdateWatershed(int id, string name)
        {
            Watershed watershed = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "UpdateWatershed";
            comm.Parameters.AddWithValue("@id", id);
            comm.Parameters.AddWithValue("@name", name);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                watershed = new Watershed
                {
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    WatershedName = Convert.ToString(dataRow["WatershedName"])
                };
            }

            return watershed;
        }
        public static bool DeleteWatershed(int id)
        {
            bool result = false;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "DeleteWatershed";
            comm.Parameters.AddWithValue("@id", id);
            result = (conn.DoUpdateUsingCmdObj(comm) == 1);


            return result;
        }

        ///////////////////////////////// IMAGE Functions

        public static Image UploadImage(byte[] bytes, string contentType, string filename)
        {
            Image result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "UploadImage";
            comm.Parameters.AddWithValue("@bytes", DataProcessor.ProcessImage(bytes, contentType));
            comm.Parameters.AddWithValue("@contenttype", contentType);
            comm.Parameters.AddWithValue("@filename", filename);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Image
                {
                    ImageID = Convert.ToInt32(dataRow["ImageID"]),
                    ContentType = Convert.ToString(dataRow["ContentType"]),
                    Filename = Convert.ToString(dataRow["Filename"]),
                    Bytes = dataRow["Bytes"] as byte[]
                };
            }

            return result;
        }

        public static Image UploadAlbumImage(byte[] bytes, string contentType, string filename, int albumId)
        {
            Image result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "UploadAlbumImage";
            comm.Parameters.AddWithValue("@albumid", albumId);
            comm.Parameters.AddWithValue("@bytes", DataProcessor.ProcessImage(bytes, contentType));
            comm.Parameters.AddWithValue("@contenttype", contentType);
            comm.Parameters.AddWithValue("@filename", filename);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Image
                {
                    ImageID = Convert.ToInt32(dataRow["ImageID"]),
                    ContentType = Convert.ToString(dataRow["ContentType"]),
                    Filename = Convert.ToString(dataRow["Filename"]),
                };
            }

            return result;
        }

        public static bool DeleteImageById(int imageId)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "DeleteImageByID";
            comm.Parameters.AddWithValue("@imageid", imageId);
            int result = conn.DoUpdateUsingCmdObj(comm);

            return result >= 1;
        }
        public static bool SetImageIDAsAlbumProfileImageID(int imageId, int albumId)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "SetImageIDAsAlbumProfileImageID";
            comm.Parameters.AddWithValue("@imageid", imageId);
            comm.Parameters.AddWithValue("@albumid", albumId);
            int result = conn.DoUpdateUsingCmdObj(comm);

            return result >= 1;
        }

        public static Image GetImage(int imageId)
        {
            Image result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetImage";
            comm.Parameters.AddWithValue("@imageid", imageId);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Image
                {
                    ImageID = Convert.ToInt32(dataRow["ImageID"]),
                    Bytes = dataRow["Bytes"] as byte[],
                    Filename = Convert.ToString(dataRow["Filename"]),
                    ContentType = Convert.ToString(dataRow["ContentType"])
                };
            }

            return result;
        }

        public static Image GetImageInfo(int imageId)
        {
            Image result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetImage";
            comm.Parameters.AddWithValue("@imageid", imageId);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Image
                {
                    ImageID = Convert.ToInt32(dataRow["ImageID"]),
                    Filename = Convert.ToString(dataRow["Filename"]),
                    ContentType = Convert.ToString(dataRow["ContentType"])
                };
            }

            return result;
        }

        public static Location SetLocationImage(int locationId, byte[] bytes, string contentType)
        {
            Location result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "SetLocationImage";
            comm.Parameters.AddWithValue("@locationid", locationId);
            comm.Parameters.AddWithValue("@bytes", DataProcessor.ProcessImage(bytes, contentType));
            comm.Parameters.AddWithValue("@contenttype", contentType);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Location
                {
                    LocationID = Convert.ToInt32(dataRow["LocationID"]),
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    Latitude = Convert.ToDouble(dataRow["Latitude"]),
                    Longitude = Convert.ToDouble(dataRow["Longitude"]),
                    SensorName = Convert.ToString(dataRow["SensorName"]),
                    AlbumId = Convert.ToInt32(dataRow["AlbumId"])
                };
            }

            return result;
        }

        public static Image GetLocationImage(int locationId)
        {
            Image result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetLocationImage";
            comm.Parameters.AddWithValue("@locationid", locationId);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Image
                {
                    ImageID = Convert.ToInt32(dataRow["ImageID"]),
                    Bytes = dataRow["Bytes"] as byte[],
                    Filename = Convert.ToString(dataRow["Filename"]),
                    ContentType = Convert.ToString(dataRow["ContentType"])
                };
            }

            return result;
        }

        public static Image GetAlbumProfileImage(int albumId)
        {
            Image result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAlbumProfileImage";
            comm.Parameters.AddWithValue("@albumid", albumId);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Image
                {
                    ImageID = Convert.ToInt32(dataRow["ImageID"]),
                    Bytes = dataRow["Bytes"] as byte[],
                    Filename = Convert.ToString(dataRow["Filename"]),
                    ContentType = Convert.ToString(dataRow["ContentType"])
                };
            }

            return result;
        }
        public static Image GetAlbumProfileImageDetails(int albumId)
        {
            Image result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAlbumProfileImageDetails";
            comm.Parameters.AddWithValue("@albumid", albumId);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Image
                {
                    ImageID = Convert.ToInt32(dataRow["ImageID"]),
                    Filename = Convert.ToString(dataRow["Filename"])
                };
            }

            return result;
        }

        public static List<int> GetAlbumImageIDs(int albumId)
        {
            List<int> result = new List<int>();

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAlbumImageIDs";
            comm.Parameters.AddWithValue("@albumid", albumId);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            foreach (DataRow dataRow in dataSet.Tables[0].Rows)
            {
                result.Add(Convert.ToInt32(dataRow["ImageID"]));
            }
            

            return result;
        }

        public static List<Image> GetAlbumImagesDetails(int albumId)
        {
            List<Image> result = new List<Image>();

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAlbumImagesDetails";
            comm.Parameters.AddWithValue("@albumid", albumId);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            foreach (DataRow dataRow in dataSet.Tables[0].Rows)
            { 
                result.Add(new Image
                {
                    ImageID = Convert.ToInt32(dataRow["ImageID"]),
                    Filename = Convert.ToString(dataRow["Filename"])
                });
            }

            return result;
        }

        public static Image AddImageToAlbum(int albumId, byte[] bytes, string contentType)
        {
            Image result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "AddImageToAlbum";
            comm.Parameters.AddWithValue("@albumid", albumId);
            comm.Parameters.AddWithValue("@bytes", DataProcessor.ProcessImage(bytes, contentType));
            comm.Parameters.AddWithValue("@contenttype", contentType);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Image
                {
                    ImageID = Convert.ToInt32(dataRow["ImageID"]),
                    Bytes = dataRow["Bytes"] as byte[],
                    Filename = Convert.ToString(dataRow["Filename"]),
                    ContentType = Convert.ToString(dataRow["ContentType"])
                };
            }

            return result;
        }


        /////////////////////////////////   VOLUNTEER FUNCTIONS
        public static DataSet GetVolunteers()
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllVolunteers";
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static Volunteer CreateVolunteer(string firstName, string lastName, string email, string message)
        {
            Volunteer result = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "CreateVolunteer";
            comm.Parameters.AddWithValue("@firstname", firstName);
            comm.Parameters.AddWithValue("@lastname", lastName);
            comm.Parameters.AddWithValue("@email", email);
            comm.Parameters.AddWithValue("@message", message);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                result = new Volunteer
                {
                    VolunteerID = Convert.ToInt32(dataRow["VolunteerID"]),
                    FirstName = Convert.ToString(dataRow["FirstName"]),
                    LastName = Convert.ToString(dataRow["LastName"]),
                    Email = Convert.ToString(dataRow["Email"]),
                    Message = Convert.ToString(dataRow["Message"]),
                    DateSubmitted = Convert.ToDateTime(dataRow["DateSubmitted"])
                };
            }

            return result;
        }


        /////////////////////////////////   ADMIN FUNCTIONS
        public static DataSet GetAdmins()
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllAdmins";
            return conn.GetDataSetUsingCmdObj(comm);
        }
        public static Admin CreateAdmin(string tuid, string fname, string lname, string email)
        {
            Admin admin = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "CreateAdmin";
            comm.Parameters.AddWithValue("@tuid", tuid);
            comm.Parameters.AddWithValue("@fname", fname);
            comm.Parameters.AddWithValue("@lname", lname);
            comm.Parameters.AddWithValue("@email", email);
            comm.Parameters.AddWithValue("@active", true);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                admin = new Admin
                {
                    AdminID = Convert.ToInt32(dataRow["AdminID"]),
                    TUID = Convert.ToString(dataRow["TUID"]),
                    FName = Convert.ToString(dataRow["FName"]),
                    LName = Convert.ToString(dataRow["LName"]),
                    Email = Convert.ToString(dataRow["Email"]),
                    Active = Convert.ToBoolean(dataRow["Active"])
                };
            }

            return admin;
        }
        public static Admin UpdateAdmin(int id, string tuid, string fname, string lname,string email,  bool active)
        {
            Admin admin = null;

            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "UpdateAdmin";
            comm.Parameters.AddWithValue("@id", id);
            comm.Parameters.AddWithValue("@tuid", tuid);
            comm.Parameters.AddWithValue("@fname", fname);
            comm.Parameters.AddWithValue("@lname", lname);
            comm.Parameters.AddWithValue("@email", email);
            comm.Parameters.AddWithValue("@active", active);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                admin = new Admin
                {
                    AdminID = Convert.ToInt32(dataRow["AdminID"]),
                    TUID = Convert.ToString(dataRow["TUID"]),
                    FName = Convert.ToString(dataRow["FName"]),
                    LName = Convert.ToString(dataRow["LName"]),
                    Email = Convert.ToString(dataRow["Email"]),
                    Active = Convert.ToBoolean(dataRow["Active"])
                };
            }

            return admin;
        }



        /////////////////////////////////   ABOUT FUNCTIONS
        public static About GetAbout()
        {
            About a = null;
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetLatestAbout";
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);
            if(dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                a = new About
                {
                    Description = Convert.ToString(dataRow["ProgramDescription"]),
                    Question1 = Convert.ToString(dataRow["Question1"]),
                    Question2 = Convert.ToString(dataRow["Question2"]),
                    Question3 = Convert.ToString(dataRow["Question3"]),
                    Answer1 = Convert.ToString(dataRow["Answer1"]),
                    Answer2 = Convert.ToString(dataRow["Answer2"]),
                    Answer3 = Convert.ToString(dataRow["Answer3"])
                };
            }
            return a;
        }
        public static About UpdateAbout(string description, string question1, string question2, string question3, string answer1, string answer2, string answer3)
        {
            //  Update About bahaves like a CREATE function (to keep record of what each iteration of the About page looked like)
            About a = null;
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "NewAbout";
            comm.Parameters.AddWithValue("@description", description);
            comm.Parameters.AddWithValue("@question1", question1);
            comm.Parameters.AddWithValue("@question2", question2);
            comm.Parameters.AddWithValue("@question3", question3);
            comm.Parameters.AddWithValue("@answer1", answer1);
            comm.Parameters.AddWithValue("@answer2", answer2);
            comm.Parameters.AddWithValue("@answer3", answer3);
            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);
            if(dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                a = new About
                {
                    Description = Convert.ToString(dataRow["ProgramDescription"]),
                    Question1 = Convert.ToString(dataRow["Question1"]),
                    Question2 = Convert.ToString(dataRow["Question2"]),
                    Question3 = Convert.ToString(dataRow["Question3"]),
                    Answer1 = Convert.ToString(dataRow["Answer1"]),
                    Answer2 = Convert.ToString(dataRow["Answer2"]),
                    Answer3 = Convert.ToString(dataRow["Answer3"])
                };
            }
            return a;
        }

        public static int GetAlbumProfileImageID(int albumId)
        {
            int returnResult = -1;
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAlbumProfileImageID";
            comm.Parameters.AddWithValue("@albumid", albumId);

            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);
            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                returnResult = Convert.ToInt32(dataRow["AlbumId"]);
            }

            return returnResult;
        }

        public static Album GetAlbum(int albumId)
        {
            Album returnResult = null;
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAlbum";
            comm.Parameters.AddWithValue("@albumid", albumId);

            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);
            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                returnResult = new Album
                {
                    AlbumID = Convert.ToInt32(dataRow["AlbumID"]),
                    Name = Convert.ToString(dataRow["Name"]),
                    Description = Convert.ToString(dataRow["Description"]),
                    IsLocationAlbum = Convert.ToBoolean(dataRow["IsLocationAlbum"])
                };

                returnResult.ImageList = GetAlbumImages(returnResult.AlbumID);
                int profileImageId = GetAlbumProfileImageID(returnResult.AlbumID);
                returnResult.ProfileImage = GetImage(profileImageId);
            }

            return returnResult;
        }

        public static List<Image> GetAlbumImages(int albumId)
        {
            List<Image> returnResult = new List<Image>();
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAlbumImageIDs";
            comm.Parameters.AddWithValue("@albumid", albumId);

            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            foreach (DataRow dataRow in dataSet.Tables[0].Rows)
            {
                int imageId = 0;
                imageId = Convert.ToInt32(dataRow[imageId]);

                returnResult.Add(ClassFunctions.GetImageInfo(imageId));
            }

            return returnResult;
        }

        public static int CreateAlbum(string name, string description, int imageid)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "CreateAlbum";
            comm.Parameters.AddWithValue("@name", name);
            comm.Parameters.AddWithValue("@description", description);
            comm.Parameters.AddWithValue("@imageid", imageid);

            int returnResult = conn.DoUpdateUsingCmdObj(comm);

            return returnResult;
        }

        public static int UpdateAlbum(int albumid, string name, string description)
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "UpdateAlbum";
            comm.Parameters.AddWithValue("@name", name);
            comm.Parameters.AddWithValue("@description", description);
            comm.Parameters.AddWithValue("@albumid", albumid);

            int returnResult = conn.DoUpdateUsingCmdObj(comm);

            return returnResult;
        }

        /////////////////////////////////   GALLERY FUNCTIONS
        public static List<Album> GetAllAlbum()
        {
            List<Album> returnResult = new List<Album>();
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllAlbum";

            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);

            foreach(DataRow dataRow in dataSet.Tables[0].Rows)
            {
                Album album = new Album
                {
                    AlbumID = Convert.ToInt32(dataRow["AlbumID"]),
                    Name = Convert.ToString(dataRow["Name"]),
                    Description = Convert.ToString(dataRow["Description"]),
                    IsLocationAlbum = Convert.ToBoolean(dataRow["IsLocationAlbum"])
                };

                returnResult.Add(album);
            }

            return returnResult;
        }

        public static Album MakePrimaryAlbumImage(int albumId, int imageId)
        {
            Album returnResult = null;
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "MakePrimaryAlbumImage";
            comm.Parameters.AddWithValue("@albumid", albumId);
            comm.Parameters.AddWithValue("@imageid", imageId);

            DataSet dataSet = conn.GetDataSetUsingCmdObj(comm);
            if (dataSet.Tables[0].Rows.Count == 1)
            {
                DataRow dataRow = dataSet.Tables[0].Rows[0];

                returnResult = new Album
                {
                    AlbumID = Convert.ToInt32(dataRow["AlbumID"]),
                    Name = Convert.ToString(dataRow["Name"]),
                    Description = Convert.ToString(dataRow["Description"]),
                    IsLocationAlbum = Convert.ToBoolean(dataRow["IsLocationAlbum"])
                };
            }

            return returnResult;
        }


      
        ///////////////////////////////// Convenience Functions
        public static string FormatForFileSystem(string theString)
        {
            foreach (char c in System.IO.Path.GetInvalidFileNameChars())
            {
                theString = theString.Replace(c, '_');
            }

            return theString;
        } 
      
    }
}

