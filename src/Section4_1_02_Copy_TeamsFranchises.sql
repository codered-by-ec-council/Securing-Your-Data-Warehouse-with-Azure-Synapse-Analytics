COPY INTO dbo.TeamsFranchises
(franchID 1, franchName 2, active 3, NAassoc 4)
FROM 'https://bridadlskf20211129.dfs.core.windows.net/synapse/import/dbo.TeamsFranchises.parquet'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)
GO