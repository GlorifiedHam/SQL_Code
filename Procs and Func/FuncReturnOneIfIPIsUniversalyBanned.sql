-- If it return 1 the user IP is banned, if it returns 0 the IP is not banned
USE GamingSiteDB
GO

CREATE FUNCTION dbo.isIPUniversalyBanned(@GuestID int)
RETURNS BIT
AS
BEGIN

DECLARE @isBanned BIT

DECLARE @IP NVARCHAR(255) = (SELECT TextAddress FROM [Site].[GuestIP] WHERE GuestID = @GuestID)

IF((SELECT COUNT(*) FROM Internal.UniversalBan
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

INSERT INTO Internal.UniversalBan
(Group8, Group7 ,Group6, Group5, Group4, Group3, Group2, Group1, Network)
VALUES
(NULL, NULL, NULL, NULL, 194, 111, 243, 13, 88) -- IPv6
GO
SELECT dbo.isIPUniversalyBanned(2) -- Banned
SELECT dbo.isIPUniversalyBanned(1) -- Not banned
SELECT dbo.isIPUniversalyBanned(3) -- Account with the same IP is banned but not universaly, so it will return 0


