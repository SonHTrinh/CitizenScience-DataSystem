-- DROP TABLES
DROP TABLE IF EXISTS [About]
GO

DROP TABLE IF EXISTS [Error]
GO

DROP TABLE IF EXISTS [Admin]
GO

DROP TABLE IF EXISTS [AlbumImages]
GO

DROP TABLE IF EXISTS [Album]
GO

DROP TABLE IF EXISTS [Temperature]
GO

DROP TABLE IF EXISTS [BulkUpload]
GO

DROP TABLE IF EXISTS [Location]
GO

DROP TABLE IF EXISTS [Watershed]
GO

DROP TABLE IF EXISTS [Volunteer]
GO

DROP TABLE IF EXISTS [Image]
GO

-- DROP Stored PROCEDURES
DROP PROCEDURE IF EXISTS [AddTemperatures]
GO

DROP PROCEDURE IF EXISTS [BulkTemperatureDataInsert]
GO

DROP PROCEDURE IF EXISTS [CreateLocation]
GO

DROP PROCEDURE IF EXISTS [CreateWatershed]
GO

DROP PROCEDURE IF EXISTS [GetAllBulkUploads]
GO

DROP PROCEDURE IF EXISTS [GetAllLocations]
GO

DROP PROCEDURE IF EXISTS [GetAllTemperatures]
GO

DROP PROCEDURE IF EXISTS [GetAllTemperaturesByLocationId]
GO

DROP PROCEDURE IF EXISTS [GetLatestLocationTemperature]
GO

DROP PROCEDURE IF EXISTS [GetAllTemperaturesByMultipleLocationIds]
GO

DROP PROCEDURE IF EXISTS [GetAllWatersheds]
GO

DROP PROCEDURE IF EXISTS [GetLocationsByWatershed]
GO

DROP PROCEDURE IF EXISTS [ReadLocation]
GO

DROP PROCEDURE IF EXISTS [ReadWatershed]
GO

DROP PROCEDURE IF EXISTS [UpdateLocation]
GO

DROP PROCEDURE IF EXISTS [UpdateWatershed]
GO

DROP PROCEDURE IF EXISTS [GetAllVolunteers]
GO

DROP PROCEDURE IF EXISTS [GetLocationTemperaturesByDateRange]
GO

DROP PROCEDURE IF EXISTS [GetLocationImage]
GO

DROP PROCEDURE IF EXISTS [SetLocationImage]
GO

DROP PROCEDURE IF EXISTS [GetAlbumImageIDs]
GO

DROP PROCEDURE IF EXISTS [GetImage]
GO

DROP PROCEDURE IF EXISTS [AddImageToAlbum]
GO

DROP PROCEDURE IF EXISTS [CreateVolunteer]
GO

DROP PROCEDURE IF EXISTS [UploadImage]
GO

DROP PROCEDURE IF EXISTS [CreateVolunteer]
GO

DROP PROCEDURE IF EXISTS [CreateAdmin]
GO

DROP PROCEDURE IF EXISTS [UpdateAdmin]
GO

DROP PROCEDURE IF EXISTS [ValidateAdmin]
GO

DROP PROCEDURE IF EXISTS [NewAbout]
GO

DROP PROCEDURE IF EXISTS [GetLatestAbout]
GO

DROP PROCEDURE IF EXISTS [GetAllAdmins]
GO

DROP PROCEDURE IF EXISTS [GenerateTestImage]
GO

-- DROP Types

DROP TYPE IF EXISTS [TEMPERATUREDATA]
GO
