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
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
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
        public void Volunteers()
        {
            DataSet volunteerDataSet = ClassFunctions.GetVolunteers();
            List<Volunteer> volunteerList = new List<Volunteer>();

            for (int i = 0; i < volunteerDataSet.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = volunteerDataSet.Tables[0].Rows[i];

                Volunteer volunteer = new Volunteer
                {
                    VolunteerID = Convert.ToInt32(dataRow["VolunteerID"]),
                    FirstName = Convert.ToString(dataRow["FirstName"]),
                    LastName = Convert.ToString(dataRow["LastName"]),
                    Email = Convert.ToString(dataRow["Email"]),
                    Message = Convert.ToString(dataRow["Message"]),
                    DateSubmitted = Convert.ToDateTime(dataRow["DateSubmitted"]),
                };

                volunteerList.Add(volunteer);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(volunteerList));
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void GetAlbumImageIds(int albumId)
        {
            List<int> result = new List<int>();

            result = ClassFunctions.GetAlbumImageIDs(albumId);

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(result));
        }

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void Admins()
        {
            DataSet adminDataSet = ClassFunctions.GetAdmins();
            List<Admin> adminList = new List<Admin>();

            for (int i = 0; i < adminDataSet.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = adminDataSet.Tables[0].Rows[i];

                Admin admin = new Admin
                {
                    AdminID = Convert.ToInt32(dataRow["AdminID"]),
                    TUID = Convert.ToString(dataRow["TUID"])  ,
                    Active = Convert.ToBoolean(dataRow["Active"])
                };

                adminList.Add(admin);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(adminList));
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

        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void About()
        {
            About about = ClassFunctions.GetAbout();

            if(about != null)
                BuildResponse(200, about);
            else
                BuildResponse(500, about);          
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
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void ReadAllWatersheds()
        {
            DataSet watershedDataSet = ClassFunctions.GetWatersheds();
            List<Watershed> result = new List<Watershed>();

            for (int i = 0; i < watershedDataSet.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = watershedDataSet.Tables[0].Rows[i];

                Watershed watershed = new Watershed
                {
                    WatershedID = Convert.ToInt32(dataRow["WatershedID"]),
                    WatershedName = Convert.ToString(dataRow["WatershedName"])
                };

                result.Add(watershed);
            }

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
        public void CreateLocation(int watershedId, string name, double latitude, double longitude, int imageId)
        {
            Location result = ClassFunctions.CreateLocation(watershedId, name, latitude, longitude, imageId);

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
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void ReadAllLocation()
        {
            List<Location> result = ClassFunctions.ReadAllLocation();

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
        public void UpdateLocation(int id, int watershedId, string name, double latitude, double longitude, int imageId)
        {
            Location result = ClassFunctions.UpdateLocation(id, watershedId, name, latitude, longitude, imageId);

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


        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void LocationTemperaturesCsv(int[] locationId)
        {
            string csvFileName = $"Temperatures-{DateTime.Now.ToString("M/d/yy-H:mm")}.csv";

            DataSet temperatureDataset = ClassFunctions.GetAllTemperaturesByMultipleLocationIds(new List<int>(locationId));

            List<Temperature> temperatureList = new List<Temperature>();
            for (int i = 0; i < temperatureDataset.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = temperatureDataset.Tables[0].Rows[i];

                Temperature t = new Temperature();
                t.Timestamp = Convert.ToDateTime(dataRow["Timestamp"].ToString());
                t.Celsius = Convert.ToDouble(dataRow["TempC"]);
                t.Fahrenheit = Convert.ToDouble(dataRow["TempF"]);
                temperatureList.Add(t);
            }

            byte[] allTempDataBytes = DataProcessor.CreateCsvAsBytes(temperatureList);

            Context.Response.Clear();
            Context.Response.ContentType = "application/force-download";
            Context.Response.AddHeader("content-disposition", "attachment; filename=" + csvFileName);
            Context.Response.BinaryWrite(allTempDataBytes);
            Context.Response.End();
        }        

        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void AllLocationTemperaturesCsv()
        {
            string csvFileName = $"Temperatures-{DateTime.Now.ToString("M/d/yy-H:mm")}.csv";

            DataSet temperatureDataset = ClassFunctions.GetAllTemperatures();

            List<Temperature> temperatureList = new List<Temperature>();
            for (int i = 0; i < temperatureDataset.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = temperatureDataset.Tables[0].Rows[i];

                Temperature t = new Temperature();
                t.Timestamp = Convert.ToDateTime(dataRow["Timestamp"].ToString());
                t.Celsius = Convert.ToDouble(dataRow["TempC"]);
                t.Fahrenheit = Convert.ToDouble(dataRow["TempF"]);
                temperatureList.Add(t);
            }

            byte[] allTempDataBytes = DataProcessor.CreateCsvAsBytes(temperatureList);

            Context.Response.Clear();
            Context.Response.ContentType = "application/force-download";
            Context.Response.AddHeader("content-disposition", "attachment; filename=" + csvFileName);
            Context.Response.BinaryWrite(allTempDataBytes);
            Context.Response.End();
        }

        //  MAP PAGE DOWNLOAD FUNCTIONS
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void LocationTemperaturesCsvStartNoEnd(int locationId, DateTime startDate)
        {
            string csvFileName = $"Temperatures-{DateTime.Now.ToString("M/d/yy-H:mm")}.csv";

            DataSet temperatureDataset = ClassFunctions.GetTemperaturesByLocationIdStartNoEnd(locationId, startDate);

            List<Temperature> temperatureList = new List<Temperature>();
            for (int i = 0; i < temperatureDataset.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = temperatureDataset.Tables[0].Rows[i];

                Temperature t = new Temperature();
                t.Timestamp = Convert.ToDateTime(dataRow["Timestamp"].ToString());
                t.Celsius = Convert.ToDouble(dataRow["TempC"]);
                t.Fahrenheit = Convert.ToDouble(dataRow["TempF"]);
                temperatureList.Add(t);
            }

            byte[] allTempDataBytes = DataProcessor.CreateCsvAsBytes(temperatureList);

            Context.Response.Clear();
            Context.Response.ContentType = "application/force-download";
            Context.Response.AddHeader("content-disposition", "attachment; filename=" + csvFileName);
            Context.Response.BinaryWrite(allTempDataBytes);
            Context.Response.End();
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void LocationTemperaturesCsvNoStartEnd(int locationId, DateTime endDate)
        {
            string csvFileName = $"Temperatures-{DateTime.Now.ToString("M/d/yy-H:mm")}.csv";

            DataSet temperatureDataset = ClassFunctions.GetTemperaturesByLocationIdNoStartEnd(locationId, endDate);

            List<Temperature> temperatureList = new List<Temperature>();
            for (int i = 0; i < temperatureDataset.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = temperatureDataset.Tables[0].Rows[i];

                Temperature t = new Temperature();
                t.Timestamp = Convert.ToDateTime(dataRow["Timestamp"].ToString());
                t.Celsius = Convert.ToDouble(dataRow["TempC"]);
                t.Fahrenheit = Convert.ToDouble(dataRow["TempF"]);
                temperatureList.Add(t);
            }

            byte[] allTempDataBytes = DataProcessor.CreateCsvAsBytes(temperatureList);

            Context.Response.Clear();
            Context.Response.ContentType = "application/force-download";
            Context.Response.AddHeader("content-disposition", "attachment; filename=" + csvFileName);
            Context.Response.BinaryWrite(allTempDataBytes);
            Context.Response.End();
        }
        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public void LocationTemperaturesCsvStartEnd(int locationId, DateTime startDate, DateTime endDate)
        {
            string csvFileName = $"Temperatures-{DateTime.Now.ToString("M/d/yy-H:mm")}.csv";

            DataSet temperatureDataset = ClassFunctions.GetTemperaturesByLocationIdStartEnd(locationId, startDate, endDate);

            List<Temperature> temperatureList = new List<Temperature>();
            for (int i = 0; i < temperatureDataset.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = temperatureDataset.Tables[0].Rows[i];

                Temperature t = new Temperature();
                t.Timestamp = Convert.ToDateTime(dataRow["Timestamp"].ToString());
                t.Celsius = Convert.ToDouble(dataRow["TempC"]);
                t.Fahrenheit = Convert.ToDouble(dataRow["TempF"]);
                temperatureList.Add(t);
            }

            byte[] allTempDataBytes = DataProcessor.CreateCsvAsBytes(temperatureList);

            Context.Response.Clear();
            Context.Response.ContentType = "application/force-download";
            Context.Response.AddHeader("content-disposition", "attachment; filename=" + csvFileName);
            Context.Response.BinaryWrite(allTempDataBytes);
            Context.Response.End();
        }

        //////////////////////////// CRUD Admin \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void CreateAdmin(string tuid)
        {
            Admin result = ClassFunctions.CreateAdmin(tuid);

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
        public void UpdateAdmin(int id, string tuid, bool active)
        {
            Admin result = ClassFunctions.UpdateAdmin(id, tuid, active);
        }
        
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        // start and end are strings that will get parsed for datetime ex: "MM-DD-YYYY" and "YYYY-MM-DD"
        public void GetLocationTemperaturesByDateRange(int locationId, string start, string end)
        {
            DateTime startDate = DateTime.Parse(start);
            DateTime endDate = DateTime.Parse(end);

            List<Temperature> result = ClassFunctions.GetLocationTemperaturesByDateRange(locationId, startDate, endDate);

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
        [ScriptMethod(UseHttpGet = true)]
        public void GetLocationLatestTemperature(int locationId)
        {
            Temperature result = ClassFunctions.GetLatestLocationTemperature(locationId);

            if (result != null)
            {
                BuildResponse(200, result);
            }
            else
            {
                BuildResponse(500, result);
            }

        }

        //////////////////////////// CRUD About \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public void UpdateAbout(string description, string question1, string question2, string question3, string answer1, string answer2, string answer3)
        {
            About result = ClassFunctions.UpdateAbout(description, question1, question2, question3, answer1, answer2, answer3);
            if (result != null)
                BuildResponse(200, result);
            else
                BuildResponse(500, result);
        }

        //////////////////////////// CRUD Gallery \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


        [WebMethod]
        [ScriptMethod(UseHttpGet = true, ResponseFormat = ResponseFormat.Json)]
        public void AllAlbum()
        {
            DataSet albumDataSet = ClassFunctions.GetAllAlbum();
            List<Album> albumList = new List<Album>();

            for (int i = 0; i < albumDataSet.Tables[0].Rows.Count; i++)
            {
                DataRow dataRow = albumDataSet.Tables[0].Rows[i];

                Album album = new Album
                {
                    AlbumID = Convert.ToInt32(dataRow["AlbumID"]),
                    Name = Convert.ToString(dataRow["Name"]),
                    Description = Convert.ToString(dataRow["Description"]),
                    LastUpdated = Convert.ToDateTime(dataRow["LastUpdated"])
                };

                albumList.Add(album);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Clear();
            Context.Response.ContentType = "application/json";
            Context.Response.Write(js.Serialize(albumList));
        }
    }
}
