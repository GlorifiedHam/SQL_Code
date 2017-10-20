--Role Procs & Functions, need to add try catch
Use GamingSiteDB
GO

/*Returns the RolenName of a user*/
CREATE FUNCTION dbo.GetRoleName(@UserID Int)
Returns NVARCHAR(255)
AS
BEGIN
 
DECLARE @RoleID INT = (SELECT RoleID FROM [Site].[User] WHERE UserID = @UserID) 
DECLARE @RoleName NVARCHAR(255) = (SELECT RoleName FROM Internal.Role WHERE RoleID = @RoleID) 

RETURN (@RoleName)
END;
GO

/*Returns the RolenRank of a user*/
CREATE FUNCTION dbo.GetRoleRank(@UserID Int)
Returns int
AS
BEGIN
 
DECLARE @RoleID INT = (SELECT RoleID FROM [Site].[User] WHERE UserID = @UserID) 
DECLARE @RoleRank INT = (SELECT RoleRank FROM Internal.Role WHERE RoleID = @RoleID) 

RETURN (@RoleRank)
END;
GO

/*Updates the Role of a user*/
CREATE PROC ChangeRole(@UserID INT, @RoleName NVARCHAR(255), @Message NVARCHAR(255) OUTPUT)
AS
BEGIN TRANSACTION
BEGIN TRY
DECLARE @CurrentRoleID INT = (SELECT RoleID FROM [Site].[User] WHERE UserID = @UserID) 

SELECT TOP 1 RoleID FROM Internal.[Role] WHERE RoleName = @RoleName
IF (@@ROWCOUNT > 0)
BEGIN
DECLARE @NewRoleID INT = (SELECT RoleID FROM Internal.[Role] WHERE RoleName = @RoleName) 

IF(@CurrentRoleID = @NewRoleID)
BEGIN
Set @Message = 'The new Role is the same as the old one, please choose another Role'
END

ELSE
BEGIN
UPDATE [Site].[User]
SET RoleID = @NewRoleID
WHERE UserID = @UserID
Set @Message = 'Done'
END
END

Else
BEGIN
Set @Message = 'There is no role with the name of: ' + @RoleName + ' please insert a valid name';
END
COMMIT TRANSACTION
END TRY

BEGIN CATCH
ROLLBACK TRANSACTION
print 'ErrorNumber:' + CAST(error_number() AS VARCHAR);
print 'ErrorMessage' + error_message();
print 'ErrorSevirity:' + error_severity();   
END CATCH

GO

-- How to call it 
-- Will return There is no role with the name of: ...
DECLARE @Mess1 nvarchar(255)
EXEC ChangeRole 6, '7', @Message = @Mess1 Output
Print @Mess1

-- Working
DECLARE @Mess2 nvarchar(255)
EXEC ChangeRole 6, 'Member', @Message = @Mess2 Output
Print @Mess2


