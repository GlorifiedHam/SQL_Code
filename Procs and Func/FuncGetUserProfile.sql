USE GamingSiteDB
Go

-- Om användaren inte visa något kommer den kolumnen tillbaka som null
Create Function dbo.GetUserProfile(@UserID INT)
Returns Table
AS
RETURN
(
SELECT Username, [Amount of entries], RegDATE, RoleName, Picture, [Description],
CASE WHEN (SELECT ShowFirstName FROM [Site].[User] Where [Site].[User].UserID = @UserID) = 1  THEN (SELECT Firstname FROM [Site].[User] Where [Site].[User].UserID = @UserID) END AS FirstName,
CASE WHEN (SELECT ShowLastName FROM [Site].[User] Where [Site].[User].UserID = @UserID) = 1 THEN (SELECT Lastname FROM [Site].[User] Where [Site].[User].UserID = @UserID) END AS Lastname,
CASE WHEN (SELECT ShowAge FROM [Site].[User] Where [Site].[User].UserID = @UserID) = 1 THEN (SELECT Age FROM [Site].[User] Where [Site].[User].UserID = @UserID) END AS Age,
CASE WHEN (SELECT ShowEmail FROM [Site].[User] Where [Site].[User].UserID = @UserID) = 1 THEN (SELECT Email FROM [Site].[User] Where [Site].[User].UserID = @UserID) END AS Email
FROM [Site].[User]
JOIN Internal.[Role]
ON [Site].[User].RoleID = Internal.[Role].RoleID
JOIN Internal.[Profile]
ON [Site].[User].UserID = Internal.[Profile].UserID
JOIN Internal.Picture
ON Internal.[Profile].PicAvatarID = Internal.Picture.PictureID 
Where [Site].[User].UserID = @UserID
)
GO

SELECT * FROM dbo.GetUserProfile(1)
SELECT * FROM dbo.GetUserProfile(6)

