USE ForumDB
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'ArMa3#ArBast$AnD?/Lov114*E';  
GO  

CREATE CERTIFICATE PasswordCert
WITH SUBJECT = 'User Password';
GO

CREATE SYMMETRIC KEY PW_Key  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE PasswordCert;  
GO

-- Creates the column that stores the encrypted data.  
ALTER TABLE [Site].[User]   
    ADD PW_Encrypted varbinary(128);   
GO  

-- Opens the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY PW_Key  
   DECRYPTION BY CERTIFICATE PasswordCert;

-- Now we encrypt the value in column [Password] using the symmetric key PW_Key. 
-- And saves the result in column PW_Encrypted    
UPDATE [Site].[User] 
SET PW_Encrypted = EncryptByKey(Key_GUID('PW_Key')  
    , [Password], 1, HashBytes('SHA1', CONVERT( varbinary  
    , UserID)));  
GO  

-- Verify the encryption.  
-- First, open the symmetric key with which to decrypt the data.  

OPEN SYMMETRIC KEY PW_Key
   DECRYPTION BY CERTIFICATE PasswordCert;  
GO  

-- Now list the original pw, the encrypted pw,  
-- and the decrypted ciphertext. If the decryption worked,  
-- the original number will match the decrypted number.  


SELECT [Password], PW_Encrypted  
    AS 'Encrypted pw', CONVERT(nvarchar,  
    DecryptByKey(PW_Encrypted, 1 ,   
    HashBytes('SHA1', CONVERT(varbinary, UserID))))  
    AS 'Decrypted pw' FROM [Site].[User];  
GO  

ALTER TABLE [Site].[User]
DROP COLUMN [Password];

SELECT PW_Encrypted  
    AS 'Encrypted pw', CONVERT(nvarchar,  
    DecryptByKey(PW_Encrypted, 1 ,   
    HashBytes('SHA1', CONVERT(varbinary, UserID))))  
    AS 'Decrypted pw' FROM [Site].[User];  
GO  

--Test so that not everyone can use the decryption 
SELECT UserID, PW_Encrypted AS 'PW_Encrypted',
CONVERT(varchar, DecryptByKey(PW_Encrypted)) AS 'Decrypted Credit Card Number'
FROM [Site].[User];