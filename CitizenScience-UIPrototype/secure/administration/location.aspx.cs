using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CitizenScience_UIPrototype.administration
{
    public partial class location : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Authenticated"] == null || Session["Authenticated"].ToString() == "" || Session["Authenticated"].ToString() == "false")
            {
                Server.Transfer("403http.aspx");
            }

        }
    }
}