using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitizenScienceClasses
{
    public class Admin
    {
        private int adminID;
        private string tuid;
        private string fname;
        private string lname;
        private string email; 
        private bool active;

        public Admin() { }
        public Admin(int id, string tu,string fn, string ln, string em, bool act)
        {
            adminID = id;
            tuid = tu;
            active = act;
            fname = fn;
            lname = ln;
            Email = em; 
        }
        public int AdminID
        {
            get { return adminID; }
            set { adminID = value; }
        }

        public string FName
        {
            get { return fname; }
            set { fname = value;  }
        }
        public string LName
        {
            get { return lname; }
            set { lname = value; }
        }
        public string Email
        {
            get { return email; }
            set { email = value; }
        }
        public string TUID
        {
            get { return tuid; }
            set { tuid = value; }
        }
        public bool Active
        {
            get { return active; }
            set { active = value; }
        }
    }
}
