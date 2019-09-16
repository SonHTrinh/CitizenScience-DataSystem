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

        /////////////////////////////////   WATERSHED FUNCTIONS
        public static DataSet GetWatersheds()
        {
            DBConnect conn = new DBConnect();
            SqlCommand comm = new SqlCommand();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = "GetAllWatersheds";
            return conn.GetDataSetUsingCmdObj(comm);
        }
    }
}
