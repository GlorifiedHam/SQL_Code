-- Turnicate Scripttruncate table
USE GamingSiteDB
GO

-- Tar bort alla främmande nycklar för att kunna göra en turnacte (återställa identity kolumnerna till 1)

ALTER TABLE [GamingSiteDB].Internal.AccountBan DROP CONSTRAINT FK_User_AccountBan
ALTER TABLE [GamingSiteDB].Forum.ThreadLock DROP CONSTRAINT FK_User_ThreadLock
ALTER TABLE [GamingSiteDB].Forum.ThreadLock DROP CONSTRAINT FK_Thread_ThreadLock
ALTER TABLE [GamingSiteDB].Internal.Picture DROP CONSTRAINT FK_User_Picture 
ALTER TABLE [GamingSiteDB].Forum.AccountForumBan DROP CONSTRAINT FK_User_AccountForumBan
ALTER TABLE [GamingSiteDB].[Site].[IPAddress] DROP CONSTRAINT FK_User_IPAddress
ALTER TABLE [GamingSiteDB].Internal.[Profile] DROP CONSTRAINT FK_User_Profile
ALTER TABLE [GamingSiteDB].Internal.[Profile] DROP CONSTRAINT FK_Picture_Profile
ALTER TABLE [GamingSiteDB].Internal.Picture DROP CONSTRAINT UQ_UserID_Name
ALTER TABLE [GamingSiteDB].[Site].MessageSend DROP CONSTRAINT FK_User_MessageSender
ALTER TABLE [GamingSiteDB].[Site].MessageSend DROP CONSTRAINT FK_User_UsernameReciver
ALTER TABLE [GamingSiteDB].Forum.GlobalCategory DROP CONSTRAINT FK_User_GlobalCategory
ALTER TABLE [GamingSiteDB].Forum.GlobalCategory DROP CONSTRAINT FK_Roles_GlobalCategory
ALTER TABLE [GamingSiteDB].Forum.SubCategory DROP CONSTRAINT FK_User_SubCategory
ALTER TABLE [GamingSiteDB].Forum.SubCategory DROP CONSTRAINT FK_GlobalCategoryID_SubCategory
ALTER TABLE [GamingSiteDB].Forum.SubCategory DROP CONSTRAINT FK_Roles_SubCategory_Read
ALTER TABLE [GamingSiteDB].Forum.SubCategory DROP CONSTRAINT FK_Roles_SubCategory_Write
ALTER TABLE [GamingSiteDB].Forum.Thread DROP CONSTRAINT FK_User_Thread
ALTER TABLE [GamingSiteDB].Forum.Thread DROP CONSTRAINT FK_SubCategory_Thread
ALTER TABLE [GamingSiteDB].Forum.Thread DROP CONSTRAINT FK_Roles_Thread_Read
ALTER TABLE [GamingSiteDB].Forum.Thread DROP CONSTRAINT FK_Roles_Thread_Write
ALTER TABLE [GamingSiteDB].Forum.ForumEntry DROP CONSTRAINT FK_User_ForumEntry
ALTER TABLE [GamingSiteDB].Forum.ForumEntry DROP CONSTRAINT FK_Thread_ForumEntry
ALTER TABLE [GamingSiteDB].[Site].News DROP CONSTRAINT FK_User_News
ALTER TABLE [GamingSiteDB].[Site].NewsPrictures DROP CONSTRAINT FK_News_NewsPrictures
ALTER TABLE [GamingSiteDB].[Site].Guide DROP CONSTRAINT FK_User_Guide
ALTER TABLE [GamingSiteDB].[Site].GuidePrictures DROP CONSTRAINT FK_Guide_GuidePrictures
ALTER TABLE [GamingSiteDB].Gaming.IPAddressPlayer DROP CONSTRAINT FK_Player_IPAddressPlayer
ALTER TABLE [GamingSiteDB].Gaming.[IPAddressServer] DROP CONSTRAINT FK_Server_IPAddress
ALTER TABLE [GamingSiteDB].Gaming.Server24 DROP CONSTRAINT FK_Server_Server24
ALTER TABLE [GamingSiteDB].Gaming.UniquePlayers24 DROP CONSTRAINT FK_Server24_UniquePlayers24
ALTER TABLE [GamingSiteDB].Gaming.ServerStats DROP CONSTRAINT FK_Server_ServerStats
ALTER TABLE [GamingSiteDB].Gaming.ServerBan DROP CONSTRAINT FK_Server_Ban
ALTER TABLE [GamingSiteDB].Forum.ForumBan DROP CONSTRAINT FK_User_ForumBan
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_User_GameCharacter
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Clothing_GameCharacter_BackpackSlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Clothing_GameCharacter_VestSlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Clothing_GameCharacter_HeadSlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Items_GameCharacter_WatchSlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Items_GameCharacter_CompassSlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Items_GameCharacter_RadioSlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Items_GameCharacter_MapSlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Items_GameCharacter_BinocularSlot 
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Items_GameCharacter_NVGSlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Items_GameCharacter_GPSSlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Weapons_GameCharacter_PrimarySlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Weapons_GameCharacter_SecondarySlot
ALTER TABLE [GamingSiteDB].Gaming.GameCharacter DROP CONSTRAINT FK_Weapons_GameCharacter_LauncherSlot
ALTER TABLE [GamingSiteDB].Gaming.GameStats DROP CONSTRAINT FK_User_GameStats
ALTER TABLE [GamingSiteDB].[Site].[User] DROP CONSTRAINT FK_Role_User
GO

--Tar bort ev data som redan finns i tabellerna, snabbare än delete och återsäller identitykolumnerna till 1. Delete fungerar dock bra om det inte finns mycket data i databasen

truncate table Internal.[Role];
truncate table [Site].[GuestIP]
truncate table Forum.ThreadLock;
truncate table Forum.AccountForumBan;
truncate table [Site].[User];
truncate table Internal.AccountBan;
truncate table [Site].[IPAddress];
truncate table Internal.[Profile];
truncate table Internal.Picture;
truncate table [Site].MessageSend;
truncate table Forum.GlobalCategory;
truncate table Forum.SubCategory;
truncate table Forum.Thread;
truncate table Forum.ForumEntry; 
truncate table [Site].Announcement;
truncate table [Site].News; 
truncate table [Site].NewsPrictures; 
truncate table [Site].Guide; 
truncate table [Site].GuidePrictures; 
truncate table Gaming.IPAddressPlayer; 
truncate table Gaming.[Server];
truncate table Gaming.Players; 
truncate table Gaming.IPAddressServer; 
truncate table Gaming.Server24; 
truncate table Gaming.UniquePlayers24; 
truncate table Gaming.ServerStats;
truncate table Gaming.ServerBan;
truncate table Forum.ForumBan;
truncate table Gaming.GameCharacter; 
truncate table Gaming.GameStats;
GO

--Skapar de främmande nycklarna igen

ALTER TABLE [Site].[User]
ADD CONSTRAINT FK_Role_User foreign key (RoleID) REFERENCES internal.[Role](RoleID) ON DELETE CASCADE

ALTER TABLE Forum.ThreadLock
ADD CONSTRAINT FK_User_ThreadLock FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.ThreadLock
ADD CONSTRAINT FK_Thread_ThreadLock FOREIGN KEY (ThreadID) REFERENCES Forum.Thread(ThreadID)

ALTER TABLE [Site].[IPAddress]
ADD CONSTRAINT FK_User_IPAddress FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Internal.AccountBan
ADD CONSTRAINT FK_User_AccountBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Internal.[Profile]
ADD CONSTRAINT FK_User_Profile FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Internal.[Profile]
ADD CONSTRAINT FK_Picture_Profile FOREIGN KEY (PicAvatarID) REFERENCES Internal.Picture(PictureID)

ALTER TABLE Internal.Picture
ADD CONSTRAINT FK_User_Picture FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Internal.Picture
ADD CONSTRAINT UQ_UserID_Name UNIQUE(UserId, [Name])

ALTER TABLE [Site].MessageSend
ADD CONSTRAINT FK_User_MessageSender FOREIGN KEY (SenderID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE [Site].MessageSend
ADD CONSTRAINT FK_User_UsernameReciver FOREIGN KEY (ReciverID) REFERENCES [Site].[User](UserID)

ALTER TABLE Forum.GlobalCategory
ADD CONSTRAINT FK_User_GlobalCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.GlobalCategory
ADD CONSTRAINT FK_Roles_GlobalCategory FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.SubCategory
ADD CONSTRAINT FK_User_SubCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.SubCategory
ADD CONSTRAINT FK_GlobalCategoryID_SubCategory FOREIGN KEY (GlobalCategoryID) REFERENCES Forum.GlobalCategory(GlobalCategoryID) 

ALTER TABLE Forum.SubCategory
ADD CONSTRAINT FK_Roles_SubCategory_Read FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.SubCategory
ADD CONSTRAINT FK_Roles_SubCategory_Write FOREIGN KEY ([Write]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.Thread
ADD CONSTRAINT FK_User_Thread FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.Thread
ADD CONSTRAINT FK_SubCategory_Thread FOREIGN KEY (SubCategoryID) REFERENCES Forum.SubCategory(SubCategoryID)

ALTER TABLE Forum.Thread
ADD CONSTRAINT FK_Roles_Thread_Read FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.Thread
ADD CONSTRAINT FK_Roles_Thread_Write FOREIGN KEY ([Write]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.AccountForumBan
ADD CONSTRAINT FK_User_AccountForumBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.ForumEntry
ADD CONSTRAINT FK_User_ForumEntry FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.ForumEntry
ADD CONSTRAINT FK_Thread_ForumEntry FOREIGN KEY (ThreadID) REFERENCES Forum.Thread(ThreadID)

ALTER TABLE [Site].News
ADD CONSTRAINT FK_User_News FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE [Site].NewsPrictures
ADD CONSTRAINT FK_News_NewsPrictures FOREIGN KEY (NewsID) REFERENCES [Site].News(NewsID) ON DELETE CASCADE

ALTER TABLE [Site].Guide
ADD CONSTRAINT FK_User_Guide FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE [Site].GuidePrictures
ADD CONSTRAINT FK_Guide_GuidePrictures FOREIGN KEY (GuideID) REFERENCES [Site].Guide(GuideID) ON DELETE CASCADE

ALTER TABLE Gaming.IPAddressPlayer
ADD CONSTRAINT FK_Player_IPAddressPlayer FOREIGN KEY (PlayerID) REFERENCES Gaming.Players(PlayerID) ON DELETE CASCADE

ALTER TABLE Gaming.IPAddressServer
ADD CONSTRAINT FK_Server_IPAddress FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE

ALTER TABLE Gaming.Server24
ADD CONSTRAINT FK_Server_Server24 FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE

ALTER TABLE Gaming.UniquePlayers24
ADD CONSTRAINT FK_Server24_UniquePlayers24 FOREIGN KEY (ServerID) REFERENCES Gaming.Server24(Server24ID) ON DELETE CASCADE

ALTER TABLE Gaming.ServerStats
ADD CONSTRAINT FK_Server_ServerStats FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE

ALTER TABLE Gaming.ServerBan
ADD CONSTRAINT FK_Server_Ban FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE

ALTER TABLE Forum.ForumBan
ADD CONSTRAINT FK_User_ForumBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_User_GameCharacter FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Clothing_GameCharacter_BackpackSlot FOREIGN KEY (BackpackSlot) REFERENCES [Inventory].[Clothing$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Clothing_GameCharacter_VestSlot FOREIGN KEY (VestSlot) REFERENCES [Inventory].[Clothing$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Clothing_GameCharacter_HeadSlot FOREIGN KEY (HeadSlot) REFERENCES [Inventory].[Clothing$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Items_GameCharacter_WatchSlot FOREIGN KEY (WatchSlot) REFERENCES [Inventory].[Items$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Items_GameCharacter_CompassSlot FOREIGN KEY (CompassSlot) REFERENCES [Inventory].[Items$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Items_GameCharacter_RadioSlot FOREIGN KEY (RadioSlot) REFERENCES [Inventory].[Items$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Items_GameCharacter_MapSlot FOREIGN KEY (MapSlot) REFERENCES [Inventory].[Items$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Items_GameCharacter_BinocularSlot FOREIGN KEY (BinocularSlot) REFERENCES [Inventory].[Items$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Items_GameCharacter_NVGSlot FOREIGN KEY (NVGSlot) REFERENCES [Inventory].[Items$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Items_GameCharacter_GPSSlot FOREIGN KEY (GPSSlot) REFERENCES [Inventory].[Items$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Weapons_GameCharacter_PrimarySlot FOREIGN KEY (PrimarySlot) REFERENCES [Inventory].[Weapons$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Weapons_GameCharacter_LauncherSlot FOREIGN KEY (LauncherSlot) REFERENCES [Inventory].[Weapons$]([Class Name])

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK_Weapons_GameCharacter_SecondarySlot FOREIGN KEY (SecondarySlot) REFERENCES [Inventory].[Weapons$]([Class Name])

ALTER TABLE Gaming.GameStats
ADD CONSTRAINT FK_User_GameStats FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE
GO