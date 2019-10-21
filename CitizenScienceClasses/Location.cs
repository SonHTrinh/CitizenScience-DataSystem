using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitizenScienceClasses
{
    public class Location
    {        
        private int locationID;
        private int watershedID;
        private double latitude;
        private double longitude;
        private string sensorName;
        private int profileImageID;
        private DateTime lastUpdated;

        public Location() { }
        public Location(int locId, int watId, double lat, double lon, string name, int profile, DateTime updated)
        {
            locationID = locId;
            watershedID = watId;
            latitude = lat;
            longitude = lon;
            sensorName = name;
            profileImageID = profile;
            lastUpdated = updated;
        }

        public int LocationID
        {
            get { return locationID; }
            set { locationID = value; }
        }
        public int WatershedID
        {
            get { return watershedID; }
            set { watershedID = value; }
        }
        public double Latitude
        {
            get { return latitude; }
            set { latitude = value; }
        }
        public double Longitude
        {
            get { return longitude; }
            set { longitude = value; }
        }
        public string SensorName
        {
            get { return sensorName; }
            set { sensorName = value; }
        }
        public int ProfileImageID
        {
            get { return profileImageID; }
            set { profileImageID = value; }
        }
        public DateTime LastUpdated
        {
            get { return lastUpdated; }
            set { lastUpdated = value; }
        }       
    }
}
