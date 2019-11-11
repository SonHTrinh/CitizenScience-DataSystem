using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using CitizenScienceClasses;
using System.Web.Services;
namespace CitizenScience_UIPrototype.secure.administration
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //Variables
            string employeeNumber = string.Empty, eduPersonPrincipalName = string.Empty, mail = string.Empty, affiliation = string.Empty;

            /* Check if the application is running demo mode */
            //for this "Demo_mode" check the web config 
            //if (ConfigurationManager.AppSettings["demo_mode"].ToLower().Equals("false"))
            //{
            /* Check if the application is running locally for development
             * Retrieve request header information
             */
            if (HttpContext.Current.Request.IsLocal.Equals(true))
            {
                /*The SSO Sign-on page will not appear while running locally. This is only used for development.*/
                employeeNumber = "915261297";

                Session["Authenticated"] = true;
                Response.Redirect("about.aspx");
            }
            else
            {
                /*Application is running on server and the user has active Shibboleth session.*/
                employeeNumber = GetShibbolethHeaderAttributes();
                GetUserInformation(employeeNumber);
            }


            /*Use employee number to get user information from web services and then redirect*/

            


            //}
        }


        /// Retrieve user information from Shibboleth headers
        /// <returns>User's TUid</returns>
        protected string GetShibbolethHeaderAttributes()
        {
            string employeeNumber = Request.Headers["employeeNumber"]; //Use this to retrieve the user's information via the web services  
            Session["SSO_Attribute_mail"] = Request.Headers["mail"];
            Session["SSO_Attribute_affiliation"] = Request.Headers["affiliation"];
            Session["SSO_Attribute_eduPersonPrincipalName"] = Request.Headers["eduPersonPrincipalName"];
            Session["SSO_Attribute_Unscoped_Affiliation"] = Request.Headers["unscopedaffiliation"];
            Session["SSO_Attribute_employeeNumber"] = employeeNumber;

            return employeeNumber;
        }

        /// Use employeeNumber (TUid) to retrieve infromation about the user
        /// from the web services.

        protected void GetUserInformation(string employeeNumber)
        {
            if (!string.IsNullOrWhiteSpace(employeeNumber))
            {
                DataSet ds = new DataSet();
                /* Requesting user's LDAP information via Web Service */
                CitizenScienceClasses.WebService.LDAPuser Temple_Information = CitizenScienceClasses.WebService.Webservice.getLDAPEntryByTUID(employeeNumber);
                /* Checking we received something from Web Services*/
                if (Temple_Information != null)
                {
                    /*Populating the Session Object with the user's information*/
                    Session["TU_ID"] = Temple_Information.templeEduID;
                    Session["First_Name"] = Temple_Information.givenName;
                    Session["Last_Name"] = Temple_Information.sn;
                    Session["Email"] = Temple_Information.mail;
                    Session["Title"] = Temple_Information.title;
                    Session["Affiliation_Primary"] = Temple_Information.eduPersonPrimaryAffiliation;
                    Session["Affiliation_Secondary"] = Temple_Information.eduPersonAffiliation;
                    Session["Full_Name"] = Temple_Information.cn;
                    ds = DataProcessor.AuthenticateAdmin(Session["TU_ID"].ToString());


                }
                else if (Temple_Information == null)
                {
                    ds = DataProcessor.AuthenticateAdmin(employeeNumber);
                }

                if (ds.Tables[0].Rows.Count > 0)
                {
                    Session["Authenticated"] = true;
                    Response.Redirect("about.aspx");
                }
                else
                {
                    Server.Transfer("403http.aspx");
                    Session["Authenticated"] = false;
                }
            }
    

            else
            {
                Server.Transfer("403http.aspx");
                Session["Authenticated"] = false;

            }
        }
    

//        protected void btnShibb_Click(object sender, EventArgs e)
//        {
//            try
//            {
//                if (Request.Headers["employeeNumber"] != null)
//                {
//                    GetUserInformation(Request.Headers["employeeNumber"]);
//                }
//                else
//                {
//                    //divError.Visible = true;
//                    //lblError.Text = (HttpContext.Current.Request.IsLocal.Equals(true)) ? "<strong>Error:</strong> Shibboleth cannot be used if application is running locally." : "<strong>Error:</strong> Profile could not be loaded!";
//                }
//            }
//            catch (Exception)
//            {
//                Server.Transfer("500http.aspx");
//            }
//        }


    }
}