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
        private string accessnet;
        public Admin() { }
        public Admin(int id, string access)
        {
            adminID = id;
            accessnet = access;
        }
        public int AdminID
        {
            get { return adminID; }
            set { adminID = value; }
        }
        public string Accessnet
        {
            get { return accessnet; }
            set { accessnet = value; }
        }        
    }
}
