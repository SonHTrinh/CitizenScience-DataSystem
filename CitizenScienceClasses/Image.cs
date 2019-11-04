using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitizenScienceClasses
{
    public class Image
    {
        private int imageID;
        private byte[] bytes;
        private string description;
        private string contentType;

        public int ImageID { get => imageID; set => imageID = value; }
        public string ContentType { get => contentType; set => contentType = value; }
        public string Description { get => description; set => description = value; }
        public byte[] Bytes { get => bytes; set => bytes = value; }
    }
}
