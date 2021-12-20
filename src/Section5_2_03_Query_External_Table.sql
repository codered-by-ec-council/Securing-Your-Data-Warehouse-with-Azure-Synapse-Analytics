USE BRIServerless
GO
SELECT TOP(10) * FROM dbo.GameLogs;
GO
SELECT  * FROM dbo.GameLogs WHERE [Date] = '19990731';
GO
-- Need to grant Alicia rights if she is to view this data.
GRANT REFERENCES ON DATABASE SCOPED CREDENTIAL::[SynapseMSI] TO [alicia@feaselklgmail.onmicrosoft.com]
GO
-- Note that this will fail!
CREATE EXTERNAL TABLE [dbo].[DoubleHeaders] WITH (
		DATA_SOURCE = [DataLake],
        LOCATION = '/DoubleHeaders/',
        FILE_FORMAT = [ParquetFileFormat]
) AS
SELECT *
FROM dbo.GameLogs
WHERE NumberOfGameCode <> '0';
GO
