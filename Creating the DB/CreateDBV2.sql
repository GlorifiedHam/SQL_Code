	use master;		
go

if db_id('GamingSiteDB') is NOT NULL
	drop database GamingSiteDB
go

CREATE database GamingSiteDB
go

use GamingSiteDB
go

CREATE FUNCTION [dbo].[GetBlobData]()
RETURNS VARBINARY(MAX) 
AS
BEGIN
    DECLARE @IFFileExists INT,
        @BinaryData VARBINARY(MAX)
    -- Set minimum binary representation HexaDECIMAL number as DEFAULT
    SET @BinaryData =(0x) 
    -- First CHECK if the file exists on the directory 
    EXEC Master.dbo.xp_fileexist N'D:/Programming/SQL/GamingSiteDB/Images/Game.PNG', @IFFileExists OUT 
    IF @IFFileExists = 1
    
        -- If exists then read the file content
        SET @BinaryData = (SELECT * FROM OPENROWSET(BULK N'D:/Programming/SQL/GamingSiteDB/Images/Game.PNG',SINGLE_BLOB)
	AS BLOBData)

    RETURN @BinaryData
END  

go

CREATE SCHEMA [Site];
GO
CREATE SCHEMA Gaming;
GO
CREATE SCHEMA Forum;
GO
CREATE SCHEMA Internal;
GO
CREATE SCHEMA Inventory;
GO

-- Run all of this inside another file later
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
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Weapons$]
Go
SELECT * INTO Inventory.[Explosives$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Explosives$]
Go
SELECT * INTO Inventory.[Misc$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Misc$]
Go
SELECT * INTO Inventory.[Ammunition$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Ammunition$]
Go
SELECT * INTO Inventory.[Items$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Items$]
Go
SELECT * INTO Inventory.[Clothing$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Clothing$]
Go
SELECT * INTO Inventory.[Vehicles$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Vehicles$]
Go
SELECT * INTO Inventory.[Crafting$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Crafting$]
Go
SELECT * INTO Inventory.[Attachments$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Attachments$]
Go
SELECT * INTO Inventory.[Medical$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Medical$]
Go
SELECT * INTO Inventory.[Food$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Food$]
Go
SELECT * INTO Inventory.[Drinkables$]
FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\GamingSiteDB\Excel\Shop_Inv_V3.xlsx;Extended Properties=Excel 12.0')...[Drinkables$]
Go

IF((SELECT COUNT(*) FROM Inventory.[Weapons$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Weapons$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Weapons$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Weapons$]
ADD PRIMARY KEY ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Explosives$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Explosives$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Explosives$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Explosives$]
ADD PRIMARY KEY  ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[MISC$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[MISC$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[MISC$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[MISC$]
ADD PRIMARY KEY  ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Ammunition$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Ammunition$] WHERE [Class Name] IS null
END
ALTER TABLE Inventory.[Ammunition$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Ammunition$]
ADD PRIMARY KEY ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Items$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Items$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Items$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Items$]
ADD PRIMARY KEY ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Clothing$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Clothing$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Clothing$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Clothing$]
ADD PRIMARY KEY ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Vehicles$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Vehicles$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Vehicles$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Vehicles$]
ADD PRIMARY KEY ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Crafting$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Crafting$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Crafting$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Crafting$]
ADD PRIMARY KEY ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Attachments$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Attachments$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Attachments$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Attachments$]
ADD PRIMARY KEY ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Medical$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Medical$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Medical$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Medical$]
ADD PRIMARY KEY  ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Food$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Food$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Food$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Food$]
ADD PRIMARY KEY  ([Class Name])

IF((SELECT COUNT(*) FROM Inventory.[Drinkables$] WHERE [Class Name] is null) > 0)
BEGIN
DELETE FROM Inventory.[Drinkables$] WHERE [Class Name] IS null
END 
ALTER TABLE Inventory.[Drinkables$]
ALTER COLUMN [Class Name] NVARCHAR(255) NOT NULL
GO
ALTER TABLE Inventory.[Drinkables$]
ADD PRIMARY KEY  ([Class Name])

/*Regular create statements from this point on*/

CREATE TABLE [Site].[GuestIP]
(
GuestIPID INT NOT NULL IDENTITY,
GuestID INT UNIQUE,
Group8 VARBINARY(2) NULL,  --I VARBINARY(2) fields that represents the 8 groups in a ipv6. The fields 5 - 8 is nullable as they are only used for IPv6. The fields 1 - 4 is set to NOT NULL as they are be used for both IPv4 and IPv6.
Group7 VARBINARY(2) NULL,
Group6 VARBINARY(2) NULL,
Group5 VARBINARY(2) NULL,
Group4 VARBINARY(2) NOT null,
Group3 VARBINARY(2) NOT null,
Group2 VARBINARY(2) NOT null,
Group1 VARBINARY(2) NOT null,
Network TINYINT null,
)
ALTER TABLE [Site].[GuestIP]
ADD CONSTRAINT [PK_GuestIP]
PRIMARY KEY CLUSTERED
(GuestIPID ASC)
 WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

CREATE NONCLUSTERED INDEX [Index_GuestIP_Groups]
  ON [Site].[GuestIP] (Group1 ASC, Group2 ASC, Group3 ASC, Group4 ASC,
         Group5 ASC, Group6 ASC, Group7 ASC, Group8 ASC, Network ASC)
  WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

  ALTER TABLE [Site].[GuestIP] 
  ADD TextAddress AS (
IIF([Group8] IS NULL,
    -- IPv4
    CONCAT(CONVERT(TINYINT, [Group4]), '.', CONVERT(TINYINT, [Group3]), '.',
      CONVERT(TINYINT, [Group2]), '.', CONVERT(TINYINT, [Group1]),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')),
    -- IPv6
    LOWER(CONCAT(
      CONVERT(VARCHAR(4), [Group8], 2), ':', CONVERT(VARCHAR(4), [Group7], 2), ':',
      CONVERT(VARCHAR(4), [Group6], 2), ':', CONVERT(VARCHAR(4), [Group5], 2), ':',
      CONVERT(VARCHAR(4), [Group4], 2), ':', CONVERT(VARCHAR(4), [Group3], 2), ':',
      CONVERT(VARCHAR(4), [Group2], 2), ':', CONVERT(VARCHAR(4), [Group1], 2),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')
     ))
   ) -- end of IIF
);

CREATE TABLE Internal.[Role]( -- Only admin should be able to make changes to this table
RoleID INT IDENTITY PRIMARY KEY,
RoleRank int,
RoleName NVARCHAR(100) UNIQUE
)

CREATE TABLE [Site].[User](
UserID INT IDENTITY PRIMARY KEY,
Username NVARCHAR(100) NOT NULL UNIQUE,
Firstname NVARCHAR(1000) NOT NULL,
ShowFirstName BIT NOT NULL DEFAULT 0,
Lastname NVARCHAR(1000) NOT NULL,
ShowLastName BIT NOT NULL DEFAULT 0,
Age DATE NOT NULL,
ShowAge BIT  DEFAULT 0,
[Password] NVARCHAR(100), --Changes to pw_encrypted 
Email NVARCHAR(300) NOT NULL UNIQUE,
ShowEmail BIT NOT NULL DEFAULT 0,
[Amount of entries] INT DEFAULT 0, --Trigger on creating an entry
-- Phonenumber VARCHAR(22), 
RegDATE DATE DEFAULT GETDATE(),
Verification BIT, -- kommer ske genom Email just nu, men i framtiden kan det ske genom mobilen också 
RoleID int DEFAULT 2,

CONSTRAINT FK_Role_User FOREIGN KEY (RoleID) REFERENCES internal.[Role](RoleID) ON DELETE CASCADE
);

CREATE TABLE Internal.FailLogIn
(
FailLogInID INT IDENTITY PRIMARY KEY,
UserID INT NOT NULL,
Tries INT NOT NULL, -- 5 = 15m lock, 10 = 120m lock, 15 24h lock, 20 puts on a primary lock by changing email verification to 0
Lock DateTime NULL,

CONSTRAINT FK_User_FailLogIn FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

CREATE TABLE Internal.AccountBan
(
AccountBanID INT IDENTITY PRIMARY KEY,
UserID INT NOT NULL,
BannersID INT NOT NULL, -- The one that executed the ban
Reason NVARCHAR (1000) NOT NULL,
DisplayReason NVARCHAR (1000) NOT NULL,
Severity INT NOT NULL, -- 1-10
HowLong DATETIME NOT NULL,
BanDate DATETIME NOT NULL,

CONSTRAINT FK_User_AccountBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

CREATE TABLE Internal.UniversalBan
(
UniversalBanID INT NOT NULL IDENTITY,
Group8 VARBINARY(2) NULL,  --I VARBINARY(2) fields that represents the 8 groups in a ipv6. The fields 5 - 8 is nullable as they are only used for IPv6. The fields 1 - 4 is set to NOT NULL as they are be used for both IPv4 and IPv6.
Group7 VARBINARY(2) NULL,
Group6 VARBINARY(2) NULL,
Group5 VARBINARY(2) NULL,
Group4 VARBINARY(2) NOT null,
Group3 VARBINARY(2) NOT null,
Group2 VARBINARY(2) NOT null,
Group1 VARBINARY(2) NOT null,
Network TINYINT null
)
ALTER TABLE Internal.UniversalBan -- Adds the PK
ADD CONSTRAINT [PK_UniversalBanID]
PRIMARY KEY CLUSTERED
(UniversalBanID ASC)
 WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

CREATE NONCLUSTERED INDEX [Index_UniversalBan_Groups] -- Adds an Index
  ON Internal.UniversalBan (Group1 ASC, Group2 ASC, Group3 ASC, Group4 ASC,
         Group5 ASC, Group6 ASC, Group7 ASC, Group8 ASC, Network ASC)
  WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

  ALTER TABLE Internal.UniversalBan -- Creates a textaddress of the IP address
  ADD TextAddress AS (
IIF([Group8] IS NULL,
    -- IPv4
    CONCAT(CONVERT(TINYINT, [Group4]), '.', CONVERT(TINYINT, [Group3]), '.',
      CONVERT(TINYINT, [Group2]), '.', CONVERT(TINYINT, [Group1]),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')),
    -- IPv6
    LOWER(CONCAT(
      CONVERT(VARCHAR(4), [Group8], 2), ':', CONVERT(VARCHAR(4), [Group7], 2), ':',
      CONVERT(VARCHAR(4), [Group6], 2), ':', CONVERT(VARCHAR(4), [Group5], 2), ':',
      CONVERT(VARCHAR(4), [Group4], 2), ':', CONVERT(VARCHAR(4), [Group3], 2), ':',
      CONVERT(VARCHAR(4), [Group2], 2), ':', CONVERT(VARCHAR(4), [Group1], 2),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')
     ))
   ) -- end of IIF
);


CREATE TABLE [Site].[IPAddress]
(
IPAddressID INT NOT NULL IDENTITY,
Group8 VARBINARY(2) NULL,  --I VARBINARY(2) fields that represents the 8 groups in a ipv6. The fields 5 - 8 is nullable as they are only used for IPv6. The fields 1 - 4 is set to NOT NULL as they are be used for both IPv4 and IPv6.
Group7 VARBINARY(2) NULL,
Group6 VARBINARY(2) NULL,
Group5 VARBINARY(2) NULL,
Group4 VARBINARY(2) NOT null,
Group3 VARBINARY(2) NOT null,
Group2 VARBINARY(2) NOT null,
Group1 VARBINARY(2) NOT null,
Network TINYINT null,
UserID INT,

CONSTRAINT FK_User_IPAddress FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)
ALTER TABLE [Site].[IPAddress]
ADD CONSTRAINT [PK_IPAddress]
PRIMARY KEY CLUSTERED
(IPAddressID ASC)
 WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

CREATE NONCLUSTERED INDEX [Index_IPAddress_Groups]
  ON [Site].[IPAddress] (Group1 ASC, Group2 ASC, Group3 ASC, Group4 ASC,
         Group5 ASC, Group6 ASC, Group7 ASC, Group8 ASC, Network ASC)
  WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

  ALTER TABLE [Site].[IPAddress] -- Explain how it works, its really simple
  ADD TextAddress AS (
IIF([Group8] IS NULL,
    -- IPv4
    CONCAT(CONVERT(TINYINT, [Group4]), '.', CONVERT(TINYINT, [Group3]), '.',
      CONVERT(TINYINT, [Group2]), '.', CONVERT(TINYINT, [Group1]),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')),
    -- IPv6
    LOWER(CONCAT(
      CONVERT(VARCHAR(4), [Group8], 2), ':', CONVERT(VARCHAR(4), [Group7], 2), ':',
      CONVERT(VARCHAR(4), [Group6], 2), ':', CONVERT(VARCHAR(4), [Group5], 2), ':',
      CONVERT(VARCHAR(4), [Group4], 2), ':', CONVERT(VARCHAR(4), [Group3], 2), ':',
      CONVERT(VARCHAR(4), [Group2], 2), ':', CONVERT(VARCHAR(4), [Group1], 2),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')
     ))
   ) -- end of IIF
);

CREATE TABLE Internal.Picture(
PictureID INT IDENTITY PRIMARY KEY,
UserID INT NOT NULL,
[Name] NVARCHAR(255) NOT NULL,
DateAdded DateTime NOT NULL DEFAULT GetDate(),
Picture VarBinary(max) DEFAULT ([dbo].[GetBlobData]()) NOT NULL, -- Vi kan skapa en trigger istället, som skapar en ny pricture TABLE med DEFAULT bilden?

CONSTRAINT FK_User_Picture FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

ALTER TABLE Internal.Picture
ADD CONSTRAINT UQ_UserID_Name UNIQUE(UserId, [Name])

CREATE TABLE Internal.[Profile](
ProfileID INT IDENTITY PRIMARY KEY,
UserID INT NOT NULL,
PicAvatarID INT NOT NULL,
[Description] NVARCHAR(3000),

CONSTRAINT FK_User_Profile FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK_Picture_Profile FOREIGN KEY (PicAvatarID) REFERENCES Internal.Picture(PictureID)
)

-- https://stackoverflow.com/questions/3094495/db-schema-for-chats
CREATE TABLE [Site].MessageSend(
MessageSendID INT IDENTITY PRIMARY KEY,
SenderID INT,
ReciverID INT,
[Message] NVARCHAR(3000) NOT NULL,
title NVARCHAR(200) NOT NULL,
DateSent DateTime,
[read] BIT DEFAULT 0,  
Flag BIT DEFAULT 0,

CONSTRAINT FK_User_MessageSender FOREIGN KEY (SenderID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK_User_UsernameReciver FOREIGN KEY (ReciverID) REFERENCES [Site].[User](UserID)
)

CREATE TABLE Forum.GlobalCategory
(
GlobalCategoryID INT IDENTITY PRIMARY KEY,
UserID INT,
[Read] INT, 
GlobalCategoryName NVARCHAR(200) NOT NULL,

CONSTRAINT FK_User_GlobalCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK_Roles_GlobalCategory FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID)
)

CREATE TABLE Forum.SubCategory
(
SubCategoryID INT IDENTITY PRIMARY KEY,
[Read] INT DEFAULT 1, 
[Write] INT DEFAULT 1,
UserID INT,
SubCategoryName NVARCHAR(200) NOT NULL,
GlobalCategoryID INT,

CONSTRAINT FK_User_SubCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK_GlobalCategoryID_SubCategory FOREIGN KEY (GlobalCategoryID) REFERENCES Forum.GlobalCategory(GlobalCategoryID),
CONSTRAINT FK_Roles_SubCategory_Read FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID),
CONSTRAINT FK_Roles_SubCategory_Write FOREIGN KEY ([Write]) REFERENCES Internal.[Role](RoleID)
)

CREATE TABLE Forum.Thread
(
ThreadID INT IDENTITY PRIMARY KEY,
[Read] INT DEFAULT 1, 
[Write] INT DEFAULT 1,
UserID INT,
ThreadTitle NVARCHAR(200) NOT NULL,
SubCategoryID INT,
Locked BIT DEFAULT 0,

CONSTRAINT FK_User_Thread FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE, 
CONSTRAINT FK_SubCategory_Thread FOREIGN KEY (SubCategoryID) REFERENCES Forum.SubCategory(SubCategoryID),
CONSTRAINT FK_Roles_Thread_Read FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID),
CONSTRAINT FK_Roles_Thread_Write FOREIGN KEY ([Write]) REFERENCES Internal.[Role](RoleID)
)

CREATE TABLE Forum.ThreadLock
(
ThreadLockID INT IDENTITY PRIMARY KEY,
ThreadID INT,
Reason NVARCHAR(1000),
DisplayReason NVARCHAR(1000),
UserID INT,

CONSTRAINT FK_User_ThreadLock FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE, 
CONSTRAINT FK_Thread_ThreadLock FOREIGN KEY (ThreadID) REFERENCES Forum.Thread(ThreadID)
)

CREATE TABLE Forum.AccountForumBan
(
AccountForumBan INT IDENTITY PRIMARY KEY,
UserID INT,
BannersID INT, -- The one that executed the ban
Reason NVARCHAR (1000),
DisplayReason NVARCHAR (1000),
Severity INT, -- 1-10
HowLong DATETIME,
BanDate DATETIME,

CONSTRAINT FK_User_AccountForumBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

CREATE TABLE Forum.ForumEntry
(
ForumEntryID INT IDENTITY PRIMARY KEY,
UserID INT,
[Entry] NVARCHAR(4000) NOT NULL,
ThreadID INT,
Edited BIT default 0,
LastEdited DATETIME,
Created DATETIME,

CONSTRAINT FK_User_ForumEntry FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE, 
CONSTRAINT FK_Thread_ForumEntry FOREIGN KEY (ThreadID) REFERENCES Forum.Thread(ThreadID)
)

CREATE TABLE Forum.ForumBan
(
UserID INT,
ForumBanID INT IDENTITY PRIMARY KEY,
Reason NVARCHAR,
Severity INT, -- 1-10
HowLong DATE,
BanDate Date,

CONSTRAINT FK_User_ForumBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

CREATE TABLE [Site].Announcement
(
AnnouncementID INT IDENTITY PRIMARY KEY,
[Message] NVARCHAR(3000),
Kind NVARCHAR(255) NOT NULL, 
CHECK (Kind = 'Server' OR Kind = 'Forum' OR Kind = 'HomePage' OR Kind='Important' OR Kind = 'Other')
)

CREATE TABLE [Site].News
(
NewsID INT IDENTITY PRIMARY KEY,
UserID INT, 
[Text] NVARCHAR(3500),
DatePosted DATE NOT NULL DEFAULT getDATE(),
Likes INT,
clicks INT,

CONSTRAINT FK_User_News FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

CREATE TABLE [Site].NewsPrictures
(
NewsPricturesID INT IDENTITY PRIMARY KEY,
Picture VarBinary(max) NOT NULL,
NewsID INT,

CONSTRAINT FK_News_NewsPrictures FOREIGN KEY (NewsID) REFERENCES [Site].News(NewsID) ON DELETE CASCADE
)

CREATE TABLE [Site].Guide 
(
GuideID INT IDENTITY PRIMARY KEY,
UserID INT, 
[Text] NVARCHAR(3500),
DatePosted DATE NOT NULL DEFAULT getDATE(),
Likes INT,
clicks INT,

CONSTRAINT FK_User_Guide FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

CREATE TABLE [Site].GuidePrictures
(
GuidePrictures INT IDENTITY PRIMARY KEY,
Picture VarBinary(max) NOT NULL,
GuideID INT,

CONSTRAINT FK_Guide_GuidePrictures FOREIGN KEY (GuideID) REFERENCES [Site].Guide(GuideID) ON DELETE CASCADE
)

CREATE TABLE Gaming.[Server]
(
ServerID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(100),
[Online] BIT NOT NULL,
LastCHECK DATE,
MaxPlayers INT,
CHECK (MaxPlayers >= NumberOfPlayers),
NumberOfPlayers INT,
UniquePlayers INT, -- Kan hämtas från players genom en trigger
HeadMod NVARCHAR,
Map NVARCHAR, 
Mods NVARCHAR,
LastServerReset Datetime,
Resets DateTime, --Hours 
Bans INT,
MoneyCirculatedInShop money,
MissionsDone int,
PlayerKills int, 
PlayerAIKills int, --Player killed AI
AIPlayerKills int, --AI killed Player
)

CREATE TABLE Gaming.[IPAddressServer]
(
IPAddressServerID INT NOT NULL IDENTITY,
Group8 VARBINARY(2) NULL,  --I VARBINARY(2) fields that represents the 8 groups in a ipv6. The fields 5 - 8 is nullable as they are only used for IPv6. The fields 1 - 4 is set to NOT NULL as they are be used for both IPv4 and IPv6.
Group7 VARBINARY(2) NULL,
Group6 VARBINARY(2) NULL,
Group5 VARBINARY(2) NULL,
Group4 VARBINARY(2) NOT NULL,
Group3 VARBINARY(2) NOT NULL,
Group2 VARBINARY(2) NOT NULL,
Group1 VARBINARY(2) NOT NULL,
Network TinyINT NULL,
ServerID INT

CONSTRAINT FK_Server_IPAddress FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE -- Turnicate...
)
ALTER TABLE Gaming.[IPAddressServer]
ADD CONSTRAINT [PK_IPAddressServer]
PRIMARY KEY CLUSTERED
(IPAddressServerID ASC)
 WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

CREATE NONCLUSTERED INDEX [Index_IPAddressServer_Groups]
  ON Gaming.[IPAddressServer] (Group1 ASC, Group2 ASC, Group3 ASC, Group4 ASC,
         Group5 ASC, Group6 ASC, Group7 ASC, Group8 ASC, Network ASC)
  WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

  ALTER TABLE Gaming.[IPAddressServer] -- Explain how it works, its really simple
  ADD TextAddress AS (
IIF([Group8] IS NULL,
    -- IPv4
    CONCAT(CONVERT(TINYINT, [Group4]), '.', CONVERT(TINYINT, [Group3]), '.',
      CONVERT(TINYINT, [Group2]), '.', CONVERT(TINYINT, [Group1]),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')),
    -- IPv6
    LOWER(CONCAT(
      CONVERT(VARCHAR(4), [Group8], 2), ':', CONVERT(VARCHAR(4), [Group7], 2), ':',
      CONVERT(VARCHAR(4), [Group6], 2), ':', CONVERT(VARCHAR(4), [Group5], 2), ':',
      CONVERT(VARCHAR(4), [Group4], 2), ':', CONVERT(VARCHAR(4), [Group3], 2), ':',
      CONVERT(VARCHAR(4), [Group2], 2), ':', CONVERT(VARCHAR(4), [Group1], 2),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')
     ))
   ) -- end of IIF
);

/*
CREATE TABLE Gaming.Players
(
PlayerID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(100),
PlayerIdentity INT,
LastServerID INT,
)
*/
/*
CREATE TABLE Gaming.IPAddressPlayer
(
IPAdressServerID INT NOT NULL IDENTITY ,
PlayerID INT,
Group8 VARBINARY(2) NULL,  --I VARBINARY(2) fields that represents the 8 groups in a ipv6. The fields 5 - 8 is nullable as they are only used for IPv6. The fields 1 - 4 is set to NOT NULL as they are be used for both IPv4 and IPv6.
Group7 VARBINARY(2) NULL,
Group6 VARBINARY(2) NULL,
Group5 VARBINARY(2) NULL,
Group4 VARBINARY(2) NOT NULL,
Group3 VARBINARY(2) NOT NULL,
Group2 VARBINARY(2) NOT NULL,
Group1 VARBINARY(2) NOT NULL,
Network TinyINT NULL,

CONSTRAINT FK_Player_IPAddressPlayer FOREIGN KEY (PlayerID) REFERENCES Gaming.Players(PlayerID) ON DELETE CASCADE
) 
ALTER TABLE Gaming.IPAddressPlayer
ADD CONSTRAINT [PK_IPAddressPlayer]
PRIMARY KEY CLUSTERED
(IPAdressServerID ASC)
 WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

CREATE NONCLUSTERED INDEX [Index_IPAddressPlayer_Groups]
  ON Gaming.IPAddressPlayer (Group1 ASC, Group2 ASC, Group3 ASC, Group4 ASC,
         Group5 ASC, Group6 ASC, Group7 ASC, Group8 ASC, Network ASC)
  WITH (FILLFACTOR = 100, DATA_COMPRESSION = PAGE);

  ALTER TABLE Gaming.IPAddressPlayer -- Explain how it works, its really simple
  ADD TextAddress AS (
IIF([Group8] IS NULL,
    -- IPv4
    CONCAT(CONVERT(TINYINT, [Group4]), '.', CONVERT(TINYINT, [Group3]), '.',
      CONVERT(TINYINT, [Group2]), '.', CONVERT(TINYINT, [Group1]),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')),
    -- IPv6
    LOWER(CONCAT(
      CONVERT(VARCHAR(4), [Group8], 2), ':', CONVERT(VARCHAR(4), [Group7], 2), ':',
      CONVERT(VARCHAR(4), [Group6], 2), ':', CONVERT(VARCHAR(4), [Group5], 2), ':',
      CONVERT(VARCHAR(4), [Group4], 2), ':', CONVERT(VARCHAR(4), [Group3], 2), ':',
      CONVERT(VARCHAR(4), [Group2], 2), ':', CONVERT(VARCHAR(4), [Group1], 2),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')
     ))
   ) -- end of IIF
);
*/

CREATE TABLE Gaming.Server24
(
Server24ID INT IDENTITY PRIMARY KEY,
ServerID INT,
UniquePlayers INT, --Make a trigger
Bans INT,
MoneyCirculatedInShop money,
MissionsDone int,
PlayerKills int, 
PlayerAIKills int, --Players kille AI
AIPlayerKills int, --AI killed Player

CONSTRAINT FK_Server_Server24 FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE
)

CREATE TABLE Gaming.UniquePlayers24
(
UniquePlayer24ID INT IDENTITY PRIMARY KEY,
ServerID INT,
PlayerID INT,

CONSTRAINT FK_Server24_UniquePlayers24 FOREIGN KEY (ServerID) REFERENCES Gaming.Server24(Server24ID) ON DELETE CASCADE
)

CREATE TABLE Gaming.ServerStats
(
ServerStatsID INT IDENTITY PRIMARY KEY,
ServerID INT,
UniquePlayers INT, --Make a trigger
Bans INT,
PlayerKills int, 
PlayerAIKills int, --Players kille AI
AIPlayerKills int, --AI killed Player															       
MoneyCirculatedInShop money, -- If MoneyCirculatedInShop >= 912,337,203,685,477.5807, highest is 922,337,203,685,477.5807, we could use an instead of trigger,
FullMoney int not null default 0, -- Sätt till 0 så det inte ger errors
MissionsDone int,

CONSTRAINT FK_Server_ServerStats FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE
)

CREATE TABLE Gaming.ServerBan
(
ServerBanID INT IDENTITY PRIMARY KEY,
ServerID INT,
PlayerID INT,
Reason NVARCHAR,
Severity INT, -- 1-10
HowLong DATE,
BanDate Date,

CONSTRAINT FK_Server_Ban FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE
)

-- GameCharacter
CREATE TABLE Gaming.GameCharacter
(
GameCharacterID INT IDENTITY PRIMARY KEY,
ServerID INT,
UserID INT NOT NULL,
BackpackSlot NVARCHAR(255),
HeadSlot NVARCHAR(255),
VestSlot NVARCHAR(255),
WatchSlot NVARCHAR(255),
CompassSlot NVARCHAR(255),
RadioSlot NVARCHAR(255),
MapSlot NVARCHAR(255),
BinocularSlot NVARCHAR(255),
NVGSlot NVARCHAR(255),
PrimarySlot NVARCHAR(255),
GPSSlot NVARCHAR(255),
LauncherSlot NVARCHAR(255),
SecondarySlot NVARCHAR(255),
ChatacterName NVARCHAR(100),
HP INT, 
FoodLevel INT,
WaterLevel INT,
x DECIMAL, --Coord
y DECIMAL, --Coord
Alive BIT,
kills INT,
Amount MONEY, -- Make a trigger if it gets full 
CHECK(Amount <= MoneyFull),
MoneyFull Money, -- Make a trigger
Respect DECIMAL,

CONSTRAINT FK_User_GameCharacter FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK_Clothing_GameCharacter_BackpackSlot FOREIGN KEY (BackpackSlot) REFERENCES [Inventory].[Clothing$]([Class Name]),
CONSTRAINT FK_Clothing_GameCharacter_VestSlot FOREIGN KEY (VestSlot) REFERENCES [Inventory].[Clothing$]([Class Name]),
CONSTRAINT FK_Clothing_GameCharacter_HeadSlot FOREIGN KEY (HeadSlot) REFERENCES [Inventory].[Clothing$]([Class Name]),
CONSTRAINT FK_Items_GameCharacter_WatchSlot FOREIGN KEY (WatchSlot) REFERENCES [Inventory].[Items$]([Class Name]),
CONSTRAINT FK_Items_GameCharacter_CompassSlot FOREIGN KEY (CompassSlot) REFERENCES [Inventory].[Items$]([Class Name]),
CONSTRAINT FK_Items_GameCharacter_BinocularSlot FOREIGN KEY (BinocularSlot) REFERENCES [Inventory].[Items$]([Class Name]),
CONSTRAINT FK_Items_GameCharacter_GPSSlot FOREIGN KEY (GPSSlot) REFERENCES [Inventory].[Items$]([Class Name]),
CONSTRAINT FK_Items_GameCharacter_RadioSlot FOREIGN KEY (RadioSlot) REFERENCES [Inventory].[Items$]([Class Name]),
CONSTRAINT FK_Items_GameCharacter_MapSlot FOREIGN KEY (MapSlot) REFERENCES [Inventory].[Items$]([Class Name]),
CONSTRAINT FK_Items_GameCharacter_NVGSlot FOREIGN KEY (NVGSlot) REFERENCES [Inventory].[Items$]([Class Name]),
CONSTRAINT FK_Weapons_GameCharacter_PrimarySlot FOREIGN KEY (PrimarySlot) REFERENCES [Inventory].[Weapons$]([Class Name]),
CONSTRAINT FK_Weapons_GameCharacter_LauncherSlot FOREIGN KEY (LauncherSlot) REFERENCES [Inventory].[Weapons$]([Class Name]), 
CONSTRAINT FK_Weapons_GameCharacter_SecondarySlot FOREIGN KEY (SecondarySlot) REFERENCES [Inventory].[Weapons$]([Class Name]),
CONSTRAINT FK_Server_GameCharacter FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID)

)

CREATE TABLE Inventory.WeaponsInBackPack
(
WeaponsInBackPackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Weapons_WeaponsInBackPack FOREIGN KEY ([Class Name]) REFERENCES [Inventory].[Weapons$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_WeaponsInBackPack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)

)

CREATE TABLE Inventory.ClothesInBackPack
(
ClothesInBackPackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Clothing_ClothesInBackPack FOREIGN KEY ([Class Name]) REFERENCES [Inventory].[Clothing$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_ClothesInBackPack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Inventory.ItemsInBackpack
(
ItemsInBackpackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Items_ItemsInBackpack FOREIGN KEY ([Class Name]) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_ItemsInBackpack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Inventory.ExplosivesInBackpack
(
ExplosivesInBackpackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Explosives_ExplosivesInBackpack FOREIGN KEY ([Class Name]) REFERENCES [Inventory].[Explosives$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_ExplosivesInBackpack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Inventory.MiscInBackpack
(
MiscInBackpackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Misc_MiscInBackpack FOREIGN KEY ([Class Name]) REFERENCES Inventory.[Misc$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_MiscInBackpack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Inventory.AmmunitionInBackpack
(
AmmunitionInBackpackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Ammunition_AmmunitionInBackpack FOREIGN KEY ([Class Name]) REFERENCES Inventory.[Ammunition$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_AmmunitionInBackpack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Inventory.AttachmentsInBackpack
(
AttachmentsInBackpackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Attachments_AttachmentsInBackpack FOREIGN KEY ([Class Name]) REFERENCES Inventory.[Attachments$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_AttachmentsInBackpack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)

)

CREATE TABLE Inventory.MedicalInBackpack
(
MedicalInBackpackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Medical_MedicalInBackpack FOREIGN KEY ([Class Name]) REFERENCES Inventory.[Medical$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_MedicalInBackpack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Inventory.FoodInBackpack
(
FoodInBackpackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Food_FoodInBackpack FOREIGN KEY ([Class Name]) REFERENCES Inventory.[Food$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_FoodInBackpack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Inventory.DrinkablesInBackpack
(
DrinkablesInBackpackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Food_DrinkablesInBackpack FOREIGN KEY ([Class Name]) REFERENCES Inventory.[Drinkables$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_DrinkablesInBackpack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Inventory.CraftingInBackpack
(
CraftingInBackpackID INT PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID INT,
Amount INT NOT NULL,
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Crafting_CraftingInBackpack FOREIGN KEY ([Class Name]) REFERENCES Inventory.[Crafting$]([Class Name]) ON DELETE CASCADE,
CONSTRAINT FK_GameCharacter_CraftingInBackpack FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Gaming.Garage
(
GarageID INT IDENTITY PRIMARY KEY,
[Class Name] NVARCHAR(255),
GameCharacterID  INT,
Amount INT NOT NULL
UNIQUE ([Class Name], GameCharacterID),

CONSTRAINT FK_Vehicles_Garage FOREIGN KEY ([Class Name]) REFERENCES Inventory.[Vehicles$]([Class Name]) ON DELETE CASCADE, 
CONSTRAINT FK_GameCharacter_Garage FOREIGN KEY (GameCharacterID) REFERENCES Gaming.GameCharacter(GameCharacterID)
)

CREATE TABLE Gaming.GameStats
(
GameStatsID INT IDENTITY PRIMARY KEY,
UserID INT,
Kills INT,
Deaths INT, 
Revivals INT,
MoneySpent BIGINT, 
MoneyLostWhenKilled BIGINT, 

CONSTRAINT FK_User_GameStats FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)
GO

-- Run all of this inside another file later
EXEC sp_configure 'ad hoc distributed queries', 0 --Needed to be able to get the data from the excel file
RECONFIGURE
GO
EXEC sp_configure 'show advanced options', 0 --Needed to be able to get the data from the excel file
RECONFIGURE
GO

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 0 --Needed to be able to get the data from the excel file
GO 
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 0 --Needed to be able to get the data from the excel file
GO
