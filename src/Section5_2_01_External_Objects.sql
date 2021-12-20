USE [BRIServerless]
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.symmetric_keys
)
BEGIN
    CREATE MASTER KEY;
END
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.database_scoped_credentials dsc
    WHERE
        dsc.name = N'SynapseMSI'
)
BEGIN
    CREATE DATABASE SCOPED CREDENTIAL [SynapseMSI]
        WITH IDENTITY = 'Managed Service Identity';
END
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.external_data_sources ds
    WHERE
        ds.name = N'DataLake'
)
BEGIN
    CREATE EXTERNAL DATA SOURCE [DataLake] WITH
    (
        LOCATION = N'abfss://synapse@bridadlskf20211129.dfs.core.windows.net/',
        CREDENTIAL = [SynapseMSI]
    );
END
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.external_file_formats ff
    WHERE
        ff.name = N'CsvFileFormat'
)
BEGIN
	CREATE EXTERNAL FILE FORMAT CsvFileFormat WITH
	(
		FORMAT_TYPE = DELIMITEDTEXT,
		FORMAT_OPTIONS
		(
			FIELD_TERMINATOR = N',',
			USE_TYPE_DEFAULT = True,
			STRING_DELIMITER = '"',
			ENCODING = 'UTF8'
		)
	);
END
GO
IF NOT EXISTS
(
    SELECT *
    FROM sys.external_file_formats ff
    WHERE
        ff.name = N'ParquetFileFormat'
)
BEGIN
    CREATE EXTERNAL FILE FORMAT [ParquetFileFormat] WITH
    (
        FORMAT_TYPE = PARQUET,
        DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
    );
END
GO
