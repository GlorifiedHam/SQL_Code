-- If it return 1 the user IP is banned, if it returns 0 the IP is not banned
USE GamingSiteDB
GO

CREATE FUNCTION dbo.isIPBanned(@GuestID int)
RETURNS BIT
AS
BEGIN

DECLARE @isBanned BIT

DECLARE @IP NVARCHAR(255) = (SELECT TextAddress FROM [Site].[GuestIP] WHERE GuestID = @GuestID)

IF((SELECT COUNT(*) FROM Internal.AccountBan 
JOIN [Site].[IPAddress]
ON Internal.AccountBan.UserID = [Site].[IPAddress].UserID
WHERE @IP  IN (TextAddress)) > 0)
BEGIN 
SET @isBanned = 1
END
ELSE 
BEGIN
SET @isBanned = 0
END
return @isBanned
END
GO

INSERT INTO [Site].[GuestIP] 
(Group8, Group7 ,Group6, Group5, Group4, Group3, Group2, Group1, Network, GuestID)
VALUES
(127, 0, 0, 0, 4, 22, 222, 54, NULL, 1), -- IPv6
(NULL, NULL, NULL, NULL, 194, 111, 243, 13, 88, 2), --Bannad
(127, 12, 111, 0, 44, 333, 123, 23, NULL, 3) -- Bannad
GO
SELECT dbo.isIPBanned(1), dbo.isIPBanned(2), dbo.isIPBanned(3)
