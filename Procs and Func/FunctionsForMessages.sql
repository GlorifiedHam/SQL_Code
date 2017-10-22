CREATE FUNCTION dbo.ReturnResivedMessages (@UserID INT) -- Will return a table with a users recived messages, takes UserID as input
RETURNS TABLE
AS
RETURN 
SELECT title, [Message], DateSent, [read], Flag
FROM [Site].MessageSend
WHERE  ReciverID = @UserID
GO

SELECT * FROM dbo.ReturnResivedMessages(1) -- Test
GO

CREATE FUNCTION dbo.ReturnSentMessages (@UserID INT) -- Will return a table with a users sent messages, takes UserID as input
RETURNS TABLE
AS
RETURN 
SELECT title, [Message], DateSent, [read], Flag
FROM [Site].MessageSend
WHERE SenderID = @UserID
GO

SELECT * FROM dbo.ReturnSentMessages(1) -- Test
GO

CREATE FUNCTION dbo.ReturnUnreadMessages (@UserID INT) -- Will return a table with a users unread messages, takes UserID as input
RETURNS TABLE
AS
RETURN 
SELECT * FROM dbo.ReturnResivedMessages(@UserID)
WHERE  [read] = 0
GO

SELECT * FROM dbo.ReturnUnreadMessages(1) -- Test
GO

CREATE FUNCTION dbo.ReturnFlagedMessages (@UserID INT) -- Will return a table with a users flaged messages, takes UserID as input
RETURNS TABLE
AS
RETURN 
SELECT * FROM dbo.ReturnResivedMessages(@UserID)
WHERE  Flag = 1
GO

SELECT * FROM dbo.ReturnFlagedMessages(1) -- Test, will not return anything becuase the user does not have any flaged messages
GO