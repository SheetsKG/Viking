USE [Rabbit]
GO
/****** Object:  StoredProcedure [dbo].[SelectStructuresForSection]    Script Date: 01/21/2011 15:57:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[SelectStructuresForSection]
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

	if @QueryDate <> NULL
		INSERT INTO @StructsOnSection (ID)
		Select distinct(ParentID) from Location where Z = @Z
	else
		INSERT INTO @StructsOnSection (ID)
		Select distinct(ParentID) from Location where Z = @Z
		
	Select * from Structure
	where ID in (Select ID from @StructsOnSection)

	Select * from StructureLink L
	where (L.TargetID in (Select ID from @StructsOnSection))
	   OR (L.SourceID in (Select ID from @StructsOnSection)) 
END
