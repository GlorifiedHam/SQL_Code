-- Insert script
USE ForumDB
go

-- Tar bort alla främmande nycklar för att kunna göra en turnacte (återställa identity kolumnerna till 1)
Alter table [dbo].[Role] DROP CONSTRAINT FK__User_Role
Alter table [dbo].[Profile] DROP CONSTRAINT FK__User_Profile
Alter table [dbo].Picture DROP CONSTRAINT FK__User_Picture
Alter table [dbo].MessageSend DROP CONSTRAINT FK__User_MessageSender
Alter table [dbo].MessageSend DROP CONSTRAINT FK__User_UsernameReciver
Alter table [dbo].GlobalCategory DROP CONSTRAINT FK__User_GlobalCategory
Alter table [dbo].SubCategory DROP CONSTRAINT FK__User_SubCategory
Alter table [dbo].SubCategory DROP CONSTRAINT FK__GlobalCategoryID_SubCategory
Alter table [dbo].Thread DROP CONSTRAINT FK__User_Thread
Alter table [dbo].ForumEntry DROP CONSTRAINT FK__ForumEntry_Thread

--Tar bort ev data som redan finns i tabellerna, snabbare 舅 delete och 蚯erst舁ler identitykolumnerna till 1
truncate table [User]; 
truncate table [Role]; 
truncate table [Profile]; 
truncate table Picture; 
truncate table MessageSend; 
truncate table GlobalCategory; 
truncate table SubCategory; 
truncate table Thread; 
truncate table ForumEntry; 
truncate table AmountOfCategorys;

--Skapar de främmande nycklarna igen
Alter table [Role]
Add constraint FK__User_Role foreign key (UserID)
references [User](UserID)

Alter table [Profile]
Add constraint FK__User_Profile foreign key (UserID) 
references [User](UserID)

Alter table Picture
Add constraint FK__User_Picture foreign key (UserID) 
references [User](UserID) 

Alter table MessageSend
Add constraint FK__User_MessageSender foreign key (UsernameSender) 
references [User](Username)

Alter table MessageSend
Add constraint FK__User_UsernameReciver foreign key (UsernameReciver) 
references [User](Username)

Alter table GlobalCategory
Add constraint FK__User_GlobalCategory foreign key (UserID) references [User](UserID)

Alter table GlobalCategory
Add constraint FK__User_SubCategory foreign key (UserID) references [User](UserID)

Alter table GlobalCategory
Add constraint FK__GlobalCategoryID_SubCategory foreign key (GlobalCategoryID) references GlobalCategory(GlobalCategoryID) 

Alter table Thread
Add constraint FK__User_Thread foreign key (UserID) references [User](UserID)

Alter table ForumEntry
Add constraint FK__User_ForumEntry foreign key (UserID) references [User](UserID)

Alter table ForumEntry
Add constraint FK__Thread_ForumEntry foreign key (ThreadID) references Thread(ThreadID)
go

-- Insert into user
Insert into [User]
Values
('GlorifiedHam','Alexander','Jansson','1994-04-04', 'War2Glory', 'Alexanderjan94@gmail.com',0,0704335884, default)

Insert into [User]
Values
('Rival','Jimmie','Petersson','1993-09-05','WowIsBest213', 'Jimmy@gmail.com',0,0765437869, '2017-7-31')

Insert into [User]
Values
('Wardawg','Tom','karlsson','1990-11-12', 'qwerty123', 'Tom@live.se',0,0705467781, default)

Insert into [User]
Values
('User4','Sara','Woodlow','1991-06-25', 'asdfghjkl123', 'Saralee@hotmail.com',0,0736127743, default)

Insert into [User]
Values
('User5','Klara','cicelot','1996-08-01', 'Yellowflag3', 'Klarkie@gmail.com',0,0709651126, default)

Insert into [User]
Values
('User6','Johanna','wromba', '1989-03-18','UtopiaLamb', 'JohannaW93@hotmail.com',0,0765431176, default)

--Insert into Role

Insert into [Role]
Values
(1, 'SuperAdmin'),
(2,'Admin'),
(3,default),
(4, 'VIP'),
(5,default),
(6,default)

--Insert profile

Declare @picture1 varbinary = (Select * FROM Openrowset(Bulk'D:/Programming/SQL/ForumDB/Images/Games.PNG',SINGLE_BLOB )) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
Insert into [Profile]
Values  (1, @picture1, 'Hi I am the one that made this site :)')

Declare @picture2 varbinary = (Select * FROM Openrowset(Bulk'D:/Programming/SQL/ForumDB/Images/CSGO.jpg',SINGLE_BLOB )) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
Insert into [Profile]
Values  (1, @picture2, 'I am an admin here on ****')

INSERT INTO [Profile]
Values  (1, default, 'Hi I am the one that made this site :)')

INSERT INTO [Profile]
Values  (1, default, 'Hi I am the one that made this site :)')

INSERT INTO [Profile]
Values  (1, default, 'Hi I am the one that made this site :)')

INSERT INTO [Profile]
Values  (1, default, 'Hi I am the one that made this site :)')

--Insert into pictures

Declare @picture4 varbinary = (Select * FROM Openrowset(Bulk'D:/Programming/SQL/ForumDB/Images/CSGO.jpg',SINGLE_BLOB )) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
Insert into [Picture]
values (1, @picture4)


--Insert into message
INSERT INTO MessageSend
values (1,2,'What should we do next?','Next step for the site', default)

INSERT INTO MessageSend
values (3,4,'Hi','Hi', default)

INSERT INTO MessageSend
values (2,6,'Do you like the site?','The site', default)

INSERT INTO GlobalCategory
Values (default,2,'For he Staff')

INSERT INTO GlobalCategory
Values (default,1,'Crew')

INSERT INTO GlobalCategory
Values (default,1,'Game Discussion' )

INSERT INTO GlobalCategory
Values (default,1,'Rules' )

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




















