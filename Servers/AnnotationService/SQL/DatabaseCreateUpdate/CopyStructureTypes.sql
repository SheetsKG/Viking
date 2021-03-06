/****** Script for SelectTopNRows command from SSMS  ******/
SET identity_insert StructureType ON

  
INSERT INTO {TARGET}.dbo.StructureType ( ID
      ,ParentID
      ,Name
      ,Notes
      ,MarkupType
      ,Tags
      ,StructureTags
      ,Abstract
      ,Color
      ,Code
      ,HotKey
      ,Username
      ,LastModified
      ,Created)
      SELECT  ID
      ,ParentID
      ,Name
      ,Notes
      ,MarkupType
      ,Tags
      ,StructureTags
      ,Abstract
      ,Color
      ,Code
      ,HotKey
      ,Username
      ,LastModified
      ,Created FROM {SOURCE}.dbo.StructureType 

go

SET identity_insert StructureType OFF
