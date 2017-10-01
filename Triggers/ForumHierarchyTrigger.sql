USE ForumDb 
GO

CREATE TRIGGER CheckSubCategoryRole
ON Forum.SubCategory
AFTER INSERT, UPDATE
AS
DECLARE @GlobalCategoryID INT = (SELECT GlobalCategoryID FROM inserted)
DECLARE @GlobalCategoryRoleID INT = (SELECT [Read] FROM GlobalCategory WHERE GlobalCategoryID = @GlobalCategoryID) 
DECLARE @GRoleRank INT = (SELECT RoleRank FROM Internal.[Role] WHERE RoleID = @GlobalCategoryRoleID)

DECLARE @SubCategoryID INT = (SELECT SubCategoryID from inserted)
DECLARE @SubCategoryReadRole INT = (SELECT [READ] FROM Forum.SubCategory WHERE SubCategoryID = @SubCategoryID)
DECLARE @SubCategoryWriteRole INT = (SELECT [Write] FROM Forum.SubCategory WHERE SubCategoryID = @SubCategoryID) 
DECLARE @SReadRank INT = (SELECT RoleRank FROM Internal.[Role] WHERE RoleID = @SubCategoryReadRole)
DECLARE @SWriteRank INT = (SELECT RoleRank FROM Internal.[Role] WHERE RoleID = @SubCategoryWriteRole)

IF (@SReadRank < @GRoleRank AND @SWriteRank < @GRoleRank) 
BEGIN
UPDATE Forum.SubCategory
SET [READ] = @GlobalCategoryRoleID, [Write] = @GlobalCategoryRoleID
WHERE SubCategoryID = @SubCategoryID 
END

IF (@SReadRank < @GRoleRank)
BEGIN
UPDATE Forum.SubCategory
SET [READ] = @GlobalCategoryRoleID
WHERE SubCategoryID = @SubCategoryID 
END

IF (@SWriteRank < @GRoleRank)
BEGIN
UPDATE Forum.SubCategory
SET [Write] = @GlobalCategoryRoleID
WHERE SubCategoryID = @SubCategoryID 
END

GO

CREATE TRIGGER ChecThreadRole
ON Forum.Thread
AFTER INSERT, UPDATE
AS

DECLARE @SubCategoryID INT = (SELECT SubCategoryID from inserted)
DECLARE @SubCategoryReadRole INT = (SELECT [READ] FROM Forum.SubCategory WHERE SubCategoryID = @SubCategoryID)
DECLARE @SubCategoryWriteRole INT = (SELECT [Write] FROM Forum.SubCategory WHERE SubCategoryID = @SubCategoryID) 
DECLARE @SReadRank INT = (SELECT RoleRank FROM Internal.[Role] WHERE RoleID = @SubCategoryReadRole)
DECLARE @SWriteRank INT = (SELECT RoleRank FROM Internal.[Role] WHERE RoleID = @SubCategoryWriteRole)

DECLARE @ThreadID INT = (SELECT ThreadID FROM inserted)
DECLARE @ThreadReadRole INT = (SELECT [READ] FROM Forum.Thread WHERE ThreadID = @ThreadID)
DECLARE @ThreadWriteRole INT = (SELECT [Write] FROM Forum.Thread WHERE ThreadID = @ThreadID)
DECLARE @TReadRank INT = (SELECT RoleRank FROM Internal.[Role] WHERE RoleID = @ThreadReadRole)
DECLARE @TWriteRank INT = (SELECT RoleRank FROM Internal.[Role] WHERE RoleID = @ThreadWriteRole)

IF (@TReadRank < @SReadRank AND @TWriteRank < @SWriteRank) 
BEGIN
UPDATE Forum.Thread
SET [READ] = @SReadRank, [Write] = @SWriteRank
WHERE ThreadID = @ThreadID 
END

IF (@TReadRank < @SReadRank)
BEGIN
UPDATE Forum.Thread
SET [READ] = @SReadRank
WHERE ThreadID = @ThreadID 
END

IF (@TWriteRank < @SWriteRank)
BEGIN
UPDATE Forum.Thread
SET [Write] = @SWriteRank
WHERE ThreadID = @ThreadID 
END