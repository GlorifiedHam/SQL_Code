-- Functions for returning global categories, subcategories, threads and entries and matching them with the users rolerank

USE GamingSiteDB
GO

--GlobalCategory 
CREATE FUNCTION dbo.GetGlobalCategoriesGuest() -- Used for Guests
RETURNS TABLE
AS
RETURN
(
SELECT GlobalCategoryName FROM  Forum.GlobalCategory WHERE [Read] <= 1
)
GO

SELECT * FROM dbo.GetGlobalCategoriesGuest() -- Test
GO

CREATE FUNCTION dbo.GetGlobalCategories(@UserID INT) -- Get the global categorys for a user
RETURNS TABLE
AS
RETURN
(
SELECT GlobalCategoryName FROM  Forum.GlobalCategory WHERE [Read] <= (SELECT dbo.GetRoleRank(@UserID))
)
GO

SELECT * FROM dbo.GetGlobalCategories(1)
GO

--Subcategories
CREATE FUNCTION dbo.GetSubCategoriesGuest(@GlobalCategoryID INT)
RETURNS TABLE
AS 
RETURN
(
SELECT SubCategoryName FROM Forum.SubCategory WHERE [Read] <= 1 AND GlobalCategoryID = @GlobalCategoryID
)
GO

SELECT * FROM dbo.GetSubCategoriesGuest(1) --Test
SELECT * FROM dbo.GetSubCategoriesGuest(7) --Test will be empty
GO

CREATE FUNCTION dbo.GetSubCategories(@UserID INT, @GlobalCategoryID INT)
RETURNS TABLE
AS 
RETURN
(
SELECT SubCategoryName FROM Forum.SubCategory WHERE [Read] <= (SELECT dbo.GetRoleRank(@UserID)) AND GlobalCategoryID = @GlobalCategoryID
)
GO

SELECT * FROM dbo.GetSubCategories(1, 7) -- Will return something now
SELECT * FROM dbo.GetSubCategories(4, 7) -- Will not return anything
GO

