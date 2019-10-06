﻿using System;
using System.Collections.Generic;
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
        public static Location CreateLocation(int watershedId, string name, double latitude, double longitude)
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
                    LastUpdated = Convert.ToDateTime(dataRow["LastUpdated"])
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
                    LastUpdated = Convert.ToDateTime(dataRow["LastUpdated"])
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
                    Longitude = Convert.ToDouble(dataRow["Longitude"]),
                    LastUpdated = Convert.ToDateTime(dataRow["LastUpdated"])
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
                    Longitude = Convert.ToDouble(dataRow["Longitude"]),
                    LastUpdated = Convert.ToDateTime(dataRow["LastUpdated"])
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
                    WatershedName = Convert.ToString(dataRow["WatershedName"]),
                    LastUpdated = Convert.ToDateTime(dataRow["LastUpdated"])
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
                    WatershedName = Convert.ToString(dataRow["WatershedName"]),
                    LastUpdated = Convert.ToDateTime(dataRow["LastUpdated"])
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
                    WatershedName = Convert.ToString(dataRow["WatershedName"]),
                    LastUpdated = Convert.ToDateTime(dataRow["LastUpdated"])
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
    }
}

