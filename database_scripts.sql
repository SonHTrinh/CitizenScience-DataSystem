----- Citizen Science Database Creation Script

-- Run this script against a new database

-------------------- Tables --------------------

CREATE TABLE [dbo].[Watershed] (
	[WatershedID] INT IDENTITY (1,1) NOT NULL,
	[WatershedName] VARCHAR (MAX) NOT NULL,
	[LastUpdated] DATE NOT NULL,
	PRIMARY KEY CLUSTERED ([WatershedID] ASC)
);

GO

CREATE TABLE [dbo].[Image] (
    [ImageID]          INT            IDENTITY (1, 1) NOT NULL,
    [Bytes]			   VARBINARY (MAX) NOT NULL,
    [Description] NVARCHAR (MAX),
	[ContentType] NVARCHAR (MAX),
    [LastUpdated]      DATETIME           NOT NULL,
    PRIMARY KEY CLUSTERED ([ImageID] ASC)
);

GO

CREATE TABLE [dbo].[Location](
	[LocationID] INT IDENTITY (1,1) NOT NULL,
	[WatershedID] INT NOT NULL,
	[Longitude] FLOAT(53) NOT NULL,
	[Latitude] FLOAT (53) NOT NULL,
	[SensorName] VARCHAR(MAX) NOT NULL,
	[ProfileImageID] INT,
	[LastUpdated] DATE NOT NULL,
	PRIMARY KEY CLUSTERED ([LocationID] ASC) ,
	CONSTRAINT  [FK_Location_ToTable] FOREIGN KEY ([WatershedID]) REFERENCES [dbo].[Watershed] ([WatershedID]),
	CONSTRAINT  [FK_Image_ToTable] FOREIGN KEY ([ProfileImageID]) REFERENCES [dbo].[Image] ([ImageID])
);

GO

CREATE TABLE [dbo].[Temperature](
	[TempID] INT IDENTITY(1,1) NOT NULL,
	[LocationID] INT NOT NULL,
	[Timestamp] DateTime  NOT NULL,
	[TempC] FLOAT(53) NOT NULL,
	[TempF] FLOAT(53) NOT NULL,
	PRIMARY KEY CLUSTERED ([TempID] ASC) ,
	CONSTRAINT [FK_Temperature_ToTable] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[Location] ([LocationID])
);

GO

CREATE TABLE [dbo].[Admin] (
    [AdminID]     INT            IDENTITY (1, 1) NOT NULL,
    [Accessnet]   NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([AdminID] ASC)
);

GO

CREATE TABLE [dbo].[About] (
    [AboutID]            INT            IDENTITY (1, 1) NOT NULL,
    [ProgramDescription] NVARCHAR (MAX) NOT NULL,
    [Question1]          NVARCHAR (MAX) NOT NULL,
    [Question2]          NVARCHAR (MAX) NOT NULL,
    [Question3]          NVARCHAR (MAX) NOT NULL,
    [Answer1]            NVARCHAR (MAX) NOT NULL,
    [Answer2]            NVARCHAR (MAX) NOT NULL,
    [Answer3]            NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([AboutID] ASC)
);

GO

CREATE TABLE [dbo].[Album] (
    [AlbumID]     INT            IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (MAX) NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
	[LastUpdated] DATETIME,
    PRIMARY KEY CLUSTERED ([AlbumID] ASC)
);

GO

CREATE TABLE [dbo].[AlbumImages] (
	[AlbumID] INT NOT NULL,
	[ImageID] INT NOT NULL,
	[LastUpdated] DATETIME,
	CONSTRAINT [FK_ImageLink_ToTable] FOREIGN KEY ([ImageID]) REFERENCES [dbo].[Image] ([ImageID]),
	CONSTRAINT [FK_Album_ToTable] FOREIGN KEY ([AlbumID]) REFERENCES [dbo].[Album] ([AlbumID])
);

GO

CREATE TABLE [dbo].[Volunteer] (
    [VolunteerID]      INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]        NVARCHAR (MAX) NOT NULL,
    [LastName]         NVARCHAR (MAX) NOT NULL,
    [Email]            NVARCHAR (MAX) NOT NULL,
    [Message]          NVARCHAR (MAX) NULL,
    [DateSubmitted]    DATE           NOT NULL,
    PRIMARY KEY CLUSTERED ([VolunteerID] ASC)
);

GO

-------------------- Custom Types --------------------

CREATE TYPE [dbo].[TEMPERATUREDATA] AS TABLE(
	[LocationID] INT NOT NULL,
	[TimeStamp] DateTime  NOT NULL,
	[TempC] FLOAT(53) NOT NULL,
	[TempF] FLOAT(53) NOT NULL
);

GO

-------------------- Stored Procedures --------------------

------------------------------------------------------------------
------------------------------------------------- GET Procedures
------------------------------------------------------------------
CREATE PROCEDURE [dbo].[GetAllLocations]
AS
	SELECT * FROM Location

GO

CREATE PROCEDURE [dbo].[GetLocationsByWatershed]
	@watershedID int
AS
	SELECT * FROM Location
    WHERE WatershedID = @watershedID

GO

CREATE PROCEDURE [dbo].[GetAllTemperatures]
AS
	SELECT * FROM Temperature

GO

CREATE PROCEDURE [dbo].[GetAllWatersheds]
AS
	SELECT * FROM Watershed

GO

CREATE PROCEDURE [dbo].[GetAllTemperaturesByLocationId]
	@locationID int
AS
	SELECT * FROM Temperature
    WHERE LocationID = @locationID

GO

CREATE PROCEDURE [dbo].[GetAllTemperaturesByMultipleLocationIds]
	@listOflocationID varchar(max)
AS
	SELECT * FROM Temperature
    JOIN STRING_SPLIT(@listOflocationID, ',')
    ON value = LocationID

GO

CREATE PROCEDURE [dbo].[GetAllVolunteers]
AS
	SELECT * FROM Volunteer

GO

CREATE PROCEDURE [dbo].[GetLatestAbout]
AS
	SELECT TOP 1 * 
	FROM About 
	ORDER BY AboutID DESC

GO

-------------------------------------------------  Image
CREATE PROCEDURE [dbo].[SetLocationImage]
	@locationid int,
	@bytes VARBINARY(MAX),
	@contenttype varchar(max)
AS
	DECLARE @imageId int;
	INSERT INTO [Image] ([Bytes], [ContentType],  [LastUpdated]) VALUES (@bytes, @contenttype, GETDATE());

	SELECT @imageId = (SELECT SCOPE_IDENTITY());

	UPDATE Location
	SET [ProfileImageID] = @imageId,
	[LastUpdated] = GETDATE()
	WHERE LocationID = @locationid;

	SELECT * FROM [Location]
	WHERE LocationID = @locationid;

GO

CREATE PROCEDURE [dbo].[GetLocationImage]
	@locationid int
AS
	SELECT * FROM [Image]
	WHERE ImageId = (SELECT [ProfileImageID] FROM Location WHERE LocationID = @locationid)

GO

CREATE PROCEDURE [dbo].[AddImageToAlbum]
	@albumid int,
	@bytes varbinary(MAX),
	@contenttype nvarchar(MAX)
AS
	DECLARE @imageId int;
	INSERT INTO [Image] ([Bytes], [ContentType],  [LastUpdated]) VALUES (@bytes, @contenttype, GETDATE());

	SELECT @imageId = (SELECT SCOPE_IDENTITY());

	INSERT INTO [AlbumImages] ([AlbumID], [ImageID], [LastUpdated]) VALUES (@albumid, @imageId, GETDATE())

	UPDATE Album
	SET [LastUpdated] = GETDATE()
	WHERE AlbumID = @albumid;

	SELECT * FROM [Image]
	WHERE [ImageID] = @imageId;

GO

CREATE PROCEDURE [dbo].[GetAlbumImageIDs]
	@albumid int
AS
	SELECT [ImageID] FROM [AlbumImages]
	WHERE [AlbumID] = @albumid

GO

CREATE PROCEDURE [dbo].[GetImage]
	@imageid int
AS
	SELECT * FROM [Image]
	WHERE ImageId = @imageid

GO

------------------------------------------------------------------
------------------------------------------------- CRUD Procedures
------------------------------------------------------------------

------------------------------------------------- CRUD Temperature

CREATE PROCEDURE [dbo].[GetLocationTemperaturesByDateRange]
	@locationid int,
	@startdate datetime,
	@enddate datetime
AS
	SELECT * FROM Temperature
	WHERE LocationID = @locationid AND [Timestamp] BETWEEN @startdate AND @enddate

GO

CREATE PROCEDURE [dbo].[AddTemperatures]
	@locationid int,
	@ts datetime,
	@temp_c float,
	@temp_f float
AS
	INSERT INTO Temperature (LocationID, [Timestamp], TempC, TempF)
	VALUES (@locationid, @ts, @temp_c, @temp_f)

GO

CREATE PROCEDURE [dbo].[BulkTemperatureDataInsert]
	@temperaturetable TEMPERATUREDATA readonly
AS
	INSERT INTO Temperature select  LocationID, [Timestamp], TempC, TempF from @temperaturetable

GO

------------------------------------------------- CRUD Watershed
CREATE PROCEDURE [dbo].[CreateWatershed]
    @name varchar(255)
AS
    INSERT INTO Watershed (WatershedName, LastUpdated)
    VALUES (@name, GETDATE())
    SELECT * FROM Watershed WHERE WatershedID = SCOPE_IDENTITY()

GO

CREATE PROCEDURE [dbo].[ReadWatershed]
	@id int
AS
	SELECT * FROM Watershed WHERE watershedID = @id

GO

CREATE PROCEDURE [dbo].[UpdateWatershed]
	@id int,
	@name varchar(255)
AS
	UPDATE Watershed
	SET WatershedName = @name, LastUpdated = GETDATE()
	WHERE WatershedID = @id
	SELECT * FROM Watershed where WatershedID = @id

GO

------------------------------------------------- CRUD Location
CREATE PROCEDURE [dbo].[CreateLocation]
	@watershedid int,
    @name varchar(255),
    @latitude float,
    @longitude float
AS
    INSERT INTO Location (WatershedID, SensorName, Latitude, Longitude, LastUpdated)
    VALUES (@watershedid, @name, @latitude, @longitude, GETDATE())
    SELECT * FROM Location WHERE locationID = SCOPE_IDENTITY()

GO

CREATE PROCEDURE [dbo].[ReadLocation]
	@id int
AS
	SELECT * FROM Location WHERE LocationID = @id

GO

CREATE PROCEDURE [dbo].[UpdateLocation]
	@id int,
	@watershedid int,
    @name varchar(255),
    @latitude float,
    @longitude float
AS
	UPDATE Location
	SET WatershedID = @watershedid,
		SensorName = @name,
		Latitude = @latitude,
		Longitude = @longitude,
		LastUpdated = GETDATE()
	WHERE LocationID = @id
	SELECT * FROM Location where LocationID = @id

GO

----- CRUD Volunteer
CREATE PROCEDURE [dbo].[CreateVolunteer]
	@firstname nvarchar(MAX),
	@lastname nvarchar(MAX),
	@email nvarchar(MAX),
	@message nvarchar(MAX)
AS
	INSERT INTO Volunteer (FirstName, LastName, Email, Message, DateSubmitted)
	VALUES (@firstname, @lastname, @email, @message, GETDATE())
    SELECT * FROM Volunteer WHERE VolunteerID = SCOPE_IDENTITY()
	
GO

----- CRUD About
CREATE PROCEDURE [dbo].[NewAbout]
	@description NVARCHAR(MAX),
	@question1 NVARCHAR(MAX),
	@question2 NVARCHAR(MAX),
	@question3 NVARCHAR(MAX),
	@answer1 NVARCHAR(MAX),
	@answer2 NVARCHAR(MAX),
	@answer3 NVARCHAR(MAX)
AS
	INSERT INTO About(ProgramDescription, Question1, Question2, Question3, Answer1, Answer2, Answer3)
	VALUES(@description, @question1, @question2, @question3, @answer1, @answer2, @answer3)
	SELECT * FROM About WHERE AboutID = SCOPE_IDENTITY()
	
GO	

