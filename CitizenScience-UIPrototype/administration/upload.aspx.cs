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
            feedbackSuccess.Visible = false;
            feedbackDanger.Visible = false;
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

            if (FileUpload1.HasFile)
            {
                try
                {
                    if (ddlLocations.SelectedValue.Equals("")) throw new Exception("Select a valid Location.");

                    Stream fileStream = FileUpload1.PostedFile.InputStream;
                    //turns it into a list here called temperatureList and is bound. need to save in database instead. 
                    List<Temperature> temperatureList = DataProcessor.ReadCsvFile(fileStream);

                    int locationId = int.Parse(ddlLocations.SelectedValue);
                    int uploadId = 1;

                    ClassFunctions.BulkTemperatureDataInsert(temperatureList, locationId, uploadId);

                    txtLocation.InnerText = ddlLocations.SelectedItem.Text;
                    txtRowcount.InnerText = temperatureList.Count.ToString();
                    feedbackSuccess.Visible = true;
                }
                catch (Exception ex)
                {
                    txtFail.InnerText = ex.Message;
                    feedbackDanger.Visible = true;
                }
            }
        }
    }
}