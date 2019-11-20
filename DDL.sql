----- Citizen Science Database Creation Script

-- Run this script against a new database

-------------------- Tables --------------------

CREATE TABLE [dbo].[Watershed] (
	[WatershedID] INT IDENTITY (1,1) NOT NULL,
	[WatershedName] VARCHAR (MAX) NOT NULL,
	[LastUpdated] DATETIME,
	PRIMARY KEY CLUSTERED ([WatershedID] ASC)
);

GO

CREATE TABLE [dbo].[Image] (
    [ImageID] INT IDENTITY (1, 1) NOT NULL,
    [Bytes] VARBINARY (MAX) NOT NULL,
    [Filename] NVARCHAR (MAX),
	[ContentType] NVARCHAR (MAX),
    [LastUpdated] DATETIME,
    PRIMARY KEY CLUSTERED ([ImageID] ASC)
);

GO

CREATE TABLE [dbo].[Album] (
    [AlbumID]     INT            IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (MAX) NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
	[ProfileImageID] INT,
	[IsLocationAlbum] BIT,
	[LastUpdated] DATETIME,
    PRIMARY KEY CLUSTERED ([AlbumID] ASC)
);

GO

CREATE TABLE [dbo].[Location](
	[LocationID] INT IDENTITY (1,1) NOT NULL,
	[WatershedID] INT NOT NULL,
	[Longitude] FLOAT(53) NOT NULL,
	[Latitude] FLOAT (53) NOT NULL,
	[SensorName] VARCHAR(MAX) NOT NULL,
	[AlbumID] INT,
	[LastUpdated] DATETIME,
	PRIMARY KEY CLUSTERED ([LocationID] ASC) ,
	CONSTRAINT  [FK_Location_ToTable] FOREIGN KEY ([WatershedID]) REFERENCES [dbo].[Watershed] ([WatershedID]),
	CONSTRAINT  [FK_Album_ToTable] FOREIGN KEY ([AlbumID]) REFERENCES [dbo].[Album] ([AlbumID])
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
    [FName]   NVARCHAR (MAX) NOT NULL,
    [LName]   NVARCHAR (MAX) NOT NULL,
    [Email]   NVARCHAR (MAX) NOT NULL,
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

CREATE TABLE [dbo].[AlbumImages] (
	[AlbumID] INT NOT NULL,
	[ImageID] INT NOT NULL,
	CONSTRAINT [FK_ImageLink_ToTable] FOREIGN KEY ([ImageID]) REFERENCES [dbo].[Image] ([ImageID]),
	CONSTRAINT [FK_AlbumLink_ToTable] FOREIGN KEY ([AlbumID]) REFERENCES [dbo].[Album] ([AlbumID])
);

GO

CREATE TABLE [dbo].[Volunteer] (
    [VolunteerID]      INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]        NVARCHAR (MAX) NOT NULL,
    [LastName]         NVARCHAR (MAX) NOT NULL,
    [Email]            NVARCHAR (MAX) NOT NULL,
    [Message]          NVARCHAR (MAX) NOT NULL,
    [DateSubmitted]    DATETIME,
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

-------------------------------- LOCATION TRIGGER
-- Trigger that happens when new location is added to the database
CREATE TRIGGER [dbo].[LocationLastUpdatedTrigger] ON [dbo].[Location]
AFTER INSERT, UPDATE AS
BEGIN
    UPDATE [dbo].[Location]
    SET [LastUpdated] = GETDATE()
    WHERE [LocationID] = (SELECT [LocationID] FROM [inserted])
END
GO

-------------------------------- ALBUM TRIGGERS
-- Trigger that happens when new album is added to the database
CREATE TRIGGER [dbo].[AlbumLastUpdatedTrigger] ON [dbo].[Album]
AFTER INSERT, UPDATE AS
BEGIN
    UPDATE [dbo].[Album]
    SET [LastUpdated] = GETDATE()
    WHERE [AlbumID] = (SELECT [AlbumID] FROM [inserted])
END
GO

-------------------------------- IMAGE TRIGGERS
-- Trigger that happens when new image is added to the database
CREATE TRIGGER [dbo].[ImageLastUpdatedTrigger] ON [dbo].[Image]
AFTER INSERT, UPDATE AS
BEGIN
    UPDATE [dbo].[Image]
    SET [LastUpdated] = GETDATE()
    WHERE [ImageID] = (SELECT [ImageID] FROM [inserted])
END
GO

-------------------------------- WATERSHED TRIGGERS
-- Trigger that happens when new watershed is added to the database
CREATE TRIGGER [dbo].[WatershedLastUpdatedTrigger] ON [dbo].[Watershed]
AFTER INSERT, UPDATE AS
BEGIN
    UPDATE [dbo].[Watershed]
    SET [LastUpdated] = GETDATE()
    WHERE [WatershedID] = (SELECT [WatershedID] FROM [inserted])
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

-----------------------------	MAP PAGE DOWNLOAD PROCEDURES
CREATE PROCEDURE [dbo].[GetTemperaturesByLocationIdStartEnd]
	@locationID int,
	@startDate date,
	@endDate date
AS
	SELECT * FROM Temperature JOIN Location ON Temperature.LocationID = Location.LocationID
	WHERE Temperature.Timestamp >= @startDate
	AND Temperature.Timestamp <= @endDate
	AND Temperature.LocationID = @locationID

GO

CREATE PROCEDURE [dbo].[GetTemperaturesByLocationIdNoStartEnd]
	@locationID int,
	@endDate date
AS
	SELECT * FROM Temperature JOIN Location ON Temperature.LocationID = Location.LocationID
	WHERE Temperature.Timestamp <= @endDate
	AND Temperature.LocationID = @locationID

GO

CREATE PROCEDURE [dbo].[GetTemperaturesByLocationIdStartNoEnd]
	@locationID int,
	@startDate date
AS
	SELECT * FROM Temperature JOIN Location ON Temperature.LocationID = Location.LocationID
	WHERE Temperature.Timestamp >= @startDate
	AND Temperature.LocationID = @locationID

GO
-------------------------------------------------------------

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

CREATE PROCEDURE [dbo].[GetLatestLocationTemperature]
	@locationid int
AS
	SELECT TOP 1 *
	FROM [Temperature]
	WHERE [Timestamp]
	IN
		(SELECT MAX([Timestamp]) FROM [Temperature] WHERE [LocationID] = @locationid)

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
CREATE PROCEDURE [dbo].[BootstrapLocation]
	@watershedid int,
    @name varchar(255),
    @latitude float,
    @longitude float,
	@profileimage varbinary(max),
	@imagecontenttype varchar(255),
	@imagefilename varchar(255)
AS
    DECLARE @newimageid int;
    DECLARE @newalbumid int;


    INSERT INTO [Image] (Bytes, Filename, ContentType)
    VALUES (@profileimage, @imagefilename, @imagecontenttype)

    SET @newimageid = SCOPE_IDENTITY();

    INSERT INTO [dbo].[Album] ([Name], [Description], [ProfileImageID], [IsLocationAlbum])
    VALUES (@name, 'Album of ' + @name + ' images', @newimageid, 1);

    SET @newalbumid = SCOPE_IDENTITY();

    INSERT INTO [dbo].[AlbumImages] (AlbumID, ImageID)
    VALUES (@newalbumid, @newimageid);

    INSERT INTO Location (WatershedID, SensorName, Latitude, Longitude, AlbumID)
    VALUES (@watershedid, @name, @latitude, @longitude, @newalbumid);

    SELECT * FROM Location WHERE locationID = SCOPE_IDENTITY();

GO

CREATE PROCEDURE [dbo].[CreateLocation]
	@watershedid int,
    @name varchar(255),
    @latitude float,
    @longitude float,
	@imageid int
AS
    DECLARE @newalbumid int;

    INSERT INTO [dbo].[Album] ([Name], [Description], [ProfileImageID], [IsLocationAlbum])
    VALUES (@name, 'Album of ' + @name + ' images', @imageid, 1);

    SET @newalbumid = SCOPE_IDENTITY();

    INSERT INTO [dbo].[AlbumImages] (AlbumID, ImageID)
    VALUES (@newalbumid, @imageid);

    INSERT INTO Location (WatershedID, SensorName, Latitude, Longitude, AlbumID)
    VALUES (@watershedid, @name, @latitude, @longitude, @newalbumid);

    SELECT * FROM Location WHERE locationID = SCOPE_IDENTITY();

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
		Longitude = @longitude
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
------------ CRUD ADMIN
GO

------------------------------------------------- CRUD Admin
CREATE PROCEDURE [dbo].[CreateAdmin]
	@tuid nvarchar(MAX),
	@fname nvarchar(MAX),
	@lname nvarchar(MAX),
	@email nvarchar(MAX),
	@active bit
AS
	INSERT INTO Admin(TUID, FName, LName, Email, Active)
	VALUES(@tuid, @fname, @lname, @email, @active)
	SELECT * FROM Admin WHERE AdminID = SCOPE_IDENTITY()

GO

CREATE PROCEDURE [dbo].[ValidateAdmin]
	@TU_ID varchar(max)
AS
	SELECT * FROM Admin 
	WHERE TUID = @TU_ID AND Active = 1

GO

CREATE PROCEDURE [dbo].[UpdateAdmin]
	@id int,
	@tuid NVARCHAR(MAX),
	@fname nvarchar(MAX),
	@lname nvarchar(MAX),
	@email nvarchar(MAX),
	@active BIT
AS
	UPDATE Admin
	SET TUID = @tuid, Active = @active, FName = @fname, LName = @lname, Email = @email
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
	@filename varchar(max)
AS
	INSERT INTO [Image] ([Bytes], [ContentType], [Filename], [LastUpdated]) VALUES (@bytes, @contenttype, @filename, GETDATE());
	SELECT * FROM [Image] WHERE [ImageID] = SCOPE_IDENTITY();
GO

CREATE PROCEDURE [dbo].[UploadAlbumImage]
	@albumid int,
	@bytes VARBINARY(MAX),
	@contenttype varchar(max),
	@filename varchar(max)
AS
	DECLARE @newimageid int;
	
	INSERT INTO [Image] ([Bytes], [ContentType], [Filename], [LastUpdated]) VALUES (@bytes, @contenttype, @filename, GETDATE());
	
	SELECT @newimageid = (SELECT SCOPE_IDENTITY());

	INSERT INTO [dbo].[AlbumImages] ([AlbumID], [ImageID]) VALUES (@albumid, @newimageid);

	SELECT * FROM [Image] WHERE [ImageID] = @newimageid;
GO

CREATE PROCEDURE [dbo].[GetLocationImage]
	@locationid int
AS
	SELECT * FROM [Image]
	WHERE ImageId = (SELECT [ProfileImageID] FROM [Album] WHERE [AlbumID] = (SELECT [AlbumID] FROM [Location] WHERE [LocationID] = @locationid))

GO

CREATE PROCEDURE [dbo].[GetAlbumProfileImage]
	@albumid int
AS
	SELECT * FROM [Image]
	WHERE [ImageId] = (SELECT [ProfileImageID] FROM [Album] WHERE AlbumID = @albumid)

GO

CREATE PROCEDURE [dbo].[MakePrimaryAlbumImage]
    @albumid int,
    @imageid int
AS
    UPDATE [Album]
    SET [ProfileImageID] = @imageid
    WHERE [AlbumID] = @albumid;


GO

CREATE PROCEDURE [dbo].[GetAlbumProfileImageDetails]
	@albumid int
AS
	SELECT [ImageID], [Filename] FROM [Image]
	WHERE [ImageId] = (SELECT [ProfileImageID] FROM [Album] WHERE AlbumID = @albumid)

GO

CREATE PROCEDURE [dbo].[GetAlbumImageIDs]
	@albumid int
AS
	SELECT [ImageID] FROM [AlbumImages]
	WHERE [AlbumID] = @albumid

GO

CREATE PROCEDURE [dbo].[DeleteImageByID]
	@imageid int
AS
    DELETE FROM [AlbumImages]
    WHERE ImageID = @imageid;

	DELETE FROM [Image]
    WHERE ImageID = @imageid

GO

CREATE PROCEDURE [dbo].[SetImageIDAsAlbumProfileImageID]
	@albumid int,
	@imageid int
AS
	UPDATE [Album]
    SET [ProfileImageID] = @imageid
    WHERE [AlbumID] = @albumid

GO

CREATE PROCEDURE [dbo].[GetAlbumImagesDetails]
    @albumid int
AS
    SELECT [ImageID], [Filename]
    FROM [dbo].[Image]
    WHERE [ImageID] IN (SELECT [ImageID] FROM [AlbumImages] WHERE AlbumID = @albumid)

GO
CREATE PROCEDURE [dbo].[GetImage]
	@imageid int
AS
	SELECT * FROM [Image]
	WHERE ImageId = @imageid

GO

CREATE PROCEDURE [dbo].[GetAllAlbum]
AS
	SELECT * FROM [Album]

GO

CREATE PROCEDURE [dbo].[GetAlbum]
	@albumid int
AS
	SELECT *
	FROM [Album]
	WHERE [Album].AlbumID = @albumid

GO

Create Procedure [dbo].[GetAlbumProfileImageID]
	@albumid int
AS
	SELECT *
	FROM [Album]
	WHERE [AlbumID] = @albumid
GO

Create Procedure [dbo].[CreateAlbum]
	@name varchar(max),
	@description varchar(max),
	@imageid int
AS
    DECLARE @albumid int;

	INSERT INTO [dbo].[Album] (Name, Description, ProfileImageID, IsLocationAlbum) VALUES (@name, @description, @imageid, 0);

    SET @albumid = SCOPE_IDENTITY();

    INSERT INTO [dbo].[AlbumImages] (AlbumID, ImageID) VALUES (@albumid, @imageid);
GO

Create Procedure [dbo].[UpdateAlbum]
	@name varchar(max),
	@description varchar(max),
	@albumid int
AS
    UPDATE [dbo].[Album]
	SET Name = @name, Description = @description
	WHERE AlbumID = @albumid
GO
