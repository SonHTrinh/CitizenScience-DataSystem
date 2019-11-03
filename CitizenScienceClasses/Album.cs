using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitizenScienceClasses
{
    public class Album
    {
        private int albumID;
        private string name;
        private string description;
        private DateTime lastUpdated;

        public Album() { }
        public Album(int id, string album_name, string desc, DateTime updated)
        {
            albumID = id;
            name = album_name;
            description = desc;
            lastUpdated = updated;
        }

        public int AlbumID
        {
            get { return albumID; }
            set { albumID = value; }
        }

        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        public string Description
        {
            get { return description; }
            set { description = value; }
        }

        public DateTime LastUpdated
        {
            get { return lastUpdated; }
            set { lastUpdated = value; }
        }
    }
}
