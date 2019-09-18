using CitizenScienceClasses;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CitizenScience_UIPrototype
{
    public partial class debug : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();

            if (FileUpload1.HasFile)
            {
                try
                {
                    Stream fileStream = FileUpload1.PostedFile.InputStream;
                    List<Temperature> temperatureList = DataProcessor.ReadCsvFile(fileStream);

                    rptCSV.DataSource = temperatureList;
                    rptCSV.DataBind();
                }
                catch (Exception ex)
                {
                    sb.AppendFormat("Unable to save file <br/> {0}", ex.Message);
                }
            }

            lblmessage.Text = sb.ToString();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            rptCSV.DataSource = new List<Temperature>();
            rptCSV.DataBind();
        }

        protected void btnDownload_Click(object sender, EventArgs e)
        {
            string csvFileName = $"Temps-{DateTime.Now.ToString("M/d/yy-H:mm")}.csv";

            List<Temperature> temperatureList = new List<Temperature>
            {
                new Temperature
                {
                    Id = 0,
                    Timestamp = DateTime.Now,
                    Celsius = 1.1,
                    Fahrenheit = 2.22
                },
                new Temperature
                {
                    Id = 1,
                    Timestamp = DateTime.Now,
                    Celsius = 3.333,
                    Fahrenheit = 4.4444
                }
            };

            byte[] csvData = DataProcessor.CreateCsvAsBytes(temperatureList);

            Response.Clear();
            Response.ContentType = "application/force-download";
            Response.AddHeader("content-disposition", "attachment; filename=" + csvFileName);
            Response.BinaryWrite(csvData);
            Response.End();
        }
    }
}