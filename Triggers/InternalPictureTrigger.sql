USE GamingSiteDB
GO

CREATE Trigger checkImageOnInsert
ON Internal.Picture
INSTEAD OF INSERT
AS
DECLARE @NewName NVARCHAR(255) = (SELECT [Name] FROM inserted)
DECLARE @UserID INT = (SELECT UserID FROM inserted)
IF 0 = (SELECT COUNT(*) FROM Internal.Picture WHERE UserID = @UserID and @NewName IN([Name]))
BEGIN
DECLARE @picture VarBinary(MAX) = (SELECT Picture FROM inserted)
DECLARE @DateAdded DateTime = (SELECT DateAdded FROM inserted)

INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
VALUES (@UserID, @picture ,@NewName, @DateAdded)
END

ELSE
BEGIN
PRINT 'There is already a picture with that name'
END
GO

CREATE Trigger checkImageOnUpdate
ON Internal.Picture
INSTEAD OF UPDATE
AS
DECLARE @NewName NVARCHAR(255) = (SELECT [Name] FROM inserted)
DECLARE @UserID INT = (SELECT UserID FROM inserted)
IF 0 = (SELECT COUNT(*) FROM Internal.Picture WHERE UserID = @UserID and @NewName IN([Name]))
BEGIN
DECLARE @name NVARCHAR(255) = (SELECT [Name] FROM inserted)

UPDATE Internal.Picture
SET [Name] = @NewName
WHERE UserID = @UserID
END

ELSE
BEGIN
PRINT 'There is already a picture with that name'
END
GO