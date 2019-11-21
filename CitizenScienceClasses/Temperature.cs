using CsvHelper.Configuration.Attributes;
using System;
using CsvHelper.Configuration;

namespace CitizenScienceClasses
{
    public class Temperature
    {
        [Ignore]
        public int Id { get; set; }

//        [Name("Date")]
        [Format("M/d/yyyy H:mm")]
        public DateTime Timestamp { get; set; }

//        [Name("Temperature_C")]
        public double? Celsius { get; set; }

//        [Name("Temperature_F")]
        public double? Fahrenheit { get; set; }

//        [Ignore]
        public string Location { get; set; }

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

    public class TemperatureMap : ClassMap<Temperature>
    {
        public TemperatureMap()
        {
            Map(m => m.Location).Name("Sensor Name");
            Map(m => m.Timestamp).Name("Date Time");
            Map(m => m.Celsius).Name("Temperature_C");
            Map(m => m.Fahrenheit).Name("Temperature_F");
        }
    }

    public class TemperatureMapNoLocation : ClassMap<Temperature>
    {
        public TemperatureMapNoLocation()
        {
            Map(m => m.Timestamp).Name("Date Time");
            Map(m => m.Celsius).Name("Temperature_C");
            Map(m => m.Fahrenheit).Name("Temperature_F");
        }
    }
}
