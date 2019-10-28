using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CitizenScienceClasses
{
    public class About
    {
        private string description;
        private string question1;
        private string answer1;
        private string question2;
        private string answer2;
        private string question3;
        private string answer3;
        public About() { }
        private About(string d, string q1, string a1, string q2, string a2, string q3, string a3)
        {
            description = d;
            question1 = q1;
            question2 = q2;
            question3 = q3;
            answer1 = a1;
            answer2 = a2;
            answer3 = a3;
        }
        public string Description
        {
            get { return description; }
            set { description = value; }
        }
        public string Question1
        {
            get { return question1; }
            set { question1 = value; }
        }
        public string Question2
        {
            get { return question2; }
            set { question2 = value; }
        }
        public string Question3
        {
            get { return question3; }
            set { question3 = value; }
        }
        public string Answer1
        {
            get { return answer1; }
            set { answer1 = value; }
        }
        public string Answer2
        {
            get { return answer2; }
            set { answer2 = value; }
        }
        public string Answer3
        {
            get { return answer3; }
            set { answer3 = value; }
        }
    }
}
