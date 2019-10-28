using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitizenScienceClasses
{
    public class Volunteer
    {
        private int volunteerID;
        private string firstName;
        private string lastName;
        private string email;
        private string message;
        private DateTime dateSubmitted;
        public Volunteer() { }
        public Volunteer(int id, string fname, string lname, string em, string mes, DateTime date)
        {
            volunteerID = id;
            firstName = fname;
            lastName = lname;
            email = em;
            message = mes;
            dateSubmitted = date;      
        }
        public int VolunteerID
        {
            get { return volunteerID; }
            set { volunteerID = value; }
        }        
        public string FirstName
        {
            get { return firstName; }
            set { firstName = value; }
        }
        public string LastName
        {
            get { return lastName; }
            set { lastName = value; }
        }
        public string Email
        {
            get { return email; }
            set { email = value; }
        }
        public string Message
        {
            get { return message; }
            set { message = value; }
        }
        public DateTime DateSubmitted
        {
            get { return dateSubmitted; }
            set { dateSubmitted = value; }
        }
    }
}
