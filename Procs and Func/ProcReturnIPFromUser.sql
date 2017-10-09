-- Returns a users IPv6 as NVARCHAR
CREATE FUNCTION dbo.ReturnIPV6(@UserID int)
RETURNS NVARCHAR(255)
AS
BEGIN
DECLARE @null varbinary(2) = (SELECT [Group8] FROM [Site].IPAddress WHERE UserID = @UserID)
IF(@null is null )
BEGIN
DECLARE @Message NVARCHAR(255) = 'This user does not have a IPv6 IP'
Return @Message
END
DECLARE @IP NVARCHAR(255)= (
SELECT CONCAT(
      CONVERT(TINYINT, [Group8], 2), ':', CONVERT(TINYINT, [Group7], 2), ':',
      CONVERT(TINYINT, [Group6], 2), ':', CONVERT(TINYINT, [Group5], 2), ':',
      CONVERT(TINYINT, [Group4], 2), ':', CONVERT(TINYINT, [Group3], 2), ':',
      CONVERT(TINYINT, [Group2], 2), ':', CONVERT(TINYINT, [Group1], 2),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')) AS [IP] FROM [Site].[IPAddress] 
	  WHERE UserID = @UserID
	   )

	   Return @IP
END

-- Returns a users IP as NVARCHAR
CREATE FUNCTION dbo.ReturnIPv4(@UserID int)
RETURNS NVARCHAR(255)
AS
BEGIN
DECLARE @null varbinary(2) = (SELECT [Group8] FROM [Site].IPAddress WHERE UserID = @UserID)
IF(@null IS NOT NULL)
BEGIN
DECLARE @Message NVARCHAR(255) = 'This user does not have a IPv4 IP'
Return @Message
END
DECLARE @IP NVARCHAR(255) = (SELECT TextAddress FROM [Site].IPAddress WHERE UserId = @UserID)

RETURN @IP
END

CREATE FUNCTION dbo.ReturnUserIP(@UserID int)
RETURNS NVARCHAR(255)
AS
BEGIN
DECLARE @null varbinary(2) = (SELECT [Group8] FROM [Site].IPAddress WHERE UserID = @UserID)
IF(@null IS NOT NULL)
BEGIN
DECLARE @IP6 NVARCHAR(255)= (
SELECT CONCAT(
      CONVERT(TINYINT, [Group8], 2), ':', CONVERT(TINYINT, [Group7], 2), ':',
      CONVERT(TINYINT, [Group6], 2), ':', CONVERT(TINYINT, [Group5], 2), ':',
      CONVERT(TINYINT, [Group4], 2), ':', CONVERT(TINYINT, [Group3], 2), ':',
      CONVERT(TINYINT, [Group2], 2), ':', CONVERT(TINYINT, [Group1], 2),
      IIF([Network] IS NOT NULL, CONCAT('/', [Network]), '')) AS [IP] FROM [Site].[IPAddress] 
	  WHERE UserID = @UserID
	   )

	   Return @IP6
END

DECLARE @IP4 NVARCHAR(255) = (SELECT TextAddress FROM [Site].IPAddress WHERE UserId = @UserID)

RETURN @IP4
END
