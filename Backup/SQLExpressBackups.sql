USE GamingSiteDB;  
GO  
BACKUP DATABASE GamingSiteDB  
TO DISK = 'D:\SQLServerBackups\LGamingSiteDB.Bak'  
   WITH FORMAT,  
      MEDIANAME = 'D_SQLServerBackups',  
      NAME = 'Full Backup of GamingSiteDB';  
GO  

/* 
Insert 

"D:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\SQLCMD.EXE" -S 
(local)\SQLExpress -i D:\Programming\SQL\GamingSiteDB\Backup.sql

Into Windows Scheduled Tasks
*/
