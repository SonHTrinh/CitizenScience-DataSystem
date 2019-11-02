using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CitizenScienceClasses;

namespace CitizenScience_UIPrototype.images
{
    /// <summary>
    /// Summary description for get
    /// </summary>
    public class get : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                Image image = null;
                byte[] bytes;
                int imageId = int.Parse(context.Request["id"]);

                image = ClassFunctions.GetImage(imageId);

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