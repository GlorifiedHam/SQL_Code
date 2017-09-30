USE ForumDb -- Need one for Updates as well
GO

CREATE TRIGGER ForumHierarchy
ON Forum.SubCategory
AFTER INSERT
AS
DECLARE @GlobalCategoryID INT = (SELECT GlobalCategoryID FROM inserted)
DECLARE @GlobalCategoryRole Nvarchar(50) = (SELECT [Read] FROM GlobalCategory WHERE GlobalCategoryID = @GlobalCategoryID)
DECLARE @GlobalCategoryRoleRank int = (SELECT RoleRank FROM )
IF