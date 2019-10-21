-- TODO: Find a better way to insert initial images
DECLARE @cnt INT = 1;

WHILE @cnt <= 30
BEGIN
   EXEC [dbo].[GenerateTestImage]
   SET @cnt = @cnt + 1;
END;


DECLARE @WatershedId int;

----- Create Cobbs Watershed
INSERT INTO [dbo].[Watershed]
([WatershedName], [LastUpdated])
VALUES
('Cobbs', GETDATE())

-- Store the watershed's primary key
SELECT @WatershedId = (SELECT SCOPE_IDENTITY());

-- Create Watershed Locations
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'GilmoreRd_Bridge', -75.3025, -75.3025, 1, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'HillcrestAve', -75.3173, 39.9848, 2, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'Hollywood_Footbridge', -75.2965, 39.9647, 3, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'NaylorsPark_A', -75.2825, 39.9571, 4, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'NaylorsPark_B', -75.2810, 39.9562, 5, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'NaylorsPark_C', -75.2780, 39.9549, 6, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'RemingtonLower', -75.2712, 39.9903, 7, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'RemingtonUpper', -75.2724, 39.9922, 8, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'WashingtonAve_A', -75.3117, 39.9790, 9, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'WashingtonAve_B', -75.3099, 39.9771, 10, GETDATE());

GO
DECLARE @WatershedId int;
----- Create Pennypack Watershed
INSERT INTO [dbo].[Watershed]
([WatershedName], [LastUpdated])
VALUES
('Pennypack', GETDATE())

-- Store the watershed's primary key
SELECT @WatershedId = (SELECT SCOPE_IDENTITY());

-- Create Locations
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'LoriLane', -75.1030, 40.1666, 11, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'PennypackCircle_A', -75.0980, 40.1697, 12, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'PennypackCircle_B', -75.0990, 40.1692, 13, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'PennypackCircle_C', -75.1000, 40.1687, 14, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'PennypackCircle_D', -75.1009, 40.1684, 15, GETDATE());

GO
DECLARE @WatershedId int;
----- Ceate Tookany/Tcacony-Frankfurt Watershed
INSERT INTO [dbo].[Watershed]
([WatershedName], [LastUpdated])
VALUES
('Tookany/Tacony-Frankfurt', GETDATE())

-- Store the Watershed's Primay Key
SELECT @WatershedId = (SELECT SCOPE_IDENTITY());

-- Create Locations
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'AlverthorpeField_B', -75.1070, 40.0892, 16, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'AlvPond_Down', -75.1141, 40.0884, 17, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'AlvPond_Up', -75.1153, 40.0906, 18, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'AnthonyRd', -75.1082, 40.0780, 19, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'ArtCenter', -75.1152, 40.0929, 20, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'JenkintownRd_Meade', -75.1072, 40.0720, 21, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'McKinley', -75.1064, 40.0850, 22, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'TwshpLineRd', -75.1080, 40.0760, 23, GETDATE());

GO
DECLARE @WatershedId int;
----- Create Wissahickon Watershed
INSERT INTO [dbo].[Watershed]
([WatershedName], [LastUpdated])
VALUES
('Wissahickon', GETDATE())

-- Store the Watershed's Primay Key
SELECT @WatershedId = (SELECT SCOPE_IDENTITY());

-- Create Locations
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'GrovePark_A', -75.1265, 40.1290, 24, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'GrovePark_B', -75.1280, 40.1287, 25, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'GrovePark_C', -75.1292, 40.1284, 26, GETDATE());
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [ProfileImageID], [LastUpdated])
VALUES
(@WatershedId, 'RoslynPark', -75.1428, 40.1290, 27, GETDATE());

GO


-- Create About
INSERT INTO [dbo].[About]
([ProgramDescription], [Question1], [Question2], [Question3], [Answer1], [Answer2], [Answer3])
VALUES
('Citizen Science Data System (CS) is a project headed by Dr. Laura Toran and Dr. Sarah Beganskas who both work in the Earth and Environmental Science department in the College of Science and Technology. They are planning to develop an initiative which tasks volunteers with measuring temperature of water in watersheds located in the Greater Philadelphia and surrounding areas. With the CS Data System, they intend to engage the volunteers that travel to watersheds and provide accurate data reporting of the measured water temperature. The project will help visualize the data collected and allow for users that visit the application to view the various metrics.',
'Who are we?',
'What are our goals?',
'What are the expected benefits?',
'Citizen Science Data System (CS) is a project headed by Dr. Laura Toran and Dr. Sarah Beganskas who both work in the Earth and Environmental Science department in the College of Science and Technology. They are planning to develop an initiative which tasks volunteers with measuring temperature of water in watersheds located in the Greater Philadelphia and surrounding areas. With the CS Data System, they intend to engage the volunteers that travel to watersheds and provide accurate data reporting of the measured water temperature. The project will help visualize the data collected and allow for users that visit the application to view the various metrics.',
'The Citizen Science Data System will record water temperature information and organize it by location. This data will be displayed in the form of interactive graphs that can be accessed from a map-view user interface. This project will serve to monitor local water source statistics while also engaging the community by allowing them to be actively involved in the collection and analysis of the data.',
'The main benefits to be gained through this new system will be a secure and organized data storage method for vital water temperature data as well as a way of involving Greater Philadelphia area residents in the conservation of local water ecosystems. The system will be designed to allow administrative users to easily record relevant data. That collected data will then be displayed in an intuitive and user-friendly manner.')

GO