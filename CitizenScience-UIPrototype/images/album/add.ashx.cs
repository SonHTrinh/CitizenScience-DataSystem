using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using CitizenScienceClasses;

namespace CitizenScience_UIPrototype.images.album
{
    public class Add : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                string description = context.Request.Form.Get("description");
                HttpPostedFile postedFile = context.Request.Files[0];
                if (postedFile.ContentLength == 0)
                    throw new Exception("Empty file received");

                byte[] bytes;
                int albumId = int.Parse(context.Request["id"]);

                using (Stream stream = postedFile.InputStream)
                {
                    using (BinaryReader binaryReader = new BinaryReader(stream))
                    {
                        bytes = binaryReader.ReadBytes((int)stream.Length);
                    }

                    string contentType = postedFile.ContentType;

                    Image image = ClassFunctions.UploadImage(bytes, contentType, description);

                    context.Response.ContentType = contentType;
                    context.Response.Write(image.ImageID);
                }
            }
            catch (Exception ex)
            {
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


    public class Get : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                Image image = null;
                byte[] bytes;
                int albumId = int.Parse(context.Request["id"]);

                image = ClassFunctions.GetAlbumImage(albumId);

                context.Response.ContentType = image.ContentType;
                context.Response.BinaryWrite(image.Bytes);

            }
            catch (Exception ex)
            {
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