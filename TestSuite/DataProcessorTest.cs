using System;
using System.Collections.Generic;
using System.IO;
using CitizenScienceClasses;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using CsvHelper;

namespace TestSuite
{
    [TestClass]
    public class DataProcessorTest
    {
        private readonly string pathToSampleData = Path.GetFullPath(@"..\..\") + "/sample_data";
        
        private readonly List<Temperature> sampleData = new List<Temperature>
        {
            new Temperature
            {
                Id = 0,
                Timestamp = DateTime.Parse("4/24/2019 14:10"),
                Celsius = 15.7,
                Fahrenheit = 60.26
            },
            new Temperature
            {
                Id = 1,
                Timestamp = DateTime.Parse("4/24/2019 14:15"),
                Celsius = 15.61,
                Fahrenheit = 60.098
            },
            new Temperature
            {
                Id = 2,
                Timestamp = DateTime.Parse("4/24/2019 14:20"),
                Celsius = 15.74,
                Fahrenheit = 60.332
            }
        };

        [TestMethod]
        public void ReadCsv_Passing()
        {
            string testFileLocaton = pathToSampleData + "/pass_1.csv";

            List<Temperature> testingData = null;

            using (FileStream fileStream = File.OpenRead(testFileLocaton))
            testingData = DataProcessor.ReadCsvFile(fileStream);

            Assert.IsNotNull(testingData);

            Assert.AreEqual(sampleData[0].Timestamp, testingData[0].Timestamp);
            Assert.AreEqual(sampleData[0].Celsius, testingData[0].Celsius);
            Assert.AreEqual(sampleData[0].Fahrenheit, testingData[0].Fahrenheit);

            Assert.AreEqual(sampleData[1].Timestamp, testingData[1].Timestamp);
            Assert.AreEqual(sampleData[1].Celsius, testingData[1].Celsius);
            Assert.AreEqual(sampleData[1].Fahrenheit, testingData[1].Fahrenheit);

            Assert.AreEqual(sampleData[2].Timestamp, testingData[2].Timestamp);
            Assert.AreEqual(sampleData[2].Celsius, testingData[2].Celsius);
            Assert.AreEqual(sampleData[2].Fahrenheit, testingData[2].Fahrenheit);
        }

        [TestMethod]
        public void ReadCsv_Failing_InvalidTimestamp()
        {
            string testFileLocaton = pathToSampleData + "/fail_1.csv";

            using (FileStream fileStream = File.OpenRead(testFileLocaton))
                Assert.ThrowsException<ReaderException>(() => DataProcessor.ReadCsvFile(fileStream));
        }
    }
}
