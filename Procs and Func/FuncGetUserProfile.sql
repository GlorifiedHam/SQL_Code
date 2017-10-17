USE ForumDB
Go

Create Function dbo.GetUserProfile(@UserID INT)
Returns Table
AS
RETURN
(
SELECT Username, Firstname, Lastname, Age, Email, [Amount of entries] , Phonenumber, RegDATE, RoleName
FROM [Site].[User]
JOIN Internal.[Role]
ON [Site].[User].RoleID = Internal.[Role].RoleID
Where [Site].[User].UserID = @UserID
)
GO
SELECT * FROM dbo.GetUserProfile(1)