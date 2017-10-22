USE GamingSiteDB
GO

CREATE PROCEDURE validateUser @UserID INT
AS
IF((SELECT COUNT(*) FROM [Site].[User] WHERE UserID = @UserID AND Verification = 1) > 0)
BEGIN
PRINT 'The user is already verified'
END
IF((SELECT COUNT(*) FROM [Site].[User] WHERE UserID = @UserID) <= 0)
BEGIN
Print 'There is no user in the database with that ID'
END
ELSE
IF((SELECT Tries FROM Internal.FailLogIn WHERE UserID = @UserID) = 20)
BEGIN 
DELETE Internal.FailLogIn
WHERE UserID = @UserID

UPDATE [Site].[User]
SET Verification = 1
WHERE UserID = @UserID
END
ELSE
BEGIN
UPDATE [Site].[User]
SET Verification = 1
WHERE UserID = @UserID
END
GO

