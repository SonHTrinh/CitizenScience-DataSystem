using System;
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
    }
}
