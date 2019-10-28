using CsvHelper.Configuration.Attributes;
using System;

namespace CitizenScienceClasses
{
    public class Temperature
    {
        [Ignore]
        public int Id { get; set; }

        [Name("Date")]
        [Format("M/d/yyyy H:mm")]
        public DateTime Timestamp { get; set; }

        [Name("Temperature_C")]
        public double Celsius { get; set; }

        [Name("Temperature_F")]
        public double Fahrenheit { get; set; }

        /*
             WARNING: Do not make a constructor for this class, it will break CSV mapping,
             to avoid having to make a custom configuration mapper, dynamically make a Temperature object.

             Temperature temp = new Temperature
             {
                 Id = 9,
                 Timestamp = DateTime.Now,
                 Celsius = 1.1,
                 Fahrenheit = 2.22
              }

              OR

              Temperature temp = new Temperature();
              temp.Id = 9;
              temp.Timestamp = DateTime.Now;
              temp.Celsius = 1.1;
              temp.Fahrenheit = 2.22;

        */
    }
}
