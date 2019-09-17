using System;
using System.Collections.Generic;
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
                    FileUpload1.SaveAs(Server.MapPath($"upload/{FileUpload1.FileName}"));

                    rptCSV.DataSource = DataProcessor.Read(FileUpload1.PostedFile.InputStream);
                    rptCSV.DataBind();
                }
                catch (Exception ex)
                {
                    
                    sb.AppendFormat("Unable to save file <br/> {0}", ex.Message);
                }
            }

            lblmessage.Text = sb.ToString();
        }
    }
}