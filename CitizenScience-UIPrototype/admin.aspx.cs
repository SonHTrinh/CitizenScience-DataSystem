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
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                divAddLocation.Visible = false;
                divAddWatershed.Visible = false;
                divUploadSensorData.Visible = false;
                divDownloadSensorData.Visible = false;
                divManageAdmins.Visible = false;
                divEditGallery.Visible = false;
                divEditAbout.Visible = false;
                divVolunteers.Visible = false;
                divAdminPrompt.Visible = true;
            }
        }

        //  FUNCTION TO NAVIGATE ADMIN PANELS
        protected void Navigate(object sender, EventArgs e)
        {
            divAdminPrompt.Visible = false;
            LinkButton lnk = sender as LinkButton;            
            switch (lnk.Attributes["CustomParameter"].ToString())
            {
                case "location":
                    lblPanelTitle.Text = "New Location:";
                    divAddLocation.Visible = true;
                    divAddWatershed.Visible = false;
                    divUploadSensorData.Visible = false;
                    divDownloadSensorData.Visible = false;
                    divManageAdmins.Visible = false;
                    divEditGallery.Visible = false;
                    divEditAbout.Visible = false;
                    divVolunteers.Visible = false;
                    break;
                case "watershed":
                    lblPanelTitle.Text = "New Watershed:";
                    divAddLocation.Visible = false;
                    divAddWatershed.Visible = true;
                    divUploadSensorData.Visible = false;
                    divDownloadSensorData.Visible = false;
                    divManageAdmins.Visible = false;
                    divEditGallery.Visible = false;
                    divEditAbout.Visible = false;
                    divVolunteers.Visible = false;
                    break;
                case "upload":
                    lblPanelTitle.Text = "Upload Sensor Data:";
                    divAddLocation.Visible = false;
                    divAddWatershed.Visible = false;
                    divUploadSensorData.Visible = true;
                    divDownloadSensorData.Visible = false;
                    divManageAdmins.Visible = false;
                    divEditGallery.Visible = false;
                    divEditAbout.Visible = false;
                    divVolunteers.Visible = false;

                    divUploadError.Visible = false;
                    break;
                case "download":
                    lblPanelTitle.Text = "Download Sensor Data:";
                    divAddLocation.Visible = false;
                    divAddWatershed.Visible = false;
                    divUploadSensorData.Visible = false;
                    divDownloadSensorData.Visible = true;
                    divManageAdmins.Visible = false;
                    divEditGallery.Visible = false;
                    divEditAbout.Visible = false;
                    divVolunteers.Visible = false;
                    LoadDownloadPageData();
                    break;
                case "admins":
                    lblPanelTitle.Text = "Manage Administrators:";
                    divAddLocation.Visible = false;
                    divAddWatershed.Visible = false;
                    divUploadSensorData.Visible = false;
                    divDownloadSensorData.Visible = false;
                    divManageAdmins.Visible = true;
                    divEditGallery.Visible = false;
                    divEditAbout.Visible = false;
                    divVolunteers.Visible = false;

                    divNewAdmin.Visible = false;
                    break;
                case "gallery":
                    lblPanelTitle.Text = "Manage Gallery:";
                    divAddLocation.Visible = false;
                    divAddWatershed.Visible = false;
                    divUploadSensorData.Visible = false;
                    divDownloadSensorData.Visible = false;
                    divManageAdmins.Visible = false;
                    divEditGallery.Visible = true;
                    divEditAbout.Visible = false;
                    divVolunteers.Visible = false;

                    divEditAlbum.Visible = false;
                    divAddNewAlbum.Visible = false;
                    ddlAlbumLocation.Visible = false;
                    break;
                case "about":
                    lblPanelTitle.Text = "Manage About:";
                    divAddLocation.Visible = false;
                    divAddWatershed.Visible = false;
                    divUploadSensorData.Visible = false;
                    divDownloadSensorData.Visible = false;
                    divManageAdmins.Visible = false;
                    divEditGallery.Visible = false;
                    divEditAbout.Visible = true;
                    divVolunteers.Visible = false;
                    break;
                case "volunteer":
                    lblPanelTitle.Text = "Volunteer Form Submissions:";
                    divAddLocation.Visible = false;
                    divAddWatershed.Visible = false;
                    divUploadSensorData.Visible = false;
                    divDownloadSensorData.Visible = false;
                    divManageAdmins.Visible = false;
                    divEditGallery.Visible = false;
                    divEditAbout.Visible = false;
                    divVolunteers.Visible = true;
                    break;
            }
        }

        ////////////////////////////////////////////////////////////////////////////////////////      ADD LOCATION FUNCTIONS
        
        protected void btnAddLocation_Click(object sender, EventArgs e)
        {
            
        }

        ////////////////////////////////////////////////////////////////////////////////////////      DOWNLOAD TEMPERATURE DATA FUNCTIONS
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
            //  Loop through all Repeater Items
            for(int i = 0; i < rptDownloadSensorLocations.Items.Count; i++)
            {
                cbox = (CheckBox)rptDownloadSensorLocations.Items[i].FindControl("cbxDownloadSensorLocation");
                hid = (HiddenField)rptDownloadSensorLocations.Items[i].FindControl("hdnDownloadSensorLocationID");
                //  If the Repeater item's checkbox is checked
                if (cbox.Checked)
                {
                    //  Add its LocationID to the list
                    selectedLocations.Add(Convert.ToInt32(hid.Value));
                }
            }

            //  Get data of selected Locations from database
            DataSet selectedTempDataSet = ClassFunctions.GetAllTemperaturesByMultipleLocationIds(selectedLocations);

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
        protected void btnDownloadAllSensorData_Click(object sender, EventArgs e)
        {
            string csvFileName = $"Temps-{DateTime.Now.ToString("M/d/yy-H:mm")}.csv";

            //  Download all data from the database
            DataSet allTempDataSet = ClassFunctions.GetAllTemperatures();
            List<Temperature> tempList = new List<Temperature>();
            for(int i = 0; i < allTempDataSet.Tables[0].Rows.Count; i++)
            {
                Temperature t = new Temperature();
                t.Timestamp = Convert.ToDateTime(allTempDataSet.Tables[0].Rows[i]["DateRecorded"]);
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


        ////////////////////////////////////////////////////////////////////////////////////////      UPLOAD TEMPERATURE DATA FUNCTIONS
        protected void btnUploadSensorData_Click(object sender, EventArgs e)
        {
            //  Show error div
            divUploadError.Visible = true;
        }
        protected void HideUploadError(object sender, EventArgs e)
        {
            //  Hide error div
            divUploadError.Visible = false;
        }

        ////////////////////////////////////////////////////////////////////////////////////////      MANAGE ADMINS FUNCTIONS        
        protected void btnAddNewAdmin_Click(object sender, EventArgs e)
        {
            divNewAdmin.Visible = true;
        }
        protected void HideNewAdmin(object sender, EventArgs e)
        {
            divNewAdmin.Visible = false;
        }


        ////////////////////////////////////////////////////////////////////////////////////////      MANAGE GALLERY FUNCTIONS
        protected void btnEditAlbum_Click(object sender, EventArgs e)
        {
            divEditAlbum.Visible = true;
            divAddNewAlbum.Visible = false;
        }
        //  Open New Album Form
        protected void btnAddAlbum_Click(object sender, EventArgs e)
        {
            divEditAlbum.Visible = false;
            divAddNewAlbum.Visible = true;
        }
        //  Submit New Album Form
        protected void btnCreateAlbum_Click(object sender, EventArgs e)
        {
            divAddNewAlbum.Visible = false;
        }
        protected void btnCloseEditGallery_Click(object sender, EventArgs e)
        {
            divEditAlbum.Visible = false;
        }
        protected void ddlNewAlbumGroup_Change(object sender, EventArgs e)
        {        
            string type = ddlNewAlbumGroup.SelectedValue;
            if (type == "location")
                ddlAlbumLocation.Visible = true;
            else
                ddlAlbumLocation.Visible = false;
        }
    }
}