using CitizenScienceClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CitizenScience_UIPrototype.administration
{
    public partial class upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GenerateLocationDropdownList();
            }
        }

        private void GenerateLocationDropdownList()
        {
            List<Location> locationList = ClassFunctions.ReadAllLocation();

            ddlLocations.Items.Add(new ListItem("-- Select --", ""));

            foreach(Location location in locationList)
            {
                ddlLocations.Items.Add(new ListItem(location.SensorName, location.LocationID.ToString()));
            }
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();

            if (FileUpload1.HasFile)
            {
                try
                {
                    Stream fileStream = FileUpload1.PostedFile.InputStream;
                    //turns it into a list here called temperatureList and is bound. need to save in database instead. 
                    List<Temperature> temperatureList = DataProcessor.ReadCsvFile(fileStream);

                    //ClassFunctions.AddTempsToDatabase(temperatureList);
                }
                catch (Exception ex)
                {
                    sb.AppendFormat($"Unable to save file: {ex.Message}");
                }
            }

            lblFeedback.Text = sb.ToString();
        }
    }
}