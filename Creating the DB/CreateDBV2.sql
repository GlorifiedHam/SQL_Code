use master; 
go

if db_id('ForumDB') is NOT NULL
	drop database ForumDB
go

CREATE database ForumDB
go

use ForumDB
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
    EXEC Master.dbo.xp_fileexist N'D:/Programming/SQL/ForumDB/Images/Game.PNG', @IFFileExists OUT 
    IF @IFFileExists = 1
    
        -- If exists then read the file content
        SET @BinaryData = (SELECT * FROM OPENROWSET(BULK N'D:/Programming/SQL/ForumDB/Images/Game.PNG',SINGLE_BLOB)
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

/*Regular create statements from this point on*/

CREATE TABLE Internal.[Role]( -- Only admin should be able to make changes to this table
RoleID INT IDENTITY PRIMARY KEY,
RoleRank int,
RoleName NVARCHAR(100) UNIQUE
)

CREATE TABLE [Site].[User](
UserID INT IDENTITY PRIMARY KEY,
Username NVARCHAR(100) NOT NULL UNIQUE,
Firstname NVARCHAR(1000) NOT NULL,
Lastname NVARCHAR(1000) NOT NULL,
Age DATE NOT NULL,
[Password] NVARCHAR(100) NOT NULL,--Make an old password TABLE, with a trigger, that only saves one pw back?  
Email NVARCHAR(300) NOT NULL,
[Amount of entries] INT DEFAULT 0, --Trigger on creating an entry
Phonenumber VARCHAR(22), 
RegDATE DATE DEFAULT GETDATE(),
RoleID int DEFAULT 1,

CONSTRAINT FK__Role_User FOREIGN KEY (RoleID) REFERENCES internal.[Role](RoleID) ON DELETE CASCADE
);

CREATE TABLE Internal.AccountBan
(
AccountBanID INT IDENTITY PRIMARY KEY,
UserID INT,
Reason NVARCHAR (1000),
Severity INT, -- 1-10
HowLong DATETIME,
BanDate DATETIME,

CONSTRAINT FK__User_AccountBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

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

CONSTRAINT FK__User_IPAddress FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
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

CONSTRAINT FK__User_Picture FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

ALTER TABLE Internal.Picture
ADD CONSTRAINT UQ_UserID_Name UNIQUE(UserId, [Name])

CREATE TABLE Internal.[Profile](
ProfileID INT IDENTITY PRIMARY KEY,
UserID INT,
PicAvatarID INT,
Description NVARCHAR(3000) NOT NULL,

CONSTRAINT FK__User_Profile FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK__Picture_Profile FOREIGN KEY (PicAvatarID) REFERENCES Internal.Picture(PictureID)
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

CONSTRAINT FK__User_MessageSender FOREIGN KEY (SenderID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK__User_UsernameReciver FOREIGN KEY (ReciverID) REFERENCES [Site].[User](UserID)
)

CREATE TABLE Forum.GlobalCategory
(
GlobalCategoryID INT IDENTITY PRIMARY KEY,
UserID INT,
[Read] INT, 
GlobalCategoryName NVARCHAR(200) NOT NULL,

CONSTRAINT FK__User_GlobalCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
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

CONSTRAINT FK__User_SubCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK__GlobalCategoryID_SubCategory FOREIGN KEY (GlobalCategoryID) REFERENCES Forum.GlobalCategory(GlobalCategoryID),
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

CONSTRAINT FK__User_Thread FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE, 
CONSTRAINT FK__SubCategory_Thread FOREIGN KEY (SubCategoryID) REFERENCES Forum.SubCategory(SubCategoryID),
CONSTRAINT FK_Roles_Thread_Read FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID),
CONSTRAINT FK_Roles_Thread_Write FOREIGN KEY ([Write]) REFERENCES Internal.[Role](RoleID)
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

CONSTRAINT FK__User_ForumEntry FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE, 
CONSTRAINT FK__Thread_ForumEntry FOREIGN KEY (ThreadID) REFERENCES Forum.Thread(ThreadID)
)

CREATE TABLE [Site].Announcement
(
AnnouncementID INT IDENTITY PRIMARY KEY,
[Message] NVARCHAR(3000),
Kind NVARCHAR NOT NULL, 
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

CONSTRAINT FK__User_News FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

CREATE TABLE [Site].NewsPrictures
(
NewsPricturesID INT IDENTITY PRIMARY KEY,
Picture VarBinary(max) NOT NULL,
NewsID INT,

CONSTRAINT FK__News_NewsPrictures FOREIGN KEY (NewsID) REFERENCES [Site].News(NewsID) ON DELETE CASCADE
)

CREATE TABLE [Site].Guide 
(
GuideID INT IDENTITY PRIMARY KEY,
UserID INT, 
[Text] NVARCHAR(3500),
DatePosted DATE NOT NULL DEFAULT getDATE(),
Likes INT,
clicks INT,

CONSTRAINT FK__User_Guide FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

CREATE TABLE [Site].GuidePrictures
(
GuidePrictures INT IDENTITY PRIMARY KEY,
Picture VarBinary(max) NOT NULL,
GuideID INT,

CONSTRAINT FK__Guide_GuidePrictures FOREIGN KEY (GuideID) REFERENCES [Site].Guide(GuideID) ON DELETE CASCADE
)

CREATE TABLE Gaming.[Server]
(
ServerID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(100),
[Online] BIT NOT NULL,
LastCHECK DATE,
MaxPlayers INT,
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

CONSTRAINT FK__Server_IPAddress FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE -- Turnicate...
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

CREATE TABLE Gaming.Players
(
PlayerID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(100),
IPAdressPlayerID INT,
PlayerIdentity INT,
LastServerID INT,

CONSTRAINT FK__Server_Players FOREIGN KEY (LastServerID) REFERENCES [Gaming].[Server](ServerID) ON DELETE CASCADE
)

CREATE TABLE Gaming.IPAddressPlayer
(
IPAdressServer INT NOT NULL IDENTITY ,
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

CONSTRAINT FK__Player_IPAddressServer FOREIGN KEY (PlayerID) REFERENCES Gaming.Player(PlayerID) ON DELETE CASCADE
) 


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

CONSTRAINT FK__Server_Server24 FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE
)

CREATE TABLE Gaming.UniquePlayers24
(
UniquePlayer24ID INT IDENTITY PRIMARY KEY,
ServerID INT,
PlayerID INT,

CONSTRAINT FK__Server24_UniquePlayers24 FOREIGN KEY (ServerID) REFERENCES Gaming.Server24(Server24ID) ON DELETE CASCADE
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

CONSTRAINT FK__Server_ServerStats FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE
)

CREATE TABLE Gaming.ServerBan
(
ServerID INT,
BanID INT IDENTITY PRIMARY KEY,
PlayerID INT,
Reason NVARCHAR,
Severity INT, -- 1-10
HowLong DATE,
BanDate Date,

CONSTRAINT FK__Server_Ban FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE
)

CREATE TABLE Forum.ForumBan
(
UserID INT,
ForumBanID INT IDENTITY PRIMARY KEY,
Reason NVARCHAR,
Severity INT, -- 1-10
HowLong DATE,
BanDate Date,

CONSTRAINT FK__User_ForumBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

-- Slots

CREATE TABLE Gaming.VestSlot
(
VestSID INT IDENTITY PRIMARY KEY,
Vest_Class_Name NVARCHAR(255), -- We should make a trigger that checks inside the Clotihing table so that the Class_Name has the right type.

CONSTRAINT FK__Clothing_VestSlot FOREIGN KEY (Vest_Class_Name) REFERENCES [Inventory].[Clothing$]([Class Name]) ON DELETE CASCADE
)

CREATE TABLE Gaming.HeadSlot
(
HeadSID INT IDENTITY PRIMARY KEY,
Headgear_Class_Name NVARCHAR(255),

CONSTRAINT FK__Clothing_HeadSlot FOREIGN KEY (Headgear_Class_Name) REFERENCES [Inventory].[Clothing$]([Class Name]) ON DELETE CASCADE
)

CREATE TABLE Gaming.BackpackSlot
(
BackpackSID INT IDENTITY PRIMARY KEY,
Backpack_Class_Name NVARCHAR(255),

CONSTRAINT FK__Clothing_BackpackSlot FOREIGN KEY (Backpack_Class_Name) REFERENCES [Inventory].[Clothing$]([Class Name]) ON DELETE CASCADE
)

CREATE TABLE Gaming.CompassSlot
(
CompassSID INT IDENTITY PRIMARY KEY,
Compass_Class_Name NVARCHAR(255),

CONSTRAINT FK__Items_CompassSlot FOREIGN KEY (Compass_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE
) -- We could make this one different because there is only one compass (atm)

CREATE TABLE Gaming.GPSSlot
(
GPSSID INT IDENTITY PRIMARY KEY,
GPS_Class_Name NVARCHAR(255),

CONSTRAINT FK__Items_GPSsSlot FOREIGN KEY (GPS_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE
)

CREATE TABLE Gaming.WatchSlot
(
WatchSID INT IDENTITY PRIMARY KEY,
Watch_Class_Name NVARCHAR(255),

CONSTRAINT FK__Items_WatchSlot FOREIGN KEY (Watch_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE
) -- We could make this one different because there is only one watch (atm)

CREATE TABLE Gaming.RadioSlot
(
RadioSID INT IDENTITY PRIMARY KEY,
Radio_Class_Name NVARCHAR(255),

CONSTRAINT FK__Items_RadioSlot FOREIGN KEY (Radio_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE
) -- We could make this one different because there is only one radio (atm)

CREATE TABLE Gaming.MapSlot
(
MapSID INT IDENTITY PRIMARY KEY,
Map_Class_Name NVARCHAR(255),

CONSTRAINT FK__Items_MapSlot FOREIGN KEY (Map_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE
) -- Different map depending on the map that is played.

CREATE TABLE Gaming.BinocularSlot
(
BinocularSID INT IDENTITY PRIMARY KEY,
Binocular_Class_Name NVARCHAR(255),

CONSTRAINT FK__Items_BinocularSlot FOREIGN KEY (Binocular_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE
)

CREATE TABLE Gaming.NVGSlot
(
NVGSID INT IDENTITY PRIMARY KEY,
NVG_Class_Name NVARCHAR(255),

CONSTRAINT FK__Items_NVGSlot FOREIGN KEY (NVG_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE
)

CREATE TABLE Gaming.PrimarySlot
(
PrimarySID INT IDENTITY PRIMARY KEY,
Primary_Class_Name NVARCHAR(255),

CONSTRAINT FK__Weapons_PrimarySlot FOREIGN KEY (Primary_Class_Name) REFERENCES [Inventory].[Weapons$]([Class Name]) ON DELETE CASCADE
)

CREATE TABLE Gaming.SecondarySlot
(
SecondarySID INT IDENTITY PRIMARY KEY,
Secondary_Class_Name NVARCHAR(255),

CONSTRAINT FK__Weapons_SecondarySlot FOREIGN KEY (Secondary_Class_Name) REFERENCES [Inventory].[Weapons$]([Class Name]) ON DELETE CASCADE
)

CREATE TABLE Gaming.LauncherSlot
(
LauncherSID INT IDENTITY PRIMARY KEY,
Launcher_Class_Name NVARCHAR(255),
 
CONSTRAINT FK__Weapons_LauncherSlot FOREIGN KEY (Launcher_Class_Name) REFERENCES [Inventory].[Weapons$]([Class Name]) ON DELETE CASCADE
)

CREATE TABLE Gaming.GameCharacter
(
GameCharacterID INT IDENTITY PRIMARY KEY,
UserID INT,
BackpackSID INT,
HeadSID INT,
VestSID INT,
WatchSID INT,
CompassSID INT,
RadioSID INT,
MapSID INT,
BinocularSID INT,
NVGSID INT,
PrimarySID INT,
GPSSID INT,
LauncherSID INT,
ChatacterName NVARCHAR,
HP INT, 
FoodLevel INT,
WaterLevel INT,
x DECIMAL, --Coord
y DECIMAL, --Coord
Alive BIT,
kills INT,
Amount MONEY, -- Make a trigger if it gets full 
MoneyFull Money, -- Make a trigger
Respect DECIMAL,

CONSTRAINT FK__User_GameCharacter FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK__BackpackSlot_GameCharacter FOREIGN KEY (BackpackSID) REFERENCES Gaming.BackpackSlot(BackpackSID),
CONSTRAINT FK__VestSlot_GameCharacter FOREIGN KEY (VestSID) REFERENCES Gaming.VestSlot(VestSID),
CONSTRAINT FK__HeadSlot_GameCharacter FOREIGN KEY (HeadSID) REFERENCES Gaming.HeadSlot(HeadSID),
CONSTRAINT FK__WatchSlot_GameCharacter FOREIGN KEY (WatchSID) REFERENCES Gaming.WatchSlot(WatchSID),
CONSTRAINT FK__CompassSlot_GameCharacter FOREIGN KEY (CompassSID) REFERENCES Gaming.CompassSlot(CompassSID),
CONSTRAINT FK__RadioSlot_GameCharacter FOREIGN KEY (RadioSID) REFERENCES Gaming.RadioSlot(RadioSID),
CONSTRAINT FK__MapSlot_GameCharacter FOREIGN KEY (MapSID) REFERENCES Gaming.MapSlot(MapSID),
CONSTRAINT FK__BinocularSlot_GameCharacter FOREIGN KEY (BinocularSID) REFERENCES Gaming.BinocularSlot(BinocularSID),
CONSTRAINT FK__NVGSlot_GameCharacter FOREIGN KEY (NVGSID) REFERENCES Gaming.NVGSlot(NVGSID),
CONSTRAINT FK__PrimarySlot_GameCharacter FOREIGN KEY (PrimarySID) REFERENCES Gaming.PrimarySlot(PrimarySID),
CONSTRAINT FK__GPSSlot_GameCharacter FOREIGN KEY (GPSSID) REFERENCES Gaming.GPSSlot(GPSSID),
CONSTRAINT FK__LauncherSlot_GameCharacter FOREIGN KEY (LauncherSID) REFERENCES Gaming.LauncherSlot(LauncherSID)
)

CREATE TABLE Gaming.GameStats
(
GameStatsID INT IDENTITY PRIMARY KEY,
UserID INT,
Kills INT,
Deaths INT, 
Revivals INT,
MoneySpent Money, --Make a trigger if it gets full 
MoneySpentFull int default 0,
MoneyLostWhenKilled Money, --Make a trigger if it gets full 
MoneyLostWhenKilledFull int default 0,

CONSTRAINT FK__User_GameStats FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

