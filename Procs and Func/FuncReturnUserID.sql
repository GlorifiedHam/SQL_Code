Use GamingSiteDB
GO

--If it returns 0 there is no user with the specified username in the db

CREATE FUNCTION dbo.GetUserIDFromUsername(@Username NVARCHAR(255))
RETURNS INT
AS 
BEGIN 
DECLARE @UserID INT 

IF((Select COUNT(*) FROM [Site].[User] WHERE LOWER(@Username) IN (LOWER(Username))) = 0)
BEGIN
SET @UserID = 0;
END
ELSE
BEGIN 
DECLARE @ID INT = (SELECT UserID FROM [Site].[User] WHERE LOWER(Username) = LOWER(@Username))
SET @UserID = @ID
END

RETURN @UserID
END 
GO