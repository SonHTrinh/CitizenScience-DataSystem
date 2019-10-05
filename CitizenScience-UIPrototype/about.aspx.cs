using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CitizenScienceClasses;

namespace CitizenScience_UIPrototype
{
    public partial class about : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                RenderAboutPage();
        }
        protected void RenderAboutPage()
        {
            About a = new About();
            txtAboutDescription.Text = a.Description;
            btnQuestion1.InnerText = a.Question1;
            btnQuestion2.InnerText = a.Question2;
            btnQuestion3.InnerText = a.Question3;
            divAnswer1.InnerText = a.Answer1;
            divAnswer2.InnerText = a.Answer2;
            divAnswer2.InnerText = a.Answer2;
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string fname = txtFname.Value;
            string lname = txtFname.Value;
            string email = txtEmail.Value;
            string message = txtMessage.Value;
            DateTime submitted = DateTime.Now;
            if(fname != "")
            {
                if(lname != "")
                {
                    if(email != "")
                    {
                        Volunteer v = new Volunteer();
                        v.FirstName = fname;
                        v.LastName = lname;
                        v.Email = email;
                        v.Message = message;
                        bool success = ClassFunctions.CreateVolunteer(v);
                        if (success)
                            lblSubmittedEmail.Text = email;
                    }
                }
            }            
        }
    }
}