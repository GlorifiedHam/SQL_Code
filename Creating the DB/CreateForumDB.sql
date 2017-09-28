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



CREATE TABLE [Site].[User](
UserID INT IDENTITY PRIMARY KEY,
Username NVARCHAR(100) NOT NULL UNIQUE,
Firstname NVARCHAR(1000) NOT NULL,
Lastname NVARCHAR(1000) NOT NULL,
Age DATE NOT NULL,
[Password] NVARCHAR(100) NOT NULL,--Make an old password TABLE, with a trigger, that only saves one pw back?  
Email NVARCHAR(300) NOT NULL,
[Amount of entries] INT, --Trigger on creating an entry
Phonenumber VARCHAR(22) CHECK(Phonenumber > 0), 
RegDATE DATE DEFAULT GETDATE()
);


CREATE TABLE [Site].[IPAdress]
(
IPAdress INT NOT NULL IDENTITY PRIMARY KEY,
Group8 VARBINARY(2) null,  --I VARBINARY(2) fields that represents the 8 groups in a ipv6. The fields 5 - 8 is nullable as they are only used for IPv6. The fields 1 - 4 is set to NOT NULL as they are be used for both IPv4 and IPv6.
Group7 VARBINARY(2) null,
Group6 VARBINARY(2) null,
Group5 VARBINARY(2) null,
Group4 VARBINARY(2) null,
Group3 VARBINARY(2) null,
Group2 VARBINARY(2) null,
Group1 VARBINARY(2) null,
Network TinyINT null
)


CREATE TABLE Internal.[Role](
RoleID INT IDENTITY PRIMARY KEY,
UserID INT NOT NULL,
RoleName NVARCHAR(100) DEFAULT 'Member' NOT NULL,
CHECK (RoleName = 'Member' Or RoleName = 'SuperAdmin' OR RoleName = 'Admin' or RoleName = 'Moderator' Or RoleName = 'VIP' ),

CONSTRAINT FK__User_Role FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)


CREATE TABLE Internal.[Profile](
ProfileID INT IDENTITY PRIMARY KEY,
UserID INT,

Picture VarBinary(max) DEFAULT ([dbo].[GetBlobData]()) NOT NULL, -- Vi kan skapa en trigger istället, som skapar en ny pricture TABLE med DEFAULT bilden?
Description NVARCHAR(3000) NOT NULL,

CONSTRAINT FK__User_Profile FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)

CREATE TABLE Internal.Picture(
PictureID INT IDENTITY PRIMARY KEY,
UserID INT,
Picture VarBinary(max) NOT NULL,

CONSTRAINT FK__User_Picture FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)
-- https://stackoverflow.com/questions/3094495/db-schema-for-chats
CREATE TABLE [Site].MessageSend(
MessageSendID INT IDENTITY PRIMARY KEY,
UsernameSender NVARCHAR(100) NOT NULL, -- Fixas i programet this.username
UsernameReciver NVARCHAR(100) NOT NULL, -- Skrivs in, man ska kunna skicka medelanden till sig själv
[Message] NVARCHAR(3000) NOT NULL,
title NVARCHAR(200) NOT NULL,
[read] BIT DEFAULT 0,  


CONSTRAINT FK__User_MessageSender FOREIGN KEY (UsernameSender ) REFERENCES [Site].[User](Username) ON DELETE CASCADE,
CONSTRAINT FK__User_UsernameReciver FOREIGN KEY (UsernameReciver ) REFERENCES [Site].[User](Username)
)

CREATE TABLE Forum.GlobalCategory
(
GlobalCategoryID INT IDENTITY PRIMARY KEY,
UserID INT,
[Read] NVARCHAR(50) DEFAULT 'Member', 
GlobalCategoryName NVARCHAR(200) NOT NULL,

CONSTRAINT FK__User_GlobalCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)


CREATE TABLE Forum.SubCategory
(
SubCategoryID INT IDENTITY PRIMARY KEY,
[Read] NVARCHAR(50) DEFAULT 'Member', 
[Write] NVARCHAR(50) DEFAULT 'Member',
UserID INT,
SubCategoryName NVARCHAR(200) NOT NULL,
GlobalCategoryID INT,

CONSTRAINT FK__User_SubCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE,
CONSTRAINT FK__GlobalCategoryID_SubCategory FOREIGN KEY (GlobalCategoryID) REFERENCES Forum.GlobalCategory(GlobalCategoryID)
)

CREATE TABLE Forum.Thread
(
ThreadID INT IDENTITY PRIMARY KEY,
[Read] NVARCHAR(50) DEFAULT 'Member', 
[Write] NVARCHAR(50) DEFAULT 'Member',
UserID INT,
ThreadTitle NVARCHAR(200) NOT NULL,
SubCategoryID INT,
GlobalCategoryID INT DEFAULT null, 

locked BIT DEFAULT 0,

CONSTRAINT FK__User_Thread FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE, 
CONSTRAINT FK__SubCategory_Thread FOREIGN KEY (SubCategoryID) REFERENCES Forum.SubCategory(SubCategoryID),
CONSTRAINT FK_GlobalCategory_Thread FOREIGN KEY(GlobalCategoryID) REFERENCES Forum.GlobalCategory(GlobalCategoryID) 
)

CREATE TABLE Forum.ForumEntry
(
ForumEntryID INT IDENTITY PRIMARY KEY,
UserID INT,
[Entry] NVARCHAR(4000) NOT NULL,
ThreadID INT

CONSTRAINT FK__User_ForumEntry FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE, 
CONSTRAINT FK__Thread_ForumEntry FOREIGN KEY (ThreadID) REFERENCES Forum.Thread(ThreadID)
)

CREATE TABLE [Site].Announcement
(
Announcement INT IDENTITY PRIMARY KEY,
[Message] NVARCHAR(3000),
Kind NVARCHAR NOT NULL, 
CHECK (Kind = 'Server' OR Kind = 'Forum' OR Kind = 'HomePage' OR Kind='Important' OR Kind = 'Other')

)


CREATE TABLE [Site].News
(
NewsID INT IDENTITY PRIMARY KEY,
UserID INT, 
[Text] NVARCHAR(3500),
DATEPosted DATE NOT NULL DEFAULT getDATE(),
Likes INT,
clicks INT,

CONSTRAINT FK__User_News FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)


CREATE TABLE [Site].NewsPrictures
(
NewsPrictures INT IDENTITY PRIMARY KEY,
Picture VarBinary(max) NOT NULL,
NewsID INT,

CONSTRAINT FK__News_NewsPrictures FOREIGN KEY (NewsID) REFERENCES [Site].News(NewsID) ON DELETE CASCADE
)

CREATE TABLE [Site].Guide 
(
GuideID INT IDENTITY PRIMARY KEY,
UserID INT, 
[Text] NVARCHAR(3500),
DATEPosted DATE NOT NULL DEFAULT getDATE(),
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

CREATE TABLE [Gaming].[IPAdressPlayer]
(
IPAdressPlayerID INT NOT NULL IDENTITY PRIMARY KEY,
Group8 VARBINARY(2) null,  --I VARBINARY(2) fields that represents the 8 groups in a ipv6. The fields 5 - 8 is nullable as they are only used for IPv6. The fields 1 - 4 is set to NOT NULL as they are be used for both IPv4 and IPv6.
Group7 VARBINARY(2) null,
Group6 VARBINARY(2) null,
Group5 VARBINARY(2) null,
Group4 VARBINARY(2) null,
Group3 VARBINARY(2) null,
Group2 VARBINARY(2) null,
Group1 VARBINARY(2) null,
Network TinyINT null
)

CREATE TABLE Gaming.Players
(
PlayerID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(100),
IPAdressPlayer INT,
-- Kan man hämta arma3 playerID eller steamID?

CONSTRAINT FK__IPAdressPlayer_Players FOREIGN KEY (IPAdressPlayerID) REFERENCES [Gaming].[IPAdressPlayer](IPAdressPlayerID) ON DELETE CASCADE
 
)

CREATE TABLE Gaming.[Server]
(
ServerID INT IDENTITY PRIMARY KEY,
[Name] NVARCHAR(100),
[Online] BIT NOT NULL,
LastCHECK DATE,
MaxPlayers INT,
Players INT,
UniquePlayers INT, --Make a trigger
HeadMod NVARCHAR,
Map NVARCHAR, 
Mods NVARCHAR,
LastServerReset DATEtime,
Resets int, --Hours 
Bans INT,
MoneyCirculatedInShop money,
MissionsDone int,
PlayerKills int, 
PlayerAIKills int, --Player killed AI
AIPlayerKills int, --AI killed Player
)


CREATE TABLE Gaming.IPAdressServer
(
IPAdressServer INT NOT NULL IDENTITY PRIMARY KEY,
ServerID INT,
Group8 VARBINARY(2) null,  --I VARBINARY(2) fields that represents the 8 groups in a ipv6. The fields 5 - 8 is nullable as they are only used for IPv6. The fields 1 - 4 is set to NOT NULL as they are be used for both IPv4 and IPv6.
Group7 VARBINARY(2) null,
Group6 VARBINARY(2) null,
Group5 VARBINARY(2) null,
Group4 VARBINARY(2) null,
Group3 VARBINARY(2) null,
Group2 VARBINARY(2) null,
Group1 VARBINARY(2) null,
Network TinyINT null,
Port INT,

CONSTRAINT FK__Server_IPAdressServer FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE
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

CREATE TABLE Internal.AccountBan
(
UserID INT,
AccountBanID INT IDENTITY PRIMARY KEY,
Reason NVARCHAR,
Severity INT, -- 1-10
HowLong DATE,
BanDate Date,

CONSTRAINT FK__User_AccountBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
)


CREATE TABLE Gaming.GameCharacter
(
GameCharacterID INT IDENTITY PRIMARY KEY,
UserID INT, 
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

CONSTRAINT FK__User_GameCharacter FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
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




/*
ALTER TABLE MessageSend
DROP CONSTRAINT FK__User_MessageSender

ALTER TABLE MessageSend
DROP CONSTRAINT FK__User_UsernameReciver 


ALTER TABLE MessageSend
ALTER COLUMN
UsernameSender NVARCHAR(100) COLLATE Latin1_General_CS_AI;

ALTER TABLE MessageSend
ALTER COLUMN
UsernameReciver NVARCHAR(100) COLLATE Latin1_General_CS_AI;


ALTER TABLE [Site].[User]
alter column 
Username NVARCHAR(100) COLLATE Latin1_General_CS_AI;

ALTER TABLE[Site].[User]
alter column 
[Password] NVARCHAR(100) COLLATE Latin1_General_CS_AI;

ALTER TABLE MessageSend
add CONSTRAINT FK__User_MessageSender FOREIGN KEY (UsernameSender ) REFERENCES [Site].[User](Username)

ALTER TABLE MessageSend
add CONSTRAINT FK__User_UsernameReciver FOREIGN KEY (UsernameReciver ) REFERENCES [Site].[User](Username)

ALTER TABLE [Site].[User]
add CONSTRAINT [Unique_User] unique NONCLUSTERED 
(
	username ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

*/