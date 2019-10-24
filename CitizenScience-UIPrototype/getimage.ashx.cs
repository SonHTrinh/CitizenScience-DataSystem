using CitizenScienceClasses;
using System;
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
                Image image = null;
                byte[] bytes;
                int locationId = int.Parse(context.Request["locationid"]);

                image = ClassFunctions.GetLocationImage(locationId);

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