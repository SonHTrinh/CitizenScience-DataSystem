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
        private bool active;
        public Admin() { }
        public Admin(int id, string tu, bool act)
        {
            adminID = id;
            tuid = tu;
            active = act;
        }
        public int AdminID
        {
            get { return adminID; }
            set { adminID = value; }
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
