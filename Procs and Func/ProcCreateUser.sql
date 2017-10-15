CREATE PROCEDURE AddMember @Username NVARCHAR(100), 
@Firstname NVARCHAR(1000), @LastName NVARCHAR(1000), 
@Age DATE, @Password NVARCHAR(100), @Email NVARCHAR(300), @Phonenumber VARCHAR(22)
AS
DECLARE @RoleID INT = 2
DECLARE @Entries INT = 0
DECLARE @RegDate Date = getDate()
OPEN SYMMETRIC KEY PW_Key  
DECRYPTION BY CERTIFICATE PasswordCert;
DECLARE @USERID INT = (SELECT max(UserID) + 1 FROM [Site].[User]) SELECT @USERID AS a
SELECT * FROM [Site].[User]
INSERT INTO [Site].[User]
(Username, Firstname, Lastname, Age, PW_Encrypted, Email, [Amount of entries], Phonenumber, RegDATE, RoleID)
VALUES 
(@Username, @Firstname, @LastName, @Age, null, @Email, @Entries, @Phonenumber, @RegDATE, @RoleID)
DECLARE @IDENTITY INT = @@IDENTITY
UPDATE [Site].[User]
SET PW_Encrypted = EncryptByKey(Key_GUID('PW_Key'), @Password, 1, HashBytes('SHA1', CONVERT( varbinary, @IDENTITY)))
WHERE Username = @Username
GO

-- Only for admins
CREATE PROCEDURE AddUser @Username NVARCHAR(100), 
@Firstname NVARCHAR(1000), @LastName NVARCHAR(1000), 
@Age DATE, @Password NVARCHAR(100), @Email NVARCHAR(300), @Phonenumber VARCHAR(22), @RoleID INT = 2
AS
DECLARE @Entries INT = 0
DECLARE @RegDate Date = getDate()
OPEN SYMMETRIC KEY PW_Key  
DECRYPTION BY CERTIFICATE PasswordCert;
DECLARE @USERID INT = (SELECT max(UserID) + 1 FROM [Site].[User]) SELECT @USERID AS a
SELECT * FROM [Site].[User]
INSERT INTO [Site].[User]
(Username, Firstname, Lastname, Age, PW_Encrypted, Email, [Amount of entries], Phonenumber, RegDATE, RoleID)
VALUES 
(@Username, @Firstname, @LastName, @Age, null, @Email, @Entries, @Phonenumber, @RegDATE, @RoleID)
DECLARE @IDENTITY INT = @@IDENTITY
UPDATE [Site].[User]
SET PW_Encrypted = EncryptByKey(Key_GUID('PW_Key'), @Password, 1, HashBytes('SHA1', CONVERT( varbinary, @IDENTITY)))
WHERE Username = @Username
GO

