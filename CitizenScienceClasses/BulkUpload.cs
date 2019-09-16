using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitizenScienceClasses
{
    class BulkUpload
    {
        private int uploadID;
        private string adminAccessnet;
        private DateTime dateUploaded;

        public BulkUpload() { }
        public BulkUpload(int id, string admin, DateTime upload)
        {
            uploadID = id;
            adminAccessnet = admin;
            dateUploaded = upload;
        }

        public int UploadID
        {
            get { return uploadID; }
            set { uploadID = value; }
        }
        public string AdminAccessnet
        {
            get { return adminAccessnet; }
            set { adminAccessnet = value; }
        }
        public DateTime DateUploaded
        {
            get { return dateUploaded; }
            set { dateUploaded = value; }
        }
    }
}
