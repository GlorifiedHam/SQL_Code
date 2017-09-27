sp_configure 'show advanced options', 1;
RECONFIGURE;
GO  --Added        
sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;
GO
SELECT * INTO XLImport3 FROM OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source=D:\Programming\SQL\ForumDB\Excel\Shop_InventoryV2.xlsx;Extended Properties=Excel 12.0')...[Handguns$]
Go

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 
GO 
EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
GO