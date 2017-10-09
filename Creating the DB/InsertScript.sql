-- Insert script
USE ForumDB
go

-- Insert into Role
INSERT INTO [Internal].Role
Values
(1,'Guest') , (2, 'Member'), (3,'Donator'), (4,'VIP'), (5,'SuperVIP'), (6,'Moderator'), (7,'ForumModerator'), (8, 'ServerModerator'), (9, 'SuperModerator'), (10,'Admin'), (11, 'ForumAdmin'), (12, 'ServerAdmin'), (13, 'SuperAdmin') -- Might change this (Need something under superAdmin) , admin/moderator might also need to be changed
GO
-- Insert into user
Insert into [Site].[User]
([Username], [Firstname], [Lastname], [Age], [Password], [Email], [Amount of entries], [Phonenumber], [RegDATE], [RoleID])
Values
('GlorifiedHam','Alexander','Jansson','1994-04-04', 'War2Glory', 'Alexanderjan94@gmail.com',0,0704335884, default, 13),
('Rival','Jimmie','Petersson','1993-09-05','WowIsBest213', 'Jimmy@gmail.com',0,0765437869, '2017-7-31', 12),
('Wardawg','Tom','karlsson','1967-06-19', 'qwerty123', 'Tom@live.se',0,0705467781, default, 2),
('SilverStorm','Amanda','Ekström','1996-03-22', 'qwerty123', 'Amanda@live.se',0,2515469442, default, 5),
('LongTime','Sara','Hewitt','1990-11-12', 'qwerty123', 'Sara@gmail.com',0,9495694371, default, 3),
('Qwerty90','Anders','Pinnelli','1992-10-04', 'qwerty123', 'Anders@hotmail.com',0,6719251352, default, 4),
('BroMan','Erik','Pinnelli','1985-07-23', 'qwerty123', 'Erik@hotmail.se',0,2269062721, default, 2),
('DropKick','Klara','Woodlow','1991-06-25', 'asdfghjkl123', 'Saralee@hotmail.com',0,0736127743, default, 2),
('Loop96','Doris','cicelot','1996-08-01', 'Yellowflag3', 'Klarkie@gmail.com',0,0709651126, default, 3),
('WoopWoop11','Johanna','wromba', '1989-03-18','UtopiaLamb', 'JohannaW93@hotmail.com',0,0765431176, default,2),
('BadUser1', 'Tolvin', 'Blovich', '1992-05-17', 'LoveMyPW2', 'Tolvin@gmail.com',0,076453123, default,2),
('BadUser2', 'Matilda', 'Passito', '1991-01-23', 'PWPWPWPW1', 'Matilda@gmail.com',0,073423473, default,2)
GO

-- Insert banned users
INSERT INTO Internal.AccountBan
(UserID, Reason, Severity, HowLong, BanDate)
VALUES 
(11,'Spamm Account', 10, Cast('2317-01-01' AS DATETIME), getDate() ),
(12,'Harassment',3, CAST('2017-11-05' AS DATETIME), getDate())
GO

-- INSERT User IP
INSERT INTO [Site].[IPAddress]
(Group8, Group7 ,Group6, Group5, Group4, Group3, Group2, Group1, Network, UserID)
VALUES
(127, 0, 0, 0, 4, 22, 222, 54, NULL, 1), -- IPv6
(28, 11, 1675, 0, 45673, 201, 2, 7363, 33, 2), -- IPv6
(NULL, NULL, NULL, NULL, 82, 144, 3, 53, NULL, 3), -- v4
(NULL, NULL, NULL, NULL, 196, 154, 234, 11, 24, 4) -- v4)
GO

-- INSERT User Pictures 
INSERT INTO Internal.Picture 
(UserID, Picture, [Name], DateAdded)
VALUES
(1, Default, 'DefaultAvatar', '2017-10-07'),
(2, Default, 'DefaultAvatar', DEFAULT),	
(3, Default, 'DefaultAvatar', DEFAULT),
(4, Default, 'DefaultAvatar', DEFAULT),
(5, Default, 'DefaultAvatar', DEFAULT),
(6, Default, 'DefaultAvatar', DEFAULT),
(7, Default, 'DefaultAvatar', DEFAULT),
(8, Default, 'DefaultAvatar', DEFAULT),
(9, Default, 'DefaultAvatar', DEFAULT),
(10, Default, 'DefaultAvatar', DEFAULT),
(11, Default, 'DefaultAvatar', DEFAULT),
(12, Default, 'DefaultAvatar', DEFAULT)

Declare @picture1 varbinary(MAX) = (Select * FROM Openrowset(Bulk N'D:/Programming/SQL/ForumDB/Images/Games.jpg',SINGLE_BLOB ) AS SRC) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
VALUES  (1, @picture1, 'GamingAvatar', DEFAULT)

--'Hi I am the one that made this site :)'

Declare @picture2 varbinary(MAX) = (Select * FROM Openrowset(Bulk N'D:/Programming/SQL/ForumDB/Images/Games.jpg',SINGLE_BLOB ) AS Controller) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
VALUES  (1, @picture2, 'GamingController',DEFAULT)

Declare @picture3 varbinary(MAX) = (Select * FROM Openrowset(Bulk'D:/Programming/SQL/ForumDB/Images/ChessKing.jpeg',SINGLE_BLOB ) AS King) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
values (2, @picture3,'King',DEFAULT)

Declare @picture4 varbinary(MAX) = (Select * FROM Openrowset(Bulk'D:/Programming/SQL/ForumDB/Images/Code.jpg',SINGLE_BLOB ) AS Code) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
values (3, @picture4,'Code', DEFAULT)

-- INSERT sent messages 
INSERT INTO [Site].MessageSend
(SenderID, ReciverID, DateSent, [Message], title, [read])
VALUES
(1, 2, '2017-08-10 08:00', '<h2>Hello</h2> \n Do you have any ideas for new features? Have you made any updates to the testing gaming server? For some reason I cant open the changelog :P', 'Updates', 1),
(1, 2, '2017-08-15 12:32', 'Hi again \n I still have the same problem, sorry that I am pushy ^^', 'Updates V2', 1),
(2 ,1, '2017-08-16 15:45', '<3>Hi Sorry</h3>, I have not been home for some days. \n Well I dont have any new ideas at the moment. I have made some changes to the test gaming server. The changelog should be working now, so I am not going to send everything here again. Please send me text if you still cant see the changes to the changelog, but like I said it should be working now.', 'RE: Updates V2', 1),
(1, 2, '2017-08-16 16:33', 'Thanks \n The changelog is now working, gj :)', 'RE: Updates V2', 1),
(3, 4, '2017-08-20 08:11', 'Hello all good?', 'Hi', 0),
(5, 4, '2017-08-22 11:10', 'Hi \n Wanna talk?', 'Hello', 0),
(6, 7, '2017-08-25 15:07', 'Now indulgence dissimilar for his thoroughly has terminated. Agreement offending commanded my an. Change wholly say why eldest period. Are projection put celebrated particular unreserved joy unsatiable its. In then dare good am rose bred or. On am in nearer square wanted.' , 'Indulgence', 1),
(7, 6, '2017-08-27 06:35', 'Do to be agreeable conveying oh assurance. Wicket longer admire do barton vanity itself do in it. Preferred to sportsmen it engrossed listening. Park gate sell they west hard for the. Abode stuff noisy manor blush yet the far. Up colonel so between removed so do. Years use place decay sex worth drift age. Men lasting out end article express fortune demands own charmed. About are are money ask how seven.', 'Title', 0),
(3, 7, '2017-08-29 21:21', 'Fulfilled direction use continual set him propriety continued. Saw met applauded favourite deficient engrossed concealed and her. Concluded boy perpetual old supposing. Farther related bed and passage comfort civilly. Dashwoods see frankness objection abilities the. As hastened oh produced prospect formerly up am. Placing forming nay looking old married few has. Margaret disposed add screened rendered six say his striking confined.', 'Confined', 1),
(1, 8, '2017-09-01 10:16', 'Quick six blind smart out burst. Perfectly on furniture dejection determine my depending an to. Add short water court fat. Her bachelor honoured perceive securing but desirous ham required. Questions deficient acuteness to engrossed as. Entirely led ten humoured greatest and yourself. 
Besides ye country on observe. She continue appetite endeavor she judgment interest the met. For she surrounded motionless fat resolution may.', 'Water', 1),
(1, 7, '2017-09-02 19:17', 'Of on affixed civilly moments promise explain fertile in. Assurance advantage belonging happiness departure so of. Now improving and one sincerity intention allowance commanded not. Oh an am frankness be necessary earnestly advantage estimable extensive. Five he wife gone ye. Mrs suffering sportsmen earnestly any. In am do giving to afford parish settle easily garret.', 'Garret!', 1),
(1, 6, '2017-09-03 09:25', '
His exquisite sincerity education shameless ten earnestly breakfast add. So we me unknown as improve hastily sitting forming. Especially favourable compliment but thoroughly unreserved saw she themselves. Sufficient impossible him may ten insensible put continuing. Oppose exeter income simple few joy cousin but twenty. Scale began quiet up short wrong in in. Sportsmen shy forfeited engrossed may can.', 'Sportsmen', 1),
(6, 1, '2017-09-03 12:14', 'Surprise steepest recurred landlord mr wandered amounted of. Continuing devonshire but considered its. Rose past oh shew roof is song neat. Do depend better praise do friend garden an wonder to. Intention age nay otherwise but breakfast. Around garden beyond to extent by. ', 'Surprise', 0)
GO

-- INSERT GlobalCategory
INSERT INTO Forum.GlobalCategory
(UserID, [Read], GlobalCategoryName)
VALUES
(1, 0, 'Rules'),
(1, 0, 'Staff'),
(1, 0, 'Servers'),
(1, 0, 'Tips & Tricks'),
(1, 0, 'General Discussion'),
(1, 0, 'Suggestions' ),
(1, 6, 'Staff Discussion')
GO

-- INSERT SubCategory
INSERT INTO Forum.SubCategory
([Read], [Write], UserID, SubCategoryName, GlobalCategoryID)
VALUES
(1, 10, 1, 'Forum Rules', 1),
(1, 10, 1, 'Server Rules', 1),
(6, 10, 1, 'Staff Rules', 1),
(1, 6, 1, 'Staff Introduction', 2),
(2, 6, 1, 'Alpha Server', 3),
(2, 6, 1, 'Bravo Server', 3),
(2, 6, 1, 'Zed Server', 3),
(1, 2, 1, 'Game Tips', 4),
(1, 2, 1, 'Other Tips', 4),
(1, 2, 1, 'Discussions', 5),
(1, 2, 1, 'Stories', 5),
(1, 2, 1, 'Alpha Server', 6), 
(1, 2, 1, 'Bravo Server', 6), 
(1, 2, 1, 'Zed Server', 6), 
(1, 2, 1, 'Site', 6), 
(1, 2, 1, 'Forum', 6), 
(1, 2, 1, 'Other', 6), 
(6, 6, 1, 'Staff Rules', 7),
(6, 6, 1, 'Discussions', 7),
(6, 6, 1, 'Admin Discussions', 10)
GO

INSERT INTO Forum.Thread
([Read], [Write], UserID, ThreadTitle, SubCategoryID, Locked)
VALUES
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1)
GO

INSERT INTO Forum.ForumEntry
(UserID, [Entry], UserID, ThreadID, Edited, LastEdited, Created)
VALUES
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1)
GO

INSERT INTO [Site].Announcement
([Message], Kind)
VALUES
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1),
(1)
GO

INSERT INTO [Site].News
(UserID, [Text], DatePosted, Likes, clicks)
VALUES
(1),
(1)

INSERT INTO [Site].NewsPrictures
(Picture, NewsID)
VALUES
(),
()

INSERT INTO [Site].Guide
(UserID, [Text], DatePosted, Likes, clicks)
VALUES
(1),
(1)

INSERT INTO [Site].GuidePrictures
(Picture, GuideID)
VALUES
(),
()

INSERT INTO Gaming.[Server]
([Name], [Online], LastCHECK, MaxPlayers, NumberOfPlayers, UniquePlayers, HeadMod, Map, Mods, LastServerReset, Resets, Bans, MoneyCirculatedInShop, MissionsDone, PlayerKills, PlayerAIKills, AIPlayerKills )
VALUES
('GreasyFZ Exile Holm', 1),
('GreasyFZ Exile Altis', 1),
('GreasyFz Exile Cherno', 1),
('GreasyFZ KingOfTheHill Altis', 1)

INSERT INTO Gaming.[IPAddressServer]
(Group8, Group7, Group6, Group5, Group4, Group3, Group2, Group1, Network, ServerID)
VALUES
(),
()


--Insert profile


--Insert into message
INSERT INTO MessageSend
values (1,2,'What should we do next?','Next step for the site', default)

INSERT INTO MessageSend
values (3,4,'Hi','Hi', default)

INSERT INTO MessageSend
values (2,6,'Do you like the site?','The site', default)

INSERT INTO SubCategory
Values(default,default,1,'Forum Roles',1)

INSERT INTO SubCategory
Values(default,default,1,'Future',2)

INSERT INTO SubCategory
Values(default,default,1,'Staff Introduction',3)

INSERT INTO SubCategory
Values (default,default, 'Arma3', 4)

INSERT INTO SubCategory
Values (default,default, 'PUBG' ,4)

INSERT INTO SubCategory
Values (default,default, 'RPG Games', 4)

INSERT INTO SubCategory
Values (default,default, 'MOBA Games', 4) 

INSERT INTO SubCategory
Values (default,default, 'FPS Games', 4)

INSERT INTO SubCategory
Values (default,default, 'Forum Rules', 5)

Insert INTO Thread
Values(default,default,1,'Admin: GlorifiedHam',3, default,default)

INSERT INTO Thread
Values(default,default,2,'Design',2,default,default)

INSERT INTO Thread
Values(default,default,2,'Languages',1,default,default)

INSERT INTO Thread
Values(default,default,1,'',)

INSERT INTO ForumEntry
Values(1,'Hello /E 
		  I am a 23 year old programming student that loves coding. /E
		  I hope to be able to regurlarily push out tweaks and updates, but please be patient. /E
		  Please use the <a>suggestion</> thread if you have any ideas or tips for the future of this site. ',1)


INSERT INTO ForumEntry
Values(2,'Maybe you could make a cool gif background someday?',2)
INSERT INTO ForumEntry
Values(1,'Sure it could be a fun thing to do',2)

INSERT INTO ForumEntry
Values(1,'I will try to add more languages as the site progrecess. If you want a specific language added, please leave a post with the specific language down below.',3)
INSERT INTO ForumEntry
Values(3,'I would like German as an option',3)
INSERT INTO ForumEntry
Values(3,'Well spanish would be nice, but English is enough for me :)',4)




















