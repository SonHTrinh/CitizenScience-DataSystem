CREATE TABLE [dbo].[Watershed] (
[WatershedID] INT IDENTITY (1,1) NOT NULL, 
[WatershedName] VARCHAR (MAX) NOT NULL, 
[LastUpdated] DATE NOT NULL, 
PRIMARY KEY CLUSTERED ([WatershedID] ASC)
);

CREATE TABLE [dbo].[BulkUpload](
[UploadID] INT IDENTITY(1,1) NOT NULL, 
[AdminAccessnet] VARCHAR(MAX) NOT NULL, 
[DateUploaded] DATE NOT NULL, 
PRIMARY KEY CLUSTERED ([UploadID] ASC) 
); 
CREATE TABLE [dbo].[Location](
[LocationID] INT IDENTITY (1,1) NOT NULL, 
[WatershedID] INT NOT NULL, 
[Longitude] FLOAT(53) NOT NULL, 
[Latitude] FLOAT (53) NOT NULL, 
[SensorName] VARCHAR(MAX) NOT NULL, 
[SerialNumber] VARCHAR(MAX) NULL,
[ProfileImage] VARCHAR(MAX) NULL, 
[LastUpdated] DATE NOT NULL, 
PRIMARY KEY CLUSTERED ([LocationID] ASC) ,
CONSTRAINT  [FK_Location_ToTable] FOREIGN KEY ([WatershedID]) REFERENCES [dbo].[Watershed] ([WatershedID]) 
); 
CREATE TABLE [dbo].[Temperature]( 
[TempID] INT IDENTITY(1,1) NOT NULL, 
[LocationID] INT NOT NULL, 
[UploadID] INT NOT NULL, 
[DateRecorded] DATE NOT NULL, 
[TimeRecorded] TIME(7)  NOT NULL, 
[TempC] FLOAT(53) NOT NULL, 
[TempF] FLOAT(53) NOT NULL, 
PRIMARY KEY CLUSTERED ([TempID] ASC) , 
CONSTRAINT [FK_Temperature_ToTable1] FOREIGN KEY ([UploadID]) REFERENCES [dbo].[BulkUpload] ([UploadID]),
CONSTRAINT [FK_Temperature_ToTable] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[Location] ([LocationID]) 
); 



CREATE PROCEDURE [dbo].[GetAllLocations]
AS
	SELECT * FROM Location
    

CREATE PROCEDURE [dbo].[GetLocationsByWatershed]
	@watershedID int
AS
	SELECT * FROM Location
    WHERE WatershedID = @watershedID
    

CREATE PROCEDURE [dbo].[GetAllTemperatures]
AS
	SELECT * FROM Temperature


CREATE PROCEDURE [dbo].[GetAllWatersheds]
AS
	SELECT * FROM Watershed
    
    
CREATE PROCEDURE [dbo].[GetAllBulkUploads]
AS
	SELECT * FROM BulkUploads


CREATE PROCEDURE [dbo].[GetAllTemperaturesByLocationId]
	@locationID int
AS
	SELECT * FROM Temperature
    WHERE LocationID = @locationID


CREATE PROCEDURE [dbo].[GetAllTemperaturesByMultipleLocationIds]
	@listOflocationID varchar(max)
AS
	SELECT * FROM Temperature
    JOIN STRING_SPLIT(@listOflocationID, ',')
    ON value = LocationID

-- CRUD Watershed
CREATE PROCEDURE [dbo].[CreateWatershed]
    @name varchar(255)
AS
    INSERT INTO Watershed (WatershedName, LastUpdated)
    VALUES (@name, GETDATE())
    SELECT * FROM Watershed WHERE WatershedID = SCOPE_IDENTITY()

CREATE PROCEDURE [dbo].[UpdateWatershed]
	@id int
	@name varchar(255)
AS
	UPDATE Watershed
	SET WatershedName = @name, LastUpdated = GETDATE()
	WHERE WatershedID = @id
	SELECT * FROM Watershed where WatershedID = @id

CREATE PROCEDURE [dbo].[Watershed]
	@id int
AS
	DELETE FROM Watershed WHERE watershedID = @id