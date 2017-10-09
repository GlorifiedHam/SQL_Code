EXEC sp_configure 'show advanced options', 1 --Needed to be able to get the data from the excel file
RECONFIGURE
GO
EXEC sp_configure 'ad hoc distributed queries', 1 --Needed to be able to get the data from the excel file
RECONFIGURE
GO

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 --Needed to be able to get the data from the excel file
GO 
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 --Needed to be able to get the data from the excel file
GO

IF schema_id('Inventory') is null
      EXECUTE('CREATE SCHEMA Inventory') --We need to use EXECUTE because 'CREATE SCHEMA' must be first in a batch
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Weapons$')  -- TABLE_NAME = '', '' Can not contain []. We dont really need to check if there already exists tables with these names, but its does not do any harm.
DROP TABLE Inventory.[Weapons$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Explosives$') 
DROP TABLE Inventory.[Explosives$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Misc$')
DROP TABLE Inventory.[Misc$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Ammunition$')
DROP TABLE Inventory.[Ammunition$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Clothing$')
DROP TABLE Inventory.[Clothing$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Vehicles$')
DROP TABLE Inventory.[Vehicles$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Attachments$')
DROP TABLE Inventory.[Attachments$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Crafting$')
DROP TABLE Inventory.[Crafting$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Items$')
DROP TABLE Inventory.[Items$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Medical$')
DROP TABLE Inventory.[Medical$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Food$')
DROP TABLE Inventory.[Food$];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'Inventory' AND TABLE_NAME = 'Drinkables$')
DROP TABLE Inventory.[Drinkables$];
GO

SELECT * INTO Inventory.[Weapons$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Weapons$]
Go

SELECT * INTO Inventory.[Explosives$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Explosives$]
Go
SELECT * INTO Inventory.[Misc$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Misc$]
Go
SELECT * INTO Inventory.[Ammunition$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Ammunition$]
Go
SELECT * INTO Inventory.[Items$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Items$]
Go
SELECT * INTO Inventory.[Clothing$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Clothing$]
Go
SELECT * INTO Inventory.[Vehicles$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Vehicles$]
Go
SELECT * INTO Inventory.[Crafting$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Crafting$]
Go
SELECT * INTO Inventory.[Attachments$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Attachments$]
Go
SELECT * INTO Inventory.[Medical$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Medical$]
Go
SELECT * INTO Inventory.[Food$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Food$]
Go
SELECT * INTO Inventory.[Drinkables$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Drinkables$]
Go

ALTER TABLE Inventory.[Weapons$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Explosives$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[MISC$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Ammunition$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Items$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Clothing$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Vehicles$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Crafting$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Attachments$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Medical$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Food$]
ADD UNIQUE ([Class Name])

ALTER TABLE Inventory.[Drinkables$]
ADD UNIQUE ([Class Name])