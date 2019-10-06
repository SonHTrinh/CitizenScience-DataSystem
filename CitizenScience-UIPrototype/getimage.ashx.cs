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
            try {
                byte[] bytes;
                int locationId = int.Parse(context.Request["locationid"]);


                bytes = ClassFunctions.GetLocationImage(locationId);

                context.Response.ContentType = "image/jpeg";
                context.Response.BinaryWrite(bytes);  //
                
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