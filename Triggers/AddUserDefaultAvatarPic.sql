USE ForumDb Internal.[Profile]
GO

CREATE TRIGGER AddUserDefaultAvatarPicture
ON [Site].[User]
AFTER INSERT
AS
BEGIN
DECLARE @UserID INT = (SELECT UserID FROM inserted)

INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
VALUES
(@UserID, default, 'DefaultAvatar', getDate())

INSERT INTO Internal.[Profile]
(UserID, PicAvatarID, [Description])
VALUES
(@UserID, @@IDENTITY, null)
END 