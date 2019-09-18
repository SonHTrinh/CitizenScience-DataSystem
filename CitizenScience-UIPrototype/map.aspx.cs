using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CitizenScienceClasses;
using System.Data;
using System.Data.SqlClient;

namespace CitizenScience_UIPrototype
{
    public partial class map : System.Web.UI.Page
    {
        DBConnect objDB = new DBConnect();
        SqlCommand objCommand = new SqlCommand();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlWaterShed.DataSource = ClassFunctions.GetWatersheds();
                ddlWaterShed.DataTextField = "WatershedName";
                ddlWaterShed.DataValueField = "WatershedID";
                ddlWaterShed.DataBind();
            }
        }

        protected void ddlWaterShed_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplayByWatershed(ddlWaterShed.SelectedValue);
        }

        protected void DisplayByWatershed(String watershed)
        {
            LocationList.Visible = true;
            
            int selectedWatershedID = Convert.ToInt32(ddlWaterShed.SelectedValue);
            ddlLocation.DataSource = ClassFunctions.GetLocationsByWatershed(selectedWatershedID);
            ddlLocation.DataBind();
        }
    }
}