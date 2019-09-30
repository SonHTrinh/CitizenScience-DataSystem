DECLARE @WatershedId int;

----- Create Cobbs Watershed
INSERT INTO [dbo].[Watershed]
([WatershedName], [LastUpdated])
VALUES
('Cobbs', '2019-09-29 12:00:00')

-- Store the watershed's primary key
SELECT @WatershedId = (SELECT SCOPE_IDENTITY());

-- Create Watershed Locations
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [LastUpdated])
VALUES
(@WatershedId, 'GilmoreRd_Bridge', -75.3025, -75.3025, '2019-09-29 12:00:00'),
(@WatershedId, 'HillcrestAve', -75.3173, 39.9848, '2019-09-29 12:00:00'),
(@WatershedId, 'Hollywood_Footbridge', -75.2965, 39.9647, '2019-09-29 12:00:00')

GO
DECLARE @WatershedId int;
----- Create Pennypack Watershed
INSERT INTO [dbo].[Watershed]
([WatershedName], [LastUpdated])
VALUES
('Pennypack', '2019-09-29 12:00:00')

-- Store the watershed's primary key
SELECT @WatershedId = (SELECT SCOPE_IDENTITY());

-- Create Locations
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [LastUpdated])
VALUES
(@WatershedId, 'LoriLane', -75.1030, 40.1666, '2019-09-29 12:00:00'),
(@WatershedId, 'PennypackCircle_A', -75.0980, 40.1697, '2019-09-29 12:00:00'),
(@WatershedId, 'PennypackCircle_B', -75.0990, 40.1692, '2019-09-29 12:00:00')

GO
DECLARE @WatershedId int;
----- Ceate Tookany/Tcacony-Frankfurt Watershed
INSERT INTO [dbo].[Watershed]
([WatershedName], [LastUpdated])
VALUES
('Tookany/Tacony-Frankfurt', '2019-09-29 12:00:00')

-- Store the Watershed's Primay Key
SELECT @WatershedId = (SELECT SCOPE_IDENTITY());

-- Create Locations
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [LastUpdated])
VALUES
(@WatershedId, 'AlvPond_Down', -75.1141, 40.0884, '2019-09-29 12:00:00'),
(@WatershedId, 'AlvPond_Up', -75.1153, 40.0906, '2019-09-29 12:00:00'),
(@WatershedId, 'AnthonyRd', -75.1082, 40.0780, '2019-09-29 12:00:00')

GO
DECLARE @WatershedId int;
----- Create Wissahickon Watershed
INSERT INTO [dbo].[Watershed]
([WatershedName], [LastUpdated])
VALUES
('Wissahickon', '2019-09-29 12:00:00')

-- Store the Watershed's Primay Key
SELECT @WatershedId = (SELECT SCOPE_IDENTITY());

-- Create Locations
INSERT INTO [dbo].[Location]
([WatershedID], [SensorName], [Longitude], [Latitude], [LastUpdated])
VALUES
(@WatershedId, 'GrovePark_A', -75.1265, 40.1290, '2019-09-29 12:00:00'),
(@WatershedId, 'GrovePark_B', -75.1280, 40.1287, '2019-09-29 12:00:00'),
(@WatershedId, 'GrovePark_C', -75.1292, 40.1284, '2019-09-29 12:00:00')

GO