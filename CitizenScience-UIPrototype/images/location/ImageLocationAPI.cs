using CitizenScienceClasses;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace CitizenScience_UIPrototype.images.location
{
    public class Get : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                Image image = null;
                byte[] bytes;
                int locationId = int.Parse(context.Request["locationid"]);

                image = ClassFunctions.GetLocationImage(locationId);

                context.Response.ContentType = image.ContentType;
                context.Response.BinaryWrite(image.Bytes);

            }
            catch (Exception ex)
            {
                context.Response.StatusCode = 500;
                context.Response.Write("Error occurred on server " +
                  ex.Message);
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }

    public class Set : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                string filename = context.Request.Form.Get("filename");
                HttpPostedFile postedFile = context.Request.Files[0];
                if (postedFile.ContentLength == 0)
                    throw new Exception("Empty file received");

                byte[] bytes;

                using (Stream stream = postedFile.InputStream)
                {
                    using (BinaryReader binaryReader = new BinaryReader(stream))
                    {
                        bytes = binaryReader.ReadBytes((int)stream.Length);
                    }

                    string contentType = postedFile.ContentType;

                    Image image = ClassFunctions.UploadImage(bytes, contentType, filename);

                    context.Response.ContentType = contentType;
                    context.Response.Write(image.ImageID);
                }
            }
            catch (Exception ex)
            {
                context.Response.StatusCode = 500;
                context.Response.Write("Error occurred on server " +
                  ex.Message);
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
    
}