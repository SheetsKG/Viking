/**** You need to replace the following templates to use this script ****/
/**** {DATABASE_NAME} = Name of the database  */
/**** {DATABASE_DIRECTORY} = Directory Datbase lives in if it needs to be created, with the trailing slash i.e. C:\Database\
*/
USE Master

print N'{DATABASE_NAME} Database does not exist, creating...' 
	 
/****** Object:  Database [{DATABASE_NAME}]    Script Date: 06/14/2011 13:13:50 ******/
CREATE DATABASE [{DATABASE_NAME}] ON  PRIMARY 
	( NAME = N'{DATABASE_NAME}', FILENAME = N'{DATABASE_DIRECTORY}\{DATABASE_NAME}\{DATABASE_NAME}.mdf' , SIZE = 406528KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
	 LOG ON 
	( NAME = N'{DATABASE_NAME}_log', FILENAME = N'{DATABASE_DIRECTORY}\{DATABASE_NAME}\{DATABASE_NAME}_log.ldf' , SIZE = 568896KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)

GO
ALTER DATABASE [{DATABASE_NAME}] SET COMPATIBILITY_LEVEL = 100

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
	EXEC [{DATABASE_NAME}].[dbo].[sp_fulltext_database] @action = 'enable'
end

ALTER DATABASE [{DATABASE_NAME}] SET ANSI_NULL_DEFAULT OFF
ALTER DATABASE [{DATABASE_NAME}] SET ANSI_NULLS OFF
ALTER DATABASE [{DATABASE_NAME}] SET ANSI_PADDING OFF
ALTER DATABASE [{DATABASE_NAME}] SET ANSI_WARNINGS OFF
ALTER DATABASE [{DATABASE_NAME}] SET ARITHABORT OFF
ALTER DATABASE [{DATABASE_NAME}] SET AUTO_CLOSE OFF
ALTER DATABASE [{DATABASE_NAME}] SET AUTO_CREATE_STATISTICS ON
ALTER DATABASE [{DATABASE_NAME}] SET AUTO_SHRINK OFF
ALTER DATABASE [{DATABASE_NAME}] SET AUTO_UPDATE_STATISTICS ON
ALTER DATABASE [{DATABASE_NAME}] SET CURSOR_CLOSE_ON_COMMIT OFF
ALTER DATABASE [{DATABASE_NAME}] SET CURSOR_DEFAULT  GLOBAL
ALTER DATABASE [{DATABASE_NAME}] SET CONCAT_NULL_YIELDS_NULL OFF
ALTER DATABASE [{DATABASE_NAME}] SET NUMERIC_ROUNDABORT OFF
ALTER DATABASE [{DATABASE_NAME}] SET QUOTED_IDENTIFIER OFF
ALTER DATABASE [{DATABASE_NAME}] SET RECURSIVE_TRIGGERS OFF
ALTER DATABASE [{DATABASE_NAME}] SET  DISABLE_BROKER
ALTER DATABASE [{DATABASE_NAME}] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
ALTER DATABASE [{DATABASE_NAME}] SET DATE_CORRELATION_OPTIMIZATION OFF
ALTER DATABASE [{DATABASE_NAME}] SET TRUSTWORTHY OFF
ALTER DATABASE [{DATABASE_NAME}] SET ALLOW_SNAPSHOT_ISOLATION OFF
ALTER DATABASE [{DATABASE_NAME}] SET PARAMETERIZATION SIMPLE
ALTER DATABASE [{DATABASE_NAME}] SET READ_COMMITTED_SNAPSHOT OFF
ALTER DATABASE [{DATABASE_NAME}] SET HONOR_BROKER_PRIORITY OFF
ALTER DATABASE [{DATABASE_NAME}] SET  READ_WRITE
ALTER DATABASE [{DATABASE_NAME}] SET RECOVERY SIMPLE
ALTER DATABASE [{DATABASE_NAME}] SET  MULTI_USER
ALTER DATABASE [{DATABASE_NAME}] SET PAGE_VERIFY CHECKSUM
ALTER DATABASE [{DATABASE_NAME}] SET DB_CHAINING OFF
GO

print N'Created Database...' 

USE [{DATABASE_NAME}]
GO

/****** Object:  FullTextCatalog [FullTextCatalog]    Script Date: 06/14/2011 13:13:50 ******/
CREATE FULLTEXT CATALOG [FullTextCatalog]WITH ACCENT_SENSITIVITY = ON
AS DEFAULT
AUTHORIZATION [dbo]


/****** Object:  User [security]    Script Date: 06/14/2011 13:13:50 ******/
CREATE USER [security] FOR LOGIN [security] WITH DEFAULT_SCHEMA=[dbo]
/****** Object:  User [Network Service]    Script Date: 06/14/2011 13:13:50 ******/
CREATE USER [Network Service] FOR LOGIN [NT AUTHORITY\NETWORK SERVICE] WITH DEFAULT_SCHEMA=[dbo]
/****** Object:  User [Matlab]    Script Date: 06/14/2011 13:13:50 ******/
CREATE USER [Matlab] FOR LOGIN [Matlab] WITH DEFAULT_SCHEMA=[dbo]

GO

/****** Object:  Table [dbo].[LocationLink]    Script Date: 06/14/2011 13:13:51 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE TABLE [dbo].[LocationLink](
	[A] [bigint] NOT NULL,
	[B] [bigint] NOT NULL,
	[Username] [nchar](16) NOT NULL,
	[Created] [datetime] NOT NULL,
 CONSTRAINT [PK_LocationLink] PRIMARY KEY CLUSTERED 
(
	[A] ASC,
	[B] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [a] ON [dbo].[LocationLink] 
(
	[A] ASC
)
INCLUDE ( [B]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [b] ON [dbo].[LocationLink] 
(
	[B] ASC
)
INCLUDE ( [A]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The convention is that A is always less than B' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LocationLink', @level2type=N'COLUMN',@level2name=N'A'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last username to modify the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LocationLink', @level2type=N'COLUMN',@level2name=N'Username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Row Creation Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LocationLink', @level2type=N'COLUMN',@level2name=N'Created'
GO
/****** Object:  StoredProcedure [dbo].[SelectAllStructureLocationLinks]    Script Date: 06/14/2011 13:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectAllStructureLocationLinks]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	Select * from LocationLink	 
END
GO
/****** Object:  Table [dbo].[Location]    Script Date: 06/14/2011 13:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Location](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentID] [bigint] NOT NULL,
	[X] [float] NOT NULL,
	[Y] [float] NOT NULL,
	[Z] [float] NOT NULL,
	[Verticies] [varbinary](max) NULL,
	[Closed] [bit] NOT NULL,
	[Version] [timestamp] NOT NULL,
	[Overlay] [varbinary](max) NULL,
	[Tags] [xml] NULL,
	[VolumeX] [float] NOT NULL,
	[VolumeY] [float] NOT NULL,
	[Terminal] [bit] NOT NULL,
	[OffEdge] [bit] NOT NULL,
	[Radius] [float] NOT NULL,
	[TypeCode] [smallint] NOT NULL,
	[LastModified] [datetime] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Username] [nchar](16) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [LastModified] ON [dbo].[Location] 
(
	[LastModified] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ParentID] ON [dbo].[Location] 
(
	[ParentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Z] ON [dbo].[Location] 
(
	[Z] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Structure which we belong to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'ParentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A binary formatted series of X,Y doubles which can be specified to create polygons or lines' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'Verticies'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Defines whether Vertices form a closed figure (The last vertex connects to the first)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'Closed'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'An image centered on X,Y,Z which specifies which surrounding pixels are part of location' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'Overlay'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'VolumeX is the location in volume space.  It exists so that data analysis code does not need to implement transforms' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'VolumeX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'VolumeY is the location in volume space.  It exists so that data analysis code does not need to implement transforms' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'VolumeY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Set to true if this location is the edge of a structure and cannot be extended.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'Terminal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This bit is set if the structure leaves the volume at this location' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'OffEdge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Point, 1 = Circle, 2 =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'TypeCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the location was last modified' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'LastModified'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the location was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'Created'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last username to modify the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Location', @level2type=N'COLUMN',@level2name=N'Username'
GO
/****** Object:  View [dbo].[UserActivity]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserActivity]
AS
SELECT DISTINCT CAST(Username AS NVarchar(16)) AS Username, COUNT(ID) AS TotalModifications, MAX(LastModified) AS LastActiveDate
FROM         dbo.Location
GROUP BY Username
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
	  Begin PaneConfiguration = 0
		 NumPanes = 4
		 Configuration = "(H (1[40] 4[20] 2[20] 3) )"
	  End
	  Begin PaneConfiguration = 1
		 NumPanes = 3
		 Configuration = "(H (1 [50] 4 [25] 3))"
	  End
	  Begin PaneConfiguration = 2
		 NumPanes = 3
		 Configuration = "(H (1 [50] 2 [25] 3))"
	  End
	  Begin PaneConfiguration = 3
		 NumPanes = 3
		 Configuration = "(H (4 [30] 2 [40] 3))"
	  End
	  Begin PaneConfiguration = 4
		 NumPanes = 2
		 Configuration = "(H (1 [56] 3))"
	  End
	  Begin PaneConfiguration = 5
		 NumPanes = 2
		 Configuration = "(H (2 [66] 3))"
	  End
	  Begin PaneConfiguration = 6
		 NumPanes = 2
		 Configuration = "(H (4 [50] 3))"
	  End
	  Begin PaneConfiguration = 7
		 NumPanes = 1
		 Configuration = "(V (3))"
	  End
	  Begin PaneConfiguration = 8
		 NumPanes = 3
		 Configuration = "(H (1[56] 4[18] 2) )"
	  End
	  Begin PaneConfiguration = 9
		 NumPanes = 2
		 Configuration = "(H (1 [75] 4))"
	  End
	  Begin PaneConfiguration = 10
		 NumPanes = 2
		 Configuration = "(H (1[66] 2) )"
	  End
	  Begin PaneConfiguration = 11
		 NumPanes = 2
		 Configuration = "(H (4 [60] 2))"
	  End
	  Begin PaneConfiguration = 12
		 NumPanes = 1
		 Configuration = "(H (1) )"
	  End
	  Begin PaneConfiguration = 13
		 NumPanes = 1
		 Configuration = "(V (4))"
	  End
	  Begin PaneConfiguration = 14
		 NumPanes = 1
		 Configuration = "(V (2))"
	  End
	  ActivePaneConfig = 0
   End
   Begin DiagramPane = 
	  Begin Origin = 
		 Top = 0
		 Left = 0
	  End
	  Begin Tables = 
		 Begin Table = "Location"
			Begin Extent = 
			   Top = 6
			   Left = 38
			   Bottom = 114
			   Right = 189
			End
			DisplayFlags = 280
			TopColumn = 0
		 End
	  End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
	  Begin ParameterDefaults = ""
	  End
	  Begin ColumnWidths = 9
		 Width = 284
		 Width = 1500
		 Width = 1500
		 Width = 2280
		 Width = 1500
		 Width = 1500
		 Width = 1500
		 Width = 1500
		 Width = 1500
	  End
   End
   Begin CriteriaPane = 
	  Begin ColumnWidths = 12
		 Column = 1440
		 Alias = 1185
		 Table = 1170
		 Output = 720
		 Append = 1400
		 NewValue = 1170
		 SortType = 1350
		 SortOrder = 1410
		 GroupBy = 1350
		 Filter = 1350
		 Or = 1350
		 Or = 1350
		 Or = 1350
	  End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UserActivity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UserActivity'
GO
/****** Object:  StoredProcedure [dbo].[SelectSectionLocationsAndLinks]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectSectionLocationsAndLinks]
	-- Add the parameters for the stored procedure here
	@Z float,
	@QueryDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF @QueryDate IS NOT NULL
		Select * from Location 
		where Z = @Z AND LastModified >= @QueryDate
	ELSE
		Select * from Location 
		where Z = @Z	
		
	IF @QueryDate IS NOT NULL
		-- Insert statements for procedure here
		Select * from LocationLink
		 WHERE ((A in 
		(SELECT ID
		  FROM [{DATABASE_NAME}].[dbo].[Location]
		  WHERE Z = @Z)
		 )
		  OR
		  (B in 
		(SELECT ID
		  FROM [{DATABASE_NAME}].[dbo].[Location]
		  WHERE Z = @Z)
		 ))
		 AND Created >= @QueryDate
	ELSE
		-- Insert statements for procedure here
		Select * from LocationLink
		 WHERE ((A in 
		(SELECT ID
		  FROM [{DATABASE_NAME}].[dbo].[Location]
		  WHERE Z = @Z)
		 )
		  OR
		  (B in 
		(SELECT ID
		  FROM [{DATABASE_NAME}].[dbo].[Location]
		  WHERE Z = @Z)
		 ))
	
	 
END
GO
/****** Object:  StoredProcedure [dbo].[SelectSectionLocationLinks]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectSectionLocationLinks]
	-- Add the parameters for the stored procedure here
	@Z float,
	@QueryDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
	Select * from LocationLink
	 WHERE (((A in 
	(SELECT ID
	  FROM [{DATABASE_NAME}].[dbo].[Location]
	  WHERE Z >= @Z)
	 )
	  AND
	  (B in 
	(SELECT ID
	  FROM [{DATABASE_NAME}].[dbo].[Location]
	  WHERE Z <= @Z)
	 ))
	 OR
	 ((A in
	 (SELECT ID
	  FROM [{DATABASE_NAME}].[dbo].[Location]
	  WHERE Z <= @Z)
	 )
	  AND
	  (B in 
	(SELECT ID
	  FROM [{DATABASE_NAME}].[dbo].[Location]
	  WHERE Z >= @Z)
	 )))
	 AND Created >= @QueryDate
	 
END
GO
/****** Object:  StoredProcedure [dbo].[Approxima{DATABASE_NAME}ructureLocation]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Approxima{DATABASE_NAME}ructureLocation]
@StructureID int
AS
	select SUM(VolumeX*Radius*Radius)/SUM(Radius*Radius) as X,SUM(VolumeY*Radius*Radius)/SUM(Radius*Radius) as Y,SUM(Z*Radius*Radius)/SUM(Radius*Radius) as Z, AVG(Radius) as Radius
	from dbo.Location where ParentID=@StructureID
GO
/****** Object:  Table [dbo].[DeletedLocations]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeletedLocations](
	[ID] [bigint] NOT NULL,
	[DeletedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_DeletedLocations] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [DeletedOn] ON [dbo].[DeletedLocations] 
(
	[DeletedOn] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StructureType]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StructureType](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentID] [bigint] NULL,
	[Name] [nchar](128) NOT NULL,
	[Notes] [ntext] NULL,
	[MarkupType] [nchar](16) NOT NULL,
	[Tags] [xml] NULL,
	[StructureTags] [xml] NULL,
	[Abstract] [bit] NOT NULL,
	[Color] [int] NOT NULL,
	[Version] [timestamp] NOT NULL,
	[Code] [nchar](16) NOT NULL,
	[HotKey] [char](1) NOT NULL,
	[Username] [nchar](16) NOT NULL,
	[LastModified] [datetime] NOT NULL,
	[Created] [datetime] NOT NULL,
 CONSTRAINT [PK_StructureType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ParentID] ON [dbo].[StructureType] 
(
	[ParentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Point,Line,Poly' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureType', @level2type=N'COLUMN',@level2name=N'MarkupType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Strings seperated by semicolins' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureType', @level2type=N'COLUMN',@level2name=N'Tags'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Code used to identify these items in the UI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureType', @level2type=N'COLUMN',@level2name=N'Code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Hotkey used to create a structure of this type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureType', @level2type=N'COLUMN',@level2name=N'HotKey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last username to modify the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureType', @level2type=N'COLUMN',@level2name=N'Username'
GO
/****** Object:  Table [dbo].[Structure]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Structure](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TypeID] [bigint] NOT NULL,
	[Notes] [ntext] NULL,
	[Verified] [bit] NOT NULL,
	[Tags] [xml] NULL,
	[Confidence] [float] NOT NULL,
	[Version] [timestamp] NOT NULL,
	[ParentID] [bigint] NULL,
	[Created] [datetime] NOT NULL,
	[Label] [varchar](64) NULL,
	[Username] [nchar](16) NOT NULL,
	[LastModified] [datetime] NOT NULL,
 CONSTRAINT [PK_StructureBase] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [LastModified] ON [dbo].[Structure] 
(
	[LastModified] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ParentID] ON [dbo].[Structure] 
(
	[ParentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TypeID] ON [dbo].[Structure] 
(
	[TypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Strings seperated by semicolins' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Structure', @level2type=N'COLUMN',@level2name=N'Tags'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'How certain is it that the structure is what we say it is' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Structure', @level2type=N'COLUMN',@level2name=N'Confidence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Records last write time' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Structure', @level2type=N'COLUMN',@level2name=N'Version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'If the structure is contained in a larger structure (Synapse for a cell) this index contains the index of the parent' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Structure', @level2type=N'COLUMN',@level2name=N'ParentID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the structure was created' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Structure', @level2type=N'COLUMN',@level2name=N'Created'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Additional Label for structure in UI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Structure', @level2type=N'COLUMN',@level2name=N'Label'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last username to modify the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Structure', @level2type=N'COLUMN',@level2name=N'Username'
GO
/****** Object:  StoredProcedure [dbo].[SelectStructureLocations]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectStructureLocations]
	-- Add the parameters for the stored procedure here
	@StructureID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT L.ID
	   ,[ParentID]
	  ,[VolumeX]
	  ,[VolumeY]
	  ,[Z]
	  ,[Radius]
	  ,J.TypeID
	  ,[X]
	  ,[Y]
	  FROM [{DATABASE_NAME}].[dbo].[Location] L
	  INNER JOIN 
	   (SELECT ID, TYPEID
		FROM Structure
		WHERE ID = @StructureID OR ParentID = @StructureID) J
	  ON L.ParentID = J.ID
	  ORDER BY ID
END
GO
/****** Object:  StoredProcedure [dbo].[SelectStructureLocationLinks]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectStructureLocationLinks]
	-- Add the parameters for the stored procedure here
	@StructureID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	Select * from LocationLink
	 WHERE (A in 
	(SELECT L.ID
	  FROM [{DATABASE_NAME}].[dbo].[Location] L
	  INNER JOIN 
	   (SELECT ID, TYPEID
		FROM Structure
		WHERE ID = @StructureID OR ParentID = @StructureID ) J
	  ON L.ParentID = J.ID))
	  OR
	  (B in 
	(SELECT L.ID
	  FROM [{DATABASE_NAME}].[dbo].[Location] L
	  INNER JOIN 
	   (SELECT ID, TYPEID
		FROM Structure
		WHERE ID = @StructureID OR ParentID = @StructureID ) J
	  ON L.ParentID = J.ID))
	 
END
GO
/****** Object:  StoredProcedure [dbo].[SelectAllStructureLocations]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SelectAllStructureLocations]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT L.ID
	   ,[ParentID]
	  ,[VolumeX]
	  ,[VolumeY]
	  ,[Z]
	  ,[Radius]
	  ,J.TypeID
	  ,[X]
	  ,[Y]
	  FROM [{DATABASE_NAME}].[dbo].[Location] L
	  INNER JOIN 
	   (SELECT ID, TYPEID
		FROM Structure) J
	  ON L.ParentID = J.ID
	  ORDER BY ID
END
GO
/****** Object:  Table [dbo].[StructureTemplates]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StructureTemplates](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [char](64) NOT NULL,
	[StructureTypeID] [bigint] NOT NULL,
	[StructureTags] [text] NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_StructureTemplates] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Name of template' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureTemplates', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The structure type which is created when using the template' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureTemplates', @level2type=N'COLUMN',@level2name=N'StructureTypeID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The tags to create with the new structure type' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureTemplates', @level2type=N'COLUMN',@level2name=N'StructureTags'
GO
/****** Object:  Table [dbo].[StructureLink]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StructureLink](
	[SourceID] [bigint] NOT NULL,
	[TargetID] [bigint] NOT NULL,
	[Bidirectional] [bit] NOT NULL,
	[Tags] [xml] NULL,
	[Username] [nchar](16) NOT NULL,
	[Created] [datetime] NOT NULL,
	[LastModified] [datetime] NOT NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [SourceID] ON [dbo].[StructureLink] 
(
	[SourceID] ASC
)
INCLUDE ( [TargetID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [TargetID] ON [dbo].[StructureLink] 
(
	[TargetID] ASC
)
INCLUDE ( [SourceID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last username to modify the row' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureLink', @level2type=N'COLUMN',@level2name=N'Username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Row Creation Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'StructureLink', @level2type=N'COLUMN',@level2name=N'Created'
GO
/****** Object:  StoredProcedure [dbo].[SelectStructuresForSection]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SelectStructuresForSection]
	-- Add the parameters for the stored procedure here
	@Z float,
	@QueryDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @StructsOnSection TABLE 
	(
		ID bigint
	)
	INSERT INTO @StructsOnSection (ID)
	Select distinct(ParentID) from Location where Z = @Z
		
	if @QueryDate IS NULL
		Select * from Structure
		where ID in (Select ID from @StructsOnSection)	
	else
		Select * from Structure
		where ID in (Select ID from @StructsOnSection)
			AND LastModified >= @QueryDate
		
	

	Select * from StructureLink L
	where (L.TargetID in (Select ID from @StructsOnSection))
	   OR (L.SourceID in (Select ID from @StructsOnSection)) 
END
GO
/****** Object:  StoredProcedure [dbo].[MergeStructures]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[MergeStructures]
	-- Add the parameters for the stored procedure here
	@KeepStructureID bigint,
	@MergeStructureID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	update Location 
	set ParentID = @KeepStructureID 
	where ParentID = @MergeStructureID

	update Structure
	set ParentID = @KeepStructureID 
	where ParentID = @MergeStructureID
	
	update StructureLink
	set TargetID = @KeepStructureID
	where TargetID = @MergeStructureID
	
	update StructureLink
	set SourceID = @KeepStructureID
	where SourceID = @MergeStructureID

	Delete Structure
	where ID = @MergeStructureID
	
END
GO
/****** Object:  StoredProcedure [dbo].[SelectStructuresAndLinks]    Script Date: 06/14/2011 13:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SelectStructuresAndLinks]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	Select * from Structure
	
	-- Insert statements for procedure here
	Select * from StructureLink
	
END
GO
/****** Object:  Default [DF_LocationLink_Username]    Script Date: 06/14/2011 13:13:51 ******/
ALTER TABLE [dbo].[LocationLink] ADD  CONSTRAINT [DF_LocationLink_Username]  DEFAULT (N'') FOR [Username]
GO
/****** Object:  Default [DF_LocationLink_Created]    Script Date: 06/14/2011 13:13:51 ******/
ALTER TABLE [dbo].[LocationLink] ADD  CONSTRAINT [DF_LocationLink_Created]  DEFAULT (getutcdate()) FOR [Created]
GO
/****** Object:  Default [DF_Location_Closed]    Script Date: 06/14/2011 13:13:52 ******/
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_Closed]  DEFAULT ((0)) FOR [Closed]
GO
/****** Object:  Default [DF_Location_Flagged]    Script Date: 06/14/2011 13:13:52 ******/
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_Flagged]  DEFAULT ((0)) FOR [Terminal]
GO
/****** Object:  Default [DF_Location_OffEdge]    Script Date: 06/14/2011 13:13:52 ******/
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_OffEdge]  DEFAULT ((0)) FOR [OffEdge]
GO
/****** Object:  Default [DF_Location_Radius]    Script Date: 06/14/2011 13:13:52 ******/
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_Radius]  DEFAULT ((128)) FOR [Radius]
GO
/****** Object:  Default [DF_Location_TypeCode]    Script Date: 06/14/2011 13:13:52 ******/
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_TypeCode]  DEFAULT ((1)) FOR [TypeCode]
GO
/****** Object:  Default [DF_Location_LastModified]    Script Date: 06/14/2011 13:13:52 ******/
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_LastModified]  DEFAULT (getutcdate()) FOR [LastModified]
GO
/****** Object:  Default [DF_Location_Created]    Script Date: 06/14/2011 13:13:52 ******/
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_Created]  DEFAULT (getutcdate()) FOR [Created]
GO
/****** Object:  Default [DF_Location_Username]    Script Date: 06/14/2011 13:13:52 ******/
ALTER TABLE [dbo].[Location] ADD  CONSTRAINT [DF_Location_Username]  DEFAULT (N'') FOR [Username]
GO
/****** Object:  Default [DF_DeletedLocations_DeletedOn]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[DeletedLocations] ADD  CONSTRAINT [DF_DeletedLocations_DeletedOn]  DEFAULT (getutcdate()) FOR [DeletedOn]
GO
/****** Object:  Default [DF_StructureType_MarkupType]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureType] ADD  CONSTRAINT [DF_StructureType_MarkupType]  DEFAULT (N'Point') FOR [MarkupType]
GO
/****** Object:  Default [DF_StructureType_Abstract]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureType] ADD  CONSTRAINT [DF_StructureType_Abstract]  DEFAULT ((0)) FOR [Abstract]
GO
/****** Object:  Default [DF_StructureType_Color]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureType] ADD  CONSTRAINT [DF_StructureType_Color]  DEFAULT (0xFFFFFF) FOR [Color]
GO
/****** Object:  Default [DF_StructureType_Code]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureType] ADD  CONSTRAINT [DF_StructureType_Code]  DEFAULT (N'No Code') FOR [Code]
GO
/****** Object:  Default [DF_StructureType_HotKey]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureType] ADD  CONSTRAINT [DF_StructureType_HotKey]  DEFAULT ('\0') FOR [HotKey]
GO
/****** Object:  Default [DF_StructureType_Username]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureType] ADD  CONSTRAINT [DF_StructureType_Username]  DEFAULT (N'') FOR [Username]
GO
/****** Object:  Default [DF_StructureType_LastModified]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureType] ADD  CONSTRAINT [DF_StructureType_LastModified]  DEFAULT (getutcdate()) FOR [LastModified]
GO
/****** Object:  Default [DF_StructureType_Created]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureType] ADD  CONSTRAINT [DF_StructureType_Created]  DEFAULT (getutcdate()) FOR [Created]
GO
/****** Object:  Default [DF_StructureBase_Verified]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[Structure] ADD  CONSTRAINT [DF_StructureBase_Verified]  DEFAULT ((0)) FOR [Verified]
GO
/****** Object:  Default [DF_StructureBase_Confidence]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[Structure] ADD  CONSTRAINT [DF_StructureBase_Confidence]  DEFAULT ((0.5)) FOR [Confidence]
GO
/****** Object:  Default [DF_Structure_Created]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[Structure] ADD  CONSTRAINT [DF_Structure_Created]  DEFAULT (getutcdate()) FOR [Created]
GO
/****** Object:  Default [DF_Structure_Username]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[Structure] ADD  CONSTRAINT [DF_Structure_Username]  DEFAULT (N'') FOR [Username]
GO
/****** Object:  Default [DF_Structure_LastModified]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[Structure] ADD  CONSTRAINT [DF_Structure_LastModified]  DEFAULT (getutcdate()) FOR [LastModified]
GO
/****** Object:  Default [DF_StructureTemplates_Tags]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureTemplates] ADD  CONSTRAINT [DF_StructureTemplates_Tags]  DEFAULT ('') FOR [StructureTags]
GO
/****** Object:  Default [DF_StructureLink_Bidirectional]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureLink] ADD  CONSTRAINT [DF_StructureLink_Bidirectional]  DEFAULT ((0)) FOR [Bidirectional]
GO
/****** Object:  Default [DF_StructureLink_Username]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureLink] ADD  CONSTRAINT [DF_StructureLink_Username]  DEFAULT (N'') FOR [Username]
GO
/****** Object:  Default [DF_StructureLink_Created]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureLink] ADD  CONSTRAINT [DF_StructureLink_Created]  DEFAULT (getutcdate()) FOR [Created]
GO
/****** Object:  Default [DF_StructureLink_LastModified]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureLink] ADD  CONSTRAINT [DF_StructureLink_LastModified]  DEFAULT (getutcdate()) FOR [LastModified]
GO
/****** Object:  ForeignKey [FK_LocationLink_Location]    Script Date: 06/14/2011 13:13:51 ******/
ALTER TABLE [dbo].[LocationLink]  WITH CHECK ADD  CONSTRAINT [FK_LocationLink_Location] FOREIGN KEY([A])
REFERENCES [dbo].[Location] ([ID])
GO
ALTER TABLE [dbo].[LocationLink] CHECK CONSTRAINT [FK_LocationLink_Location]
GO
/****** Object:  ForeignKey [FK_LocationLink_Location1]    Script Date: 06/14/2011 13:13:51 ******/
ALTER TABLE [dbo].[LocationLink]  WITH CHECK ADD  CONSTRAINT [FK_LocationLink_Location1] FOREIGN KEY([B])
REFERENCES [dbo].[Location] ([ID])
GO
ALTER TABLE [dbo].[LocationLink] CHECK CONSTRAINT [FK_LocationLink_Location1]
GO
/****** Object:  ForeignKey [FK_Location_StructureBase1]    Script Date: 06/14/2011 13:13:52 ******/
ALTER TABLE [dbo].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_StructureBase1] FOREIGN KEY([ParentID])
REFERENCES [dbo].[Structure] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Location] CHECK CONSTRAINT [FK_Location_StructureBase1]
GO
/****** Object:  ForeignKey [FK_StructureType_StructureType]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureType]  WITH CHECK ADD  CONSTRAINT [FK_StructureType_StructureType] FOREIGN KEY([ParentID])
REFERENCES [dbo].[StructureType] ([ID])
GO
ALTER TABLE [dbo].[StructureType] CHECK CONSTRAINT [FK_StructureType_StructureType]
GO
/****** Object:  ForeignKey [FK_Structure_Structure]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[Structure]  WITH CHECK ADD  CONSTRAINT [FK_Structure_Structure] FOREIGN KEY([ParentID])
REFERENCES [dbo].[Structure] ([ID])
GO
ALTER TABLE [dbo].[Structure] CHECK CONSTRAINT [FK_Structure_Structure]
GO
/****** Object:  ForeignKey [FK_StructureBase_StructureType]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[Structure]  WITH CHECK ADD  CONSTRAINT [FK_StructureBase_StructureType] FOREIGN KEY([TypeID])
REFERENCES [dbo].[StructureType] ([ID])
GO
ALTER TABLE [dbo].[Structure] CHECK CONSTRAINT [FK_StructureBase_StructureType]
GO
/****** Object:  ForeignKey [FK_StructureTemplates_StructureType]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureTemplates]  WITH CHECK ADD  CONSTRAINT [FK_StructureTemplates_StructureType] FOREIGN KEY([StructureTypeID])
REFERENCES [dbo].[StructureType] ([ID])
GO
ALTER TABLE [dbo].[StructureTemplates] CHECK CONSTRAINT [FK_StructureTemplates_StructureType]
GO
/****** Object:  ForeignKey [FK_StructureLinkSource_StructureBaseID]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureLink]  WITH CHECK ADD  CONSTRAINT [FK_StructureLinkSource_StructureBaseID] FOREIGN KEY([SourceID])
REFERENCES [dbo].[Structure] ([ID])
GO
ALTER TABLE [dbo].[StructureLink] CHECK CONSTRAINT [FK_StructureLinkSource_StructureBaseID]
GO
/****** Object:  ForeignKey [FK_StructureLinkTarget_StructureBaseID]    Script Date: 06/14/2011 13:13:53 ******/
ALTER TABLE [dbo].[StructureLink]  WITH CHECK ADD  CONSTRAINT [FK_StructureLinkTarget_StructureBaseID] FOREIGN KEY([TargetID])
REFERENCES [dbo].[Structure] ([ID])
GO
ALTER TABLE [dbo].[StructureLink] CHECK CONSTRAINT [FK_StructureLinkTarget_StructureBaseID]
GO

