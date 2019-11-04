using System;
using System.Web.UI;

namespace CitizenScience_UIPrototype.administration
{
    public partial class watershed : Page
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