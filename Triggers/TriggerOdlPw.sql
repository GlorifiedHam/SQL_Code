-- Trigger oldPassWord

USE GamingSiteDB
go

CREATE TRIGGER oldPassword
ON [User]
AFTER Update
AS
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES Where TABLE_SCHEMA = 'TheSchema' AND TABLE_NAME = 'OldPassword')
BEGIN

Create Table OldPassword(
OldPasswordID int not null IDENTITY PRIMARY key,
OldPassword nvarchar(100) not null,
UserID int foreign key (UserID) references [User](UserID)
)
Insert into OldPassword (OldPassword, UserID) SELECT [Password], UserID from deleted; 

END

ELSE
BEGIN

Insert into OldPassword (OldPassword, UserID) SELECT [Password], UserID from deleted; 

END

 