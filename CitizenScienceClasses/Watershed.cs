using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitizenScienceClasses
{
    public class Watershed
    {
        private int watershedID;
        private string watershedName;
        private DateTime lastUpdated;

        public Watershed() { }
        public Watershed(int id, string name, DateTime updated)
        {
            watershedID = id;
            watershedName = name;
            lastUpdated = updated;
        }

        public int WatershedID
        {
            get { return watershedID; }
            set { watershedID = value; }
        }
        public string WatershedName
        {
            get { return watershedName; }
            set { watershedName = value; }
        }
        public DateTime LastUpdated
        {
            get { return lastUpdated; }
            set { lastUpdated = value; }
        }
    }
}
