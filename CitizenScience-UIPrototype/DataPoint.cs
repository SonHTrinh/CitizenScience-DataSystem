using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CitizenScience_UIPrototype
{
    public class DataPoint
    {
        private String _timestamp;
        private float _celsius;
        private float _fahrenheit;

        public string Timestamp
        {
            get { return _timestamp; }
            set { _timestamp = value; }
        }

        public float Celsius
        {
            get { return _celsius; }
            set { _celsius = value; }
        }

        public float Fahrenheit
        {
            get { return _fahrenheit; }
            set { _fahrenheit = value; }
        }
    }
}