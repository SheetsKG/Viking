/****** Script for SelectTopNRows command from SSMS  ******/
update Structure Set Tags=NULL where  Tags.value('/','varchar(100)') LIKE ';'