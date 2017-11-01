-- We need to make it so if someone tries to log in to a admin, mods account the account will be banned faster.
-- We should also store the IP of the user that is trying to log in to the account
USE GamingSiteDB
Go

CREATE PROCEDURE matchPW @UserID INT, @GuestID INT ,@Password NVARCHAR(100), @Message NVARCHAR(100) OUTPUT
AS
BEGIN
OPEN SYMMETRIC KEY PW_Key
   DECRYPTION BY CERTIFICATE PasswordCert;  
 
DECLARE @PwInDB NVARCHAR(100) = (SELECT CONVERT(nvarchar,  
    DecryptByKey(PW_Encrypted, 1 ,   
    HashBytes('SHA1', CONVERT(varbinary, UserID))))  
    AS 'Decrypted pw' FROM [Site].[User] WHERE UserID = 1);

CLOSE SYMMETRIC KEY PW_Key; 

IF ((SELECT dbo.isIPBanned(@GuestID)) = 1)
BEGIN
SET @Message =  'The users IP is banned'
END

ELSE
BEGIN
IF((SELECT Tries FROM Internal.FailLogIn WHERE UserID = @UserID) = 20)
BEGIN 
SET @Message = 'User has to verify the account via Email'
END


ELSE
BEGIN
IF((SELECT LOCK FROM Internal.FailLogIn WHERE UserID = 5) > getDate())
BEGIN
SET @Message = 'The account is locked'
END

ELSE
BEGIN
IF(@Password COLLATE Latin1_General_CS_AS = @PwInDB COLLATE Latin1_General_CS_AS )
BEGIN
SET @Message = 'Match' 

IF((SELECT COUNT(*) FROM Internal.FailLogIn WHERE UserID = @UserID) >= 1 )
BEGIN
DELETE FROM Internal.FailLogIn
WHERE UserID = @UserID;
END
END

ELSE 
BEGIN
IF((SELECT COUNT(*) FROM Internal.FailLogIn WHERE UserID = @UserID) <= 0 )
BEGIN
INSERT INTO Internal.FailLogIn
(Tries, UserID)
VALUES
(1, @UserID)

SET @Message = 'Incorrect password or username'
END

ELSE
BEGIN
UPDATE Internal.FailLogIn
SET Tries = Tries + 1
WHERE UserID = @UserID
SET @Message = 'Incorrect password or username'

IF((SELECT Tries FROM Internal.FailLogIn WHERE UserID = @UserID) = 5)
BEGIN
UPDATE Internal.FailLogIn
SET Lock = DATEADD(minute,15, GETDATE())
WHERE UserID = @UserID
SET @Message = 'Account locked for 15m'
END

ELSE
BEGIN
IF((SELECT Tries FROM Internal.FailLogIn WHERE UserID = @UserID) = 10)
BEGIN
UPDATE Internal.FailLogIn
SET Lock = DATEADD(minute,120, GETDATE())
WHERE UserID = @UserID
SET @Message = 'Account locked for 120m'
END

ELSE
BEGIN
IF((SELECT Tries FROM Internal.FailLogIn WHERE UserID = @UserID) = 15)
BEGIN
UPDATE Internal.FailLogIn
SET Lock = DATEADD(hour,24, GETDATE())
WHERE UserID = @UserID
SET @Message = 'Account locked for 24h'
END

ELSE
BEGIN
IF((SELECT Tries FROM Internal.FailLogIn WHERE UserID = @UserID) = 20)
BEGIN
UPDATE[Site].[User]
SET Verification = 0
WHERE UserID = @UserID

SET @Message = 'User has to verify the account via Email'
END

END
END
END
END
END
END
END
END
END
GO  

DECLARE  @message nvarchar(100) 
EXECUTE matchPW 1, 1,  'War2Glory', @message output -- Match
PRINT @message

DECLARE  @message2 nvarchar(100) 
EXECUTE matchPW 5, 1, 'war2Glory', @message2 output -- Incorrect password or username
PRINT @message2

