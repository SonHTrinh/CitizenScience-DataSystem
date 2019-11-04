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
        private bool isLocationAlbum;
        private Image profileImage;
        private List<Image> imageList;

        private DateTime lastUpdated;

        public Album() { }

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

        public bool IsLocationAlbum
        {
            get { return isLocationAlbum; }
            set { isLocationAlbum = value; }
        }

        public Image ProfileImage
        {
            get { return profileImage; }
            set { profileImage = value; }
        }

        public List<Image> ImageList
        {
            get { return imageList; }
            set { imageList = value; }
        }

        public DateTime LastUpdated
        {
            get { return lastUpdated; }
            set { lastUpdated = value; }
        }
    }
}
