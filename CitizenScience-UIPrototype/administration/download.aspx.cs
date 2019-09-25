using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CitizenScienceClasses;
using System.Data;
using System.Data.SqlClient;

namespace CitizenScience_UIPrototype.administration
{
    public partial class download : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsCallback)
                LoadDownloadPageData();
        }
        protected void ddlSensorDownloadWatersheds_Change(object sender, EventArgs e)
        {
            try
            {
                int selectedWatershedID = Convert.ToInt32(ddlSensorDownloadWatersheds.SelectedValue);
                rptDownloadSensorLocations.DataSource = ClassFunctions.GetLocationsByWatershed(selectedWatershedID);
                rptDownloadSensorLocations.DataBind();
            }
            catch
            {
                rptDownloadSensorLocations.DataSource = ClassFunctions.GetLocations();
                rptDownloadSensorLocations.DataBind();
            }
        }
        protected void LoadDownloadPageData()
        {
            //  Populate ddlSensorDownloadWatersheds with all watersheds in the database  
            ddlSensorDownloadWatersheds.DataSource = ClassFunctions.GetWatersheds();
            ddlSensorDownloadWatersheds.DataTextField = "WatershedName";
            ddlSensorDownloadWatersheds.DataValueField = "WatershedID";
            ddlSensorDownloadWatersheds.DataBind();
            ddlSensorDownloadWatersheds.Items.Insert(0, "-- Filter by Watershed --");

            //  Populate Location table body
            rptDownloadSensorLocations.DataSource = ClassFunctions.GetLocations();
            rptDownloadSensorLocations.DataBind();
        }
        protected void btnDownloadSelectedSensorData_Click(object sender, EventArgs e)
        {
            string csvFileName = $"Temps-{DateTime.Now.ToString("M/d/yy-H:mm")}.csv";

            //  Create list to hold selected LocationIDs
            List<int> selectedLocations = new List<int>();
            CheckBox cbox;
            HiddenField hid;
            bool itemChecked = false;
            //  Loop through all Repeater Items
            for (int i = 0; i < rptDownloadSensorLocations.Items.Count; i++)
            {
                cbox = (CheckBox)rptDownloadSensorLocations.Items[i].FindControl("cbxDownloadSensorLocation");
                hid = (HiddenField)rptDownloadSensorLocations.Items[i].FindControl("hdnDownloadSensorLocationID");
                //  If the Repeater item's checkbox is checked
                if (cbox.Checked)
                {
                    //  Add its LocationID to the list
                    selectedLocations.Add(Convert.ToInt32(hid.Value));
                    itemChecked = true;
                }
            }

            //  Get data of selected Locations from database
            DataSet selectedTempDataSet = ClassFunctions.GetAllTemperaturesByMultipleLocationIds(selectedLocations);

            if (!itemChecked)
            {
                lblMessage.Text = "Please select a location(s) for data download";
            }
            else
            {
                List<Temperature> tempList = new List<Temperature>();
                for (int i = 0; i < selectedTempDataSet.Tables[0].Rows.Count; i++)
                {
                    Temperature t = new Temperature();
                    t.Timestamp = Convert.ToDateTime(selectedTempDataSet.Tables[0].Rows[i]["DateRecorded"].ToString());
                    t.Celsius = Convert.ToDouble(selectedTempDataSet.Tables[0].Rows[i]["TempC"]);
                    t.Fahrenheit = Convert.ToDouble(selectedTempDataSet.Tables[0].Rows[i]["TempF"]);
                    tempList.Add(t);
                }

                byte[] allTempDataBytes = DataProcessor.CreateCsvAsBytes(tempList);

                Response.Clear();
                Response.ContentType = "application/force-download";
                Response.AddHeader("content-disposition", "attachment; filename=" + csvFileName);
                Response.BinaryWrite(allTempDataBytes);
                Response.End();
            }
        }
        protected void btnDownloadAllSensorData_Click(object sender, EventArgs e)
        {
            string csvFileName = $"Temps-{DateTime.Now.ToString("M/d/yy-H:mm")}.csv";

            //  Download all data from the database
            DataSet allTempDataSet = ClassFunctions.GetAllTemperatures();
            List<Temperature> tempList = new List<Temperature>();
            for (int i = 0; i < allTempDataSet.Tables[0].Rows.Count; i++)
            {
                Temperature t = new Temperature();
                t.Timestamp = Convert.ToDateTime(allTempDataSet.Tables[0].Rows[i]["Timestamp"]);
                t.Celsius = Convert.ToDouble(allTempDataSet.Tables[0].Rows[i]["TempC"]);
                t.Fahrenheit = Convert.ToDouble(allTempDataSet.Tables[0].Rows[i]["TempF"]);
                tempList.Add(t);
            }
            byte[] allTempDataBytes = DataProcessor.CreateCsvAsBytes(tempList);

            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment; filename=" + csvFileName);
            Response.BinaryWrite(allTempDataBytes);
            Response.End();
        }
    }
}