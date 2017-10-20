-- Trigger deleteUser

USE GamingSiteDB
go

CREATE TRIGGER deleteUser
ON [User]
AFTER delete
AS
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES Where TABLE_SCHEMA = 'TheSchema' AND TABLE_NAME = 'deletedUsers')
BEGIN

Create Table deletedUsers(
deletedUsersID int identity primary key,
UserID int,
Username nvarchar(100) not null unique,
Firstname nvarchar(1000) not null,
Lastname nvarchar(1000) not null,
[Password] nvarchar(100) not null,--Make an old password table, with a trigger, that only saves one pw back?  
Email nvarchar(300) not null,
[Amount of entries] int, --Trigger on creating an entry
Phonenumber varchar(22) Check(Phonenumber > 0), 
RegDate date DEFAULT GETDATE()
)

Insert into deletedUsers (UserID, Username, Firstname, Lastname, [Password], Email, [Amount of entries],Phonenumber, RegDate) SELECT UserID, Username, Firstname, Lastname, [Password], Email, [Amount of entries],Phonenumber, RegDate from Deleted; 

END

ELSE
BEGIN

Insert into deletedUsers (UserID, Username, Firstname, Lastname, [Password], Email, [Amount of entries],Phonenumber, RegDate) SELECT UserID, Username, Firstname, Lastname, [Password], Email, [Amount of entries],Phonenumber, RegDate from Deleted;

END

 