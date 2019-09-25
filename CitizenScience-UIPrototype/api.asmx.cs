using CitizenScienceClasses;
using Newtonsoft.Json;
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
    [ScriptService]
    public class Api : WebService
    {

        private void BuildResponse(int httpStatus, Object obj)
        {
            string response = JsonConvert.SerializeObject(obj);
            Context.Response.AddHeader("content-length", response.Length.ToString());
            Context.Response.Clear();
            Context.Response.StatusCode = httpStatus;
            Context.Response.ContentType = "application/json";
            Context.Response.BufferOutput = true;
            Context.Response.Write(response);
            Context.Response.Flush();
            Context.Response.End();
        }

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

        //////////////////////////// CRUD Watershed \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void CreateWatershed(string name)
        {
            Watershed result = ClassFunctions.CreateWatershed(name);

            if(result != null)
            {
                BuildResponse(200, result);
            } else
            {
                BuildResponse(500, null);
            }

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void ReadWatershed(int id)
        {
            Watershed result = ClassFunctions.ReadWatershed(id);

            if (result != null)
            {
                BuildResponse(200, result);
            }
            else
            {
                BuildResponse(500, null);
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void UpdateWatershed(int id, string name)
        {
            Watershed result = ClassFunctions.UpdateWatershed(id, name);

            if (result != null)
            {
                BuildResponse(200, result);
            }
            else
            {
                BuildResponse(500, null);
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void DeleteWatershed(int id)
        {
            //bool result = ClassFunctions.DeleteWatershed(id);
            bool result = false;

            if (result)
            {
                BuildResponse(200, result);
            }
            else
            {
                BuildResponse(500, null);
            }
        }

        //////////////////////////// CRUD Location \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void CreateLocation(int watershedId, string name, string serial, double latitude, double longitude)
        {
            Location result = ClassFunctions.CreateLocation(watershedId, name, serial, latitude, longitude);

            if (result != null)
            {
                BuildResponse(200, result);
            }
            else
            {
                BuildResponse(500, result);
            }

        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void ReadLocation(int id)
        {
            Location result = ClassFunctions.ReadLocation(id);

            if (result != null)
            {
                BuildResponse(200, result);
            }
            else
            {
                BuildResponse(500, result);
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void UpdateLocation(int id, int watershedId, string name, string serial, double latitude, double longitude)
        {
            Location result = ClassFunctions.UpdateLocation(id, watershedId, name, serial, latitude, longitude);

            if (result != null)
            {
                BuildResponse(200, result);
            }
            else
            {
                BuildResponse(500, result);
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void DeleteLocation(int id)
        {
            //bool result = ClassFunctions.DeleteLocation(id);
            bool result = false;

            if (result)
            {
                BuildResponse(200, result);
            }
            else
            {
                BuildResponse(500, result);
            }
        }

    }
}
