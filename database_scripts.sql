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
    [AdminID] INT            IDENTITY (1, 1) NOT NULL,
    [TUID]    NVARCHAR (MAX) NOT NULL,
    [Active]  BIT            NOT NULL,
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
    [Message]          NVARCHAR (MAX) NOT NULL,
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

-------------------- Triggers --------------------

-- Trigger that happens when new location is added to the database
CREATE TRIGGER [dbo].[LocationAlbumCreation] ON [dbo].[Location]
AFTER INSERT AS
BEGIN
   DECLARE @AlbumId int;

    -- Create a new album for the Location
    INSERT INTO [dbo].[Album]
    ([Name], [Description], [LastUpdated])
    SELECT
    [inserted].[SensorName], [inserted].[SensorName], GETDATE()
    FROM inserted;

    SELECT @AlbumId = (SELECT SCOPE_IDENTITY());

    -- Create a link from the Location Profile image to the Image Album
    INSERT INTO [dbo].[AlbumImages]
    (AlbumID, ImageID, LastUpdated)
    SELECT
    @AlbumId, [inserted].[ProfileImageID], GETDATE()
    FROM inserted;

END

GO

-- Trigger that happens when a location is updated
CREATE TRIGGER [dbo].[LocationAlbumUpdate] ON [dbo].[Location]
AFTER UPDATE AS
BEGIN
   DECLARE @NewImageId int;
   DECLARE @OldImageId int;

   SELECT @NewImageId = (SELECT [inserted].[ProfileImageID] FROM [inserted])
   SELECT @OldImageId = (SELECT [deleted].[ProfileImageID] FROM [deleted])

   IF @NewImageId != @OldImageId
   BEGIN
	   UPDATE [dbo].[AlbumImages]
	   SET
	   ImageID = @NewImageId
	   WHERE
	   ImageID = @OldImageId;

	   --DELETE FROM [dbo].[Image] WHERE [ImageID] = @OldImageId;
   END
END

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

CREATE PROCEDURE [dbo].[GetAllAdmins]
AS
	SELECT * FROM Admin
	
GO

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
    @longitude float,
	@profileimageid int
AS
    INSERT INTO Location (WatershedID, SensorName, Latitude, Longitude, ProfileImageID, LastUpdated)
    VALUES (@watershedid, @name, @latitude, @longitude, @profileimageid, GETDATE())
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
    @longitude float,
	@profileimageid int
AS
	UPDATE Location
	SET WatershedID = @watershedid,
		SensorName = @name,
		Latitude = @latitude,
		Longitude = @longitude,
		ProfileImageID = @profileimageid,
		LastUpdated = GETDATE()
	WHERE LocationID = @id
	SELECT * FROM Location where LocationID = @id

GO

------------------------------------------------- CRUD Volunteer
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

------------------------------------------------- CRUD Admin
CREATE PROCEDURE [dbo].[CreateAdmin]
	@tuid nvarchar(MAX),
	@active bit
AS
	INSERT INTO Admin(TUID, Active)
	VALUES(@tuid, @active)
	SELECT * FROM Admin WHERE AdminID = SCOPE_IDENTITY()
	
GO

CREATE PROCEDURE [dbo].[UpdateAdmin]
	@id int,
	@tuid NVARCHAR(MAX),
	@active BIT
AS
	UPDATE Admin
	SET TUID = @tuid, Active = @active
	WHERE AdminID = @id
	SELECT * FROM Admin where AdminID = @id
	
GO

------------------------------------------------- CRUD About
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

-------------------------------------------------- IMAGES

CREATE PROCEDURE [dbo].[UploadImage]
	@bytes VARBINARY(MAX),
	@contenttype varchar(max),
	@description varchar(max)
AS
	INSERT INTO [Image] ([Bytes], [ContentType], [Description], [LastUpdated]) VALUES (@bytes, @contenttype, @description, GETDATE());
	SELECT * FROM [Image] WHERE [ImageID] = SCOPE_IDENTITY();
GO

CREATE PROCEDURE [dbo].[GetLocationImage]
	@locationid int
AS
	SELECT * FROM [Image]
	WHERE ImageId = (SELECT [ProfileImageID] FROM Location WHERE LocationID = @locationid)

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