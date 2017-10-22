USE GamingSiteDB
GO

CREATE PROCEDURE AddMember @Username NVARCHAR(100), 
@Firstname NVARCHAR(1000), @LastName NVARCHAR(1000), 
@Age DATE, @Password NVARCHAR(100), @Email NVARCHAR(300),
@GuestID INT
AS
IF ((SELECT dbo.isIPBanned(@GuestID)) = 1)
BEGIN
Print 'The users IP is banned'
END
IF ((SELECT COUNT(*) FROM [Site].[User] WHERE @Username IN (username)) > 0)
BEGIN
PRINT 'There is already a user with that username, please select a new one'
END
IF ((SELECT COUNT(*) FROM [Site].[User] WHERE @Email IN (Email)) > 0)
BEGIN
PRINT 'There is already a user with that email please pick a new one'
END
ELSE
BEGIN
DECLARE @RoleID INT = 2
DECLARE @Entries INT = 0
DECLARE @RegDate Date = getDate()
OPEN SYMMETRIC KEY PW_Key  
DECRYPTION BY CERTIFICATE PasswordCert;
DECLARE @USERID INT = (SELECT max(UserID) + 1 FROM [Site].[User]) SELECT @USERID AS [UID]
INSERT INTO [Site].[User]
(Username, Firstname, ShowFirstName, Lastname, ShowLastName, Age, ShowAge, PW_Encrypted, Email, ShowEmail, [Amount of entries], RegDATE, Verification, RoleID)
VALUES 
(@Username, @Firstname, DEFAULT, @LastName, DEFAULT, @Age, DEFAULT, null, @Email, DEFAULT, @Entries, @RegDATE, 0, @RoleID)
DECLARE @UID INT = @@IDENTITY
UPDATE [Site].[User]
SET PW_Encrypted = EncryptByKey(Key_GUID('PW_Key'), @Password, 1, HashBytes('SHA1', CONVERT( varbinary, @UID)))
WHERE Username = @Username

INSERT INTO Internal.Picture
(UserID, [Name], DateAdded, Picture)
VALUES
(@UID,'Default Avatar Picture', DEFAULT, DEFAULT)

DECLARE @PicAvatarID INT = @@IDENTITY
INSERT INTO Internal.[Profile]
(UserID, PicAvatarID, [Description])
VALUES
(@UID, @PicAvatarID, null)
Print 'User: ' + @Username + ' Was added'

END
GO

EXECUTE AddMember 'TactiaclBacon', 'Alex', 'Jansson', '1993-04-03','qweqweqweqw' ,'Alex@gmail.com', 1  
EXECUTE AddMember 'BadBacon', 'Tommy', 'Larsson', '1990-08-06','badpw' ,'bot@gmail.com', 3
GO
-- Only for admins
CREATE PROCEDURE AddUser @Username NVARCHAR(100), 
@Firstname NVARCHAR(1000), @LastName NVARCHAR(1000), 
@Age DATE, @Password NVARCHAR(100), @Email NVARCHAR(300), @RoleID INT = 2,
@GuestID INT
AS
IF ((SELECT dbo.isIPBanned(@GuestID)) = 1)
BEGIN
Print 'The users IP is banned'
END
ELSE
BEGIN
DECLARE @Entries INT = 0
DECLARE @RegDate Date = getDate()
OPEN SYMMETRIC KEY PW_Key  
DECRYPTION BY CERTIFICATE PasswordCert;
DECLARE @USERID INT = (SELECT max(UserID) + 1 FROM [Site].[User]) SELECT @USERID AS a
SELECT * FROM [Site].[User]
INSERT INTO [Site].[User]
(Username, Firstname, ShowFirstName, Lastname, ShowLastName, Age, ShowAge, PW_Encrypted, Email, ShowEmail, [Amount of entries], Verification, RegDATE, RoleID)
VALUES 
(@Username, @Firstname, DEFAULT, @LastName, DEFAULT, @Age, DEFAULT, null, @Email, DEFAULT, @Entries, 0, @RegDATE, @RoleID)
DECLARE @UID INT = @@IDENTITY
UPDATE [Site].[User]
SET PW_Encrypted = EncryptByKey(Key_GUID('PW_Key'), @Password, 1, HashBytes('SHA1', CONVERT( varbinary, @UID)))
WHERE Username = @Username

INSERT INTO Internal.Picture
(UserID, [Name], DateAdded, Picture)
VALUES
(@UID,'Default Avatar Picture', DEFAULT, DEFAULT)

DECLARE @PicAvatarID INT = @@IDENTITY
INSERT INTO Internal.[Profile]
(UserID, PicAvatarID, [Description])
VALUES
(@UID, @PicAvatarID, null)
END
GO

