CREATE FUNCTION [dbo].[GetBlobData]()
RETURNS VARBINARY(MAX) 
AS
BEGIN
    DECLARE @IsFileExists INT,
        @BinaryData VARBINARY(MAX)
    -- Set minimum binary representation Hexadecimal number as default
    SET @BinaryData =(0x) 
    -- First check if the file exists on the directory 
    EXEC Master.dbo.xp_fileexist N'D:\Programming\SQL\GamingSiteDB', @IsFileExists OUT 
    IF @IsFileExists = 1
    
        -- If exists then read the file content
        SET @BinaryData = (SELECT * FROM OPENROWSET(BULK N'D:/Programming/SQL/GamingSiteDB/Images/Game.PNG',SINGLE_BLOB)
	AS BLOBData)

    RETURN @BinaryData
END  

