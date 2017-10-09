-- Turnicate Scripttruncate table
USE ForumDB
GO

-- Tar bort alla främmande nycklar för att kunna göra en turnacte (återställa identity kolumnerna till 1)

ALTER TABLE [ForumDb].Internal.AccountBan DROP CONSTRAINT FK__User_AccountBan
ALTER TABLE [ForumDb].[Site].[IPAddress] DROP CONSTRAINT FK__User_IPAddress
ALTER TABLE [ForumDb].Internal.[Profile] DROP CONSTRAINT FK__User_Profile
ALTER TABLE [ForumDb].Internal.[Profile] DROP CONSTRAINT FK__Picture_Profile
ALTER TABLE [ForumDb].Internal.Picture DROP CONSTRAINT FK__User_Picture
ALTER TABLE [ForumDb].Internal.Picture DROP CONSTRAINT UQ_UserID_Name
ALTER TABLE [ForumDB].[Site].MessageSend DROP CONSTRAINT FK__User_MessageSender
ALTER TABLE [ForumDB].[Site].MessageSend DROP CONSTRAINT FK__User_UsernameReciver
ALTER TABLE [ForumDB].Forum.GlobalCategory DROP CONSTRAINT FK__User_GlobalCategory
ALTER TABLE [ForumDB].Forum.GlobalCategory DROP CONSTRAINT FK_Roles_GlobalCategory
ALTER TABLE [ForumDB].Forum.SubCategory DROP CONSTRAINT FK__User_SubCategory
ALTER TABLE [ForumDB].Forum.SubCategory DROP CONSTRAINT FK__GlobalCategoryID_SubCategory
ALTER TABLE [ForumDB].Forum.SubCategory DROP CONSTRAINT FK_Roles_SubCategory_Read
ALTER TABLE [ForumDB].Forum.SubCategory DROP CONSTRAINT FK_Roles_SubCategory_Write
ALTER TABLE [ForumDB].Forum.Thread DROP CONSTRAINT FK__User_Thread
ALTER TABLE [ForumDB].Forum.Thread DROP CONSTRAINT FK__SubCategory_Thread
ALTER TABLE [ForumDB].Forum.Thread DROP CONSTRAINT FK_Roles_Thread_Read
ALTER TABLE [ForumDB].Forum.Thread DROP CONSTRAINT FK_Roles_Thread_Write
ALTER TABLE [ForumDB].Forum.ForumEntry DROP CONSTRAINT FK__User_ForumEntry
ALTER TABLE [ForumDB].Forum.ForumEntry DROP CONSTRAINT FK__Thread_ForumEntry
ALTER TABLE [ForumDB].[Site].News DROP CONSTRAINT FK__User_News
ALTER TABLE [ForumDB].[Site].NewsPrictures DROP CONSTRAINT FK__News_NewsPrictures
ALTER TABLE [ForumDB].[Site].Guide DROP CONSTRAINT FK__User_Guide
ALTER TABLE [ForumDB].[Site].GuidePrictures DROP CONSTRAINT FK__Guide_GuidePrictures
ALTER TABLE [ForumDB].Gaming.Players DROP CONSTRAINT FK__IPAdressPlayer_Players
ALTER TABLE [ForumDB].Gaming.Players DROP CONSTRAINT FK__Server_Players
ALTER TABLE [ForumDB].Gaming.[IPAddressServer] DROP CONSTRAINT FK__Server_IPAddress
ALTER TABLE [ForumDB].Gaming.Server24 DROP CONSTRAINT FK__Server_Server24
ALTER TABLE [ForumDB].Gaming.UniquePlayers24 DROP CONSTRAINT FK__Server24_UniquePlayers24
ALTER TABLE [ForumDB].Gaming.ServerStats DROP CONSTRAINT FK__Server_ServerStats
ALTER TABLE [ForumDB].Gaming.ServerBan DROP CONSTRAINT FK__Server_Ban
ALTER TABLE [ForumDB].Forum.ForumBan DROP CONSTRAINT FK__User_ForumBan
ALTER TABLE [ForumDB].Gaming.VestSlot DROP CONSTRAINT FK__Clothing_VestSlot
ALTER TABLE [ForumDB].Gaming.HeadSlot DROP CONSTRAINT FK__Clothing_HeadSlot
ALTER TABLE [ForumDB].Gaming.BackpackSlot DROP CONSTRAINT FK__Clothing_BackpackSlot
ALTER TABLE [ForumDB].Gaming.CompassSlot DROP CONSTRAINT FK__Items_CompassSlot
ALTER TABLE [ForumDB].Gaming.GPSSlot DROP CONSTRAINT FK__Items_GPSsSlot
ALTER TABLE [ForumDB].Gaming.WatchSlot DROP CONSTRAINT FK__Items_WatchSlot
ALTER TABLE [ForumDB].Gaming.RadioSlot DROP CONSTRAINT FK__Items_RadioSlot
ALTER TABLE [ForumDB].Gaming.MapSlot DROP CONSTRAINT FK__Items_MapSlot
ALTER TABLE [ForumDB].Gaming.BinocularSlot DROP CONSTRAINT FK__Items_BinocularSlot
ALTER TABLE [ForumDB].Gaming.NVGSlot DROP CONSTRAINT FK__Items_NVGSlot
ALTER TABLE [ForumDB].Gaming.PrimarySlot DROP CONSTRAINT FK__Weapons_PrimarySlot
ALTER TABLE [ForumDB].Gaming.SecondarySlot DROP CONSTRAINT FK__Weapons_SecondarySlot
ALTER TABLE [ForumDB].Gaming.LauncherSlot DROP CONSTRAINT FK__Weapons_LauncherSlot
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__User_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__BackpackSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__VestSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__HeadSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__WatchSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__CompassSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__RadioSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__MapSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__BinocularSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__NVGSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__PrimarySlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__GPSSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameCharacter DROP CONSTRAINT FK__LauncherSlot_GameCharacter
ALTER TABLE [ForumDB].Gaming.GameStats DROP CONSTRAINT FK__User_GameStats
ALTER TABLE [ForumDb].[Site].[User] DROP CONSTRAINT FK__Role_User
GO

--Tar bort ev data som redan finns i tabellerna, snabbare än delete och återsäller identitykolumnerna till 1. Delete fungerar dock bra om det inte finns mycket data i databasen

truncate table Internal.[Role];
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
truncate table [Gaming].[IPAdressPlayer]; 
truncate table Gaming.[Server];
truncate table Gaming.Players; 
truncate table Gaming.IPAdressServer; 
truncate table Gaming.Server24; 
truncate table Gaming.UniquePlayers24; 
truncate table Gaming.ServerStats;
truncate table Gaming.ServerBan;
truncate table Forum.ForumBan;
truncate table Gaming.VestSlot;
truncate table Gaming.HeadSlot;
truncate table Gaming.BackpackSlot;
truncate table Gaming.CompassSlot;
truncate table Gaming.GPSSlot;
truncate table Gaming.WatchSlot; 
truncate table Gaming.RadioSlot; 
truncate table Gaming.MapSlot; 
truncate table Gaming.BinocularSlot; 
truncate table Gaming.NVGSlot; 
truncate table Gaming.PrimarySlot; 
truncate table Gaming.SecondarySlot; 
truncate table Gaming.LauncherSlot; 
truncate table Gaming.GameCharacter; 
truncate table Gaming.GameStats;
GO

--Skapar de främmande nycklarna igen

ALTER TABLE [Site].[User]
ADD CONSTRAINT FK__Role_User foreign key (RoleID) REFERENCES internal.[Role](RoleID) ON DELETE CASCADE

ALTER TABLE [Site].[IPAddress]
ADD CONSTRAINT FK__User_IPAdress FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Internal.AccountBan
ADD CONSTRAINT FK__User_AccountBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Internal.[Profile]
ADD CONSTRAINT FK__User_Profile FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Internal.[Profile]
ADD CONSTRAINT FK__Picture_Profile FOREIGN KEY (PicAvatarID) REFERENCES Internal.Picture(PictureID)

ALTER TABLE Internal.Picture
ADD CONSTRAINT FK__User_Picture FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Internal.Picture
ADD CONSTRAINT UQ_UserID_Name UNIQUE(UserId, [Name])

ALTER TABLE [Site].MessageSend
ADD CONSTRAINT FK__User_MessageSender FOREIGN KEY (SenderID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE [Site].MessageSend
ADD CONSTRAINT FK__User_UsernameReciver FOREIGN KEY (ReciverID) REFERENCES [Site].[User](UserID)

ALTER TABLE Forum.GlobalCategory
ADD CONSTRAINT FK__User_GlobalCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.GlobalCategory
ADD CONSTRAINT FK_Roles_GlobalCategory FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.SubCategory
ADD CONSTRAINT FK__User_SubCategory FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.SubCategory
ADD CONSTRAINT FK__GlobalCategoryID_SubCategory FOREIGN KEY (GlobalCategoryID) REFERENCES Forum.GlobalCategory(GlobalCategoryID) 

ALTER TABLE Forum.SubCategory
ADD CONSTRAINT FK_Roles_SubCategory_Read FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.SubCategory
ADD CONSTRAINT FK_Roles_SubCategory_Write FOREIGN KEY ([Write]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.Thread
ADD CONSTRAINT FK__User_Thread FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.Thread
ADD CONSTRAINT FK__SubCategory_Thread FOREIGN KEY (SubCategoryID) REFERENCES Forum.SubCategory(SubCategoryID)

ALTER TABLE Forum.Thread
ADD CONSTRAINT FK_Roles_Thread_Read FOREIGN KEY ([Read]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.Thread
ADD CONSTRAINT FK_Roles_Thread_Write FOREIGN KEY ([Write]) REFERENCES Internal.[Role](RoleID)

ALTER TABLE Forum.ForumEntry
ADD CONSTRAINT FK__User_ForumEntry FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Forum.ForumEntry
ADD CONSTRAINT FK__Thread_ForumEntry FOREIGN KEY (ThreadID) REFERENCES Forum.Thread(ThreadID)

ALTER TABLE [Site].News
ADD CONSTRAINT FK__User_News FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE [Site].NewsPrictures
ADD CONSTRAINT FK__News_NewsPrictures FOREIGN KEY (NewsID) REFERENCES [Site].News(NewsID) ON DELETE CASCADE

ALTER TABLE [Site].Guide
ADD CONSTRAINT FK__User_Guide FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE [Site].GuidePrictures
ADD CONSTRAINT FK__Guide_GuidePrictures FOREIGN KEY (GuideID) REFERENCES [Site].Guide(GuideID) ON DELETE CASCADE

ALTER TABLE Gaming.Players
ADD CONSTRAINT FK__IPAdressPlayer_Players FOREIGN KEY (IPAdressPlayerID) REFERENCES [Gaming].[IPAdressPlayer](IPAdressPlayerID) ON DELETE CASCADE

ALTER TABLE Gaming.Players
ADD CONSTRAINT FK__Server_Players FOREIGN KEY (LastServerID) REFERENCES [Gaming].[Server](ServerID)

ALTER TABLE Gaming.IPAddressServer
ADD CONSTRAINT FK__Server_IPAddress FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE

ALTER TABLE Gaming.Server24
ADD CONSTRAINT FK__Server_Server24 FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE

ALTER TABLE Gaming.UniquePlayers24
ADD CONSTRAINT FK__Server24_UniquePlayers24 FOREIGN KEY (ServerID) REFERENCES Gaming.Server24(Server24ID) ON DELETE CASCADE

ALTER TABLE Gaming.ServerStats
ADD CONSTRAINT FK__Server_ServerStats FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE

ALTER TABLE Gaming.ServerBan
ADD CONSTRAINT FK__Server_Ban FOREIGN KEY (ServerID) REFERENCES Gaming.[Server](ServerID) ON DELETE CASCADE

ALTER TABLE Forum.ForumBan
ADD CONSTRAINT FK__User_ForumBan FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Gaming.VestSlot
ADD CONSTRAINT FK__Clothing_VestSlot FOREIGN KEY (Vest_Class_Name) REFERENCES [Inventory].[Clothing$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.HeadSlot
ADD CONSTRAINT FK__Clothing_HeadSlot FOREIGN KEY (Headgear_Class_Name) REFERENCES [Inventory].[Clothing$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.BackpackSlot
ADD CONSTRAINT FK__Clothing_BackpackSlot FOREIGN KEY (Backpack_Class_Name) REFERENCES [Inventory].[Clothing$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.CompassSlot
ADD CONSTRAINT FK__Items_CompassSlot FOREIGN KEY (Compass_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.GPSSlot
ADD CONSTRAINT FK__Items_GPSsSlot FOREIGN KEY (GPS_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.WatchSlot
ADD CONSTRAINT FK__Items_WatchSlot FOREIGN KEY (Watch_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.RadioSlot
ADD CONSTRAINT FK__Items_RadioSlot FOREIGN KEY (Radio_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.MapSlot
ADD CONSTRAINT FK__Items_MapSlot FOREIGN KEY (Map_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.BinocularSlot
ADD CONSTRAINT FK__Items_BinocularSlot FOREIGN KEY (Binocular_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.NVGSlot
ADD CONSTRAINT FK__Items_NVGSlot FOREIGN KEY (NVG_Class_Name) REFERENCES [Inventory].[Items$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.PrimarySlot
ADD CONSTRAINT FK__Weapons_PrimarySlot FOREIGN KEY (Primary_Class_Name) REFERENCES [Inventory].[Weapons$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.SecondarySlot
ADD CONSTRAINT FK__Weapons_SecondarySlot FOREIGN KEY (Secondary_Class_Name) REFERENCES [Inventory].[Weapons$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.LauncherSlot
ADD CONSTRAINT FK__Weapons_LauncherSlot FOREIGN KEY (Launcher_Class_Name) REFERENCES [Inventory].[Weapons$]([Class Name]) ON DELETE CASCADE

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__User_GameCharacter FOREIGN KEY (UserID) REFERENCES [Site].[User](UserID) ON DELETE CASCADE

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__BackpackSlot_GameCharacter FOREIGN KEY (BackpackSID) REFERENCES Gaming.BackpackSlot(BackpackSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__VestSlot_GameCharacter FOREIGN KEY (VestSID) REFERENCES Gaming.VestSlot(VestSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__HeadSlot_GameCharacter FOREIGN KEY (HeadSID) REFERENCES Gaming.HeadSlot(HeadSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__WatchSlot_GameCharacter FOREIGN KEY (WatchSID) REFERENCES Gaming.WatchSlot(WatchSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__CompassSlot_GameCharacter FOREIGN KEY (CompassSID) REFERENCES Gaming.CompassSlot(CompassSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__RadioSlot_GameCharacter FOREIGN KEY (RadioSID) REFERENCES Gaming.RadioSlot(RadioSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__MapSlot_GameCharacter FOREIGN KEY (MapSID) REFERENCES Gaming.MapSlot(MapSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__BinocularSlot_GameCharacter FOREIGN KEY (BinocularSID) REFERENCES Gaming.BinocularSlot(BinocularSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__NVGSlot_GameCharacter FOREIGN KEY (NVGSID) REFERENCES Gaming.NVGSlot(NVGSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__PrimarySlot_GameCharacter FOREIGN KEY (PrimarySID) REFERENCES Gaming.PrimarySlot(PrimarySID) 

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__GPSSlot_GameCharacter FOREIGN KEY (GPSSID) REFERENCES Gaming.GPSSlot(GPSSID)

ALTER TABLE Gaming.GameCharacter
ADD CONSTRAINT FK__LauncherSlot_GameCharacter FOREIGN KEY (LauncherSID) REFERENCES Gaming.LauncherSlot(LauncherSID)
GO