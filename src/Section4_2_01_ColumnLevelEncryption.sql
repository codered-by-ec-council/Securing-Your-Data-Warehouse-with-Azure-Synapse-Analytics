CREATE MASTER KEY;
GO
CREATE CERTIFICATE PersonnelCert WITH SUBJECT = 'Baseball Player details';
GO
CREATE SYMMETRIC KEY PersonnelKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE PersonnelCert;
GO
ALTER TABLE dbo.People
    ADD nameLastEncrypted VARBINARY(160);
GO
OPEN SYMMETRIC KEY PersonnelKey
    DECRYPTION BY CERTIFICATE PersonnelCert;
UPDATE dbo.People
SET nameLastEncrypted = CAST(EncryptByKey(Key_GUID('PersonnelKey'), nameLast) AS VARBINARY(160));
GO
OPEN SYMMETRIC KEY PersonnelKey
    DECRYPTION BY CERTIFICATE PersonnelCert;
SELECT
    nameLast,
    nameLastEncrypted,
    CONVERT(NVARCHAR, DecryptByKey(nameLastEncrypted)) AS nameLastDecrypted
FROM dbo.People;
GO
