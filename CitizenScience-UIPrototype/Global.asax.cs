using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace CitizenScience_UIPrototype
{
    public class Global : System.Web.HttpApplication
    {
        public static string URLPREFIX;
        protected void Application_Start(object sender, EventArgs e)
        {
            // Uncomment for deploying on school servers
            URLPREFIX = "/cis4396-F06";
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}