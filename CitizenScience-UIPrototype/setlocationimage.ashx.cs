using CitizenScienceClasses;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace CitizenScience_UIPrototype
{
    /// <summary>
    /// Summary description for setlocationimage
    /// </summary>
    public class setlocationimage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
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

                    int locationId = int.Parse(context.Request["locationid"]);
                    string contentType = postedFile.ContentType;

                    Image result = ClassFunctions.SetLocationImage(locationId, bytes, contentType);

                    context.Response.ContentType = contentType;
                    context.Response.Write(result.ToString());
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
}