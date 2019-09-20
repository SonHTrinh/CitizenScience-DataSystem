using CitizenScienceClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;


namespace CitizenScience_UIPrototype
{

    [WebService(Namespace = "http://localhost")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class Api : WebService
    {

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void AllLocations()
        {
            DataSet locationsDataSet = ClassFunctions.GetLocations();
            List<Location> locationList = new List<Location>();

            for (int i = 0; i < locationsDataSet.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = locationsDataSet.Tables[0].Rows[i];

                Location location = new Location
                {
                    Latitude = Convert.ToDouble(dataRow["Latitude"]),
                    Longitude = Convert.ToDouble(dataRow["Longitude"]),
                    SensorName = Convert.ToString(dataRow["SensorName"]),
                    LocationID = Convert.ToInt32(dataRow["LocationID"])
                };

                locationList.Add(location);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(locationList));
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void Watersheds()
        {
            DataSet watershedDataSet = ClassFunctions.GetWatersheds();
            List<Watershed> watershedList = new List<Watershed>();

            for(int i = 0; i < watershedDataSet.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = watershedDataSet.Tables[0].Rows[i];

                Watershed watershed = new Watershed
                {
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    WatershedName = Convert.ToString(dataRow["WatershedName"])
                };

                watershedList.Add(watershed);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(watershedList));
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void Location(int watershedId)
        {
            DataSet locationDataSet = ClassFunctions.GetLocationsByWatershed(watershedId);
            List<Location> locationList = new List<Location>();

            for(int i = 0; i < locationDataSet.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = locationDataSet.Tables[0].Rows[i];

                Location location = new Location
                {
                    Latitude = Convert.ToDouble(dataRow["Latitude"]),
                    Longitude = Convert.ToDouble(dataRow["Longitude"]),
                    SensorName = Convert.ToString(dataRow["SensorName"]),
                    LocationID = Convert.ToInt32(dataRow["LocationID"])
                };

                locationList.Add(location);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(locationList));
        }
    }
}
