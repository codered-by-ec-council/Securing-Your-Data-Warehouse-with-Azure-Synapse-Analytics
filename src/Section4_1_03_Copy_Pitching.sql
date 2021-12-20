COPY INTO dbo.Pitching
(playerID 1, yearID 2, stint 3, teamID 4, lgID 5, W 6, L 7, G 8, GS 9, CG 10, SHO 11, SV 12, IPouts 13, H 14, ER 15, HR 16, BB 17, SO 18, BAOpp 19, ERA 20, IBB 21, WP 22, HBP 23, BK 24, BFP 25, GF 26, R 27, SH 28, SF 29, GIDP 30)
FROM 'https://bridadlskf20211129.dfs.core.windows.net/synapse/import/dbo.Pitching.parquet'
WITH
(
	FILE_TYPE = 'PARQUET'
	,MAXERRORS = 0
)
GO
