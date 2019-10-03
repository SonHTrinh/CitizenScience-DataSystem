using CitizenScienceClasses;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace CitizenScience_UIPrototype
{
    /// <summary>
    /// Summary description for getimage
    /// </summary>
    public class getimage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

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


                    bytes = ClassFunctions.GetLocationImage(3);

                    context.Response.ContentType = postedFile.ContentType;
                    context.Response.BinaryWrite(bytes);  //
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