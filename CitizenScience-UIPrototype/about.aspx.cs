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
    public partial class about : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text;
            string lastName = txtLastName.Text;
            string email = txtEmail.Text;
            string message = txtMessage.Text;

            Volunteer volunteer = new Volunteer();
            if (firstName != "" && lastName != "" && email != "" && message != "")
            {
                volunteer.FirstName = firstName;
                volunteer.LastName = lastName;
                volunteer.Email = email;
                volunteer.Message = message;

                lblDisplay.Text = "";

                try
                {
                    ClassFunctions.CreateVolunteer(firstName, lastName, email, message);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                lblDisplay.Text = "Please fill in all required field!";
            }

            txtFirstName.Text = ""; txtLastName.Text = ""; txtEmail.Text = ""; txtMessage.Text = "";

        }
    }
}
