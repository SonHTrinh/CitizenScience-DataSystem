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
CREATE TABLE [dbo].[Admin] (
    [AdminID]     INT            IDENTITY (1, 1) NOT NULL,
    [Accessnet]   NVARCHAR (MAX) NOT NULL,
    [AddedBy]     NVARCHAR (MAX) NOT NULL,
    [ProgramLead] BIT            NOT NULL,
    PRIMARY KEY CLUSTERED ([AdminID] ASC)
);
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
CREATE TABLE [dbo].[Album] (
    [AlbumID]     INT            IDENTITY (1, 1) NOT NULL,
    [LocationID]  INT            NOT NULL,
    [Category]    NVARCHAR (MAX) NOT NULL,
    [Description] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([AlbumID] ASC),
    CONSTRAINT [FK_Album_ToTable] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[Location] ([LocationID])
);
CREATE TABLE [dbo].[Error] (
    [ErrorID]      INT            IDENTITY (1, 1) NOT NULL,
    [UploadID]     INT            NOT NULL,
    [AdminID]      INT            NOT NULL,
    [ErrorMessage] NVARCHAR (MAX) NOT NULL,
    PRIMARY KEY CLUSTERED ([ErrorID] ASC),
    CONSTRAINT [FK_Error_ToTable] FOREIGN KEY ([UploadID]) REFERENCES [dbo].[BulkUpload] ([UploadID]),
    CONSTRAINT [FK_Error_ToTable_1] FOREIGN KEY ([AdminID]) REFERENCES [dbo].[Admin] ([AdminID])
);
CREATE TABLE [dbo].[Image] (
    [ImageID]          INT            IDENTITY (1, 1) NOT NULL,
    [AlbumID]          INT            NOT NULL,
    [ImageURL]         NVARCHAR (MAX) NOT NULL,
    [ImageAlternative] NVARCHAR (MAX) NOT NULL,
    [ProfileImage]     BIT            NOT NULL,
    [LastUpdated]      DATE           NOT NULL,
    PRIMARY KEY CLUSTERED ([ImageID] ASC),
    CONSTRAINT [FK_Image_ToTable] FOREIGN KEY ([AlbumID]) REFERENCES [dbo].[Album] ([AlbumID])
);


/////////////	STORED PROCEDURES

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