using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CitizenScience_UIPrototype.secure.administration
{
    public partial class _403http : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Context.Response.Status = "403 Forbidden";
            Context.Response.StatusCode = 403;
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}