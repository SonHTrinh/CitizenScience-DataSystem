using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitizenScienceClasses
{
    class Temperature
    {
        private int temperatureID;
        private int locationID;
        private int uploadID;
        private DateTime dateRecorded;
        private DateTime timeRecorded;
        private double tempC;
        private double tempF;

        public Temperature() { }
        public Temperature(int tempID, int locID, int upId, DateTime date, DateTime time, double tempc, double tempf)
        {
            temperatureID = tempID;
            locationID = locID;
            uploadID = upId;
            dateRecorded = date;
            timeRecorded = time;
            tempC = tempc;
            tempF = tempf;
        }

        public int TemperatureID
        {
            get { return temperatureID; }
            set { temperatureID = value; }
        }
        public int LocationID
        {
            get { return locationID; }
            set { locationID = value; }
        }
        public int UploadID
        {
            get { return uploadID; }
            set { uploadID = value; }
        }
        public DateTime DateRecorded
        {
            get { return dateRecorded; }
            set { dateRecorded = value; }
        }
        public DateTime TimeRecorded
        {
            get { return timeRecorded; }
            set { timeRecorded = value; }
        }
        public double TempC
        {
            get { return tempC; }
            set { tempC = value; }
        }
        public double TempF
        {
            get { return tempF; }
            set { tempF = value; }
        }
    }
}
